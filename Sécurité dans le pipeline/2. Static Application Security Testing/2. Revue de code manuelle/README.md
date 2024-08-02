Avant de sauter dedans SAST outils, nous examinerons comment l'examen manuel du noyau est généralement effectué, car cela facilitera la compréhension de la façon dont SAST les outils regardent le code.

Au cours de cette tâche, notre objectif sera de trouver des vulnérabilités d'injection SQL dans le code source d'une application simple. L'application présente d'autres vulnérabilités, mais nous nous concentrerons sur un seul type de vulnérabilité pour comprendre comment les révisions de code traditionnelles sont effectuées et comment ces étapes correspondent aux techniques d'analyse utilisées par SAST outils.

Avant de continuer, assurez-vous que votre VM il court en appuyant sur le vert **Démarrer la Machine** bouton attaché à cette tâche. Le VM commence en vue partagée. Si la machine n'est pas visible, appuyez sur le bleu **Afficher Split View** bouton en haut à droite de cette pièce.

Pour cette tâche, le code que nous allons utiliser peut être trouvé dans `/home/ubuntu/Desktop/simple-webapp/`

Recherche de Fonctions Insécurisées

La première étape lors de l'examen du code consiste à identifier les fonctions potentiellement non sécurisées utilisées. Puisque nous recherchons des injections SQL, nous devrions nous concentrer sur toutes les fonctions qui pourraient être utilisées pour envoyer des requêtes brutes à la base de données. Puisque notre code utilise PHP et MySQL, voici quelques fonctions qui sont généralement utilisées pour envoyer des requêtes MySQL:

| Moteur de Base de Données | Fonction                                                                                 |
| ------------------------- | ---------------------------------------------------------------------------------------- |
| MySQL                     | mysqli_query()<br>mysql_requête()<br>mysqli_prépare()<br>requête()<br>préparer()<br><br> |

Un moyen simple de rechercher manuellement les instances de ces fonctions consiste à utiliser grep pour vérifier tous les fichiers de notre projet de manière récursive. Par exemple, pour rechercher des instances de `mysqli_query()`, allez dans le répertoire de base du projet et exécutez la commande suivante:

Linux

```
user@machine$ cd /home/ubuntu/Desktop/simple-webapp/html/

user@machine$ grep -r -n 'mysqli_query('
  db.php:18: $result = mysqli_query($conn, $query);
```

Le `-r` option indique à grep de rechercher récursivement tous les fichiers sous le répertoire courant, et `-n` l'option indique que nous voulons que grep nous indique le numéro de la ligne où le motif a été trouvé. Dans la sortie de terminal ci-dessus, nous pouvons voir qu'une seule instance de `mysqli_query()` a été trouvé en ligne `18`.

Nous avons identifié une ligne qui pourrait conduire à des injections SQL. Cependant, juste en regardant cette ligne, nous ne pouvons pas déterminer si une vulnérabilité est présente.

Comprendre le Contexte

Ouvrons `db.php` analyser le contexte autour de la `mysqli_query()` fonction pour voir si nous avons une meilleure idée de la façon dont il est utilisé:

```
function db_query($conn, $query){
    $result = mysqli_query($conn, $query);
    return $result;
}

```

Ici, nous pouvons voir cela `mysqli_query()` est enveloppé dans le `db_query()` fonction, et que la `$query` le paramètre est passé directement sans modification. Il est très courant que des fonctions soient imbriquées dans d'autres fonctions, il n'est donc parfois pas suffisant d'analyser le contexte local d'une fonction pour déterminer si une vulnérabilité est présente. Nous devons maintenant retracer les utilisations de la `db_query()` fonctionnez dans tout notre code pour identifier les vulnérabilités potentielles.

Tracer les Entrées Utilisateur vers des Fonctions Potentiellement Vulnérables

Nous pouvons utiliser grep à nouveau pour rechercher des utilisations de `db_query()`:

Linux

