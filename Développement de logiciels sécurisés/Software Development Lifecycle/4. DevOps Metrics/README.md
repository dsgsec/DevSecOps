# Introduction

Il est essentiel de comprendre quelles mesures les ingénieurs DevOps recueillent avant de pouvoir conseiller et introduire la sécurité. Comme on le voit dans le [Introduction à DevSecOps](https://tryhackme.com/jr/introductiontodevsecops) la place, gagner du terrain d'entente pour construire la perspective et l'empathie est cruciale pour l'adhésion et l'instauration de la sécurité.

## DevOps Métriques

Pendant le processus de création manuelle de l'infrastructure, les déploiements sont bloqués. Il peut y avoir trop d'erreurs dans l'application en direct, indiquant que l'automatisation des tests de sécurité doit être améliorée ou prend trop de puissance de calcul et de temps. Comprendre comment et où trouver des améliorations nécessite des mesures pour mesurer vos ressources. Voici les métriques essentielles recueillies par les ingénieurs et les questions auxquelles il vise à répondre:

-   Entre-temps et la production ([MTTP](https://about.gitlab.com/handbook/engineering/infrastructure/team/delivery/metrics.html)'). Quel est le délai d'exécution pour le code source nouvellement engagé?
-   Fréquence de déploiement. Quelle est la fréquence de déploiement des versions? Le délai moyen. Combien de temps faut-il pour développer, construire, tester et déployer une nouvelle fonctionnalité?
-   Vitesse de déploiement. Une nouvelle version est déployée en production; combien de temps cela prend-il?
-   Déploiement Agilité. Vous pouvez mesurer l'agilité de déploiement en combinant vitesse et fréquence de déploiement.
-   Taux d'échec de production. À quelle fréquence les défaillances se produisent-elles en production?
-   MTTR signifie temps moyen pour récupérer. Quel est le temps de récupération après un échec?

## MTTP

Un critique DevOps métrique à suivre est la production de temps moyen. MTTP est la durée entre le moment où un changement de code est engagé et quand il est dans un état déployé. Un test de pré-version, par exemple, est passé lorsque toutes les exigences du code ont été respectées. L'automatisation des tests et le travail en petits lots sont de bons moyens d'améliorer le temps MTTP. Les développeurs peuvent recevoir des commentaires rapides sur le code qu'ils commettent en suivant ces pratiques, en identifiant les défauts et en les corrigeant le plus rapidement possible.   

## Taux d'Échec

Lorsqu'un changement de code entre en production, un certain pourcentage de changements de code nécessitent des correctifs ou d'autres mesures de correction. Il ne mesure pas les défaillances détectées lors des tests et des correctifs avant le déploiement du code. Les mêmes pratiques qui permettent des temps MTTP plus courts sont en corrélation avec la réduction des taux d'échec de changement. Toutes ces pratiques rendent les bogues beaucoup plus faciles à identifier et à corriger. Le suivi et la déclaration des taux d'échec sont essentiels pour s'assurer que les nouvelles versions de code répondent aux exigences de sécurité.

## Fréquence de déploiement

Comprendre à quelle fréquence le nouveau code est déployé en production est essentiel au succès de DevOps. La fréquence de déploiement se reporte au MTTP lorsqu'il est libéré dans un environnement de pré-production et se réserve le "déploiement" pour faire référence aux modifications de code publiées en production. Les équipes peuvent déployer des modifications à la demande et souvent plusieurs fois par jour. La capacité de déploiement à la demande nécessite un pipeline de déploiement qui intègre des mécanismes de test et de rétroaction automatisés, comme mentionné dans les tâches précédentes, minimisant ainsi le besoin d'intervention humaine. 

## MTTR

Lorsqu'une interruption de service partielle ou totale se produit, le temps moyen de récupération (MTTR) est mesuré. Garder une trace de cette métrique est crucial. Si une défaillance se produit, un correctif doit être déployé dès que possible, ou les modifications qui ont causé la défaillance doivent être annulées. Dans la plupart des cas, il s'agit de surveiller en permanence l'état du système et d'alerter les opérations en cas de défaillance. L'équipe opérationnelle dispose des processus, outils et autorisations nécessaires pour résoudre les incidents. 

## Communiquer le Risque

Vous pouvez démontrer une amélioration au fil du temps en mesurant l'un de ces éléments, et vous aurez les preuves pour soutenir l'adhésion de l'entreprise et des équipes. Le risque est très différent entre les équipes. Pour les ingénieurs DevSecOps, le risque signifie la probabilité qu'une vulnérabilité soit exploitée et son impact sur les systèmes. Alors que pour un ingénieur DevOps, un risque important serait des taux élevés de défaillance de la production, par exemple. En comprenant les définitions du risque des autres équipes, a DevSecOps l'ingénieur peut trouver un terrain d'entente et mieux construire une perception du risque de sécurité pour les autres équipes.
