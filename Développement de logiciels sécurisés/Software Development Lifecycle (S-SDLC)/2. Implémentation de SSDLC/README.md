Exécution SSDLC
---------------

Comme le [Intro À DevSecOps](https://tryhackme.com/room/introductiontodevsecops) spectacles en chambre, Sécurisé SDLC implique d'instiller des processus de sécurité à toutes les phases du cycle de vie. Des outils de test de sécurité à l'écriture des exigences de sécurité aux exigences fonctionnelles.

Comprendre la Sécurité Posture

﻿Comme avec chaque nouveau processus, comprendre vos lacunes et votre état est essentiel pour réussirintroduction un nouvel outil, une nouvelle solution ou un nouveau changement. Pour aider à comprendre ce que votre la posture de sécurité est, vous pouvez commencer par faire ce qui suit:﻿

-   Effectuer a** analyse des lacunes** pour déterminer quelles activités et politiques existent dans votre organisation et leur efficacité. Par exemple, s'assurer que les politiques sont en place (ce que l'équipe fait) avec les procédures de sécurité (comment l'équipe exécute ces politiques).

-   Créer **Sécurité du Logiciel Initiatives** (SSI) en établissant des objectifs réalistes et réalisables avec des mesures définies pour le succès. Par exemple, il pourrait s'agir d'un Secure Coding Standard, playbooks pour le traitement des données, etc sont suivis à l'aide d'outils de gestion de projet.

-   **Formaliser processus** pour les activités de sécurité au sein de votre SSI. Après avoir commencé un programme ou standard, il est essentiel de passer une période opérationnelle à aider les ingénieurs à se familiariser avec elle et à se rassembler rétroaction avant de l'appliquer. Lors de l'analyse des lacunes, chaque politique devrait avoir défini des procédures pour les rendre efficaces.

-   **Investir dans la formation en sécurité** pour les ingénieurs ainsi que les outils appropriés. Assurez-vous que les gens conscients des nouveaux processus et des outils qui les accompagneront opérationnalisez-les et investissez dans la formation tôt, idéalement avant établir /intégrer l'outil.

**SSDLC Processus**

Après avoir compris votre posture de sécurité, il est maintenant temps de prioriser et d'instiller la sécurité dans votre SDLC. De manière générale, un SDLC intégrer des processus tels que les tests de sécurité et d'autres activités dans un processus de développement existant. Les exemples incluent l'écriture des exigences de sécurité aux côtés des exigences fonctionnelles et l'exécution d'une analyse des risques d'architecture pendant la phase de conception de l'architecture SDLC. Ces processus sont les suivants:

![3d1e3379a1e3ccc46f3c7471095cbfae](https://github.com/user-attachments/assets/f10e671d-4f54-4716-acd6-1a9105a69dbe)

-   **Évaluation des Risques **pendant les premiers stades de SDLC, il est essentiel d'identifier les considérations de sécurité qui favorisent une approche de sécurité par conception lorsque les exigences fonctionnelles sont recueillies dans les étapes de planification et d'exigences. Par exemple, si un utilisateur demande une entrée de blog à partir d'un site, l'utilisateur ne devrait pas être en mesure de modifier le blog ou de supprimer les champs de saisie inutiles.

-   **Modélisation des Menaces** est le processus d'identification des menaces potentielles lorsqu'il n'y a pas de garanties appropriées. Il est très efficace lors de la suite d'une évaluation des risques et lors de la phase de conception de la SDLC, comme la Modélisation des Menaces se concentre sur ce qui ne devrait pas arriver. En revanche, les exigences de conception indiquent comment le douxware se comportera et interagira. Par exemple, assurez-vous qu'il y a une vérification lorsqu'un utilisateur demande des informations de compte.
-   **Analyse de Code / Revue** les révisions de code peuvent être manuelles ou automatisées. L'analyse de code ou les révisions automatisées de code peuvent tirer parti des technologies de test Static and Dynamic Security. Ceux-ci sont cruciaux dans les étapes de développement que le code est écrit.
-   **Évaluations de Sécurité - Comme Tests de Pénétration et Évaluations de Vulnérabilité** sont une forme de test automatisé qui peut identifier les chemins critiques d'une application qui peut conduire à l'exploitation d'une vulnérabilité. Cependant, ceux-ci sont hypothétiques car l'évaluation ne comporte pas de simulations de ces attaques. Pentesting, d'autre part, identifie ces défauts et tente de les exploiter pour démontrer la validité. Les Pentests et les Évaluations de Vulnérabilité sont réalisés pendant la phase Opérations & Maintenance du SDLC après un prototype de l'application.

Il existe des méthodologies pour appliquer les processus de la tâche 5 qui vous aideront à naviguer et à vous guider lors de l'introduction de l'évaluation des risques, de la modélisation des menaces, de l'analyse et des tests, et de l'assurance opérationnelle. Les tâches suivantes couvriront ces processus plus en détail.
