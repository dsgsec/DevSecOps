Introduction

[CALME](https://www.atlassian.com/devops/frameworks/calms-framework), comme expliqué dans le post Atlassian, est un cadre qui évalue la capacité d'une entreprise à adopter des processus DevOps. L'acronyme a été inventé par Jez Humble, co-auteur de "The DevOps Handbook", qui signifie Culture, Automation, Lean, Measurement et Sharing.

Culture\
Comme souligné dans le [Intro À DevSecOps](https://tryhackme.com/jr/introductiontodevsecops) chambre, DevOps n'est pas simplement un processus ou une approche différente du développement; c'est un changement de culture. Pour tout DevOps adoption pour réussir, une organisation devra faire un changement de culture. Plutôt que l'approche plus lente et à libération complète du modèle en cascade, les équipes devront adopter de nouvelles stratégies pour diviser les projets en tâches plus petites qui peuvent être complétées puis présentées dans une série de sprints. Ce changement de culture est nécessaire pour tous les employés, y compris non seulement les équipes de développement, mais aussi l'AQ, la gestion des produits et les opérations.

AutomatisationUne grande partie de DevOps est l'accent mis sur l'automatisation. Étant donné que nous divisons les projets en composants plus petits, il serait inefficace d'intégrer manuellement ces composants dans la solution finale. Ainsi, il est préférable de passer du temps à créer des processus automatisés qui peuvent garantir que les nouvelles intégrations de fonctionnalités peuvent se produire de manière fiable et reproductible. Cela commence généralement du côté de la livraison continue pour les nouvelles équipes. Mais à mesure que les équipes mûrissent, elles passeront également à une intégration continue.

Les équipes matures peuvent également chercher à automatiser la configuration elle-même grâce à des outils tels que la configuration en tant que code. Cela signifie que la configuration de l'application elle-même est définie dans le code, ce qui modifierait les instructions de construction en fonction de l'environnement pour lequel l'application est construite. Cela rationalise le processus de création de code prêt pour la production, et les paramètres de configuration pourraient être utilisés pour réduire la verbosité des erreurs et supprimer les contournements des développeurs avant que le code ne soit construit pour l'environnement de production.

Maigre\
En mettant en œuvre DevOps, nous voulons nous assurer que les tâches sont brisées aussi petites que possible. Cela permet aux équipes de créer des versions initiales des applications plus rapidement. Le principe commun est que nous améliorons constamment notre logiciel, mais il est plus précieux d'obtenir une version de notre application dans les mains des utilisateurs plus tôt plutôt que d'avoir à attendre des années jusqu'à ce que le produit soit complètement perfectionné. Ainsi, nous commençons avec une première version allégée qui est constamment améliorée avec le temps. Cette méthode permet également à notre base d'utilisateurs de fournir des commentaires et une liste de fonctionnalités pour l'application.

Mesure

Lors de l'implémentation DevOps, il est important d'avoir une sorte de mesure de l'efficacité. Ces mesures sont importantes car elles nous aideront à apporter de petits changements à nos processus et à nous assurer que nous nous améliorons constamment. Dans la prochaine tâche, nous allons développer sur la façon dont DevOps gère les mesures et les mesures essentielles pour rechercher une amélioration et un suivi constants.

Partage\
Dans un efficace DevOps pipeline, il y a une responsabilité partagée pour l'application globale entre toutes les équipes, y compris le développement et les opérations. Comprendre que tous les membres de l'équipe sont tenus de fournir la solution finale et de partager la responsabilité de le faire se traduira par un meilleur produit pour les utilisateurs.
