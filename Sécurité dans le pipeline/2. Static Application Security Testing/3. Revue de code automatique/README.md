Test de Sécurité des Applications Statiques

Test de Sécurité des Applications Statiques (SAST) se réfère à l'utilisation d'outils automatisés pour l'analyse de code. L'idée n'est pas de remplacer les révisions manuelles du code, mais de fournir une méthode simple pour automatiser les vérifications simples du code afin de trouver rapidement des vulnérabilités pendant le processus de développement sans nécessiter d'individu spécialisé.

SAST complète d'autres techniques, telles que Dynamic Application Security Testing (DAST) ou Software Composition Analysis (SCA), pour fournir une approche holistique de la sécurité des applications au cours du cycle de développement. Comme pour toutes les autres techniques, SAST aura ses avantages et ses inconvénients dont nous devons être conscients:

|
| Points positifs: Il ne nécessite pas d'instance en cours d'exécution de l'application cible.  Il offre une grande couverture des fonctionnalités de l'application. Il fonctionne rapidement par opposition à d'autres techniques dynamiques. SAST les outils signalent exactement où se trouvent les vulnérabilités dans le code. Facile à intégrer dans votre CI/CD pipeline. | Points négatifs: Le code source d'une application n'est pas toujours disponible (applications tierces). Proner aux faux positifs. Impossible d'identifier les vulnérabilités de nature dynamique. SAST les outils sont principalement spécifiques à la langue. Ils ne peuvent vérifier que les langues qu'ils connaissent. |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|

SAST Sous le Capot

Alors que chaque SAST outil est différent, la plupart d'entre eux effectueront deux tâches principales:

1.  **Transformer le code en un modèle abstrait:** Les outils SAST ingèrent généralement le code source et produisent une représentation abstraite pour une analyse plus approfondie. La plupart des outils SAST représenteront le code en utilisant Abstract Syntax Trees (AST), mais certains outils peuvent avoir d'autres structures propriétaires équivalentes. Cela permet une analyse plus facile du code d'une manière indépendante du langage de programmation utilisé. Cette étape est cruciale pour une analyse ultérieure, car toute fonctionnalité d'un langage de programmation qui n'est pas correctement traduite dans l'AST ne sera probablement pas analysée efficacement pour les problèmes de sécurité.
2.  **Analyser le modèle abstrait pour les questions de sécurité:** Différentes techniques d'analyse seront utilisées pour rechercher des vulnérabilités potentielles dans le modèle de code.

Pendant cette salle, nous ne couvrirons pas la modélisation du code en détail, car vous n'aurez pas à le traiter du point de vue de l'utilisateur. Nous nous concentrerons plutôt sur les différentes techniques d'analyse couramment utilisées par SAST outils:

