# Examen et analyse de code sécurisé

Selon une étude menée par Verizon en 2020 sur les violations de données, 43% des violations étaient des attaques sur des applications Web, tandis que d'autres violations de sécurité résultaient de certaines vulnérabilités dans les applications Web. Mise en œuvre d'un examen de code sécurisé dans les phases d'un SDLC, en particulier pendant la phase de mise en œuvre, augmentera la résilience et la sécurité du produit sans supporter de coûts supplémentaires pour les futurs correctifs. L'examen sécurisé du code est défini comme une mesure où le code lui-même est vérifié et validé pour s'assurer que les vulnérabilités trouvées peuvent être atténuées et supprimées pour éviter les vulnérabilités et les failles. Faire en sorte que les développeurs soient conscients et proactifs dans l'examen du code pendant le développement peut entraîner des réponses d'atténuation plus rapides et moins de menaces sans surveillance. La révision du code est une étape cruciale dans la SDLC pour les développeurs. Il empêche tout revers sur la version et les problèmes exposés aux utilisateurs. Comme indiqué dans le précédent SSDLCtâche, le coût du projet lui-même et l'effort mis en est proportionnelle et moins cher à long terme que le coût de l'application de revues de code et d'analyse. En mettant en œuvre cette approche, l'organisation sera également conforme aux normes établies par les organismes gouvernementaux et les certifications.

Examen du code peut être fait manuellement ou automatisé. Un examen manuel du code est l'endroit où un expert analyse et vérifie le code source en allant ligne par ligne pour identifier les vulnérabilités. Par conséquent, un examen manuel de code de haute qualité nécessite que l'expert communique avec les développeurs de logiciels pour se procurer le but et les fonctionnalités de l'application. La sortie d'analyse sera ensuite signalée aux développeurs s'il est nécessaire de corriger les bogues.

## Analyse de Code

L'analyse statique examine le code source sans exécuter le programme. En revanche, l'analyse dynamique examine la source

code lorsque le programme est en cours d'exécution, l'analyse statique détecte les bogues au niveau de l'implémentation et l'analyse dynamique détecte les erreurs pendant l'exécution du programme. Test de Sécurité des Applications Statiques Automatisées (SAST) analyse et vérifie automatiquement le code source.

## SAST

SAST signifie Static Application Security Testing, une méthode de test en boîte blanche qui analyse directement le code source.

Beaucoup de gens ont tendance à développer une application qui pourrait automatiser ou exécuter des processus rapidement et améliorer les performances et l'expérience utilisateur, oubliant ainsi l'impact négatif d'une application qui manque de sécurité pourrait causer. 



**Pourquoi est-ce statique?** parce que le test est effectué avant qu'une application soit en cours d'exécution. SAST peut même aider à détecter les vulnérabilités dans votre application avant que le code ne soit fusionné ou intégré dans le logiciel s'il est ajouté dans le cadre du SDLC phase de développement.

**Comment Fait SAST Travail**

SAST utilise une méthodologie de test d'analyse d'un code source pour détecter toute trace de vulnérabilités qui pourraient fournir une porte dérobée à un attaquant. SAST analyse et analyse généralement une application avant que le code ne soit compilé.

Le processus de SAST est également connu sous le nom de White Box Testing. Une fois qu'une vulnérabilité est détectée, la ligne d'action suivante consiste à vérifier le code et à le patcher avant que le code ne soit compilé et déployé. White Box Testing est une approche ou une méthode que les testeurs utilisent pour tester la structure interne du logiciel et voir comment il s'intègre aux systèmes externes.

## Bonus: SCA

