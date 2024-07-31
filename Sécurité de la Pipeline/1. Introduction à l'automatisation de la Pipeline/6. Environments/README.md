![0065d23932f564df870affd95f73dd3d](https://github.com/user-attachments/assets/8ae2992e-57fb-4a51-8264-93c85dc18e11)

Zoomons un peu sur la section pipeline des Environnements. Le plus les pipelines ont plusieurs environnements. Chacun de ces environnements a une cas d'utilisation spécifique, et leur posture de sécurité diffère souvent. Prenons un regardez quelques-uns des plus communs:

|                         Environnement                         |                                                                                                                                                                                                                                                                                                                                 Description                                                                                                                                                                                                                                                                                                                                 |  Stabilité  |  Poste de Sécurité | Peut-il contenir des données clients? |
|:-------------------------------------------------------------:|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|:-----------:|:------------------:|:-------------------------------------:|
|                      DEV - Développement                      |                                                 Le L'environnement DEV est le terrain de jeu des développeurs. Cet environnement est le plus instable que les développeurs poussent continuellement nouveau code et le tester. Du point de vue de la sécurité, cet environnement a la sécurité la plus faible. Le contrôle d'accès est généralement plus laxiste et les développeurs l'ont souvent fait accès direct à l'infrastructure elle-même. La probabilité de la l'environnement de développement étant compromis est élevé, mais s'il y a une ségrégation adéquate, l'impact d'un tel compromis devrait être faible.                                                |   Instable  |       Faible       |                  Non                  |
|           UAT - Test d'Acceptation des Utilisateurs           |                                                    Le L'environnement UAT est utilisé pour tester l'application ou sélectionner des fonctionnalités avant d'être mis en production. Ceux-ci incluent des tests unitaires qui garantissent que la fonctionnalité développée se comporte comme prévu. Cela peut (et devrait) inclure des tests de sécurité aussi. Bien que cet environnement soit plus stable que DEV, il peut souvent encore être assez instable. De même, certains contrôles de renforcement de la sécurité auraient été introduits pour UAT, mais il n'est toujours pas aussi durci que PreProd ou PROD.                                                   | Semi-Stable |   Deuxième Faible  |                  Non                  |
|                    PreProd - Pré-Production                   |                                                                                                                                        Le L'environnement PreProd est utilisé pour imiter la production sans réel données client/utilisateur. Cet environnement est maintenu stable et utilisé pour effectuer les derniers tests avant que la nouvelle fonctionnalité ne soit mise en production. De a du point de vue de la sécurité, la sécurité de PreProd devrait techniquement refléter PROD. Mais ce n'est pas toujours le cas.                                                                                                                                       |    Stable   | Deuxième Strongest |                  Non                  |
|                       PROD - Production                       | Le L'environnement PROD est le plus sensible. C'est le courant actif environnement qui sert les utilisateurs ou les clients. Pour s'assurer que notre les utilisateurs ont la meilleure expérience, cet environnement doit être maintenu stable. Non les mises à jour doivent être effectuées ici sans gestion appropriée du changement. À faites respecter cela, la sécurité de cet environnement est la plus forte. Seulement un sélectionnez quelques employés ou services auront la capacité d'apporter des modifications ici. En outre, puisque nous pouvons avoir des utilisateurs "malicieux", la sécurité a être durci pour prévenir les menaces extérieures aussi. |    Stable   |        Fort        |                  Oui                  |
| DR/HA - Récupération après Catastrophe ou Haute Disponibilité |                 Dépendant sur la criticité du système, il peut y avoir un environnement DR ou HA. Si le basculement est instantané, il est généralement appelé HA environnement. Ceci est souvent utilisé pour des applications critiques telles que Online Banque, où la banque doit payer des pénalités importantes si le site Web va bas. Dans le cas où certains temps d'arrêt (mais toujours petits) sont autorisés, le l'environnement est appelé un environnement DR, destiné à être utilisé pour récupérer d'une catastrophe dans la production. Les environnements DR et HA doivent être exacts miroirs de PROD à la fois en stabilité et sécurité.                |    Stable   |        Fort        |                  Oui                  |



Dans les pipelines modernes, les logiciels ne sont pas déplacés manuellement entre différents environnements. Au lieu de cela, un processus automatisé peut être suivi pour compiler, construire, intégrer et déployer de nouvelles fonctionnalités logicielles. Ce processus est appelé CI/CD.

