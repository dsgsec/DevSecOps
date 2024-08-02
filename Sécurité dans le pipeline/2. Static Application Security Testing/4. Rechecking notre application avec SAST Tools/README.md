Maintenant que nous savons comment fonctionnent les outils SAST, nous sommes prêts à en utiliser quelques-uns. Nous utiliserons une application PHP simple comme cible pour cette tâche. Vous pouvez trouver le code de l'application dans le `simple-webapp` dossier sur votre bureau.

Revoir notre application avec Psaume

Nous allons d'abord utiliser **Psaume (PHP Analyse Statique Machine à Linting)**, un outil simple pour analyser le code PHP. L'outil est déjà installé dans le cadre du projet de l'application, vous n'aurez donc pas besoin de l'installer, mais vous pouvez trouver des instructions d'installation sur [Documentation en ligne du psaume](https://psalm.dev/docs/running_psalm/installation/) si nécessaire.

Ouvrez un terminal et accédez au répertoire du projet. Vous trouverez un fichier psalm.xml à la racine du projet. Ceci est le fichier de configuration de Psalm, et il devrait ressembler à ceci:

```
<?xml version="1.0"?>
<psalm
    errorLevel="3"
    resolveFromConfigFile="true"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns="https://getpsalm.org/schema/config"
    xsi:schemaLocation="https://getpsalm.org/schema/config vendor/vimeo/psalm/config.xsd"
    findUnusedBaselineEntry="true"
>
    <projectFiles>
        <directory name="html/" />
        <ignoreFiles>
            <directory name="vendor" />
        </ignoreFiles>
    </projectFiles>
</psalm>
```

Nous n'allons pas trop loin dans les options de configuration, mais ici vous pouvez voir le `errorLevel` paramètre, qui indique à quel point le Psaume sera strict lors du signalement des problèmes. Plus la valeur est faible, plus les problèmes seront signalés. Il y a aussi une section appelée `projectFiles`, où les fichiers à analyser sont indiqués. Seul le répertoire html sera analysé pour ce projet, et le répertoire fournisseur sera ignoré (car nous ne voulons pas tester les dépendances tierces).

Avec le jeu de fichiers de configuration, vous pouvez exécuter Psalm en utilisant la commande suivante dans le répertoire du projet:

Linux

```
user@machine$ cd /home/ubuntu/Desktop/simple-webapp/
user@machine$ ./vendor/bin/psalm --no-cache

ERROR: TypeDoesNotContainType - html/hidden-panel.php:10:5 - Operand of type 0 is always falsy (see https://psalm.dev/056)
  if ($result->num_rows = 0) {
```

Par défaut, Psalm n'effectuera qu'une analyse structurelle du code et nous montrera les erreurs de programmation qui nécessitent notre attention. Dans l'exemple précédent, Psaume rapporte que la condition sur le `if` clause est toujours `false`. Dans ce cas, le programmeur a utilisé par erreur l'opérateur d'affectation (`=`) au lieu de l'opérateur de comparaison (`==`'). Puisque l'opérateur d'affectation renvoie toujours la valeur assignée (`0` dans ce cas), la condition sera toujours évaluée comme fausse (`0` sera automatiquement lancé à `false` in PHP').

Les tests par défaut rechercheront les problèmes avec les types de variables, l'initialisation des variables et d'autres modèles de codage sûrs. Bien que ces problèmes ne soient pas des vulnérabilités, Psalm fera des recommandations pour que votre code suive les meilleures pratiques de codage, ce qui est un bon début pour éviter les erreurs d'exécution.

Psalm offre également la possibilité d'exécuter une analyse de flux de données sur notre code en utilisant le `--taint-analysis` drapeau. La sortie de cette commande sera beaucoup plus intéressante car elle identifiera les problèmes de sécurité possibles. La sortie de la commande ressemblera à ceci:

Linux

```
user@machine$ cd /home/ubuntu/Desktop/simple-webapp/
user@machine$ ./vendor/bin/psalm --no-cache --taint-analysis

ERROR: TaintedInclude - html/view.php:22:9 - Detected tainted code passed to include or similar (see https://psalm.dev/251)
  $_GET
    <no known location>

  $_GET['img'] - html/view.php:22:28
include('./gallery-files/'.$_GET['img']);

  concat - html/view.php:22:9
include('./gallery-files/'.$_GET['img']);
```

Pour chaque erreur signalée, Psaume vous montrera une trace complète du flux de données de la source (`$_GET`) à la fonction d'évier (`include()`'). Ici, nous avons une Inclusion de Fichier Local typique (LFI) vulnérabilité, en tant que paramètre GET `img` est concaténé directement dans le nom de fichier passé au `include()` fonction.