﻿Pour résumer, SAST est utilisé pour analyser le code source des vulnérabilités de sécurité. Un autre type de test va de pair avec SAST, Analyse de Composition du Logiciel (SCA'). SCA il est utilisé pour analyser les dépendances à la recherche de vulnérabilités de sécurité, aidant les équipes de développement à suivre et analyser tout composant open source introduit dans un projet. SCA est maintenant un pilier essentiel dans les tests de sécurité, car les applications modernes sont de plus en plus composées de code open source. De nos jours, l'un des plus grands défis des équipes de développeurs est de s'assurer que leur base de code est sécurisée car les applications sont assemblées à partir de différents blocs de construction.

## DAST

DAST signifie Dynamic Application Security Testing, une méthode de test en boîte noire qui détecte les vulnérabilités à l'exécution. DAST est un outil pour analyser n'importe quelle application Web pour trouver des vulnérabilités de sécurité. Cet outil est utilisé pour détecter les vulnérabilités à l'intérieur d'une application Web qui a été déployée en production. DAST les outils enverront toujours des alertes à l'équipe de sécurité affectée pour une correction immédiate.

## Comment Fait DAST Travail

DAST fonctionne en simulant des attaques automatisées sur une application, imitant un attaquant malveillant. L'objectif est de trouver des résultats inattendus ou des résultats que les attaquants pourraient utiliser pour compromettre une application. Puisque les outils DAST n'ont pas d'informations internes sur l'application ou le code source, ils attaquent comme un pirate externe le ferait avec les mêmes connaissances et informations limitées sur l'application.

DAST est un outil qui peut être intégré très tôt dans le cycle de vie du développement logiciel. Son objectif est d'aider les organisations à réduire et à protéger contre le risque que les vulnérabilités des applications pourraient causer. Il est très différent de SAST parce que DAST utilise la Black Box Testing Methodology; il effectue son évaluation de vulnérabilité à l'extérieur car il n'a pas accès au code source de l'application. DAST est généralement utilisé pendant la phase de test de SDLC.

## GRINCE

GRINCE signifie Interactive Application Security Testing qui analyse le code pour les vulnérabilités de sécurité pendant l'exécution de l'application. Il est généralement déployé côte à côte avec l'application principale sur le serveur d'applications. IAST est un outil de sécurité d'application conçu pour les applications Web et mobiles pour détecter et signaler les problèmes même en cours d'exécution. Avant que quelqu'un puisse comprendre pleinement la compréhension d'IAST, la personne doit savoir ce que SAST et DAST moyen. IAST a été développé pour arrêter toutes les limitations de SAST et DAST. Il utilise la Méthode de Test de la Boîte Grise.**Comment Fait ****GRINCE**** Travail **Les tests IAST se font en temps réel, tout comme DAST, tandis que l'application s'exécute dans l'environnement de staging. IAST peut identifier la ligne de code qui cause des problèmes de sécurité et informer rapidement le développeur pour une correction immédiate. IAST vérifie le code source similaire à SAST, mais au stade post-construction, contrairement à SAST, qui se produit pendant le développement. Les agents IAST sont généralement déployés sur les serveurs d'applications. Lorsque le scanner DAST effectue son travail en signalant une vulnérabilité, l'agent IAST déployé renvoie désormais un numéro de ligne du problème à partir du code source. Peut déployer des agents IAST sur un serveur d'applications. Lors des tests fonctionnels effectués par un testeur QA, l'agent étudie chaque modèle suivi par un transfert de données dans l'application, qu'il soit dangereux ou non. Par exemple,si les données proviennent d'un utilisateur et que l'utilisateur souhaite effectuer un SQL Injection sur l'application en ajoutant un SQL requête à une requête, la requête sera signalée comme dangereuse.

## *Bonus: RÂPE*

"RASP" signifie Runtime Application Self Protection. RÂPE est une application d'exécution intégrée dans une application pour analyser le trafic entrant et sortant et les modèles de comportement de l'utilisateur final pour prévenir les attaques de sécurité. Cet outil est différent des autres outils comme RÂPE est utilisé après la sortie du produit, ce qui en fait un outil plus axé sur la sécurité par rapport aux autres qui sont connus pour les tests.

**Comment fait RÂPE travail **RÂPE est déployé sur un serveur Web ou d'application à côté de l'application principale pendant l'exécution pour surveiller et analyser le comportement du trafic entrant et sortant. Immédiatement une fois qu'un problème est trouvé, il, RÂPE envoie des alertes à l'équipe de sécurité et bloque immédiatement l'accès à la personne qui fait une demande. Lorsque vous déployez RÂPE, il sécurisera l'ensemble de l'application contre différentes attaques. Il ne suffit pas d'attendre ou d'essayer de s'appuyer uniquement sur des signatures spécifiques de certaines vulnérabilités connues.

RÂPE est une solution complète qui observe chaque détail des différentes attaques sur votre application et connaît votre comportement d'application.

Choisir des outils

SALE, DAST, et GRINCE ce sont de grands outils qui se complètent. Une force clé de DAST est qu'il identifie les problèmes d'exécution---faiblesses qui ne sont pas détectables quand une application n'est pas en cours d'exécution. SAST est excellent pour identifier les vulnérabilités pendant l'écriture du code. En outre, DAST examine comment une application réagit à une attaque, fournissant un aperçu utile de la probabilité que cette vulnérabilité soit manipulée. AST permet DevSecOps et prend en charge les tests continus, la surveillance, l'évaluation et la validation en temps réel. GRINCE aide à hiérarchiser et à alerter sur les risques critiques vitaux, tels que définis par les objectifs commerciaux et les besoins de sécurité des applications. Les experts en sécurité prennent toujours en charge l'utilisation de deux ou plusieurs de ces outils pour assurer une meilleure couverture, ce qui réduira le risque de vulnérabilités en production. Assurez-vous d'adapter ces outils à la façon dont les ingénieurs poussent le code et interagissent avec le pipeline; méfiez-vous des intégrations et concentrez-vous sur le soutien et l'éducation plutôt que sur le blocage. Par exemple, si vous choisissez SAST, vous pouvez l'intégrer lorsque les ingénieurs poussent du code, et ils peuvent obtenir des commentaires sur le PR avant de fusionner.

Chronologie de l'Application Security Automation

Consultez le diagramme ci-dessous pour voir où vous pouvez installer des outils de test de sécurité!

![ed41446ac19972111b12a8b41bdb3599](https://github.com/user-attachments/assets/95a032c1-dec3-42ff-ad5a-0df9b356588d)

Ci-dessus est un calendrier standard lors du choix de l'implémentation d'outils de test de sécurité. Comme décrit précédemment, SAST est une approche statique; il n'est pas nécessaire d'exécuter une application. Par conséquent, SAST peut être mis en œuvre dans les premiers stades de développement. SCA fonctionne généralement mieux pour identifier les composants open source, comme les packages via des dépendances. Il est également bénéfique pour identifier les licences open source utilisées, en particulier du point de vue du risque juridique. Pour cette raison, vous pouvez mettre en œuvre la gouvernance et le contrôle en appliquant des politiques de sécurité et de licence à travers les différentes étapes de SDLC.

D'un autre côté, DAST s'appuie sur l'exécution de l'application, donc l'intégrer dans le pipeline n'est pas aussi simple que SAST. DAST est généralement mis en œuvre après l'étape d'acceptation du code et l'étape de pré-production. C'est là que l'application commence à s'exécuter dans des environnements de test (par exemple sandbox/staging) similaires à IAST. DAST et IAST résident à l'extrême droite de votre pipeline parce que l'exécution de votre application est nécessaire pour DAST des outils pour faire leur travail. Cela peut prendre beaucoup de temps, surtout si votre application a grandi avec le temps. RÂPE aide à découvrir les packages tiers et les vulnérabilités associées à l'exécution, permettant ainsi aux développeurs de hiérarchiser la correction et l'atténuation de leurs vulnérabilités les plus urgentes. Ceci est généralement activé dans la phase de production car les vulnérabilités de sécurité sont évaluées pendant l'exécution de l'application.
