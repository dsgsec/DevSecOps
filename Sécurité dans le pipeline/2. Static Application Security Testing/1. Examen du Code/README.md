L'une des méthodes utilisées pour développer des applications sécurisées est souvent de tester le code pour les bogues de sécurité grâce à un processus connu sous le nom de révision de code. Les revues de code consistent à examiner le code source d'une application pour rechercher d'éventuelles vulnérabilités à l'aide d'une approche de boîte blanche. En ayant accès au code, le réviseur peut garantir une plus grande couverture des fonctionnalités de l'application et réduire le temps nécessaire pour trouver des bugs.

Si elles sont laissées sans surveillance, les vulnérabilités introduites au début du processus de développement se propageront jusqu'à la fin d'un projet, où la résolution est plus laborieuse et coûteuse. Les revues de code tenteront de détecter ces vulnérabilités tôt quand elles seront plus faciles à corriger.

![1e9aa4ddd5746ee00e0ad76d30208eb5](https://github.com/user-attachments/assets/50ac8b09-293b-4bf0-b0b2-301ccea2e22b)

Revue de Code Manuel vs Automatique

Les révisions de code sont souvent effectuées par une combinaison d'analyses manuelles et d'outils automatisés pour obtenir les meilleurs résultats. Les deux approches présentent des avantages qui doivent être pris en compte pour décider ce qui est le mieux à chaque étape du cycle de développement.

D'une part, les révisions manuelles du code ont l'avantage d'un humain qui évalue le code, ce qui permet une analyse approfondie et des résultats plus précis. Cependant, comme une application contient souvent des milliers et des milliers de lignes de code, la tâche peut rapidement devenir écrasante pour l'examinateur, ce qui entraîne l'oubli de certaines vulnérabilités en raison de la fatigue.

D'autre part, les outils automatisés excellent à trouver des vulnérabilités communes presque instantanément, économisant beaucoup de temps à l'examinateur. Les outils automatisés fonctionneront également de manière cohérente, quelle que soit la taille de la base de code, de sorte qu'ils ne manqueront pas de vulnérabilités comme un humain pourrait le faire, tant qu'ils ont des règles prédéfinies pour les faire correspondre. Si l'outil n'a pas de règles configurées pour un type spécifique de vulnérabilité, il est probable qu'elles manquent.

Un autre aspect important à comparer est le coût. Le coût d'un examen manuel sera souvent plus élevé, car un examinateur doit passer beaucoup de temps à retracer les vulnérabilités à travers le code. Les outils automatisés effectueront leur analyse presque instantanément.

Pour ces raisons, vous voudrez généralement exécuter des tests automatisés au début du cycle de vie du développement pour prendre en charge tous les fruits à faible portée à moindre coût et avoir des examens manuels espacés périodiquement ou lorsque le projet important les objectifs sont atteints pour prendre en charge les vulnérabilités complexes que les outils automatisés peuvent ne pas être en mesure de détecter.
