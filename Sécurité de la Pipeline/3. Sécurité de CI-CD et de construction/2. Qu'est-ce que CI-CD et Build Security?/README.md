Introduction

L'établissement d'un environnement de construction sécurisé est essentiel pour protéger votre processus de développement logiciel contre les menaces et les vulnérabilités potentielles. À la lumière des événements récents tels que l'attaque de la chaîne d'approvisionnement SolarWinds, il est devenu de plus en plus évident que la construction d'une base de sécurité solide est impérative. Cette tâche explorera les stratégies clés pour créer un environnement de construction sécurisé, en tenant compte des leçons tirées du cas d'utilisation de SolarWinds.

Fondamentaux de CI/CD

Selon [Gitlab](https://about.gitlab.com/topics/ci-cd/), Il y a huit fondamentaux pour CI/CD:

-   **Un référentiel source unique** la gestion du code source doit être utilisée pour stocker tous les fichiers et scripts nécessaires à la construction de l'application.

-   **Check-ins fréquents à la branche principale** les mises à jour de code doivent être réduites et effectuées plus fréquemment pour garantir que les intégrations se produisent aussi efficacement que possible.

-   **Des buildings automatisés** la construction doit être automatisée et exécutée à mesure que les mises à jour sont poussées vers les branches de la solution de stockage de code source.

-   **Auto-test construit** - Comme les builds sont automatisés, il devrait y avoir des étapes introduites le résultat de la construction est automatiquement testé pour l'intégrité, la qualité et conformité de sécurité.

-   **Les itérations fréquentes** en faisant des commits fréquents, les conflits se produisent moins fréquemment. Par conséquent, les engagements doivent être réduits et effectués régulièrement.

-   **Environnements d'essai stables** le code doit être testé dans un environnement qui imite la production aussi étroitement que possible.

-   **Une visibilité maximale** chaque développeur doit avoir accès aux dernières versions et au code pour comprendre et voir les modifications apportées.

-   **Déploiements prévisibles à tout moment** - Le pipeline devrait être rationalisé pour garantir que les déploiements peuvent être fabriqué à tout moment avec presque aucun risque pour la stabilité de la production.

Tandis que tous ces éléments fondamentaux contribueront à faire en sorte que CI/CD peut rationaliser le DevOps processus, aucun de ceux-ci ne se concentre vraiment sur la garantie que l'automatisation n'augmente pas la surface d'attaque ni ne fabrique le pipeline vulnérable aux attaques.

Un Typique CI/CD Pipeline

Donc à quoi ressemble un pipeline CI/CD typique? Le réseau le diagramme de cette pièce aide un peu à expliquer cela. Travaillons à travers le différents composants qui peuvent être trouvés dans ce pipeline:

-   **Stations de développeurs** là où la magie du codage se produit, les développeurs créent et construisent du code. Dans ce réseau, cela est simulé via votre AttackBox.

-   **Solution de stockage de code source** il s'agit d'un espace réservé central pour stocker et suivre différentes versions de code. C'est le serveur Gitlab trouvé dans notre réseau.

-   **Construire un orchestrateur** coordonne et gère l'automatisation des environnements de construction et de déploiement. Gitlab et Jenkins sont utilisés comme serveurs de construction dans ce réseau.

-   **Construire des agents** ces machines construisent, testent et emballent le code. Nous utilisons des coureurs GitLab et Jenkins agents pour nos agents de construction.

-   **Environnements** brièvement mentionné ci-dessus, il existe généralement des environnements de développement, de test (staging) et de production (code en direct). Le code est construit et validé à travers les étapes. Dans notre réseau, nous avons à la fois un environnement DEV et PROD.

Tout au long cette salle, nous allons explorer le CI/Composants CD plus en détail et montrer les erreurs de configuration de sécurité courantes trouvées ici. Il devrait notez que les pipelines DevOps avec CI/CD peut prendre plusieurs formes selon sur les outils utilisés, mais les principes de sécurité à appliquer restent les mêmes.

SolaireCas de Vent

Le La violation de SolarWinds était une cyberattaque importante découverte en décembre 2020. Les attaquants ont compromis la chaîne d'approvisionnement des logiciels de SolarWinds, injection d'un code malveillant connu sous le nom de SUNBURST dans l'Orion de la société mises à jour logicielles. Les attaquants ont réussi à obtenir un accès non autorisé à de nombreux réseaux d'organisations, y compris des agences gouvernementales et entreprises privées. La violation a souligné l'importance cruciale de sécuriser les chaînes d'approvisionnement logicielles et l'impact potentiel d'un seul fournisseur compromis sur de nombreuses entités.

Nous utiliserons ce cas comme nous passer par des mesures que nous pouvons appliquer pour assurer notre environnement de construction est sécurisé. Ces mesures mettent en œuvre l'isolement et la segmentation techniques et mise en place de contrôles d'accès et d'autorisations limiter l'accès non autorisé.

**Mettre en œuvre des Techniques d'Isolation et de Segmentation**

Le L'incident de SolarWinds a mis en évidence l'importance de l'isolement et segmenter les composants critiques dans le système de construction. En séparant différentes étapes du processus de construction et en utilisant un accès strict contrôles, vous pouvez atténuer le risque d'un seul composant compromis compromettre l'ensemble du système. L'isolement peut être réalisé par technologies de conteneurisation ou de virtualisation, créant des solutions sécurisées bacs à sable pour exécuter des processus de construction sans exposer l'ensemble environnement.

**Configurer les Contrôles d'Accès et les Autorisations Appropriés**

Limitation l'accès non autorisé à l'environnement bâti est crucial pour le maintien intégrité et sécurité du système. Suivant le principe de accorder l'accès uniquement aux personnes ou aux groupes qui en ont besoin pour accomplir leurs tâches spécifiques. Implémenter une authentification robuste mécanismes tels que l'authentification multifacteur (MFA') et appliquer des politiques de mot de passe fortes. En outre, examiner régulièrement et mettez à jour les contrôles d'accès pour vous assurer que les privilèges d'accès s'alignent le principe du moindre privilège.

Mise en œuvre stricte les contrôles sur les comptes privilégiés sont essentiels, y compris la limitation nombre de personnes ayant un accès administratif et un suivi strict et des mécanismes d'audit pour les activités privilégiées.

**Une note sur la sécurité du réseau**

Réseau la sécurité est essentielle pour protéger le système de construction contre les menaces externes. Mettre en œuvre une segmentation appropriée du réseau, telle que la division environnement intégré dans des zones de réseau distinctes, peut aider à contenir brèches potentielles et limitation des mouvements latéraux. En voici quelques autres points essentiels à considérer:

-   Mettre en œuvre une communication sécurisée canaux pour les mises à jour logicielles et s'assurer que tous les composants tiers ou les dépendances sont obtenues à partir de sources fiables. 
-   Surveillez et évaluez régulièrement la sécurité de vos fournisseurs de logiciels pour identifier et traiter les risques ou vulnérabilités potentiels.

Apprentissage des incidents tels que l'attaque SolarWinds nous aide à reconnaître le importance critique de sécuriser l'ensemble du processus de construction, à partir du code développement au déploiement, pour se protéger contre les menaces potentielles et assurez la fiabilité de votre logiciel.
