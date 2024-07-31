Exercice

Dans les profondeurs de l'espace, à bord de l'USCSS Nostromo, une équipe de développeurs était en mission pour explorer une planète lointaine. Alors qu'ils voyageaient dans le vide de l'espace, ils ont rencontré une créature étrange et terrifiante - un extraterrestre différent de tout ce qu'ils avaient jamais vu!

Alors qu'ils essayaient frénétiquement de se défendre contre les attaques du monstre, ils réalisèrent que quelque chose d'autre était encore plus dangereux que l'extraterrestre: le code du navire était criblé de trous de sécurité!

L'un des problèmes les plus alarmants était que**identifiants d'authentification sensibles** ils ont été codés directement dans le code source du logiciel du navire. Cela signifiait que toute personne ayant accès au code aurait accès à ces informations d'identification critiques, mettant ainsi toute la mission en danger.

Heureusement, l'équipe avait DevSecOps Des ingénieurs qui savaient quoi faire. Ils ont décidé d'utiliser *variables d'environnement* pour stocker les informations sensibles afin que les informations d'identification ne soient pas directement visibles dans le code source. De cette façon, ils pourraient empêcher l'accès non autorisé à leurs systèmes en protégeant leurs informations d'identification.

Pour commencer, appuyez sur le bouton Démarrer la machine en haut de cette tâche. Vous pouvez accéder à la VM en utilisant la AttackBox ou votre VPN connexion.

Ouvrez ensuite votre navigateur Web et allez à `https://LAB_WEB_URL.p.thmlabs.com` pour accéder au serveur Gitlab. Le VM prend environ 3-5 minutes pour démarrer complètement.

**Note:** En tant qu'utilisateur gratuit utilisant l'AttackBox, vous pouvez accéder à VM en allant à cette adresse. `http://MACHINE_IP`

