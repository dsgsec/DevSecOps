# Modélisation des Menaces

La modélisation des menaces est mieux intégrée dans la phase de conception d'un SDLC avant que le code soit écrit. La modélisation des menaces est un processus structuré d'identification des menaces de sécurité potentielles et de hiérarchisation des techniques pour atténuer les attaques afin que les données ou les actifs qui ont été classés comme précieux ou à risque plus élevé lors de l'évaluation des risques, les données confidentielles sont protégées. Lorsqu'il est effectué tôt, il apporte un grand avantage; les problèmes potentiels peuvent être trouvés tôt et résolus, ce qui permet d'économiser les coûts de fixation sur toute la ligne.

Il existe différentes méthodes pour effectuer la modélisation des menaces. Toutes les méthodes n'ont pas le même objectif; certaines se concentrent sur les risques ou les problèmes de confidentialité, tandis que d'autres sont plus axées sur le client. Nous pouvons combiner ces méthodes pour mieux comprendre les menaces potentielles; il est essentiel d'analyser de quelle manière s'aligne davantage avec le projet ou l'entreprise. FOULÉE, DREAD, et PÂTES figurent parmi les méthodologies communes de modélisation des menaces.

**STRIDE**

STRIDE signifie Spoofing, Tampering, Repudiation, Information Disclosure, Denial Of Service et Elevation/Escalation of Privilege. STRIDE est un modèle de menace largement utilisé développé par Microsoft qui évalue la conception du système dans une vue plus détaillée. Nous pouvons utiliser STRIDE pour identifier les menaces, y compris les biens violés par la menace et la définition. Le diagramme de flux de données du système doit être développé dans ce modèle, et chaque nœud est appliqué avec le FOULÉE modèle. L'identification des menaces à la sécurité est un processus manuel que les outils ne sont pas pris en charge et doivent être effectués lors de l'évaluation des risques. Utilisation de diagrammes de flux de données et intégration FOULÉE, les entités du système, les surfaces d'attaque, comme les frontières connues et les événements d'attaque deviennent plus identifiables. Stride signifie Spoofing Identité, Talourdir les données, Répudiation, Information Divulgation, Denial de Service, Elevation de Privilège. STRIDE repose sur le principe de la triade CIA (Confidentialité, Intégrité & Disponibilité). Les professionnels de la sécurité qui effectuent STRIDE cherchent à répondre à "Ce qui pourrait mal tourner avec ce système". Voici les éléments du cadre:

