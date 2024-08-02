Généralement, lors de discussions DAST, les gens feront référence à la mise en œuvre de l'analyse automatisée des vulnérabilités dans votre pipeline de développement plutôt que le processus manuel que nous avons couvert. De cette façon, le terme diffère de ce que vous appelleriez généralement l'application pentesting.

Ayant DAST ajouté à votre processus de développement peut sembler assez simple, mais il y a quelques mises en garde:

-   Nous devons décider à quelles étapes du processus de développement nous allons exécuter des scans.
-   Nous devons décider ce qui déclenchera un scan. Nous pouvons exécuter des analyses sur chaque commit effectué au code ou sur une base planifiée.
-   Il faut déterminer l'intensité de chaque scan. Faire une analyse complète des vulnérabilités sur une application de taille moyenne nécessitera beaucoup de temps, et nous ne voulons pas ralentir l'équipe de développement.

Comme aucune solution ne correspond à tous les scénarios, la détermination de tout cela doit être faite avec l'aide de l'équipe de développement afin que les exigences de sécurité soient satisfaites sans créer de perturbations significatives pour leurs processus établis.

Dans cette tâche, nous examinerons comment nous pouvons mettre en œuvre rapidement DAST directement dans le pipeline de développement pour fournir une visibilité précoce des vulnérabilités. Les analyses s'exécutent automatiquement à chaque validation et testent un sous-ensemble de vulnérabilités uniquement pour éviter d'introduire de longs retards dans le pipeline.

Réviser notre CI/CD Pipeline

Notre machine actuelle implémente l'ensemble du pipeline de développement pour l'application Web et API vous avez scanné précédemment. Les deux composantes suivantes sont chargées de le faire:

-   Un dépôt Gitea est en cours d'exécution [http://MACHINE_IP:3000/](http://machine_ip:3000/), où le code pour les deux applications est stocké.
-   Une instance Jenkins qui exécute le pipeline CI/CD. Vous pouvez accéder à Jenkins à [http://MACHINE_IP:8080/](http://machine_ip:8080/).

Chaque fois qu'un commit est fait dans Gitea, Jenkins prendra le code du référentiel et le compilera dans une instance Docker. Ces instances Docker sont ce que vous avez scanné jusqu'à présent. 

![image](https://github.com/user-attachments/assets/28c4e720-f22c-4663-8704-ecd15f0efe81)

Pour accéder à Gitea ou Jenkins, vous pouvez utiliser les informations d'identification suivantes:


| **Nom d'utilisateur** | thm |
| **Mot de passe** | thm |

Exécuter des Scans Automatisés Avec zap2docker

Pour intégrer ZAP dans notre pipeline, nous allons utiliser **zap2docker**, une version dockerized de ZAP proxy construit avec l'automatisation comme but principal. La documentation complète pour zap2docker peut être trouvée [ici](https://www.zaproxy.org/docs/docker/).

**Note:** Les commandes de cette section sont fournies à titre de référence seulement. Vous n'avez pas besoin de les exécuter manuellement, comme nous l'aurons fait Jenkins faites-le pour nous plus tard.

Pour installer zap2docker, vous pouvez le retirer de Docker Hub en utilisant la commande suivante:

```
docker pull owasp/zap2docker-stable
```

Vous pouvez courir ZAP à partir de l'instance du docker à l'aide de l'un des scripts d'analyse empaquetés, ce qui vous permettra d'exécuter l'un des profils d'analyse suivants:

**Baseline Scan:** ZAP araignée le site cible pour une durée maximale de 1 minute. Aucune analyse active ne sera effectuée. Vous pouvez éventuellement exécuter une araignée AJAX si vous le souhaitez.

```
docker run -t owasp/zap2docker-stable zap-baseline.py -t https://www.example.com
```

**Plein Scan:** ZAP exécutera une araignée sans limite de temps, suivie d'une analyse active.

```
docker run -t owasp/zap2docker-stable zap-full-scan.py -t https://www.example.com
```

**API Scanne:** ZAP effectuera une analyse active contre un API. Vous devrez fournir une URL à un API fichier de description (OpenAPI, GraphQL ou SAVON').

```
docker run -t owasp/zap2docker-stable zap-api-scan.py -t https://www.example.com/swagger.json -f openapi
```

Dans tous les scans, les résultats pour les scans passifs seront limités à 10 alertes. En plus des commandes de base, vous pouvez ajouter `-j` basculer pour effectuer une analyse AJAX sur la ligne de base et des analyses complètes.

Intégration ZAP Dans le Pipeline

L'environnement auquel vous avez accès a déjà une instance zap2docker prête à l'emploi. Tout ce qu'il faut faire, c'est le dire Jenkins pour exécuter zap2docker avec les options dont nous avons besoin, et ce sera tout.

Avant d'entrer dans cela, explorons ce que nous avons Jenkins. Lors de la connexion Jenkins, vous trouverez un **organisation** appelé thm, qui contient les deux **dépôts** pour l'application web et API. Pour chacun des référentiels, vous pouvez voir le disponible **branches**. 

![image](https://github.com/user-attachments/assets/ac445d3d-af3b-40e9-bb08-7123882b1f9b)

Vous aurez une seule branche dans les deux projets appelés `main`. Si vous cliquez sur la branche, vous serez en mesure de voir les builds pour elle. Le `simple-webapp` le projet, par exemple, a déjà été construit deux fois:

![image](https://github.com/user-attachments/assets/ccfbcce4-77f8-4844-b7f6-e9b46a998880)

Pour chaque construction, nous pouvons voir qu'il y a deux étapes configurées:

-   **Créer l'image Docker:** Cette étape construira le conteneur Docker basé sur le Dockerfile sur chaque projet.
-   **Déployer l'image Docker:** Cette étape va déployer le conteneur Docker.

Ces deux étapes sont définies dans le **Jenkinsfile** dans chaque dépôt. Si nous allons à Gitea et ouvrons le [Jenkinsfile](http://machine_ip:3000/thm/simple-webapp/src/branch/main/Jenkinsfile) sur le référentiel simple-webapp, nous pouvons voir les commandes spécifiques exécutées sur chacune des étapes:

![image](https://github.com/user-attachments/assets/3440718b-6bf3-455e-a9ac-5266ad6cccc7)

Dans la deuxième étape, vous pouvez voir comment l'application Web que vous avez numérisée manuellement est déployée sur le port 8082, par exemple.

Si nous voulons intégrer zap2docker dans notre pipeline, nous pouvons ajouter une troisième étape qui exécute le scan pour nous après la construction du conteneur. Pour votre commodité, la scène est déjà définie à la fin du fichier Jenkins, et vous pouvez le décompresser pour le faire fonctionner. N'hésitez pas à utiliser `git` pour envoyer un commit au dépôt ou utiliser l'éditeur intégré de Gitea si vous le trouvez plus facile:

![image](https://github.com/user-attachments/assets/f60d6b31-8e00-4526-8f12-35f614c65bd8)

Notez que nous gérons le **Baseline Scan** seulement, comme cette analyse sera exécutée pour chaque commit effectué dans le référentiel, il n'est donc pas judicieux de retarder le pipeline avec une analyse complète qui pourrait prendre des heures. Ce scan a pour but de trouver des fruits bas seulement. Cela signifie que vous n'en verrez pas SQL injection, Cross Site Scripting, ou toute autre chose qui nécessite une analyse active. 

Depuis Jenkins attrapera toutes les modifications dans le référentiel, il démarrera le processus de construction immédiatement après avoir modifié le fichier. Vous pouvez revenir au projet simple-webapp en Jenkins pour voir les progrès en direct:

![image](https://github.com/user-attachments/assets/c2ab9e55-f82f-449b-95f1-3edee4346cfa)

Vous pouvez voir que la version actuelle ajoute maintenant le étape. Le scan prendra environ 5 minutes. Une fois terminé, la construction échouera, car ZAP trouvera quelques vulnérabilités dans l'application.Pour vérifier le rapport, ouvrez la version et allez à la page **Espaces de travail** section du menu:`Scan with OWASP ZAP`

![image](https://github.com/user-attachments/assets/ee00a0ed-de33-44db-96e7-2d6c108b08ef)

Ici, vous pouvez explorer les fichiers du projet, et ZAP mettra ses rapports dans le dossier zap-reports. Téléchargez et examinez le rapport pour répondre à la question à la fin de la tâche.

**Note:** Vous devez cliquer avec le bouton droit de la souris et enregistrer le rapport avant de l'ouvrir. L'ouvrir directement à partir de Jenkins va casser le formatage.

Répétez le même processus pour activer ZAP sur le dépôt simple-api et obtenez le rapport correspondant. Utilisez le rapport pour répondre aux questions à la fin de cette tâche.
