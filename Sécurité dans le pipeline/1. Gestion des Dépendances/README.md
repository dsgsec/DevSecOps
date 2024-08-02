Il est très rare dans les temps modernes de trouver une application écrite complètement à partir de zéro. De plus, l'écrire complètement à partir de zéro est probablement une mauvaise idée, car vous allez probablement introduire des vulnérabilités en essayant de réinventer la roue. Au lieu de cela, les applications modernes utilisent largement les bibliothèques et les Kits de Développement de Logiciels (SDK) qui aident avec les fonctionnalités de base (et parfois complexes) de l'application, permettre au développeur de se concentrer uniquement sur les principales caractéristiques et fonctionnalités de l'application.

Ces bibliothèques et SDK sont appelés dépendances puisque notre application en dépend. Bien que les dépendances nous facilitent la vie, elles doivent être gérées en toute sécurité car elles font désormais partie de la surface d'attaque globale de l'application. Dans cette salle, nous allons en apprendre davantage sur les concepts de sécurité associés à la gestion des dépendances et montrer comment un problème de gestion des dépendances spécifique peut être exploité par un attaquant.

Objectifs d'Apprentissage

Cette salle vous enseignera les concepts suivants: 

-   Principes de sécurité de la gestion des dépendances
-   Sécurisation des dépendances externes et internes
-   Attaques confusion dépendance