L'analyse des flux de données obtient généralement les résultats les plus intéressants du point de vue de la sécurité. Cependant, d'autres résultats structurels sont tout aussi importants à corriger, même s'ils ne se traduisent pas directement par une vulnérabilité exploitable. Les défauts structurels peuvent souvent conduire à des erreurs de logique métier qui peuvent être difficiles à suivre ou à des comportements imprévisibles dans votre application.

Traiter avec les Faux Positifs et les Faux Négatifs

Peu importe quoi SAST outil que vous utilisez, des erreurs seront toujours présentes. Pour rappel, nous nous intéresserons généralement aux deux types d'erreurs suivants:

-   **Faux positifs:** L'outil signale une vulnérabilité qui n'est pas présente dans le code.
-   **Faux négatifs:** L'outil ne signale pas une vulnérabilité présente dans le code.

Ces erreurs peuvent se présenter parce que l'outil ne peut pas évaluer correctement le code cible, mais elles peuvent également être introduites si nous, en tant qu'utilisateurs, n'utilisons pas l'outil correctement.

Par exemple, lorsque nous avons examiné manuellement le code auparavant, nous avons trouvé trois cas possibles d'injection SQL. Pourtant, nous avons écarté l'un d'entre eux car le filtrage des caractères lui était appliqué efficacement, nous laissant avec deux vulnérabilités d'injection SQL confirmées. Si nous vérifions la sortie de Psalm, nous remarquerons seulement une seule instance de SQL l'injection est rapportée (la première en lignes `6-7` de `hidden-panel.php`'):

Linux

```
user@machine$ ./vendor/bin/psalm --no-cache --taint-analysis

ERROR: TaintedSql - html/db.php:18:32 - Detected tainted SQL (see https://psalm.dev/244)
  $_GET
    <no known location>

  $_GET['guest_id'] - html/hidden-panel.php:6:65
$sql = "SELECT id, firstname, lastname FROM MyGuests WHERE id=".$_GET['guest_id'];

  concat - html/hidden-panel.php:6:8
$sql = "SELECT id, firstname, lastname FROM MyGuests WHERE id=".$_GET['guest_id'];

```

Juste comme une expérience, commentons les lignes `6` et `7` dans hidden-pannel.php et voir ce qui se passe:

```
// $sql = "SELECT id, firstname, lastname FROM MyGuests WHERE id=".$_GET['guest_id'];
// $result = db_query($conn, $sql);

```

En théorie, nous ne devrions plus avoir d'erreurs pour signaler les instances TaintedSQL. Cependant, si nous exécutons Psalm une fois de plus, il va maintenant signaler une erreur TaintedSQL différente correspondant à l'un des deux autres SQL requêtes:

Linux

```
user@machine$ ./vendor/bin/psalm --no-cache --taint-analysis

ERROR: TaintedSql - html/db.php:18:32 - Detected tainted SQL (see https://psalm.dev/244)
  $_GET
    <no known location>

  $_GET['log_id'] - html/hidden-panel.php:19:87
$sql2 = "SELECT id, logtext FROM logs WHERE id='".preg_replace('/[^a-z0-9A-Z"]/', "", $_GET['log_id']). "'";

  call to preg_replace - html/hidden-panel.php:19:87
$sql2 = "SELECT id, logtext FROM logs WHERE id='".preg_replace('/[^a-z0-9A-Z"]/', "", $_GET['log_id']). "'";

```

À ce jour, vous vous demandez probablement pourquoi Psalm n'a pas détecté cette vulnérabilité la première fois. La raison de cela peut être trouvée si vous vérifiez la première ligne des deux erreurs. Les deux montrent la ligne `18` de `db.php` comme source du problème. Pour Psaume, les deux vulnérabilités sont les mêmes et liées à la façon dont vous appelez `mysqli_query()` en ligne `18` de `db.php`. En d'autres termes, Psalm s'attend à ce que vous appliquiez un correctif là-bas, car il ne comprend pas que le code définit `db_query()` comme un wrapper à toutes les requêtes de base de données.

Avant de continuer, assurez-vous de décompresser les lignes arrières `6-7` in `hidden-panel.php`:

```
$sql = "SELECT id, firstname, lastname FROM MyGuests WHERE id=".$_GET['guest_id'];
$result = db_query($conn, $sql);

```

Pour mieux aider Psalm à comprendre la situation, nous pouvons utiliser certains **annotation** pour donner plus de contexte. Nous pouvons préciser cela `db_query()` devrait être considéré comme un évier, donc nous obtenons une erreur si une entrée entachée atteint la fonction via le `$query` paramètre. Pour ce faire, ajoutez le commentaire suivant en haut du `db_query()` définition de fonction dans `db.php`:

