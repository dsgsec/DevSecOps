![3804e1b22987fc90c27d19e511ead12e](https://github.com/user-attachments/assets/8a3dc37d-af41-4cb6-87b6-cdf2daac9836)

Regardons le code source et le contrôle de version. C'est le début de notre pipeline. Nous avons besoin d'un endroit où nous pouvons stocker notre code. De plus, nous souhaitons souvent conserver plusieurs versions de notre code, car nous apportons continuellement des améliorations et ajoutons des fonctionnalités.

Source Code Stockage

Nous devons considérer plusieurs choses au moment de décider où stocker notre code:

-   Comment pouvons-nous effectuer un contrôle d'accès pour notre code source?
-   Comment pouvons-nous nous assurer que les modifications apportées sont suivies?
-   Pouvons-nous intégrer notre système de stockage de code source à nos outils de développement?
-   Pouvons-nous stocker et utiliser activement plusieurs versions différentes de notre code source?
-   Devrions-nous héberger notre code source en interne, ou pouvons-nous utiliser un tiers externe pour héberger notre code?

Les réponses à ces questions nous aideront à choisir la bonne solution de stockage de code source pour notre projet.

Contrôle de Version

Nous avons besoin de contrôle de version pour deux raisons principales:

-   Nous intégrons souvent de nouvelles fonctionnalités dans notre logiciel. Les approches de développement modernes, telles que Agile, nous mettent constamment à jour notre code. Pour contrôler toutes ces mises à jour, nous avons besoin d'un contrôle de version.
-   Toute une équipe de développement travaille sur le code, pas seulement un développeur. Pour nous assurer que nous pouvons intégrer les modifications de plusieurs développeurs, un contrôle de version est nécessaire.

Le contrôle de version nous permet de conserver plusieurs versions du code. Cela peut être la version spécifique sur laquelle chaque développeur travaille, mais il peut également s'agir de versions complètement différentes de notre application, y compris les versions mineures et majeures.

Outils Communs

Les deux systèmes de stockage de code source et de contrôle de version les plus courants sont Git et SubVersion (SVN). Git est un outil de contrôle de source distribué, ce qui signifie que chaque contributeur aura sa propre copie du code source. D'autre part, SVN est un outil de contrôle de source centralisé, ce qui signifie que le contrôle du dépôt est géré de manière centralisée.

GitHub est de loin le plus grand fournisseur d'hébergement Internet pour le développement de logiciels et le contrôle de version utilisant Git. Vous pouvez créer un compte GitHub et l'utiliser pour gérer vos référentiels de code source (repo). Cependant, vous pouvez également héberger votre propre serveur git à l'aide de logiciels tels que Gitlab. Pour SVN, les deux outils les plus populaires sont TortoiseSVN et Apache SVN.

Cependant, il convient de noter que les solutions de stockage de code source telles que Gitlab fournissent beaucoup plus de fonctionnalités que le simple stockage et le contrôle de version. Aujourd'hui, ces outils peuvent être utilisés pour presque tout le pipeline!

Considérations de Sécurité

Notre code source est souvent notre sauce secrète. En tant que tel, nous voulons nous assurer qu'il n'est pas exposé. C'est pourquoi l'authentification et le contrôle d'accès pour notre code source sont si importants. Nous voulons également nous assurer que les modifications et les mises à jour sont correctement suivies, ce qui nous permet de toujours revenir à une version précédente si quelque chose se produit.

Cependant, nous devons également faire attention à ce que nous stockons dans le cadre de notre code source. Le code source ne peut pas être totalement secret car les développeurs doivent y accéder. En tant que tel, nous devrions faire attention à ne pas confondre le stockage de code source avec la gestion secrète. Nous devons nous assurer de ne pas stocker de secrets, tels que des chaînes de connexion et des informations d'identification de base de données, dans notre code source. Puisque nous conservons toutes les versions de notre code source, même si nous supprimons les secrets dans une version plus récente, ils seront toujours exposés dans les versions précédentes.

Étude de cas: Git Jamais Forger

Comme mentionné précédemment, le contrôle de version peut mal se terminer pour nous si nous commettons une erreur. C'est un problème courant lors de l'utilisation d'outils de contrôle de version tels que Git. Il y a un dicton: *"Le git n'oublie jamais"*. Le code est "engagé" à un Git pension. Lorsque cela se produit, Git détermine les modifications apportées aux fichiers et crée une nouvelle version en fonction de ces modifications. Tout utilisateur ayant accès au dépôt peut consulter les commits historiques et les modifications qui ont été apportées.

Ce qui peut souvent arriver, c'est qu'un développeur commet accidentellement des secrets tels que des informations d'identification ou des chaînes de connexion à une base de données vers un dépôt Git. Réalisant leur erreur, ils suppriment les secrets et créent un autre commit. Cependant, le dépôt aura maintenant les deux commits. Si un attaquant avait accès au dépôt, il pourrait utiliser un outil tel que [GittyLeaks](https://github.com/kootenpv/gittyleaks), qui analyserait les commits pour obtenir des informations sensibles. Même si ces informations n'existent plus dans la version actuelle, ces outils peuvent parcourir toutes les versions précédentes et découvrir ces secrets.
