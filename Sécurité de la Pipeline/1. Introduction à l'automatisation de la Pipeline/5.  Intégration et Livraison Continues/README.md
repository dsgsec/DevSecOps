![678d09b2f788f32a2766556cb4730701](https://github.com/user-attachments/assets/514c37c6-35a3-4223-9c3b-15c398847132)

Dans les pipelines modernes, les logiciels ne sont pas déplacés manuellement entre différents environnements. Au lieu de cela, un processus automatisé peut être suivi pour compiler, construire, intégrer et déployer de nouvelles fonctionnalités logicielles. Ce processus est appelé CI/CD.

*Note: Le terme CI/CD a beaucoup changé ces dernières années. Initialement, l'objectif principal était simplement de s'assurer que le développement était effectué en utilisant une approche Agile alors que la livraison du produit se produisait toujours en utilisant le modèle cascade de déploiement des versions finales. Pendant ce temps, il était courant pour CI/CDpour signifier Intégration Continue et Développement Continu. Cependant, on s'est vite rendu compte que le déploiement lui-même pouvait également être rendu Agile et que l'acronyme signifiait Intégration Continue et Déploiement Continu, le développement faisant désormais partie du composant Intégration. Enfin, ils se sont rendu compte que ce n'était pas seulement le déploiement, mais tous les aspects liés à la livraison de la solution et à la façon dont nous la surveillons après la livraison et l'acronyme a été modifié pour finalement signifier Intégration Continue et Livraison Continue. Donc, vous pourriez entendre ces termes utilisés de manière interchangeable, mais ils se réfèrent tous à la même chose.*

## CI/CD

Étant donné que nous construisons constamment de nouvelles fonctionnalités pour notre système ou service, nous devons nous assurer que ces fonctionnalités fonctionneront avec l'application actuelle. Au lieu d'attendre la fin du cycle de développement lorsque toutes les fonctionnalités seront intégrées, nous pouvons désormais intégrer en permanence de nouvelles fonctionnalités et les tester au fur et à mesure de leur développement.

Nous pouvons créer ce qu'on appelle un CI/CD pipeline. Ces pipelines ont généralement les éléments distincts suivants:

-   Déclencheur de démarrage - L'action qui déclenche le processus de pipeline. Par exemple, une demande push est faite à une branche spécifique.
-   Actions de construction - Actions prises pour construire le projet et la nouvelle fonctionnalité.
-   Actions de test - Actions qui testeront le projet pour s'assurer que la nouvelle fonctionnalité n'interfère avec aucune des fonctionnalités actuelles de l'application.
-   Actions de déploiement - Si un pipeline réussit, les actions de déploiement détaillent ce qui devrait se passer avec la build. Par exemple, il devrait ensuite être poussé vers l'environnement de test.
-   Actions de livraison - As CI/CD les processus ont évolué, l'accent n'est plus seulement mis sur le déploiement lui-même, mais sur tous les aspects de la fourniture de la solution. Cela inclut des actions telles que la surveillance de la solution déployée.

CI/Les pipelines CD nécessitent une infrastructure de construction pour exécuter les actions de ces éléments. Nous appelons généralement cette infrastructure des orchestrateurs et des agents de construction. Un orchestrateur de build dirige les différents agents pour effectuer les actions du CI/CD pipelines au besoin.

Ces CI/CD les pipelines sont généralement l'endroit où la plus grande partie de l'automatisation peut être trouvée. En tant que tel, il s'agit généralement de la plus grande surface d'attaque et de la plus grande chance que des erreurs de configuration se glissent.

## Outils Communs

GitHub et Gitlab fournissent CI/Les capacités de pipeline CD et sont très populaires à utiliser. GitHub fournit des agents de compilation, tandis que Gitlab fournit une application de runner Gitlab qui peut être installée sur un hôte pour en faire un agent de compilation. Pour les versions plus complexes, créez des logiciels d'orchestrateur tels que Jenkins peut être utilisé. Nous explorerons ces outils et leurs erreurs de configuration communes dans les salles ultérieures.

## Étude de cas: Un enchevêtrement entre Dev et Prod

Une mauvaise configuration commune avec CI/CD pipelines utilise les mêmes agents de construction pour les versions Développement (DEV) et Production (PROD). Cela crée un problème intéressant puisque la plupart des développeurs auront accès au déclencheur de démarrage pour une version DEV, mais pas une version PROD.

Si l'un de ces développeurs était compromis, un attaquant pourrait tirer parti de son accès pour provoquer une construction DEV malveillante qui compromettrait l'agent de construction. Ce ne serait pas un gros problème si l'agent de construction était simplement utilisé pour les builds DEV. Cependant, comme cet agent est également utilisé pour les builds PROD, un attaquant pourrait simplement persister sur cet agent de build jusqu'à ce qu'une build PROD soit actionnée pour injecter son code malveillant dans la build, ce qui leur permettrait de compromettre la construction de production de l'application.