![2776906471490844b26be33fa44005c5](https://github.com/user-attachments/assets/a607fef4-e0fc-4550-93d3-d5d1ec21c0bd)

Ensuite, connectez-vous au serveur GitLab en utilisant les informations d'identification fournies:

**Nom d'utilisateur: TryHackMe**

**Mot de passe: TryHackMe!**

Une fois connecté, recherchez le modèle de projet USCSS-Nostromo dans la barre de recherche GitLab.  

Déclenchement

Pour interagir avec un projet, vous devez ajouter un SSH clé de votre utilisateur pour cloner le projet. Bien que cela ne soit pas nécessaire pour cette tâche, vous pouvez le faire en suivant les étapes suivantes:

1.  Ouvrez une nouvelle fenêtre de terminal.
2.  Utilisez la commande suivante pour générer un nouveau SSH clé:

`ssh-keygen -t ed25519 -C "try@hackme.com"`

Une invite apparaîtra pour entrer un nom de fichier pour enregistrer la clé. Presse **Entrer** pour accepter le nom et l'emplacement du fichier par défaut.

Ensuite, il vous sera demandé d'entrer une phrase de passe pour la clé. Vous pouvez entrer une phrase secrète ou la laisser vide sans phrase secrète. Notez que l'utilisation d'une phrase secrète ajoute une couche de sécurité supplémentaire à votre SSH clé.

Une fois la clé générée, vous pouvez afficher la clé publique en tapant la commande suivante:

`cat ~/.ssh/id_ed25519.pub`  cela affichera la clé publique dans la fenêtre du terminal.

Copiez l'intégralité du contenu de la clé publique, y compris le préfixe "ssh-ed25519" et l'adresse e-mail, dans votre presse-papiers. Ensuite, faites ce qui suit:

1.  Dans l'instance GitLab, accédez aux paramètres de votre profil en cliquant sur "Modifier le profil".
2.  Cliquez sur l'onglet "Touches SSH" (option 3 en bas). 
3.  Collez le contenu de votre clé publique dans le champ "Key.
4.  Donnez un titre à la clé, comme "My GitLab SSH Key".

5.  Cliquez sur le bouton "Ajouter la clé" pour enregistrer SSH clé de votre compte GitLab.

![a45e79c676314e036d865c952234f097](https://github.com/user-attachments/assets/fa532c6f-e5e3-4e42-8c0b-b1a6bb27efe3)

Cloner le Projet

Après vous être familiarisé avec le projet, clonez-le sur votre machine locale en utilisant la commande suivante:

`git clone <project-URL>` où **projet-URL** c'est la même URL que vous avez utilisée pour vous connecter sur votre navigateur. Entrez ensuite les informations de connexion d'avant.

Si vous souhaitez utiliser le SSH protocole, ajoutez d'abord le `gitlab.tryhackme.loc` nom d'hôte dans votre fichier hosts avec la commande `echo 'MACHINE_IP gitlab.tryhackme.loc' >> /etc/hosts`. Alors obtenez le SSH URL trouvée sous le `Clone drop-down`:


<img width="403" alt="61a7523c029d1c004fac97b3-1720717035512" src="https://github.com/user-attachments/assets/53d33485-d4d6-467e-a17f-ab8579b9cf01">

Ensuite, entrez dans le projet avec `cd uscss-nostromo` et créer un **nouvelle branche** pour travailler en exécutant la commande suivante:

`git checkout -b <branch-name-of-you-choice>`

Pouvez-vous voir ce qui ne va pas avec nostromo.go?

Environnement Variables

Nous avons mentionné les Variables d'environnement dans les tâches précédentes dans le cadre des meilleures pratiques. Ce sont des paires clé-valeur définies dans le système d'exploitation ou l'environnement shell et accessibles par des programmes et des scripts s'exécutant dans cet environnement. Les variables d'environnement peuvent stocker divers types d'informations, tels que **paramètres de configuration**, **fichier** **chemins**, et **identifiants d'authentification**. Ils gèrent généralement la configuration logicielle dans différents environnements, tels que le développement, la mise en scène et la production.

En programmation, les variables d'environnement sont souvent utilisées pour transmettre des informations entre différentes parties d'une application ou d'un système ou pour configurer le comportement d'un programme en fonction de son environnement.

**os.getenv**

Il serait préférable si vous aviez repéré les informations d'identification en texte brut dans nostromo.go maintenant. Pour apporter des modifications au projet, ouvrez le fichier uscss-nostromo/nostromo.go et remplacez les informations d'identification codées en dur par des variables d'environnement.

Pour implémenter des variables d'environnement, nous utiliserons `os.getenv`. **Os****.getenv** est une fonction utilisée pour récupérer les valeurs des variables d'environnement. Le** os.getenv** la fonction prend un seul argument: le nom de la variable d'environnement que vous souhaitez récupérer. Si la variable d'environnement est trouvée, la fonction renvoie sa valeur sous forme de chaîne. La fonction renvoie None (ou nil dans certains langages de programmation) si la variable d'environnement n'est pas trouvée. Le paquet que nous devons importer pour utiliser os.getenv est os. Il nous suffit d'ajouter `import ("os")` comme indiqué ci-dessous:

```

import (
    "fmt"
    "net/http"
    "os"
)

```

Pour implémenter os.getenv, vous pouvez remplacer ces lignes:

```

func init () {
    apiURL = "https://example.com"
    username = "admin"
    password = "p@ssw0rd"
}

```

Avec ces lignes:

```

func init () {
    apiURL = "https://example.com"
    username = os.Getenv("GITLAB_USERNAME")
    password = os.Getenv("GITLAB_PASSWORD")
}

```

Une fois que vous avez effectué vos modifications, ajoutez, validez et poussez-les vers la branche à l'aide de la commande suivante:

`git commit -a -m "Fixed credential hygiene by using environment variables"`

Pour appliquer vos modifications à la branche, utilisez la commande suivante:

`git push -u origin <branch-name-chosen-earlier>`

Vérifiez que les modifications que vous avez apportées dans la branche sont maintenant dans la branche principale en vérifiant le fichier uscss-nostromo/nostromo.go pour vos informations d'identification mises à jour.

Dans cette base de code mise à jour, nous avons les éléments suivants:

1.  Utilisé le `os.Getenv()` fonction pour lire le `NOSTROMO_API_URL`, `NOSTROMO_USERNAME`, et `NOSTROMO_PASSWORD` variables d'environnement, qui peuvent être gérées à l'aide de la fonction de gestion des secrets de GitLab.
2.  Depuis `os.Getenv` récupère les informations sensibles telles que les informations d'identification de la base de données, la base de code nostromo.go est plus sécurisée et plus facile à maintenir. Si les informations d'identification doivent être mises à jour ou tournées, elles peuvent être mises à jour dans les variables d'environnement sans modifier directement le code.

![16987028d236a18237d596d55b14c62c](https://github.com/user-attachments/assets/06ec3699-5039-4fdc-987f-aef56a1e49c3)


**Ne fusionnez pas encore les changements, nous n'avons toujours pas fini de sécuriser le Nostromo API. Continuez à la tâche suivante pour récupérer le drapeau final! **