![a5904cf6f063a62e77df6623eb1cbd33](https://github.com/user-attachments/assets/026c9490-0b9f-45e5-a5eb-c59c1442df8e)


1.  **Spoof: par exemple:** C'est un acte d'usurpation d'identité d'un utilisateur par un acteur malveillant qui viole le principe d'authentification du point de vue de l'utilisateur CIA triade. Les méthodes courantes incluent ARP, IP et DNS usurpation.

2.  **Altération:** La modification des informations par un utilisateur non autorisé. Il viole le principe d'intégrité de la CIA triade.

3.  **Répudiation:** Ne pas prendre la responsabilité des événements où les actions ne sont pas attribuées à l'attaquant. Il viole le principe de non-répudiabilité. Par exemple, l'attaquant efface tous les journaux qui pourraient conduire à laisser des traces.

4.  **Divulgation d'Information:** C'est un acte de violation de la confidentialité des CIA triade. Un exemple typique est celui des violations de données.

5.  **Déni de service:** Le déni de service se produit lorsqu'un utilisateur autorisé ne peut pas accéder au service, aux actifs ou au système en raison de l'épuisement des ressources réseau. DoS est une violation du principe de disponibilité de la CIA triade.

6.  **Élévation/Escalation du Privilège:** L'escalade des privilèges pour obtenir un accès non autorisé est un exemple classique de violation du principe d'autorisation de la loi CIA triade.

**PEUR**

L'abréviation PEUR cinq questions sur chaque potentiel: Damage Potentiel, Réproductibilité, Exploitabilité, Autilisateurs Ffected et Dcouvrabilité. DREAD est également une méthodologie créée par Microsoft qui peut être un complément au modèle STRIDE. Il s'agit d'un modèle qui classe les menaces en attribuant les menaces identifiées en fonction de leur gravité et de leur priorité. En d'autres termes, il crée un système de notation qui est noté en fonction de la probabilité de risque. Sans FOULER, le PEUR le modèle peut également être utilisé pour évaluer, analyser et trouver la probabilité de risque évaluation des menaces. Voici les éléments du cadre:

1.  **Dommages:** fait référence aux dommages possibles qu'une menace pourrait causer à l'infrastructure ou aux actifs existants. Il est basé sur une échelle de 0--10. Un score de 0 signifie aucun dommage, 5 signifie la divulgation d'informations, 8 signifie que les données utilisateur sont compromises, 9 signifie que les données internes ou administratives sont compromises et 10 signifie l'indisponibilité d'un service.

2.  **Reproductibilité:** il mesure la complexité de l'attaque. Alors, avec quelle facilité un pirate peut répliquer une menace. Un score de 0 signifie qu'il est presque impossible de copier, 5 signifie être complexe mais possible, 7,5 pour un utilisateur authentifié et un score de 10 signifie que l'attaquant peut se reproduire très rapidement sans aucune authentification.

3.  **Exploitabilité:** Se référant à la sophistication de l'attaque ou comment il serait facile de lancer l'attaque. Un score de 2,5 implique qu'il faudrait un ensemble de compétences avancées en réseautage et en programmation; 5 moyens peuvent être exploités avec les outils disponibles, et, un score de 9 signifie que nous aurions besoin d'un outil de proxy d'application Web simple et un score de 10 signifie qu'il peut exploiter via un navigateur Web.

4.  **Utilisateurs Affectés:** il décrit le nombre d'utilisateurs affectés par l'exploitation réussie d'une vulnérabilité. Un score de 0 signifierait qu'il n'y aurait pas d'utilisateurs affectés, 2,5 signifie pour un utilisateur individuel, 6 signifierait un petit groupe d'utilisateurs, 9 signifierait des utilisateurs importants comme les utilisateurs administratifs, et 10 impliquerait que tous les utilisateurs sont touchés.

5.  **Découverte:** Le processus de découverte des points vulnérables dans le système. Par exemple, la menace serait facilement trouvée en cas de compromis. Un score de 0 signifierait qu'il serait difficile de le découvrir, un score de 5 signifie que la menace peut être découverte par l'analyse des requêtes HTTP, et 8 signifie qu'il peut être facilement trouvé car il est public. Un score de 10 signifierait qu'il est visible dans la barre d'adresse du navigateur.

**PASTA**

PASTA est l'abréviation de Process for Attack Simulation and Threat Analysis; il s'agit d'un cadre de modélisation des menaces centré sur le risque. L'objectif de PASTA est d'aligner les exigences techniques avec les objectifs commerciaux. PASTA implique le processus de modélisation des menaces, de l'analyse des menaces à la recherche de moyens de les atténuer, mais à un niveau plus stratégique et du point de vue d'un attaquant. Il identifie la menace, les énumère, puis leur attribue un score. Cela aide les organisations à trouver des contre-mesures appropriées pour atténuer les menaces de sécurité. PÂTES est divisé en sept étapes:

![8222ed08e31753d975ec3ec3aa2e43a9](https://github.com/user-attachments/assets/21a7c0a2-a43c-49bb-a724-89118a412c9d)

1.  **Définir les Objectifs:** La première étape consiste à noter la structure et à définir les objectifs. Cela rend l'objectif final beaucoup plus clair et garantit que les actifs pertinents sont modélisés par la menace en définissant une portée d'actifs.

2.  **Définir la Portée Technique:** C'est là que les diagrammes architecturaux sont définis, à la fois l'infrastructure logique et physique. Utile pour cartographier la surface d'attaque et les dépendances de l'environnement.

3.  **Décomposition & Analyse:** Chaque actif aura une limite de confiance définie qui englobe toutes ses composantes et données à cette étape. Par exemple, cartographier les vecteurs de menaces pour un service de paiement et évaluer quels composants sous-jacents au service peuvent être exploités pour une attaque; les composants peuvent être des bibliothèques, dépendances, modules ou services sous-jacents, etc.

4.  **Analyse des Menaces:** Cela fait référence aux informations extraites obtenues à partir des renseignements sur les menaces. Utile pour identifier quelles applications sont vulnérables à des vecteurs spécifiques; par exemple, une application orientée client/public peut être sensible au DDOS, à l'altération de données non autorisée, etc.

5.  **Vulnérabilités & Faiblesses Analyse:** il analyse les vulnérabilités des contrôles de sécurité des applications Web. Il identifie les failles de sécurité dans l'application et énumère les vulnérabilités. Il est fortement recommandé d'ajouter des mesures d'atténuation à la menace identifiée à ce stade. Par exemple, lors de la description d'un incident passé impliquant un exploit d'un serveur de messagerie, les leçons apprises ou l'atténuation: manque de tests approfondis avant la mise en œuvre et le durcissement du serveur.

6.  **Attaque/Exploiter Énumération et Modélisation:** Dans cette étape, nous cartographions le paysage des menaces possibles et toute la surface d'attaque de notre application Web. Nous cartographions ensuite tous les vecteurs d'attaque potentiels aux différents nœuds, en identifiant les exploits et les chemins d'attaque. Cette étape simule toutes les informations énumérées extraites de toutes les étapes précédentes; cela aide les professionnels de la sécurité à déterminer l'étendue et la probabilité de lancer avec succès les vulnérabilités identifiées.

7.  **Analyse d'Impact de Risque:** Sur la base des données collectives des étapes précédentes, tous les actifs visés qui ont été touchés sont analysés et, enfin, sur la base de l'analyse des risques, les mesures recommandées pour atténuer les risques et éliminer tous les risques résiduels sont documentées.