*Note: Le terme CI/CD a beaucoup changé ces dernières années. Initialement, l'objectif principal était simplement de s'assurer que le développement était effectué en utilisant une approche Agile alors que la livraison du produit se produisait toujours en utilisant le modèle cascade de déploiement des versions finales. Pendant ce temps, il était courant pour CI/CDpour signifier Intégration Continue et Développement Continu. Cependant, on s'est vite rendu compte que le déploiement lui-même pouvait également être rendu Agile et que l'acronyme signifiait Intégration Continue et Déploiement Continu, le développement faisant désormais partie du composant Intégration. Enfin, ils se sont rendu compte que ce n'était pas seulement le déploiement, mais tous les aspects liés à la livraison de la solution et à la façon dont nous la surveillons après la livraison et l'acronyme a été modifié pour finalement signifier Intégration Continue et Livraison Continue. Donc, vous pourriez entendre ces termes utilisés de manière interchangeable, mais ils se réfèrent tous à la même chose.*

CI/CD

Étant donné que nous construisons constamment de nouvelles fonctionnalités pour notre système ou service, nous devons nous assurer que ces fonctionnalités fonctionneront avec l'application actuelle. Au lieu d'attendre la fin du cycle de développement lorsque toutes les fonctionnalités seront intégrées, nous pouvons désormais intégrer en permanence de nouvelles fonctionnalités et les tester au fur et à mesure de leur développement.

Nous pouvons créer ce qu'on appelle un CI/CD pipeline. Ces pipelines ont généralement les éléments distincts suivants:

-   Déclencheur de démarrage - L'action qui déclenche le processus de pipeline. Par exemple, une demande push est faite à une branche spécifique.
-   Actions de construction - Actions prises pour construire le projet et la nouvelle fonctionnalité.
-   Actions de test - Actions qui testeront le projet pour s'assurer que la nouvelle fonctionnalité n'interfère avec aucune des fonctionnalités actuelles de l'application.
-   Actions de déploiement - Si un pipeline réussit, les actions de déploiement détaillent ce qui devrait se passer avec la build. Par exemple, il devrait ensuite être poussé vers l'environnement de test.
-   Actions de livraison - As CI/CD les processus ont évolué, l'accent n'est plus seulement mis sur le déploiement lui-même, mais sur tous les aspects de la fourniture de la solution. Cela inclut des actions telles que la surveillance de la solution déployée.

CI/Les pipelines CD nécessitent une infrastructure de construction pour exécuter les actions de ces éléments. Nous appelons généralement cette infrastructure des orchestrateurs et des agents de construction. Un orchestrateur de build dirige les différents agents pour effectuer les actions du CI/CD pipelines au besoin.

Ces CI/CD les pipelines sont généralement l'endroit où la plus grande partie de l'automatisation peut être trouvée. En tant que tel, il s'agit généralement de la plus grande surface d'attaque et de la plus grande chance que des erreurs de configuration se glissent.

Outils Communs

GitHub et Gitlab fournissent CI/Les capacités de pipeline CD et sont très populaires à utiliser. GitHub fournit des agents de compilation, tandis que Gitlab fournit une application de runner Gitlab qui peut être installée sur un hôte pour en faire un agent de compilation. Pour les versions plus complexes, créez des logiciels d'orchestrateur tels que Jenkins peut être utilisé. Nous explorerons ces outils et leurs erreurs de configuration communes dans les salles ultérieures.

Étude de cas: Un enchevêtrement entre Dev et Prod

Une mauvaise configuration commune avec CI/CD pipelines utilise les mêmes agents de construction pour les versions Développement (DEV) et Production (PROD). Cela crée un problème intéressant puisque la plupart des développeurs auront accès au déclencheur de démarrage pour une version DEV, mais pas une version PROD.

Si l'un de ces développeurs était compromis, un attaquant pourrait tirer parti de son accès pour provoquer une construction DEV malveillante qui compromettrait l'agent de construction. Ce ne serait pas un gros problème si l'agent de construction était simplement utilisé pour les builds DEV. Cependant, comme cet agent est également utilisé pour les builds PROD, un attaquant pourrait simplement persister sur cet agent de build jusqu'à ce qu'une build PROD soit actionnée pour injecter son code malveillant dans la build, ce qui leur permettrait de compromettre la construction de production de l'application.Autres Environnements Notables

