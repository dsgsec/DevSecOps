Dans la tâche précédente, nous avons appris les différents styles de développement de logiciels au fil des ans et comment ceux-ci ont joué un grand rôle dans le développement de logiciels création de DevOps. Cette tâche vous présentera les concepts clés, les outils et la façon dont ils fonctionnent tous ensemble.

Comment fait DevOps travail?

DevOps est visualisé comme une boucle infinie, décrivant toutes les phases qui la composent:﻿

![538ad9f777ec0153d5d648edd4bcf65a](https://github.com/user-attachments/assets/52176064-d34f-40ff-95a5-22fe08aed8db)


En suivant la boucle infinie du diagramme DevOps, développons certains outils et processus DevOps que nous examinerons en suivant les étapes suivantes DevSecOps chemin et comment ils aident une organisation:

1.  **CI/ CD** -- Dans la tâche précédente, nous avons mentionné CI/CD (Intégration Continue et Continue Déploiement); CI/CD traite de la fusion fréquente de code et de l'ajout de tests de manière automatisée pour effectuer des vérifications à mesure que le nouveau code est poussé et fusionné. Nous pouvons tester le code au fur et à mesure que nous poussons et fusionnons grâce à une nouvelle dynamique et routine en déploiement, qui prend la forme de modifications mineures de code systématiquement et régulièrement. Grâce à ce changement de dynamique, il, CI/CD aide à détecter les bogues tôt et diminue l'effort de maintenir massivement le code modulaire, ce qui introduit des retours en arrière fiables des versions/code.
2.  **INFRASTRUCTURE COMME CODE** (IaC) -- un moyen de gérer et de provisionner l'infrastructure via le code et l'automatisation. Grâce à cette approche, nous pouvons réutiliser le code utilisé pour déployer l'infrastructure (par exemple, les instances cloud), ce qui facilite la création et la gestion incohérentes des ressources. Les outils standard pour IaC sont terraform, vagrant, etc. Nous allons utiliser ces outils plus loin dans la voie que nous expérimentons avec la sécurité IaC.

3.  **GESTION DES CONFIGURATIONS** -- C'est là que l'état de l'infrastructure est géré en permanence et l'application des changements efficacement, ce qui le rend plus maintenable. Grâce à cela, beaucoup de temps est économisé et plus de visibilité sur la configuration de l'infrastructure. Vous pouvez utiliser IaC pour la gestion de la configuration.
4.  **ORCHESTRATION** -- Orchestration est l'automatisation des workflows. Aide à atteindre stabilité; par exemple, en automatisant la planification des ressources, nous pouvons avoir des réponses rapides chaque fois qu'il y a un problème (par exemple, les contrôles de santé échouent); cela peut être réalisé grâce à la surveillance.
5.  **SURVEILLANCE** -- se concentre sur la collecte de données sur la performance et la stabilité des services infrastructure. Cela permet plus rapidement récupération, aide à la visibilité inter-équipes, fournit plus de données pour analysez pour une meilleure analyse des causes profondes et générez également un système automatisé réponse, comme mentionné précédemment.
6.  **MICROSERVICES** -- Une architecture cela divise une application en de nombreux petits services. Cela présente plusieurs avantages, comme la flexibilité s'il est nécessaire d'évoluer, la complexité réduite et davantage d'options pour choisir la technologie entre les microservices. Nous les examinerons plus en détail dans le DevSecOps voie.
