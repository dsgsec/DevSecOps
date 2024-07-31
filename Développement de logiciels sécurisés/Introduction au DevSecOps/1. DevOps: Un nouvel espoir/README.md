Depuis sa création, Developer Operations (DevOps) est devenu une influence significative dans le Développement Logiciel moderne, le Déploiement et les Opérations. Mais d'où vient le terme?

* * * * *

**L'histoire de DevOps**

Il y a longtemps, il y avait des cascades dans une galaxie lointaine, très lointaine.

**Waterfall Modèle**

C'est le nom donné à la façon dont la gestion de projet a été abordée à l'époque (les années 70). Le cycle constitué et fondé sur un* hiérarchie, *où chaque membre avait une responsabilité spécifique. Par exemple, les administrateurs système ont travaillé sans relâche pour que tout fonctionne bien et à flot. Les développeurs construisent et ajoutent autant de fonctionnalités que possible, et enfin, les ingénieurs Assurance Qualité (QA) testent les fonctionnalités du système, en veillant à ce que tout fonctionne comme prévu. 
![21ff900651b19689600a2a7d0cd2fcea](https://github.com/user-attachments/assets/42a70954-5a5e-4c7b-a1f6-b7da160c55b9)


Si quelque chose dérange les serveurs ou quelque chose a besoin de déploiement, sysadmins sauter sur elle. S'il s'agit d'un problème de code, les développeurs éteindront le feu. S'il y a quelque chose à voir avec la fonctionnalité de test et les commentaires, les équipes d'Assurance Qualité s'en occuperont. Mais que faire s'il y a un défaut? Un bug? Qui le répare? Ces situations ont conduit à de nombreux jeux de blâme et à passer le relais autour de cette friction créée, les choses se retrouveraient en retard, et la symbiose entre les équipes finirait par ne plus fonctionner. Au fur et à mesure que les attentes des clients augmentaient, les fonctionnalités et les nouvelles versions augmentaient. Les responsabilités et les tâches finiraient par être un gâchis cumulatif et géant. Les bogues et les failles de sécurité étaient en retard, beaucoup de ces versions non résolues et plus de versions planifiées, ce qui ne serait pas évolutif et désordonné. Le bruit excessif et la pression ont conduit à la méfiance, aux lacunes de communication,et de friction entre les équipes.

Cette stratégie et ce système populaires de résolution de problèmes sont devenus une cause profonde d'inefficacité dans la flexibilité et la communication entre les équipes.

**Modèle Agile

Avec les défis auxquels les équipes étaient confrontées, les entreprises ont commencé à développer des moyens qui permettaient plus de flexibilité et d'adaptabilité. Quelque part au début de 2000,  **La Méthodologie Agile **a été inventé. Bientôt, un manifeste a été publié: [Agile Manifeste](http://agilemanifesto.org/), en soulignant quatre valeurs pour le développement agile:

![db09323bd5eed6fb32de796bdb20196f](https://github.com/user-attachments/assets/b1bbfb26-d8a4-4118-b759-ebb94b9f3bce)


-   Les individus et les interactions sur les processus et les outils
-   Logiciel de travail sur une documentation complète
-   Collaboration client sur la négociation de contrat
-   Répondre au changement par rapport à suivre un plan

Les entreprises apprécient désormais la collaboration entre équipes et comptent sur des équipes auto-organisées, axées sur les clients et offrant une grande marge de changement et de flexibilité.

Mais il manquait encore quelque chose.

**DevOps: Un nouvel espoir**


En 2008, une conversation entre Andrew Clay et Patrick Debois a conduit à quelque chose de très révolutionnaire. Tout en discutant des inconvénients de l'Agile, DevOps est né. Après un événement en Belgique l'année suivante appelé "DevOpsDays," DevOps est devenu le prochain mot à la mode, et sa popularité a augmenté.

DevOps est assez différent des méthodologies précédentes car il se concentre sur la conduite du "changement culturel" pour augmenter l'efficacité. Pour ce faire, il unit la magie de toutes les équipes travaillant sur un projet, en utilisant l'intégration et l'automatisation. Avec ces ingrédients, vous obtenez une intégration croisée dans tous les départements, QA+sysadmins+developers. Par exemple, s'assurer que les développeurs peuvent désormais être impliqués dans le déploiement et que les administrateurs système peuvent désormais écrire des scripts, QA peut comprendre comment corriger les défauts par rapport aux tests constants de fonctionnalité. En introduisant l'automatisation et l'intégration des systèmes, ces ingénieurs peuvent désormais avoir la même visibilité à tout moment et interagir en conséquence. Nous allons approfondir la façon dont DevOps fait cela dans les dernières salles en parlant de pipelines, d'automatisation, d'Intégration Continue et de Livraison Continue (CI/CD').

Pourquoi est DevOps important?

DevOps construit une philosophie qui met l'accent sur la confiance et une meilleure liaison entre développeurs et autres équipes (sysadmins, QA, etc.). Cela aide l'organisation à aligner les projets technologiques sur les exigences de l'entreprise, augmentant l'impact et la valeur de l'entreprise à mesure que les projets deviennent plus efficaces et hiérarchisés en conséquence. Changements roulés les sorties sont généralement petites et réversibles, visibles par toutes les équipes impliquées. Cela garantit une meilleure contribution et une meilleure communication qui contribuent au rythme et à une compétence accrue lors de la prestation du travail.

﻿En Résumé:

Grâce à l'avènement de DevOps, l'infrastructure de développement actuelle est entièrement automatisée et fonctionne en libre-service:

-   Les développeurs peuvent fournir des ressources aux clouds publics sans dépendre des TI pour approvisionner l'infrastructure, ce qui a entraîné des semaines ou des mois de retards.

-   Continu intégration et déploiement (CI/CD) processus automatiquement configurez des environnements de test, de mise en scène et de production dans le cloud ou sur site. Ils peuvent être déclassés, mis à l'échelle ou reconfigurés au besoin.

-   Infrastructure-comme-Code (IaC) est largement utilisé pour déployer des environnements déclarativement*, en utilisant des outils comme Terraform et Vagrant.

-   Les organisations peuvent désormais provisionner des charges de travail conteneurisées utiliser dynamiquement des processus automatisés et adaptatifs

*L'approche déclarative exige que les utilisateurs spécifient l'état final de l'infrastructure - par exemple, déployer ces machines dans un état en cours d'exécution directement dans un environnement, automatisation des choix de configuration tout au long du workflow. Le logiciel le construit et le libère sans interaction humaine.

L'approche impérative/procédurale prend des mesures pour configurer les systèmes en une série d'étapes exploitables. Par exemple, vous pouvez déclarer déployer une nouvelle version du logiciel et automatiser une série d'étapes pour obtenir un état prêt pour le déploiement. Vous choisissez quand appliquer ces modifications à la fin en ajoutant une "porte", cette porte pourrait être un bouton pour libérer les modifications, par exemple "déployer les modifications", bouton, après toutes les vérifications automatisées et les nouvelles configurations passent.

Dans un tel flux de travail, même un petit problème pourrait créer un désordre. De plus, à mesure que le nombre de nouvelles versions augmente (cas réel), toute la question peut devenir désastreuse. Les choses seraient sûrement hors de contrôle avec un problème encore non résolu et de nombreuses fonctionnalités prévues pour être publiées.

En savoir plus sur: <https://www.appknox.com/blog/history-of-devops>
