Introduction

Avant d'explorer les erreurs de configuration, il vaut la peine de créer notre propre pipeline afin que nous puissions jouer.

Gitlab Enregistrement

Nous allons commencer le processus en créant un compte sur l'instance GitLab. Naviguer pour [http://gitlab.tryhackme.loc](http://gitlab.tryhackme.loc/) et sélectionnez le **Inscrivez-vous Maintenant** option sur la page. Remplissez les informations requises pour créer votre compte et vous inscrire. N'oubliez pas de sélectionner un mot de passe sécurisé et de l'enregistrer pour votre voyage à travers ce réseau! Une fois authentifié, vous devriez être rencontré par cette page:

![55db0c02028b6c7628f8c22235ba8093](https://github.com/user-attachments/assets/8cda7407-5066-4c9b-bc04-9f6f71bbca7d)

N'hésitez pas à explorer les fonctionnalités du serveur Gitlab. Gitlab est assez similaire à Github; cependant, il vous permet d'héberger votre propre serveur!

Création de Projet

Maintenant que vous avez un compte, l'étape suivante consiste à créer un nouveau projet. N'hésitez pas à créer certains de vos projets directement pour jouer avec la fonctionnalité. Cependant, puisque nous voulons jouer avec les pipelines, vous pouvez faire un fork d'un projet existant qui a été créé à cet effet.

Cliquez sur le *Votre onglet travail*, puis l'option Explorer, et recherchez BasicBuild. Vous verrez un projet comme celui-ci:

![ba274fe1b4b619508c2bea4961bba823](https://github.com/user-attachments/assets/0fae233b-b0a9-4a6a-8e9b-2b39a0ae07d0)


Cliquez sur le projet puis sur Fork. Pour les options du projet, assurez-vous de spécifier votre nom d'utilisateur comme espace de noms et de définir le projet sur Privé, comme indiqué ci-dessous.

![ea7a7734618d95cd1a701e14402ebf81](https://github.com/user-attachments/assets/ad34e509-46a8-4b38-8c73-6600aecef651)

Une fois cela fait, vous pouvez bifurquer le projet! Cela crée maintenant une copie du projet que vous possédez et pouvez configurer.

Compréhension CI/CD Configuration

Dans Gitlab, l'automatisation de projet est définie dans le fichier .gitlab-ci.yml. Ce fichier contient les étapes qui seront effectuées automatiquement lorsqu'un nouveau commit est effectué sur le dépôt. Comprendre ce que font les commandes de ce fichier sera important dans votre parcours d'apprentissage de la sécurité de construction. Jetons un coup d'oeil au contenu du fichier.

**Étapes**

GitLab CI les fichiers vous permettent de définir différents travaux. Chaque tâche a différentes étapes qui doivent être exécutées, comme trouvé dans le *script* section du travail. Habituellement, il y a trois étapes à n'importe quel pipeline CI, à savoir la phase de construction, de test et de déploiement, mais il peut y en avoir plus. Jetons un coup d'oeil au travail de construction:

**.gitlab-ci.yml**

```
build-job:
  stage: build
  script:
    - echo "Hello, $GITLAB_USER_LOGIN!"

```

La première ligne, build-job, est le nom du travail. La valeur de l'étape est de dire à Gitlab quelle étape du processus CI Pipeline à laquelle ce travail appartient. Comme mentionné précédemment, cela peut être construit, testé ou déployé. Les travaux de chaque étape sont exécutés en parallèle. Cela signifie que tous les travaux de construction s'exécuteront simultanément, tout comme tous les travaux de test et de déploiement. Si un travail échoue, les étapes ultérieures ne commenceront pas. Si une tâche ne spécifie pas d'étape, elle sera automatiquement affectée à l'étape de test. Si vous devez modifier l'ordre d'emploi, vous pouvez utiliser le *besoins* section pour définir les noms des tâches qui doivent être terminées avant que la tâche suivante puisse être exécutée.

La partie script détaille les commandes qui seront exécutées dans le cadre de la tâche. Comme vous pouvez le voir, seule une commande echo s'exécutera pour ce travail de construction. Cependant, nous complétons normalement toutes les activités de construction à l'étape de construction, telles que le chargement des dépendances et la compilation de notre code. Puisque nous déployons un simple PHP site web, il n'y a aucune raison de compiler du code.

**Essais**

Les travaux de test sont destinés à effectuer des tests sur la construction pour s'assurer que tout fonctionne comme prévu. Habituellement, vous exécuteriez plus d'un travail de test pour vous assurer que vous pouvez tester individuellement des parties de l'application. Si une tâche de test échoue, les autres tâches de test continueront, ce qui vous permettra de déterminer tous les problèmes liés à la construction actuelle, plutôt que d'avoir à faire plusieurs versions. Jetons un coup d'oeil aux deux cas de test:

**.gitlab-ci.yml**

```
test-job1:
  stage: test
  script:
    - echo "This job tests something"

test-job2:
  stage: test
  script:
    - echo "This job tests something, but takes more time than test-job1."
    - echo "After the echo commands complete, it runs the sleep command for 20 seconds"
    - echo "which simulates a test that runs 20 seconds longer than test-job1"
    - sleep 20

```

Comme vous pouvez le voir, nous n'avons rien à tester avec notre simple PHP application web. Cependant, nous pouvons simuler qu'un cas de test prendra plus de temps que l'autre.

**Déploiement**

Au stade du déploiement, nous souhaitons déployer notre application dans l'environnement pertinent si les étapes de construction et de test réussissent. Habituellement, les branches sont utilisées dans les repos de code source, la branche principale étant la seule qui peut être déployée en production. D'autres branches se déploieront dans des environnements tels que DEV ou UAT. Jetons un coup d'œil à ce que nous faisons dans le travail de déploiement:

**.gitlab-ci.yml**

```
deploy-prod:
  stage: deploy
  script:
- echo "This job deploys something from the $CI_COMMIT_BRANCH branch."
    - echo "Making the website directory"
    - mkdir -p /tmp/time/cicd
    - echo "Copying the website files"
    - cp website_src/* /tmp/time/cicd/
    - echo "Hosting website using a screen"
    - screen -d -m php -S 127.0.0.1:8081 -t /tmp/time/cicd/ &
    - echo "Deployment complete! Navigate to http://localhost:8081/ to test!"
  environment: production

```

La première étape du travail de déploiement consiste à créer un nouveau répertoire sous /tmp/ où nous pouvons placer notre application web. Nous copions ensuite les fichiers de l'application Web dans le répertoire et modifions les autorisations des fichiers. Une fois cela fait, hébergez l'application, en utilisant PHP. Maintenant, nous sommes prêts à lancer notre application!

*CI fichiers* peut devenir beaucoup plus complexe car il y a beaucoup plus de sections et de mots-clés que vous pourriez utiliser. Si vous voulez en savoir plus, vous pouvez regarder [ici](https://docs.gitlab.com/ee/ci/yaml/index.html). Maintenant que nous comprenons mieux l'automatisation intégrée, examinons son utilisation réelle. Pour que la construction soit exécutée, nous devons enregistrer un coureur.

Inscription des Coureurs

Dans Gitlab, nous utilisons des runners pour exécuter les tâches configurées dans le projet. Suivons le processus pour enregistrer votre machine d'attaque en tant que coureur pour votre projet.

**Note**: Assurez-vous que PHP est installé (`sudo apt install php7.2-cli`) avant de continuer. Notez que si vous faites cela sur votre propre machine, assurez-vous que le coureur déploie une application Web sur votre machine. Sinon, il est préférable de le faire sur l'AttackBox.

Dans votre projet, cliquez sur Paramètres, puis CI/CD:

![9a8bb9c51c2f90b6d38b880be4b10b2a](https://github.com/user-attachments/assets/ab52b8f0-b159-4991-b6e8-e1dc6f5b4f74)

Développez la section Runners, et vous devriez voir l'écran suivant:

![be6417445bc9a04a222c2f783cc3b24d](https://github.com/user-attachments/assets/07c03b83-cc56-473d-99a6-a52ce5c48552)

Ici, vous serez en mesure de configurer un nouveau coureur pour votre projet. Cliquez sur les trois points et sur le bouton Afficher les étapes d'installation de Runner. Vous verrez l'écran suivant:

![ad7b6d1c752c0abc2580477167f066c3](https://github.com/user-attachments/assets/142933fd-b384-437e-8f8a-5926422b8a4f)

Le premier bloc de code consiste à installer l'application GitLab-runner. Suivez ces étapes pour installer l'application sur votre machine d'attaque. Une fois terminé, utilisez la commande dans le deuxième bloc de code pour enregistrer votre coureur. Suivez les instructions ci-dessous pour le processus d'installation:

Terminal

```
root@ip-10-10-45-212:~# sudo gitlab-runner register --url http://gitlab.tryhackme.loc/ --registration-token "token"
Runtime platform                                    arch=amd64 os=linux pid=7248 revision=782e15da version=16.2.0
Running in system-mode.

Enter the GitLab instance URL (for example, https://gitlab.com/):
[http://gitlab.tryhackme.loc/]:
Enter the registration token:
["token"]:
Enter a description for the runner:
[ip-10-10-45-212]: runner-attackbox
Enter tags for the runner (comma-separated):
production
Enter optional maintenance note for the runner:

WARNING: Support for registration tokens and runner parameters in the 'register' command has been deprecated in GitLab Runner 15.6 and will be replaced with support for authentication tokens. For more information, see https://gitlab.com/gitlab-org/gitlab/-/issues/380872
Registering runner... succeeded                     runner=GR1348941qguXCM9b
Enter an executor: shell, virtualbox, instance, kubernetes, custom, docker, docker-windows, docker+machine, parallels, ssh, docker-autoscaler:
shell
Runner registered successfully. Feel free to start it, but if it's running already the config should be automatically reloaded!

Configuration (with the authentication token) was saved in "/etc/gitlab-runner/config.toml"
```

Maintenant que votre coureur est configuré, vous pouvez actualiser la page sur Gitlab, et vous devriez voir votre coureur:

![8b798c1444c78b642199c08f3be01516](https://github.com/user-attachments/assets/a5b1807f-f780-40c4-b850-a72ee5e2d78b)

La dernière étape consiste à configurer votre coureur pour exécuter des tâches non étiquetées, comme notre CI Pipeline n'utilise pas de balises. Normalement, les étiquettes seraient utilisées pour s'assurer que les bons coureurs reprennent les différents travaux. Cependant, puisque nous avons un travail simple, nous pouvons simplement dire à notre coureur d'exécuter tous les travaux. Cliquez sur l'icône du petit crayon et cliquez sur Exécuter les travaux non marqués:

![84ff9051a95bc7a09eed29cf2887688b](https://github.com/user-attachments/assets/2f1c8d6b-c5a9-4d03-a9f5-01fd9818fe49)

Vous êtes maintenant prêt à commencer le processus de construction!

Construire Automatisation

Maintenant que le coureur est enregistré, nous pouvons tester le processus de construction en effectuant un nouveau commit. Le changement le plus simple à faire pour lancer une compilation est de mettre à jour le fichier README.md:

1.  Cliquez sur le fichier dans le dépôt
2.  Sélectionnez Modifier
3.  Sélectionnez Modifier un fichier unique
4.  Faire une mise à jour du fichier
5.  Cliquez sur Commettre les modifications

Une fois terminé, votre processus de construction aura commencé! Nous pouvons suivre le processus en cliquant sur Construire, puis Pipelines:

![eb987192231a3765ee4a2936220bceff](https://github.com/user-attachments/assets/c55fcc6c-6771-40a8-9ec1-be42c33e5701)

Une fois sur place, vous devriez voir que votre pipeline a démarré! Cliquez sur le pipeline pour voir quel travail il effectue actuellement et la sortie de celui-ci:

![f7486c18218051d7cbf394915074ddf6](https://github.com/user-attachments/assets/a76d61c3-76d0-4fe4-9215-dca909ae6d1f)

Vous pouvez également cliquer sur le pipeline pour voir sa progression:

![0ac8ac26762396a70e76c3f76e67cd53](https://github.com/user-attachments/assets/1f7d0eee-034b-4ce9-b089-e487b5dcd574)

Une fois terminée, votre application aura été déployée! Vous pouvez vérifier cela en naviguant vers <http://127.0.0.1:8081/>, et vous devriez être rencontré par la page d'accueil de l'application Web.

![c18c9c2b2bcf7e4075cfe9e1dc54912e](https://github.com/user-attachments/assets/9e098a8c-4ccc-45e9-9554-349e183a2a17)

Félicitations! Vous avez créé la vôtre CI/Processus de pipeline et de construction de CD! N'hésitez pas à jouer plus avec le CI/CD configuration du pipeline et votre coureur!

**Note:** Si vous souhaitez supprimer le site, vous pouvez utiliser `sudo su gitlab-runner` suivi par `screen -r` pour vous connecter à l'écran qui héberge votre site Web. À partir de là, vous pourrez mettre fin au site Web.
