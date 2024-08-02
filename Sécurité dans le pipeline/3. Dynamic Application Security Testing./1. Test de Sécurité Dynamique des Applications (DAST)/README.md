Ce qui est DAST?

**Test de Sécurité Dynamique des Applications (DAST')** est le processus de test d'une instance en cours d'exécution d'une application Web pour les faiblesses et les vulnérabilités. Il se concentre sur une approche de test de boîte noire où les vulnérabilités sont trouvées comme un attaquant ordinaire les trouverait. Simplement mis, DAST identifie les vulnérabilités en essayant de les exploiter, manuellement ou via des outils automatisés.

En testant l'application d'un point de vue extérieur, nous pouvons nous abstraire de son fonctionnement interne et nous concentrer sur l'identification des vulnérabilités qu'un attaquant trouverait probablement. Cela signifie que les résultats obtenus à partir de DAST pointera souvent vers des vulnérabilités nécessitant une attention prioritaire car elles devraient être trouvées sans connaissance préalable de l'application.

Il est important de noter que DAST ne remplace pas d'autres méthodes pour trouver des vulnérabilités dans les applications, mais les complète plutôt. Un cycle de vie de développement sécurisé combinera souvent plusieurs techniques afin de fournir une couverture de vulnérabilité suffisante.

Manuel vs Automatisé DAST

Il y a deux façons dont DAST peut être effectuée:

-   **Manuel DAST:** Un ingénieur de sécurité effectuera manuellement des tests contre une application pour vérifier les vulnérabilités.
-   **Automatique DAST:** Un outil automatisé analysera l'application Web à la recherche de vulnérabilités.

Les deux procédés sont complémentaires et peuvent être utilisés à différentes étapes du **Cycle de vie du Développement Logiciel (SDLC')**. La combinaison d'outils manuels et automatisés donnera souvent les meilleurs résultats plutôt que de compter sur l'un ou l'autre séparément.

DAST manuel nous aidera à trouver des faiblesses qu'un outil automatisé ne sera pas facilement repérer car ils ne comprennent pas l'application d'un point de vue fonctionnel.

Le problème avec tout faire à la main est que l'exécution de tests manuels pour chaque commit ou petit changement dans le code pendant les phases de développement prendra trop de temps. C'est là que l'automatisation DAST excelle, car il fournit un moyen rapide d'exécuter de nombreux tests contre l'application cible sans nécessiter d'interaction humaine.

DAST dans le SDLC

![d5b8c1597d4d218692e466e39364c9cb](https://github.com/user-attachments/assets/c8a8880a-661a-4f28-bff2-c9862338ce14)


Bien que chaque scénario soit différent, il est courant d'utiliser automatisé DAST pendant les phases de test. Automatisé DAST les outils seront souvent optimisés pour la vitesse afin que les développeurs puissent obtenir des commentaires rapidement, contrairement à un scanner de vulnérabilité d'application Web traditionnel, qui pourrait prendre plusieurs heures à exécuter. L'idée ici n'est pas de fournir une analyse approfondie de l'application, mais d'attraper les fruits à faible pendaison tôt.

Manuel DAST, d'autre part, est souvent exécuté périodiquement pour éviter de ralentir le processus de développement dans son ensemble. Il est habituel d'exécuter des analyses manuelles chaque semaine pendant le développement des applications, mais cela dépend grandement de chaque projet. Un profil d'analyse plus intense peut être utilisé dans ces analyses manuelles pour identifier encore plus de vulnérabilités.

Lorsque l'application est prête à entrer en production, l'exécution d'une application Web pentest complète est toujours une bonne pratique pour remarquer les défauts dans la mise en œuvre du produit final.

**Note:** La plupart de la littérature se réfère souvent à DAST automatisé simplement comme DAST et considère souvent DAST manuel dans le cadre de l'application web pentesting. Le DAST manuel peut également être appelé "DAST traditionnel".

DAST Avantages et Inconvénients

Comme pour tout autre processus utilisé pour trouver des vulnérabilités dans une application, DAST aura ses avantages et ses inconvénients:

| Points positifs: Trouve les vulnérabilités pendant l'exécution. Cela inclura des vulnérabilités spécifiques au processus de déploiement, qui ne peuvent pas être vues en analysant uniquement le code. DAST trouvera des vulnérabilités telles que HTTP Request Smuggling, l'empoisonnement du cache et la pollution des paramètres qui ne seront pas trouvées à l'aide SAST. Les outils DAST ne se soucient pas du langage de programmation utilisé par votre application. Depuis DAST est test de boîte noire, toutes les applications sont traitées d'une manière langue-agnostique. Réduction du nombre de faux positifs par rapport à SAST. Les outils DAST pourraient être en mesure de trouver des failles de logique métier. L'efficacité dépendra de l'outil et ne devrait pas être prise en remplacement des tests manuels. | Points négatifs: La couverture de code n'est pas la meilleure. DAST peut ne pas couvrir des situations spécifiques qui ne seront déclenchées que par des cas d'utilisation spécifiques dans votre application. Certaines vulnérabilités peuvent être plus difficiles à trouver DAST, par rapport aux techniques d'analyse de code statique. Certaines applications sont difficiles à explorer. Les applications modernes reposent fortement sur le traitement javascript côté client. Cela rend plus difficile pour DAST des outils pour les traverser. Les scanners DAST ne seront pas en mesure de vous dire comment corriger certaines vulnérabilités en détail, car ils n'ont aucune idée du code sous-jacent. Certains types de scans peuvent prendre beaucoup de temps pour terminer. Vous avez besoin d'une application en cours d'exécution pour faire le test. |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|

Prêt à DAST?

La plupart du temps, vous trouverez DAST contextualisé comme une série de tests automatisés. Cependant, nous explorerons comment le processus manuel fonctionne pour mieux comprendre ce que la plupart des outils font fondamentalement. En termes généraux, a DAST l'outil effectuera au moins les deux tâches suivantes sur le site Web cible:

-   **Araignée/Crawling:** L'outil naviguera dans l'application Web, en essayant de mapper l'application et d'identifier une liste de pages et de paramètres pouvant être attaqués.
-   **Analyse de Vulnérabilité:** L'outil tentera de lancer des charges utiles d'attaque contre les pages et paramètres identifiés. L'utilisateur peut généralement personnaliser le type d'attaques pour n'inclure que celles pertinentes pour l'application cible.

Nous utiliserons ZAP proxy comme notre DAST outil à des fins de démonstration dans cette salle. Considérez cependant que beaucoup DAST les outils utilisés dans les configurations d'entreprise sont payants et assez coûteux, mais utiliseront les mêmes principes de base que tout autre scanner de vulnérabilité d'application Web. La principale différence entre les outils réside dans leurs capacités de détection de vulnérabilité et dans le nombre de fonctionnalités supplémentaires qu'ils ajoutent à leur produit, utiles dans les entreprises, telles que les tableaux de bord, intégration du système de billetterie et bien d'autres.

Tout au long de cette salle, vous utiliserez une Machine Virtuelle (VM'). Depuis le VM prend quelques minutes pour commencer, il pourrait être une bonne idée de cliquer sur le bouton `Start Machine` bouton dans le coin supérieur droit de cette tâche maintenant. Vous pouvez accéder à la VM en utilisant la AttackBox ou votre VPN connexion. Si vous utilisez la AttackBox, assurez-vous de frapper le `Start AttackBox` bouton en haut de la page également.
