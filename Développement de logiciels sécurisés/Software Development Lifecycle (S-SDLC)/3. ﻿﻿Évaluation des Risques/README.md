# Évaluation des Risques

Le risque fait référence à la probabilité qu'une menace soit exploitée, ce qui a un impact négatif sur une ressource ou la cible qu'elle affecte. Par exemple, les vulnérabilités exploitées après la publication d'une nouvelle version du logiciel, les défauts de conception et le code mal examiné peuvent augmenter le risque de ces scénarios. La gestion des risques est un pilier important à intégrer dans la SDLC pour atténuer les risques dans un produit ou un service.

* * * * *

L'évaluation des risques est utilisée pour déterminer le niveau de la menace potentielle. Les risques cernés dans le processus d'évaluation des risques peuvent être réduits ou éliminés en appliquant les contrôles appropriés pendant le processus d'atténuation des risques. Habituellement, une évaluation des risques est suivie d'une modélisation des menaces, qui sera expliquée plus en détail dans la section suivante.

**Effectuer une Évaluation des Risques**

1.  La première étape du processus d'évaluation des risques consiste à supposer que le logiciel sera attaqué et à prendre en compte les facteurs qui motivent l'acteur de la menace. Énumérez les facteurs tels que la valeur des données du programme, le niveau de sécurité des entreprises qui fournissent des ressources dont dépend le code, les clients qui achètent le logiciel, et quelle est la taille du logiciel distribué (unique, petit groupe de travail ou publié dans le monde entier). Sur la base de ces facteurs, notez le niveau de risque acceptable. Par exemple, une perte de données peut faire perdre des millions à l'entreprise, surtout si elle doit payer des amendes de nos jours avec le RGPD, mais éliminer tous les bogues de sécurité potentiels dans le code peut coûter $40 000. L'entreprise et certains autres groupes d'intervenants doivent décider si cela en vaut la peine; il est également crucial de communiquer ces compromis. Par conséquent,tout le monde comprend les risques et leurs implications. Du point de vue de la réputation de la marque, si l'attaque cause des dommages à l'image de l'entreprise, cela coûte plus cher à l'entreprise à long terme que de corriger le code.
2.  La prochaine étape est l'évaluation des risques. Inclure des facteurs comme le pire scénario si l'attaquant a attaqué avec succès le logiciel. Vous pouvez démontrer le pire scénario aux cadres et aux ingénieurs en simulant une attaque de ransomware. Déterminer la valeur des données à voler, des données précieuses telles que l'identité de l'utilisateur, les informations d'identification pour prendre le contrôle des points de terminaison sur le réseau, et des données ou des actifs qui présentent un risque plus faible. Un autre facteur à considérer est la difficulté de monter une attaque réussie, en d'autres termes, sa complexité. Par exemple, si un attaquant peut accéder à l'outil de l'entreprise pour donner des commentaires à des collègues ou organiser des réunions rétrospectives, il peut, cela aurait un impact moins important que l'accès au système de surveillance et d'alerte d'un environnement de production. Le niveau de risque élevé ne sera pas acceptable,et il est préférable de l'atténuer. Par exemple, une vulnérabilité peut être exploitée par toute personne exécutant des scripts d'attaque préécrits ou utilisant des botnets pour diffuser les scripts afin de compromettre les ordinateurs et les réseaux. Les utilisateurs concernés sont un facteur essentiel.
3.  Certaines attaques n'affectent qu'un ou deux utilisateurs, mais l'attaque par déni de service affectera des milliers d'utilisateurs lorsqu'un serveur est attaqué. De plus, des milliers d'ordinateurs peuvent être infectés par la propagation des vers. Le dernier facteur est l'accessibilité de la cible. Déterminez si la cible accepte les demandes sur un réseau ou uniquement l'accès local, si l'authentification est nécessaire pour établir une connexion ou si quelqu'un peut envoyer des demandes. Cela a plus d'impact si un attaquant accède à un environnement de production par rapport à un environnement de bac à sable utilisé dans les terrains de jeux locaux pour que les gens puissent faire des laboratoires ou des tutoriels.

Types d'Évaluations des Risques

Il existe plusieurs types d'évaluations des risques les mieux adaptés à différents scénarios. Vous trouverez ci-dessous les différents types d'Evaluations des Risques:

**Évaluation Qualitative des Risques**

C'est le type le plus courant d'Évaluation des Risques que vous trouverez dans les entreprises (espérons-le). Dans une Évaluation Qualitative des Risques, l'objectif est d'évaluer et de classer les risques en seuils tels que "Faible", "Moyen" et "Haut". Il examine systématiquement ce qui peut causer un préjudice et quelles décisions devraient être prises pour définir ou améliorer des mesures de contrôle adéquates. Comme tous les types d'Évaluations des Risques, chaque niveau a une priorité, où "Haut" a le plus d'urgence. Même si les Évaluations Qualitatives des Risques n'utilisent pas de chiffres, une formule typique pour évaluer le risque qualitatif est la suivante:

`Risk = Severity x Likelihood`

"Sévérité" est l'impact de la conséquence, et la probabilité est la probabilité que cela se produise. Il appartient à l'évaluateur des risques de juger de ces circonstances.^

**Évaluation Quantitative des Risques **

L'Évaluation Quantitative des Risques est utilisée pour mesurer les risques avec des valeurs numériques. Au lieu de "Basse", "Moyenne", et "Haute", vous auriez des nombres qui représentent ces bandes. Lors de la réalisation de l'Analyse Quantitative des Risques, nous pouvons utiliser des outils pour déterminer la Gravité et la Probabilité ou des séries personnalisées de calculs basés sur les processus de l'entreprise.

Par exemple, supposons qu'il existe des services avec des niveaux de criticité métier assignés. Dans ce cas, vous pouvez dire que si un bug affecte un service critique (un service d'authentification, une infrastructure de paiement, etc.), vous attribuerez 5 points. Cela souligne pourquoi il est essentiel de comprendre une posture de sécurité et ses processus. Mesurer le risque et la priorité avec une équation endémique aux services d'une entreprise aura d'excellents résultats. Un exemple de Matrice Quantitative d'Evaluation des Risques peut être vu ci-dessous:

Les évaluations des risques sont mieux effectuées au début de la SDLC, pendant les phases de planification et d'exigence. Par exemple, "Les données des clients sont exfiltrées par une attaque". Une fois le système développé, vous pouvez effectuer une analyse quantitative des risques: "Un client peut nous poursuivre pour $ 20 000 si ses données sont divulguées", et nous avons 100 clients. Cependant, le Taux Annuel d'Ocurrence (ARO) est de 0,001. Par conséquent, Annual Loss Expectancy est de = 20 000 * 100 * 0,001 $ = 2 000, ce qui signifie que tant que notre contrôle de sécurité compensatoire est inférieur à $ 2 000, nous ne dépensons pas trop en sécurité.


![e5fb607dfd764c3e162da1783dd58e02](https://github.com/user-attachments/assets/7d62f336-42e5-4b8a-ae2b-c394fa669a2a)
