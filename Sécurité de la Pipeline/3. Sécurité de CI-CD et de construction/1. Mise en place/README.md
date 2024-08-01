### Patching In

Allons vous connecter au Nostromo et au plus grand réseau extra-terrestre!

**AttackBox**

Si vous utilisez la Web-based AttackBox, vous serez automatiquement connecté au réseau si vous démarrez l'AttackBox à partir de la page de la salle. Vous pouvez le vérifier en exécutant la commande ping sur l'adresse IP de l'hôte Gitlab. Vous devez également prendre le temps de prendre note de votre VPN IP. Utilisation `ifconfig` ou `ip a`, notez l'adresse IP du **cigale** adaptateur réseau. Il s'agit de votre adresse IP et de l'interface associée que vous devez utiliser lors de l'exécution des attaques dans les tâches.

**Autres Hôtes**

Si vous allez utiliser votre propre machine d'attaque, un fichier de configuration OpenVPN aura été généré pour vous une fois que vous avez rejoint la salle. Allez à votre [accès](https://tryhackme.com/access) page. Sélectionnez 'Cicdandbuildsecurity' dans le VPN serveurs (sous l'onglet réseau) et téléchargez votre fichier de configuration.

![9cd599412c497e27c68c9dc9b0a98504](https://github.com/user-attachments/assets/ccba308e-b50e-43e7-a5ed-e5d3963ac25c)

Utilisez un client OpenVPN pour vous connecter. Cet exemple est montré sur le [Linux](https://tryhackme.com/access#pills-linux) machine; utilisez ce guide pour connecter en utilisant [Windows](https://tryhackme.com/access#pills-windows) ou [macOS](https://tryhackme.com/access#pills-macos).

### Terminal

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

![e103425252562925b7feab754054f66d](https://github.com/user-attachments/assets/2b8b9f7a-353c-43b1-a0fa-864d47af866b)

Configuration DNS

Il n'y en a que deux DNS entrées pour ce réseau qui sont importantes. Ainsi, le plus simple est de les intégrer DNS entrez directement dans votre fichier hosts, que vous utilisiez l'AttackBox ou votre propre machine. Pour ce faire, examinez le diagramme de réseau ci-dessus et notez l'adresse IP du Gitlab et Jenkins hôte. Ensuite, effectuez la commande suivante à partir d'un terminal:

`sudo echo <Gitlab IP> gitlab.tryhackme.loc >> /etc/hosts && sudo echo <Jenkins IP> jenkins.tryhackme.loc >> /etc/hosts`

Toutefois, si vous avez déjà démarré le réseau et que vous devez ajouter à nouveau cette entrée ou la mettre à jour, utilisez votre éditeur de texte préféré pour modifier directement l'entrée dans votre `/etc/hosts` fichier. Une fois configuré, vous pouvez naviguer vers [http://gitlab.tryhackme.loc](http://gitlab.tryhackme.loc/) pour vérifier que votre accès fonctionne. Vous devriez être rencontré avec la page suivante:

![990b3e40c18bb16a990cde5410bd32fe](https://github.com/user-attachments/assets/15a83fa7-6556-498d-beb6-f1e87897e8e1)

Contacter MU-TH-UR 6000

Au fur et à mesure que vous progressez dans ce réseau, vous devez signaler votre travail au mainframe MU-TH-UR 6000, mieux connu sous le nom de Mother. Vous devrez vous inscrire auprès de Mère avant de commencer ce périlleux voyage. SSH est utilisé pour la communication comme détaillé ci-dessous:

| SSH Nom d'utilisateur |      mother     |
|:---------------------:|:---------------:|
|    SSH Mot de passe   | motherknowsbest |
|         SSH IP        |    X.X.X.250    |

Utilisez votre diagramme de réseau pour remplacer les valeurs X dans votre SSH IP. Une fois authentifié, vous pourrez communiquer avec Mère. Suivez les invites pour vous inscrire au défi, et enregistrez les informations que vous obtenez pour référence future. Une fois inscrit, suivez les instructions pour vérifier que vous pouvez accéder à toutes les les systèmes pertinents.

Le VPN le serveur et le mainframe mère ne sont pas dans la portée de ce réseau, et tout test de sécurité de ces systèmes peut conduire à une interdiction du réseau.

Comme vous faites votre chemin à travers le réseau, vous devrez prouver votre compromis. Pour ce faire, il vous sera demandé d'effectuer étapes spécifiques sur l'hôte que vous avez compromis. Veuillez noter que noms d'hôtes dans le diagramme de réseau ci-dessus, car vous en aurez besoin information. Les drapeaux ne sont accessibles qu'à partir des hôtes correspondants.

**Remarque: Si le réseau a été réinitialisé ou si vous avez rejoint un nouveau sous-réseau après l'expiration de votre temps sur le réseau, votre compte mère restera actif.**
