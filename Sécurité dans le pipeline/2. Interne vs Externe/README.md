Alors que les dépendances peuvent être classées en utilisant diverses classifications, pour cette salle, nous nous concentrerons principalement sur une classification, à savoir l'origine de la dépendance. Par conséquent, nos dépendances peuvent être classées comme des dépendances externes ou internes.

Dépendances Extérieures

Une dépendance externe est une dépendance qui a été développée et maintenue en dehors de notre organisation. Habituellement, ces dépendances sont accessibles au public (certaines sont gratuites, mais certaines peuvent être payées pour les SDK). Quelques exemples de dépendances externes populaires incluent:

-   Tout paquet Python pip que vous installez à partir des dépôts publics PyPi.
-   JQuery et toutes les autres bibliothèques Node Package Manager (NPM) accessibles au public, telles que VueJS ou NodeJS.
-   Payé pour les SDK tels que ReCaptcha SDK de Google qui peuvent être utilisés pour intégrer des captchas dans votre application.

Les dépendances externes incluent presque toutes les dépendances que nous n'avons pas créées nous-mêmes. Cela signifie que quelqu'un en dehors de notre organisation est responsable du maintien de la dépendance.

Dépendances Internes

Une dépendance interne est une dépendance développée par un membre de notre organisation. Ces dépendances ne sont généralement utilisées que par les applications que nous développons en interne dans notre organisation. Quelques exemples de dépendances internes incluent:

-   Une bibliothèque d'authentification qui standardise les processus d'authentification de toutes nos applications développées en interne.
-   Une bibliothèque de connexions de sources de données qui fournit aux applications diverses techniques pour se connecter à différentes sources de données.
-   Une bibliothèque de traduction de messages qui peut convertir les messages d'application d'un format spécifique en un format qu'une application interne différente peut lire.

Les dépendances internes sont généralement créées pour standardiser un processus interne et s'assurer que nous n'avons pas à réinventer la roue chaque fois que nous voulons cette même fonctionnalité dans une autre application. Puisque nous développons nous-mêmes ces dépendances, nous, en tant qu'organisation, sommes responsables du maintien de ces dépendances.

Externe vs Interne

L'origine de la dépendance ne la rend pas nécessairement meilleure ou plus sûre. Cependant, en fonction de l'origine de la dépendance, la surface d'attaque est différente. Cela signifie que nous devrons prendre différentes mesures de sécurité pour protéger chacun. Dans cette salle, nous parlerons de ces mesures de sécurité pour les dépendances externes et internes avant d'exploiter pratiquement l'un des problèmes de sécurité des dépendances internes.