### Analyse Sémantique
![7c3d17f4c1cb81950fe4a9f056e03dba](https://github.com/user-attachments/assets/ab555af1-61d2-469a-9307-ac8fcc1f4c7c)

**Analyse sémantique :** Ce type d'analyse peut être comparé au grapping pour des fonctions potentiellement non sécurisées tout en effectuant des révisions manuelles du code. Il vise à trouver des failles concernant l'utilisation de code potentiellement non sécurisé dans un contexte localisé.

Des exemples de ceci incluent la recherche d'appels à `mysqli_query()` où les paramètres GET ou POST sont directement concaténés dans la chaîne de requête:
```php
mysqli_query($db, "SELECT * from users where username=".$_GET['username'])
```

---

### Analyse de Flux de Données
![fb294ccfe9bbd914c21a174e64f13213](https://github.com/user-attachments/assets/10cd6af3-a60c-4f19-8ec3-a74b34df2324)

**Analyse de flux de données :** Il existe des situations où des fonctions potentiellement dangereuses sont utilisées, mais il n'est pas clair si une vulnérabilité est présente simplement en analysant le contexte local autour de l'appel de fonction. Prenons par exemple une fonction définie comme suit:
```php
function db_query($conn, $query) {
    $result = mysqli_query($conn, $query);
    return $result;
}
```
En regardant le code de la fonction, il est difficile de dire s'il y a des vulnérabilités. Analyser le contexte local de l'appel à une fonction dangereuse ne suffit pas dans ce cas.

L'analyse des flux de données retracera comment les flux d'informations provenant des entrées que l'utilisateur peut manipuler vers des fonctions potentiellement vulnérables, tout comme nous l'avons fait lors de l'analyse manuelle du code de l'application fournie. Dans la terminologie de l'analyse des flux de données, les entrées de données seront appelées **sources**, et les fonctions potentiellement vulnérables seront appelées **éviers**. Si les données circulent d'une source vers un puits sans désinfection, nous avons une vulnérabilité.

Pour revenir à la fonction `db_query()`, l'analyse de flux de données devrait trouver tous ses usages et retracer pour voir si une entrée entachée (la source) lui est envoyée, se retrouvant enfin dans le cadre de la requête exécutée par `mysqli_query()` (l'évier).

![aa9389c3ba8aaadd6ed4ce84025f818d](https://github.com/user-attachments/assets/7cd96fc0-9dd2-4eb0-b00b-b079b7e51d65)

---

### Analyse du Flux de Contrôle
![1747a47ae9ed1257e9a2e83cf51940bd](https://github.com/user-attachments/assets/a2abbf4d-ab9d-46f7-b285-112f1d9719cd)

**Analyse du flux de contrôle :** Analyse l'ordre des opérations dans le code à la recherche de conditions de course, l'utilisation de variables non initialisées ou des fuites de ressources. À titre d'exemple, regardez le morceau de code Java suivant:
```java
String cmd = System.getProperty("cmd");
cmd = cmd.trim();
```
Si la propriété `cmd` n'est pas définie, l'appel à `System.getProperty()` retournera NULL. L'appel de la méthode trim à partir d'une variable NULL lancera une exception à l'exécution.

---

### Analyse Structurelle
![8e1238f36efec1e0d531a1b3fb422d7e](https://github.com/user-attachments/assets/a91f78a9-d53f-43e2-a707-219264f01780)

**Analyse structurelle :** Analyse des structures de code spécifiques à chaque langage de programmation. Cela inclut les meilleures pratiques suivantes lors de la déclaration de classes, l'évaluation de blocs de code qui peuvent ne jamais s'exécuter (code mort), en utilisant correctement les blocs try/catch et autres problèmes liés à l'utilisation de matériel cryptographique non sécurisé (clés faibles ou IV).

Voici un exemple rapide de code qui serait détecté par l'analyse structurelle:
```php
$options = array('private_key_bits' => 1024, 'private_key_type' => OPENSSL_KEYTYPE_RSA);
$res = openssl_pkey_new($options);
```
Dans ce cas, nous avons une implémentation de RSA avec une taille de clé de 1024, considérée comme insuffisante par les normes actuelles.

---

### Analyse de Configuration
![66518f2330b41f5fcab67b49daae3fc4](https://github.com/user-attachments/assets/3ebf96cd-c480-4817-9b20-3855ac0da1cd)

**Analyse de configuration :** Recherche les défauts de configuration de l'application plutôt que le code lui-même. Par exemple, les applications exécutées sous Internet Information Services auront un fichier de configuration appelé `web.config`, PHP contiendra toutes ses options de configuration dans un fichier appelé `php.ini`, et la plupart des applications utiliseront un fichier de configuration. En vérifiant les configurations, l'outil identifiera les améliorations possibles.

Voici un exemple de deux directives de PHP qui déclencheraient probablement une alerte sur les outils SAST, car elles facilitent certains vecteurs d'attaque pour RFI, SSRF ou autre:
```php
allow_url_include = On
allow_url_fopen = On
```


Il est important de noter que pas tous SAST l'outil mettra en œuvre toutes les techniques d'analyse dont nous avons discuté, mais il est bon de les avoir comme référence pour comparer différentes solutions.
