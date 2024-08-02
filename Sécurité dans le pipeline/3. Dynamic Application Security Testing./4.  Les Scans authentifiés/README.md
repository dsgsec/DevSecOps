Traiter les connexions

Jusqu'à présent, nous avons effectué une analyse réussie et trouvé certaines vulnérabilités dans l'application cible. Notre application, cependant, a encore des vulnérabilités à découvrir. Si nous naviguons manuellement vers notre application, nous verrons une console d'administration accessible uniquement avec les informations d'identification appropriées. Étant donné que ZAP ne connaît pas ces informations d'identification, il ne sera pas en mesure de vérifier tout ce qui nécessite une authentification.

Nous devons enseigner ZAP comment authentifier et s'assurer que sa session est active pour résoudre ce problème. Pour ce faire, nous allons enregistrer le processus d'authentification dans un script ZEST afin que ZAP peut reproduire le processus pendant les analyses. Pour l'instant, pensez à un script ZEST comme un moyen de sauvegarder et de reproduire une série de requêtes.

**Note:** Pour cette tâche, assurez-vous de désactiver le ZAP HUD depuis la barre d'outils. Certaines choses ne fonctionneront pas comme prévu si elles sont activées. Vous pouvez trouver le bouton pour le faire à la fin de la barre d'outils:

![ff24a4999f2585c783868e9831c541e6](https://github.com/user-attachments/assets/544f07f4-b68b-4562-8240-a47b64bcbea9)

Enregistrement Authentification

Pour enregistrer l'authentification, nous allons cliquer sur le **Enregistrer un Nouveau Script ZEST** bouton sur la barre d'outils:

![image](https://github.com/user-attachments/assets/311dd25c-a4bc-43c3-b2dd-0af6d5249aa6)

Fixons un titre à notre script et choisissons le type **Authentification. **Nous voulons également définir le préfixe à l'URL de base de notre application, car cela filtrera toutes les demandes faites à d'autres sites**:**

![image](https://github.com/user-attachments/assets/ab7531cd-871e-4777-88b0-a23f13a35d3a)

Une fois que nous avons cliqué sur le **Démarrer l'Enregistrement** bouton, chaque requête HTTP qui passe par le proxy ZAP sera enregistrée dans le cadre du script. Faisons-le et ouvrons un navigateur en cliquant sur le **Ouvrez le Navigateur** bouton sur la barre d'outils:

![image](https://github.com/user-attachments/assets/45373076-cda7-43ad-b611-5e3eb890fb0f)

Naviguer pour [http://MACHINE_IP:8082/login.php](http://machine_ip:8082/login.php) sur le navigateur nouvellement ouvert. Nous nous connecterons au site manuellement afin que ZAP peut enregistrer le processus.

![image](https://github.com/user-attachments/assets/71ffa2f7-f142-4cf7-8826-c86d57ccb405)

Vous pouvez utiliser les informations d'identification suivantes pour accéder à l'application Web depuis la page de connexion dans le menu:


| **Nom d'utilisateur** | nospider |
| **Mot de passe** | nospider |

Une fois que nous sommes correctement connectés à l'application, nous arrêterons l'enregistrement en cliquant sur le bouton **Enregistrer un Nouveau Script ZEST** bouton à nouveau. N'hésitez pas à fermer le navigateur de ZAP. Certaines des demandes capturées peuvent ne pas être nécessaires pour le processus d'authentification et peuvent être supprimées. Dans ce cas, ce sont les seules demandes qui comptent:

![image](https://github.com/user-attachments/assets/22f40864-595a-44fd-b19b-43ddc673ecf4)

Pour chacune des demandes, ZAP vérifiera le code d'état et la longueur de la réponse pour voir si elles correspondent. S'ils le font, ZAP supposera que la connexion a réussi. Vous pouvez maintenant tester le script enregistré en appuyant sur la touche **Courir** bouton sur le **Console de Script**:

![image](https://github.com/user-attachments/assets/023538cb-a520-4b2c-be0b-a98f4c396f27)

Cela devrait vous permettre de tester si vous avez enregistré le processus correctement en vérifiant les réponses aux demandes. Notre application doit répondre à la demande POST à `login.php` avec une redirection vers `cowsay.php`:

![image](https://github.com/user-attachments/assets/c3393b6b-3cde-4143-a9c8-4b71ea44fb41)

Créer un Contexte

Maintenant que notre processus d'authentification est enregistré, nous devons dire ZAP où l'utiliser. Ceci est fait en créant un **Contexte**, qui n'est rien d'autre qu'un moyen de définir un groupe d'URL.

Comme il s'agit d'une application simple, l'authentification enregistrée s'appliquera à l'ensemble de celle-ci. Nous devons donc définir un contexte qui inclut chaque URL unique dans l'application afin que nous puissions lier notre script ZEST à elle.

**Note: **En fonction de votre application cible, l'authentification enregistrée peut accorder l'accès à des parties seulement de l'application. Pensez, par exemple, à une plate-forme éducative où vous avez des enseignants et des étudiants. On s'attendrait à ce que les enseignants et les étudiants aient chacun accès à différentes parties de l'application en fonction de leurs rôles. Pour ZAP pour couvrir les deux côtés de l'application, nous aurions besoin d'enregistrer deux scripts ZEST d'authentification (un pour un compte étudiant et un pour un enseignant) et de les attacher à deux contextes différents avec les URL correspondantes.

Pour créer un nouveau contexte, allez dans le **Sites** cliquez avec le bouton droit sur l'URL de base de l'application cible **Sites** tabulation et sélection **Inclure dans le contexte -> Nouveau contexte**:

![image](https://github.com/user-attachments/assets/53a0379d-9b4e-4a90-bc2e-e501ebc144d7)

Cela créera automatiquement une regex qui correspond à n'importe quelle page de l'application Web. Il existe de nombreuses options que vous pouvez configurer dans un contexte. Pour l'instant, cliquez sur authentification, et liez votre script zest en utilisant **Authentification basée sur des scripts**:

![image](https://github.com/user-attachments/assets/0c84ff21-6ac4-469a-a1fb-77fa0019043e)

Assurez-vous de cliquer sur le **Charge** bouton à droite du nom du script. Vous pouvez également configurer la Vérification d'authentification dans cet onglet afin que ZAP peut vérifier s'il a une session valide ou doit se réauthentifier pendant les analyses, mais nous le ferons plus tard d'une manière plus facile.

Pour faire des analyses authentifiées, ZAP vous devrez également définir au moins un utilisateur dans le **Utilisateurs** section. Cela ne sera pas du tout utilisé dans notre cas, car notre script ZEST intègre l'utilisateur et le mot de passe que nous utiliserons. Cependant, ZAP nécessite qu'un utilisateur soit défini, ou il ignorera complètement l'authentification.

![image](https://github.com/user-attachments/assets/8d3aa303-35bc-4330-a397-7447deda3624)

Une fois cela fait, appuyez sur OK et vous devriez voir que toutes les ressources du site sont maintenant marquées avec une icône cible, ce qui signifie qu'elles font maintenant partie du contexte défini.

Re-spider l'Application

Maintenant que nous avons un contexte défini avec notre script d'authentification, réexécutons l'araignée, mais en définissant le contexte correct et l'utilisateur que nous avons créé:

![image](https://github.com/user-attachments/assets/35ed64cc-dafe-427a-98a7-c45d37d9047b)

Cette fois, ZAP devrait être en mesure de trouver toutes les ressources qui nécessitent une authentification et qui n'ont pas été détectées auparavant. Frappons le **Démarrer Scan **bouton et voir ce que nous obtenons. Si vous voulez voir si de nouvelles ressources ont été découvertes lors d'une session d'araignée, vous pouvez toujours vérifier **Ajout de Nodes** onglet:

![image](https://github.com/user-attachments/assets/11a1ad84-3d65-4756-a16f-dcc4ff9281e6)

ZAP a trouvé quelques autres PHP scripts. L'un de ces scripts est chargé de déconnecter un utilisateur et peut poser un problème. Si ZAP essaie d'y accéder, il se déconnectera de sa session.

Éviter les Déconnexions

Pour empêcher ZAP en vous déconnectant, vous faites un clic droit sur le script logout.php dans l'onglet Sites et vous excluez le script de notre contexte:

![image](https://github.com/user-attachments/assets/c7300168-0ef6-46ec-bac5-fc341eadf836)

Maintenant ZAP évitera d'interagir avec le script de déconnexion pendant l'araignée ou la numérisation. Notez que selon l'application, il peut être souhaitable d'exclure d'autres scripts. Savoir comment fonctionne l'application est extrêmement important pour tirer le meilleur parti du processus de numérisation.

En plus d'empêcher les déconnexions directes, nous pouvons spécifier des indicateurs pour ZAP pour identifier si sa session est toujours active ou non, et répétez le script de connexion si nécessaire. Cela se fait facilement en sélectionnant des parties d'une réponse qui n'apparaissent que lorsque vous êtes connecté ou déconnecté.

For example, we know that `cowsay.php` can only be accessed if you have successfully logged in, so it might have good indicators we can use for ZAP. Let's select `cowsay.php` from the Sites tab and select the text that corresponds to the logout link. Right-click the selected text and choose **Flag as Context -> (Your Context Name): Authentication Logged-in indicator:**

![image](https://github.com/user-attachments/assets/bd811082-9098-449a-ad88-4c9b67fbb4a2)

From now on, ZAP will search for the logout link on each response. If it isn't present, it will assume its session needs to be renewed and log back into the application using the ZEST script we recorded.

Vous pouvez également faire de même pour sélectionner un indicateur de déconnexion. Puisque nous savons que le lien de connexion ne doit être visible que si vous êtes déconnecté, nous pouvons l'utiliser à cette fin en suivant une procédure similaire. Prenons le HTML du lien à partir du `aboutme.php` script dans l'onglet Sites:

![image](https://github.com/user-attachments/assets/4d848591-e349-4dec-b520-4e31c8e67115)

Nous cliquerons avec le bouton droit sur le texte sélectionné et choisirons Signaler comme Contexte -> (Votre Nom de Contexte): Authentification Logged-out indicator.

Note: Il est possible que ZAP a mis en cache la réponse authentifiée pour `aboutme.php`. Dans ce cas, vous devrez renvoyer une demande via le navigateur intégré à cette URL pour obtenir le modèle correct.

Maintenant que ZAP a des modèles pour identifier s'il est connecté correctement, nous devons choisir un Stratégie de Vérification pour lui dire comment utiliser correctement les modèles configurés. Selon le site Web que vous consultez, vous voudrez utiliser différentes stratégies et les ajuster en fonction de l'application cible. Dans ce cas, nous utiliserons le Sondage de l'URL spécifiée stratégie et dites-lui de sonder le `/aboutme.php` ressourcez toutes les 60 demandes pour vérifier les modèles de connexion/connexion. Pour ce faire, double-cliquez sur le contexte et modifiez les paramètres suivants sous Authentification:

![image](https://github.com/user-attachments/assets/1e29302e-2e48-4079-a3ed-bb6eb5555d89)

Reprise de l'Application Une Dernière Fois

Nous sommes enfin mis en place pour exécuter une nouvelle analyse sur l'application, sachant qu'elle couvrira désormais les zones de l'application qui nécessitent une authentification. Allons à **Outils -> Active Scan**, et sélectionnez le **Contexte** et **Utilisateur** nous avons créé:

![image](https://github.com/user-attachments/assets/8b66d062-bce4-4433-9060-ac669909e06c)

Si vous avez suivi les étapes correctement, vous, ZAP va maintenant trouver une nouvelle vulnérabilité à haut risque. Assurez-vous d'en prendre note pour répondre aux questions à la fin de la tâche.