```
user@machine$ grep -rn 'db_query('
    hidden-panel.php:7:$result = db_query($conn, $sql);
    hidden-panel.php:20:$result2 = db_query($conn, $sql2);
    hidden-panel.php:23:$result3 = db_query($conn, $sql3);
    db.php:17:function db_query($conn, $query){
```

Ici, nous obtenons trois utilisations pour `db_query()` sur `hidden-panel.php`. Encore une fois, nous pouvons analyser le contexte de chaque appel, en commençant par l'appel sur la ligne 7:

```
$sql = "SELECT id, firstname, lastname FROM MyGuests WHERE id=".$_GET['guest_id'];
$result = db_query($conn, $sql);

```

Félicitations pour avoir trouvé un SQL injection! Tout ce qui est passé dans le `guest_id` paramètre via la méthode GET sera concaténé à un brut SQL requête sans aucune vérification d'entrée, permettant à l'attaquant de modifier la requête.

Si nous faisons un processus similaire pour les deux autres utilisations de `db_query()`, nous aurons le code suivant:

```
$sql2 = "SELECT id, logtext FROM logs WHERE id='".preg_replace('/[^a-z0-9A-Z"]/', "", $_GET['log_id']). "'";
$result2 = db_query($conn, $sql2);

$sql3 = "SELECT id, name FROM asciiart WHERE id=".preg_replace("/[^0-9]/", "", $_GET['art_id'], 1);
$result3 = db_query($conn, $sql3);

```

Encore une fois, nous avons certains paramètres GET concaténés en SQL requêtes. Cela nous donnerait l'impression que nous avons deux autres vulnérabilités identifiées. Néanmoins, dans les deux cas, les paramètres GET sont désinfectés `preg_replace()` utiliser différentes expressions régulières pour remplacer tout caractère qui n'est pas autorisé par une chaîne vide. Pour décider si ces lignes de code sont vulnérables, nous devrons évaluer si les filtres en place le permettent SQL injections à passer.

La requête sur `$sql2` est passé à travers un filtre qui n'autorise que les caractères qui sont alphanumériques ou à double guillemets. Bien que les doubles citations puissent sembler être un vecteur possible pour SQLi, elles ne constituent pas une menace dans ce cas SQL la phrase renferme la corde passée `$_GET['log_id']` entre guillemets simples ('). Puisqu'un attaquant n'aurait aucun moyen d'échapper à la chaîne dans la phrase SQL, nous pouvons être sûrs que cette ligne n'est pas vulnérable.

La requête sur `$sql3` est encore plus restrictif, ne permettant de passer que des caractères numériques `$_GET['art_id']`. Notez cependant que le `preg_replace()` la fonction est appelée avec un troisième paramètre défini sur "1". Si nous nous référons à la [page de manuel de la fonction](https://www.php.net/manual/en/function.preg-replace.php), nous allons apprendre que le troisième paramètre indique le nombre maximum de remplacements à effectuer. Comme il est défini sur 1, seul le premier caractère qui n'est pas un nombre sera remplacé par une chaîne vide. Tous les autres caractères passeront sans être remplacés, ce qui permet SQL injections. Cette ligne est en effet vulnérable.

Assez Manuel Révision

Nous avons utilisé la révision manuelle du code pour identifier deux points d'injection SQL dans notre application. Bien que l'exemple d'application soit assez simple, une application réelle a beaucoup plus de lignes de code. Tracer chaque instance d'une fonction potentiellement vulnérable sera beaucoup plus compliqué. À l'heure actuelle, il devrait être évident que l'examen manuel de grandes bases de code peut rapidement devenir une tâche fastidieuse. Nous allons maintenant passer à l'utilisation SAST outils pour effectuer la même analyse pour nous et analyser leur performance.

Bonus Exercice

Utilisez l'examen manuel du code pour trouver d'autres types de vulnérabilités dans le projet fourni. Les questions suivantes vous guideront à travers.