```
/**
 * @psalm-taint-sink sql $query
 * @psalm-taint-specialize
 */
function db_query($conn, $query){
    $result = mysqli_query($conn, $query);
    return $result;
}
```

Le `@psalm-taint-sink` annotation dit Psaume pour vérifier le `$query` paramètre pour entrées de type entachées `sql`. Maintenant, Psalm émettra une erreur TaintedSQL chaque fois qu'une entrée entachée atteint `db_query()`.

Nous devons également ajouter le `@psalm-taint-specialize` annotation pour dire à Psalm que chaque invocation de la fonction doit être traitée comme une question distincte et que la souillure de la fonction dépend entièrement des entrées qu'elle reçoit. De cette façon, nous aurons les deux problèmes séparément.

Après avoir relancé Psalm, nous devrions maintenant obtenir toutes les instances d'erreurs TaintedSQL comme prévu:

Linux

```
user@machine$ ./vendor/bin/psalm --no-cache --taint-analysis

ERROR: TaintedSql - html/db.php:21:26 - Detected tainted SQL (see https://psalm.dev/244)
  $_GET
    <no known location>

  $_GET['guest_id'] - html/hidden-panel.php:6:65
$sql = "SELECT id, firstname, lastname FROM MyGuests WHERE id=".$_GET['guest_id'];

  concat - html/hidden-panel.php:6:8
$sql = "SELECT id, firstname, lastname FROM MyGuests WHERE id=".$_GET['guest_id'];

  $sql - html/hidden-panel.php:6:1
$sql = "SELECT id, firstname, lastname FROM MyGuests WHERE id=".$_GET['guest_id'];

  call to db_query - html/hidden-panel.php:7:27
$result = db_query($conn, $sql);

ERROR: TaintedSql - html/db.php:21:26 - Detected tainted SQL (see https://psalm.dev/244)
  $_GET
    <no known location>

  $_GET['log_id'] - html/hidden-panel.php:19:87
$sql2 = "SELECT id, logtext FROM logs WHERE id='".preg_replace('/[^a-z0-9A-Z"]/', "", $_GET['log_id']). "'";

  call to preg_replace - html/hidden-panel.php:19:87
$sql2 = "SELECT id, logtext FROM logs WHERE id='".preg_replace('/[^a-z0-9A-Z"]/', "", $_GET['log_id']). "'";

  preg_replace#3 - html/hidden-panel.php:19:87
$sql2 = "SELECT id, logtext FROM logs WHERE id='".preg_replace('/[^a-z0-9A-Z"]/', "", $_GET['log_id']). "'";

  preg_replace - vendor/vimeo/psalm/stubs/CoreGenericFunctions.phpstub:1182:10
function preg_replace($pattern, $replacement, $subject, int $limit = -1, &$count = null) {}

  concat - html/hidden-panel.php:19:9
$sql2 = "SELECT id, logtext FROM logs WHERE id='".preg_replace('/[^a-z0-9A-Z"]/', "", $_GET['log_id']). "'";

  concat - html/hidden-panel.php:19:9
$sql2 = "SELECT id, logtext FROM logs WHERE id='".preg_replace('/[^a-z0-9A-Z"]/', "", $_GET['log_id']). "'";

  $sql2 - html/hidden-panel.php:19:1
$sql2 = "SELECT id, logtext FROM logs WHERE id='".preg_replace('/[^a-z0-9A-Z"]/', "", $_GET['log_id']). "'";

  call to db_query - html/hidden-panel.php:20:28
$result2 = db_query($conn, $sql2);
```

**Note:** Vous obtiendrez une troisième erreur en répétant l'une des précédentes. C'est parce que `mysqli_query` est toujours considéré comme un évier valide (Psalm a une liste intégrée de puits par défaut), vous devriez donc toujours avoir l'alerte d'origine au-dessus des nouveaux.

Enfin, si vous comparez les résultats de Psalm avec notre revue manuelle, vous devriez remarquer qu'il y a quelques différences dans les résultats:

|  | Revue Manuelle | Psalm Review | Verdict |
| --- | --- | --- | --- |
| $sql | Vulnérable | Vulnérable | OK |
| $sql2 | Pas Vulnérable | Vulnérable | Faux Positif |
| $sql3 | Vulnérable | Pas Vulnérable | Faux Négatif |

Un certain niveau de faux positifs et de faux négatifs est toujours attendu lors de l'utilisation SAST outils. Comme pour tout autre outil, vous devez vérifier manuellement le rapport pour rechercher toute erreur. SAST est un excellent complément aux revues manuelles, mais ne devrait jamais être considéré comme leur remplacement.