Il y a d'autres environnements dont vous pouvez entendre parler lorsque vous parlez DevOps.

**Environnements Vert et Bleu**

Vert les environnements Blue sont utilisés pour une stratégie de déploiement Blue/Green lorsque vous appuyez sur une mise à jour de PROD. Au lieu d'avoir un seul PROD par exemple, il y en a deux. L'environnement bleu exécute le courant version de l'application, et l'environnement vert exécute le plus récent version. En utilisant un proxy ou un routeur, tout le trafic peut ensuite être commuté l'environnement vert lorsque l'équipe est prête. Cependant, le Bleu l'environnement est conservé pendant un certain temps, ce qui signifie que s'il y en a problèmes imprévus avec la nouvelle version, le trafic peut simplement être acheminé vers l'environnement bleu à nouveau. Nous pouvons considérer cela comme une Haute-Disponibilité sauvegardes de PROD lors d'un nouveau déploiement à utiliser pour une restauration si quelque chose ne va pas, ce qui est plus rapide que d'avoir à effectuer un retour en arrière de l'environnement PROD réel.

**Les environnements canariens**

Similaire pour les environnements Vert et Bleu, l'objectif des environnements Canaries est de fluidifier le processus de déploiement PROD. Deux environnements sont créés, et les utilisateurs sont progressivement déplacés vers le nouvel environnement. Par exemple, au début, 10% des utilisateurs peuvent être migrés. Si le nouvel environnement reste stable, un autre 10% peut être migré jusqu'à ce que 100% des utilisateurs soient dans le nouvel environnement. Encore une fois, ceux-ci sont généralement classés sous PROD environnements mais sont utilisés pour réduire le risque associé à un PROD mise à niveau pour limiter les problèmes potentiels et les temps d'arrêt.

Outils Communs

Les environnements ont considérablement changé dans les temps modernes. Des percées telles que la virtualisation et la conteneurisation ont changé le paysage. Au lieu que les environnements soient simplement des ordinateurs, nous pouvons maintenant créer des ordinateurs virtuels via des outils tels que Vagrant ou Terraform. Nous pourrions également nous éloigner entièrement des hôtes pour des choses comme les conteneurs utilisant Docker ou les pods utilisant Kubernetes. Ces outils peuvent utiliser des processus tels que Infrastructure as Code (IaC) pour même créer des logiciels capables de créer et de gérer ces environnements.

Considérations de Sécurité

Comme mentionné précédemment, les considérations de sécurité deviennent plus importantes à mesure que l'environnement se rapproche de PROD. L'infrastructure sous-jacente d'une application fait également partie de la surface d'attaque de l'application réelle. Toute vulnérabilité de cette infrastructure pourrait permettre à un attaquant de prendre le contrôle de l'hôte et de l'application. En tant que telle, l'infrastructure doit être renforcée contre les attaques. Ce processus de durcissement nécessite généralement des choses comme les suivantes:

-   Suppression des services inutiles
-   Mise à jour de l'hôte et des applications
-   Utiliser un pare-feu pour bloquer les ports inutilisés

Étude de cas - Developer Bypasses in PROD

L'un des problèmes courants qui peuvent se produire avec différents environnements est que souvent les choses qui devraient rester dans DEV, ne le font pas. Les bypass de développement sont courants dans les environnements DEV pour des fonctionnalités telles que:

-   Authentification multi-facteurs
-   CAPTCHA
-   Le mot de passe se réinitialise
-   Portails de connexion

Les contournement des développeurs permettent aux développeurs de tester rapidement différentes fonctionnalités d'application en contournant les fonctionnalités chronophages telles que MFA invites. Un exemple courant est d'avoir un code spécifique One-Time Pin (OTP) qui est toujours accepté, quel que soit le code OTP qui est envoyé par l'application.

Cependant, s'il y a une désinfection inadéquate de ces contournements avant que l'application ne soit déplacée vers l'environnement suivant, cela pourrait conduire à un contournement du développeur jusqu'à PROD. Ce contournement OTP? Il pourrait maintenant être exploité par un attaquant pour contourner MFA et compromettre les comptes utilisateurs.

C'est pourquoi les environnements doivent être séparés et, comme les portes de qualité, les portes de sécurité doivent être mises en œuvre pour assurer le déplacement d'une application propre vers l'environnement suivant.
