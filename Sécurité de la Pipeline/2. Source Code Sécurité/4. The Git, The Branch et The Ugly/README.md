## Introduction: Git

Ici, nous allons couvrir les commandes de base pour interagir avec les projets dans GitLab.

Pour récupérer un projet à partir de GitLab, Git utilise une commande appelée clone. La syntaxe ressemble à ceci:

`git clone <repository_url>`

It's used to copy (clone) an existing repository (repo) at **un autre emplacement **dans un nouveau répertoire (**dépôts**'). Les systèmes de fichiers locaux ou les machines distantes accessibles par les protocoles pris en charge peuvent héberger le référentiel d'origine. Copies de travail de Git les référentiels ont leur historique, gèrent leurs fichiers et sont isolés de leurs référentiels sources. Le référentiel que vous créez sur votre ordinateur contient tous les fichiers et répertoires de votre projet. Vous pouvez considérer une branche comme des versions différentes de votre référentiel ou comme une ligne de développement indépendante. Différentes versions d'un référentiel peuvent être contenues dans plusieurs **branches**.

`git clone -branch`

Le *-**branche***argument vous permet de spécifier une branche à cloner au lieu de la branche par défaut vers laquelle la télécommande pointe. 

`git clone -branch name_of_branch <repository_url>`

L'exemple ci-dessus clonerait uniquement le nom_of_branch de la télécommande Git référentiel. 

Branching est une caractéristique commune dans la plupart des systèmes de contrôle de version (VCS) qui vous permet de diverger de la ligne principale de développement et de travailler sur les changements sans affecter la ligne principale. Git, un VCS populaire, a un modèle de branchement unique et puissant qui le distingue. Git les branches sont légères, rendant les opérations de ramification rapides et commutant rapidement entre les branches. Git encourage les ramifications et les fusions fréquentes, même plusieurs fois par jour, ce qui est essentiel pour un développement de projet efficace. 

## Compréhension GitModèle Branchement 's

Pour comprendre Git's modèle de branchement, it's essentiel de savoir comment Git stocke ses données. Git ne stocke pas les changements ou les différences; au lieu de cela, il conserve des instantanés du contenu. Lorsque vous faites un commit in Git, il crée un objet commit qui inclut un pointeur vers l'instantané du contenu, ainsi que des informations telles que les détails de l'auteur, le message commit et le parent commit(s) pointeur(s).

https://tryhackme-images.s3.amazonaws.com/user-uploads/61a7523c029d1c004fac97b3/room-content/cad159ab5dec96d6b750615de453a871.png

**Branchement:**

Git fournit la commande git branch pour créer, répertorier et supprimer des branches. Comme mentionné, les branches dans Git représenter des lignes de développement isolées. Lorsque vous créez une branche locale à partir d'une branche distante, les branches de suivi sont créées automatiquement par Git, qui sont des branches locales liées à des branches distantes. Vous pouvez lister les branches de suivi à distance à l'aide de l'option -r avec la commande git branch et les branches locales et distantes avec l'option -a.

In Git, les branches locales existent sur votre machine locale et les branches distantes sont stockées dans un emplacement distant. Comparer les différences entre les branches locales et distantes peut être utile. Voici les étapes pour le faire:

-   Mettez à jour les branches de suivi à distance en exécutant la commande: `git fetch` dans le terminal.
-   Listez les branches locales et distantes en utilisant la commande:  `git branch -a`. Cela montrera les branches avec un astérisque indiquant la branche actuellement vérifiée.
-   Pour lister spécifiquement les branches distantes, utilisez la commande suivante: `git branch -r`

**Ajout de code**

-   À **ajouter **modifications apportées à un fichier dans la zone de transit, utilisez le Git ajouter une commande suivie du nom du fichier. Cela dit Git pour inclure les modifications apportées au fichier dans le prochain commit.

`git add <filename>`

-   **Commettre**: Pour enregistrer les modifications apportées à la zone de transit. Cela crée un nouvel engagement dans le Git historique des changements apportés. Utilisez le message de validation pour ajouter la description des modifications; très important pour suivre les progrès.

`git commit -m "commit message"`

-   **Poussez**: Cela mettra à jour le référentiel distant avec les modifications que vous avez apportées localement. It's la commande finale pour télécharger les modifications de votre dépôt local vers la télécommande. Ajoutez le nom de la branche sur laquelle vous travaillez. **Note**: vous pouvez passer "origin". **"Origin" fait référence au référentiel à partir duquel un projet a été initialement cloné.**

`git push <branch name>`
