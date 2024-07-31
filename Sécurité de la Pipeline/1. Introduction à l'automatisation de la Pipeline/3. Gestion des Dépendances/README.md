![05428b2c1ae49738813c1644df3a31a3](https://github.com/user-attachments/assets/50bb9064-cca2-4527-93af-79d9d3f8d862)
Parlons des dépendances. Bien que nous puissions penser que nous écrivons une grande quantité de code lorsque nous développons, la vérité est que ce n'est que la pointe de l'iceberg. Sauf si vous codez en binaire, il y a de fortes chances que vous n'écriviez qu'une fraction du code réel. C'est parce qu'une grande partie du code a déjà été écrit pour nous sous la forme de bibliothèques et de kits de développement de logiciels (SDK). Même les variables comme String dans une application ont une bibliothèque entière derrière elles! La gestion de ces dépendances est une partie essentielle du pipeline.

## Dépendances Extérieures vs Internes

Les dépendances externes sont des bibliothèques et des SDK accessibles au public. Ceux-ci sont hébergés sur des gestionnaires de dépendances externes tels que PyPi pour Python, NuGet pour .NET et Gems pour les bibliothèques Ruby. Les dépendances internes sont des bibliothèques et SDK qu'une organisation développe et maintient en interne. Par exemple, une organisation peut développer une bibliothèque d'authentification. Cette bibliothèque pourrait ensuite être utilisée pour toutes les applications développées par l'organisation.

Il existe différents problèmes de sécurité pour les dépendances internes et externes:

|                                                                             Interne                                                                            |                                                                                                                Externe                                                                                                               |
|:--------------------------------------------------------------------------------------------------------------------------------------------------------------:|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|
| Les bibliothèques peuvent souvent devenir des logiciels hérités car elles ne reçoivent plus de mises à jour ou le développeur d'origine a quitté l'entreprise. |                                 Puisque nous n'avons pas le contrôle total sur la dépendance, nous devons faire preuve de diligence raisonnable pour nous assurer que la bibliothèque est sécurisée.                                 |
|                                La sécurité du gestionnaire de paquets est notre responsabilité pour les bibliothèques internes.                                |                                   Si un gestionnaire de paquets ou un réseau de distribution de contenu (CDN) est compromis, cela pourrait entraîner une attaque de la chaîne d'approvisionnement.                                   |
|          Une vulnérabilité dans une bibliothèque interne pourrait affecter plusieurs de nos applications, car elle est utilisée dans chacune d'elles.          | Les bibliothèques externes peuvent être recherchées par des attaquants pour découvrir les vulnérabilités 0day. Si une telle vulnérabilité est trouvée, elle pourrait conduire au compromis de plusieurs organisations en même temps. |

## Outils Communs

Un gestionnaire de dépendances, également appelé gestionnaire de paquets, est nécessaire pour gérer les bibliothèques et les SDK. Comme mentionné précédemment, des outils tels que PyPi, NuGet et Gems sont utilisés pour les dépendances externes. La gestion des dépendances internes est un peu plus délicate. Pour ceux-ci, nous pouvons utiliser des outils tels que JFrog Artifactory ou Azure Artifacts pour gérer ces dépendances.

## Considérations de Sécurité

Certaines considérations de sécurité ont déjà été mentionnées. Cependant, le principal problème de sécurité est que les dépendances sont du code hors de notre contrôle. Surtout dans les temps modernes, où tant de dépendances différentes sont utilisées, il est incroyablement difficile de suivre les dépendances. S'il y a des vulnérabilités dans ces dépendances, cela pourrait conduire à des vulnérabilités dans notre application.

## Étude de cas: Log4Shell

Une vulnérabilité 0day a été découverte dans la dépendance Log4j en 2021 appelée Log4Shell. Log4j est un utilitaire de journalisation basé sur Java. Il fait partie de Apache Logging Services, un projet de la Apache Software Foundation. Cette vulnérabilité pourrait permettre à un attaquant non authentifié d'obtenir l'exécution de code à distance sur un système qui utilise l'enregistreur. Le vrai problème? Cette petite dépendance était utilisée presque littéralement partout, comme le montre cette [XKCD](https://xkcd.com/2347/) dessin animé:

![fc00c5498dde8630a9b4e5f4ebcc308d](https://github.com/user-attachments/assets/adc59f26-e402-4901-a137-13dd10ea3c61)


Ce n'est pas une exagération. Jetez un oeil [ici](https://github.com/cisagov/log4j-affected-db/tree/develop/software_lists) voir combien de produits différents étaient vulnérables depuis qu'ils utilisaient cette dépendance. La liste est devenue si grande qu'ils ont dû la diviser par ordre alphabétique. Cela montre l'impact de ce qui peut arriver quand une vulnérabilité est découverte dans une dépendance.
