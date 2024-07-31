Introduction

Comme on l'a vu dans la tâche précédente, les variables d'environnement sont essentielles pour sécuriser les informations d'authentification numériques, telles que les mots de passe, clés, API et jetons, utilisées dans les applications, services, comptes privilégiés, et d'autres parties sensibles de l'écosystème IT. Cependant, nous devons mettre en œuvre un **gestion secrète** solution pour utiliser correctement ces variables d'environnement. Une gestion inadéquate des secrets peut entraîner des failles de sécurité et des problèmes d'audit, entraînant des failles de sécurité potentielles. Dans ce tutoriel, nous allons explorer comment gérer les secrets avec GitLab.

Gérer les secrets dans GitLab

Une fois que vous avez ajouté les variables d'environnement à votre projet GitLab, vous pouvez utiliser la fonctionnalité de gestion secrète de GitLab pour stocker et accéder à ces variables en toute sécurité. Voici comment vous pouvez le faire:

1.  Accédez à votre projet GitLab et accédez à la page "Paramètres.
2.  Cliquez sur l'onglet "CI/CD", puis cliquez sur "Variables".
3.  Cliquez sur "Ajouter une variable" et entrez le nom et la valeur de votre variable d'environnement. Assurez-vous de marquer la variable comme "Protégée".
4.  Cliquez sur "Ajouter une variable" pour enregistrer la variable.
5.  Maintenant, dans votre fichier nostromo.go, vous pouvez utiliser la syntaxe `os.Getenv("variable_name")` pour accéder à la valeur de la variable d'environnement.

Par exemple, nous avons ajouté des variables nommées GITLAB_USERNAME et GITLAB_PASSWORD; vous pouvez y accéder dans nostromo.go comme ceci:

```

func init () {
    apiURL = "https://example.com"
    username = os.Getenv("GITLAB_USERNAME")
    password = os.Getenv("GITLAB_PASSWORD")
}

```

Maintenant, vous pouvez stocker en toute sécurité les informations d'identification et y accéder en utilisant des variables d'environnement.

**Bonus**

Avez-vous remarqué qu'il y a un `.gitlab-ci.yml` dossier? Mais il n'y a pas de pipelines, de workflows ou de "contrôles de statut"? Pour rechercher à quoi sert ce fichier, consultez: <https://docs.gitlab.com/ee/ci/yaml/gitlab_ci_yaml.html>. Bien qu'il soit hors de portée pour cette pièce, gardez les yeux ouverts pour la pièce suivante dans le chemin: "Build System Security".

Pouvez-vous comprendre le contenu de `.gitlab-ci.yml`  moyens?
