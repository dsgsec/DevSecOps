La confusion des dépendances est une vulnérabilité qui peut exister si notre organisation utilise des dépendances internes gérées par un gestionnaire de dépendances. En bref, une condition de course peut être créée par un attaquant qui pourrait conduire à une dépendance malveillante utilisée à la place de la dépendance interne. Dans cette tâche, nous examinerons la théorie d'une vulnérabilité de Confusion de Dépendance avant d'en exploiter pratiquement une dans la tâche suivante.

Contexte

La confusion de dépendance a été découverte par [Alex Birsan en 2021](https://medium.com/@alex.birsan/dependency-confusion-4a5d60fec610). Le problème provient de la façon dont les dépendances internes sont gérées. Jetons un coup d'œil à un exemple simple en Python:

`pip install numpy`

Que se passe-t-il réellement en arrière-plan lorsque nous exécutons cette commande? Lorsque nous exécutons cette commande, pip se connecte au référentiel PyPi externe pour rechercher un package appelé numpy, trouver la dernière version et l'installer. Dans le passé, il y a eu des moyens intéressants de compromettre ce paquet par une attaque de la chaîne d'approvisionnement:

-   **Typosquattage** un attaquant héberge un paquet appelé `nunpy`, en espérant qu'un développeur va mal interpréter le nom et installer leur paquet malveillant.
-   **Source Injection** un attaquant contribue au package d'une nouvelle fonctionnalité par le biais d'une requête d'extraction, mais intègre également une vulnérabilité dans le code qui pourrait être utilisée pour compromettre les applications qui utilisent la fonctionnalité paquet.
-   **Domaine Expiration** parfois, les développeurs de paquets peuvent oublier de renouveler le domaine où leur email est hébergé. Si cela se produit, un attaquant peut acheter le domaine expiré, ce qui lui permet un contrôle total sur les e-mails, qui pourrait être utilisé pour réinitialiser le mot de passe d'un responsable de paquet pour obtenir un contrôle total sur le paquet. Il s'agit d'un risque courant pour les packages hérités sur ces référentiels externes.

Il existe plusieurs autres méthodes d'attaque de la chaîne d'approvisionnement, mais elles ciblent toutes directement la dépendance ou ses responsables. Si nous voulions utiliser pip pour installer un paquet interne et nous avons suivi l'exemple sur [StackOverflow](https://stackoverflow.com/questions/55310229/pip-install-package-from-artifactory-and-install-dependencies-from-pypi) (comme tous les bons développeurs), notre étape de construction ressemblerait à ceci:

`pip install numpy --extra-index-url https://our-internal-pypi-server.com/`

Le `--extra-index-url` argument indique à pip qu'un serveur Pypi supplémentaire doit être inspecté pour le paquet. Mais que se passe-t-il si numpy existe à la fois dans le repo interne et dans le repo PyPi externe orienté vers le public? Comment pip sait-il quel paquet installer? Eh bien, c'est simple, il collectera le package à partir de tous les repos disponibles, comparera les numéros de version, puis installera le package avec le numéro de version le plus élevé. Vous devriez commencer à voir le problème ici.

Mise en scène d'une Attaque de Confusion de Dépendance

Tout ce dont un attaquant a vraiment besoin pour lancer une attaque de dépendance interne est le nom de l'une de vos dépendances internes. Bien que cela puisse sembler un défi, cela arrive plus souvent que prévu:

-   Les développeurs posent souvent des questions sur des forums publics tels que StackOverflow, mais n'obscurcissent pas les informations sensibles telles que les noms des bibliothèques utilisées, dont certaines pourraient être des dépendances internes.
-   Certaines applications compilées comme NodeJS divulguent souvent des noms de paquets internes `package.json` fichier, qui est généralement exposé dans l'application elle-même.

Une fois qu'un attaquant apprend le nom d'une dépendance interne, il peut tenter d'héberger un paquet avec un nom similaire sur l'un des repos externes du paquet mais avec un numéro de version plus élevé. Cela forcera tout système qui tente de construire l'application et d'installer la dépendance à se confondre entre le paquet interne et externe, et si l'externe est choisi, l'attaque de confusion de dépendance de l'attaquant réussira. L'attaque complète est montrée dans le diagramme ci-dessous:

![32b158ecec6d8ed7fbad6d97630cc414](https://github.com/user-attachments/assets/e365f431-0a77-41e5-a4b5-9d5c5de70872)

Considerations

There are a couple of things that should be kept in mind:

-   Since we only know the name of the internal package, not the actual source code of the package, if we perform a dependency confusion attack, the build process of the pipeline will most likely fail at a later step since the actual package was not installed.
-   Our external version number must be higher than the version number of the internal package for the confusion to work in our favour. However, this is easy since we can simply have a package with version number 9000 since most packages have major version numbers lower than 10.
-   Dependency confusion can affect any type of package, such as Python pip packages, JavaScript npm packages, or Ruby gems packages. We will demonstrate the attack through Python for simplicity.

Regardons pratiquement effectuer une attaque de confusion de dépendance dans la tâche suivante.
