Patching In

Allons vous connecter au Nostromo et au plus grand réseau extra-terrestre!

**AttackBox**

Si vous utilisez la Web-based AttackBox, vous serez automatiquement connecté au réseau si vous démarrez l'AttackBox à partir de la page de la salle. Vous pouvez le vérifier en exécutant la commande ping sur l'adresse IP de l'hôte Gitlab. Vous devez également prendre le temps de prendre note de votre VPN IP. Utilisation `ifconfig` ou `ip a`, notez l'adresse IP du **cigale** adaptateur réseau. Il s'agit de votre adresse IP et de l'interface associée que vous devez utiliser lors de l'exécution des attaques dans les tâches.

**Autres Hôtes**

Si vous allez utiliser votre propre machine d'attaque, un fichier de configuration OpenVPN aura été généré pour vous une fois que vous avez rejoint la salle. Allez à votre [accès](https://tryhackme.com/access) page. Sélectionnez 'Cicdandbuildsecurity' dans le VPN serveurs (sous l'onglet réseau) et téléchargez votre fichier de configuration.

![VPN serveur](https://tryhackme-images.s3.amazonaws.com/user-uploads/6093e17fa004d20049b6933e/room-content/9cd599412c497e27c68c9dc9b0a98504.png)

Utilisez un client OpenVPN pour vous connecter. Cet exemple est montré sur le [Linux](https://tryhackme.com/access#pills-linux) machine; utilisez ce guide pour connecter en utilisant [Windows](https://tryhackme.com/access#pills-windows) ou [macOS](https://tryhackme.com/access#pills-macos).

Terminal
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
```
[thm@thm]$ sudo openvpn cicdandbuildsecurity.ovpn
Fri Mar 11 15:06:20 2022 OpenVPN 2.4.9 x86_64-redhat-linux-gnu [SSL (OpenSSL)] [LZO] [LZ4] [EPOLL] [PKCS11] [MH/PKTINFO] [AEAD] built on Apr 19 2020
Fri Mar 11 15:06:20 2022 library versions: OpenSSL 1.1.1g FIPS  21 Apr 2020, LZO 2.08
[....]
Fri Mar 11 15:06:22 2022 /sbin/ip link set dev tun0 up mtu 1500
Fri Mar 11 15:06:22 2022 /sbin/ip addr add dev tun0 10.50.2.3/24 broadcast 10.50.2.255
Fri Mar 11 15:06:22 2022 /sbin/ip route add 10.200.4.0/24 metric 1000 via 10.50.2.1
Fri Mar 11 15:06:22 2022 WARNING: this configuration may cache passwords in memory -- use the auth-nocache option to prevent this
Fri Mar 11 15:06:22 2022 Initialization Sequence Completed
```

Le message "Initialisation Séquence terminée" vous indique vous êtes maintenant connecté au réseau. Retour à votre page d'accès. Vous vous pouvez vérifier que vous êtes connecté en consultant votre page d'accès. Rafraîchissez le page et voir une coche verte à côté de Connecté. Il le sera aussi vous montrer votre adresse IP interne.

![page d'accès](https://tryhackme-images.s3.amazonaws.com/user-uploads/6093e17fa004d20049b6933e/room-content/e103425252562925b7feab754054f66d.png)

Configuration DNS

Il n'y en a que deux DNS entrées pour ce réseau qui sont importantes. Ainsi, le plus simple est de les intégrer DNS entrez directement dans votre fichier hosts, que vous utilisiez l'AttackBox ou votre propre machine. Pour ce faire, examinez le diagramme de réseau ci-dessus et notez l'adresse IP du Gitlab et Jenkins hôte. Ensuite, effectuez la commande suivante à partir d'un terminal:

`sudo echo <Gitlab IP> gitlab.tryhackme.loc >> /etc/hosts && sudo echo <Jenkins IP> jenkins.tryhackme.loc >> /etc/hosts`

Toutefois, si vous avez déjà démarré le réseau et que vous devez ajouter à nouveau cette entrée ou la mettre à jour, utilisez votre éditeur de texte préféré pour modifier directement l'entrée dans votre `/etc/hosts` fichier. Une fois configuré, vous pouvez naviguer vers [http://gitlab.tryhackme.loc](http://gitlab.tryhackme.loc/) pour vérifier que votre accès fonctionne. Vous devriez être rencontré avec la page suivante:

![page de connexion](https://tryhackme-images.s3.amazonaws.com/user-uploads/6093e17fa004d20049b6933e/room-content/990b3e40c18bb16a990cde5410bd32fe.png)

Contacter MU-TH-UR 6000

Au fur et à mesure que vous progressez dans ce réseau, vous devez signaler votre travail au mainframe MU-TH-UR 6000, mieux connu sous le nom de Mother. Vous devrez vous inscrire auprès de Mère avant de commencer ce périlleux voyage. SSH est utilisé pour la communication comme détaillé ci-dessous:

| **SSH Nom d'utilisateur**\
 | mère\
 |
| **SSH Mot de passe**\
 | mèreconnaît\
 |
| **SSH IP**\
 | X.X.X.250\
 |

Utilisez votre diagramme de réseau pour remplacer les valeurs X dans votre SSH IP. Une fois authentifié, vous pourrez communiquer avec Mère. Suivez les invites pour vous inscrire au défi, et enregistrez les informations que vous obtenez pour référence future. Une fois inscrit, suivez les instructions pour vérifier que vous pouvez accéder à toutes les les systèmes pertinents.

Le VPN le serveur et le mainframe mère ne sont pas dans la portée de ce réseau, et tout test de sécurité de ces systèmes peut conduire à une interdiction du réseau.

Comme vous faites votre chemin à travers le réseau, vous devrez prouver votre compromis. Pour ce faire, il vous sera demandé d'effectuer étapes spécifiques sur l'hôte que vous avez compromis. Veuillez noter que noms d'hôtes dans le diagramme de réseau ci-dessus, car vous en aurez besoin information. Les drapeaux ne sont accessibles qu'à partir des hôtes correspondants.

**Remarque: Si le réseau a été réinitialisé ou si vous avez rejoint un nouveau sous-réseau après l'expiration de votre temps sur le réseau, votre compte mère restera actif.**
