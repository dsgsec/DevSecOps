Source Code Sécurité

Comme mentionné dans le [Introduction à Pipeline Automation](http://tryhackme.com/jr/introtopipelineautomation) et [Source Code Sécurité](https://tryhackme.com/room/sourcecodesecurity) chambres, la première étape pour sécuriser le pipeline et la construction est de sécuriser la source. Dans le cas où un acteur de la menace peut compromettre la source de notre construction, ils sont en mesure de compromettre la construction elle-même. Nous voulons protéger notre code source des deux problèmes suivants:

-   **Non autorisé Falsification** c'est la question la plus simple des deux. Seuls les utilisateurs autorisés devraient pouvoir modifier le code source. Cela signifie que nous voulons contrôler qui a la capacité de pousser un nouveau code à notre dépôt.
-   **Divulgation Non Autorisée** - C'est un peu plus délicat. Selon l'application, le code source lui-même peut être considéré comme sensible. Par exemple, Microsoft ne souhaite pas divulguer le code source de Word, car c'est leur propriété intellectuelle. Dans les cas où le code source est sensible, nous devons nous assurer de ne pas le divulguer intentionnellement. Ce problème est beaucoup plus commun à trouver.

Confusion des responsabilités

Jetons un coup d'œil à l'exploitation d'une source de construction non sécurisée. Une erreur commune commise dans les grandes organisations est de croire que le périmètre est une limite de sécurité suffisante. Bien que le périmètre joue un rôle, il ne doit pas être considéré comme la seule frontière. Le contrôle d'accès granulaire sur le réseau interne devrait également être mis en œuvre. Cette fausse croyance peut conduire à des erreurs de configuration intéressantes. Jetons un coup d'oeil à un exemple pratique.

Certaines organisations sont incroyablement grandes et ont plusieurs équipes et unités commerciales responsables de différentes choses. Si nous prenons une organisation telle qu'une banque, de nombreuses équipes et unités différentes travaillent ensemble pour gérer la banque. En outre, dans de grandes organisations comme celle-ci, il n'est pas aussi simple que de simplement dire que nous avons une unité d'affaires "IT", a-t-il déclaré, comme il peut y avoir plusieurs équipes travaillant sur de nombreux projets IT et de développement différents au sein de la banque, en utilisant un large éventail de langages de codage, CI/CD pipelines et construire des cadres. Ces grandes organisations peuvent choisir d'héberger leur code source en interne, car une grande partie de ce développement peut être de la propriété intellectuelle (PI). Bien que nous espérions que l'accès aux différents dépôts de code source serait géré de manière granulaire, les erreurs se glissent.

Une telle erreur est que les organisations peuvent laisser l'enregistrement de leur instance Gitlab ouvert. Pas ouvert à Internet (bien que cela se soit également produit auparavant), mais ouvert à tout utilisateur de son réseau interne pour enregistrer un profil. Cela a été simulé dans la tâche précédente en vous permettant d'enregistrer votre propre profil Gitlab.

Certains considéreraient cela comme un risque direct, mais regardons comment la surface d'attaque se développe. Notre exemple d'organisation bancaire pourrait compter 10 000 employés, dont 2 000 pourraient travailler en tant que développeurs et avoir besoin d'accéder à Gitlab. Essentiellement, notre surface d'attaque a augmenté de 500%! Si un seul employé de notre banque est compromis, un attaquant aurait la possibilité d'enregistrer un profil et d'exfiltrer tout repos partagé publiquement.

C'est la deuxième mauvaise configuration qui entre en jeu. Les développeurs de notre banque peuvent croire que, comme l'instance Gitlab n'est accessible qu'en interne, il est acceptable de configurer les repos pour qu'ils soient partagés publiquement. Cela signifie que tout utilisateur possédant un compte Gitlab valide pourra voir le dépôt. Bien qu'ils ne puissent peut-être pas modifier le code, rappelez-vous, dans cet exemple, le code lui-même est considéré comme l'adresse IP de la banque. Cette confusion entre les responsables de la sécurisation du code source peut conduire à la divulgation d'informations sensibles à l'acteur de la menace. Regardons comment cela peut être exploité!

Exploiter une source de construction vulnérable

Vous avez déjà enregistré un profil sur l'instance GitLab. Bien que vous puissiez utiliser l'énumération manuelle pour trouver des informations sensibles dans les repos, où vous êtes dans une équipe rouge, vous devrez automatiser ce processus pour assurer la furtivité et l'efficacité. Nous n'enseignerons pas les deux dans cette tâche pour des raisons évidentes, alors regardons comment nous pouvons rendre le processus efficace. Pour énumérer efficacement les repos visibles publiquement, nous utiliserons le Gitlab API et un script Python comme suit:

énumérateur.py

```
import gitlab
import uuid

# Create a Gitlab connection
gl = gitlab.Gitlab("http://gitlab.tryhackme.loc/", private_token='glpat-TjQ4bSUSML5UUVf9Kg8S')
gl.auth()

# Get all Gitlab projects
projects = gl.projects.list(all=True)

# Enumerate through all projects and try to download a copy
for project in projects:
    print ("Downloading project: " + str(project.name))
    #Generate a UID to attach to the project, to allow us to download all versions of projects with the same name
    UID = str(uuid.uuid4())
    print (UID)
    try:
        repo_download = project.repository_archive(format='zip')
        with open (str(project.name) + "_" + str(UID) +  ".zip", 'wb') as output_file:
            output_file.write(repo_download)
    except Exception as e:
        # Based on permissions, we may not be able to download the project
        print ("Error with this download")
        print (e)
        pass

```

**Note**: Assurez-vous d'installer le paquet Gitlab pip en utilisant `pip3 install python-gitlab==3.15.0`.

Comme mentionné précédemment, le script fourni n'est pas furtif. Plutôt que de déterminer d'abord quels repos sont accessibles au public, il récupère la liste complète de tous les repos et tente de télécharger chacun d'eux. Cela montre un exemple de la façon dont un acteur de la menace peut rapidement et facilement récupérer tous les repos accessibles au public. N'hésitez pas à jouer avec le script pour introduire la furtivité.

Comme vous le verrez, la ligne 5 du script nécessite un jeton d'authentification Gitlab. Gitlab ne permet pas son API pour être interfacé avec l'utilisation des informations d'identification, car cela est jugé non sécurisé. Par conséquent, pour utiliser le script, nous devrons d'abord générer un API jeton pour notre compte. Authentifiez-vous sur le serveur Gitlab et effectuez les étapes suivantes:

1\. Cliquez sur l'icône de votre profil et sélectionnez Préférences:

<img width="254" alt="dc48bbb2b20c6149e5f5e28859905eb0" src="https://github.com/user-attachments/assets/27f267b7-d65c-4513-bda4-ad095bc2f0e9">

2\. Cliquez sur Jetons d'accès:

<img width="259" alt="4409fc960a7e0dddbb36228b67b76ba6" src="https://github.com/user-attachments/assets/a36de15b-be86-4bff-965a-41a09eb2c3fa">

3\. Entrez un nom pour un nouveau API token et sélectionnez les étendues api, read_api et read_repository:

![8bb03761c2a10024a9b92d30251174a0](https://github.com/user-attachments/assets/b7529140-8075-46d3-99ee-0731f00cf382)

4\. Cliquez sur Créer un jeton d'accès personnel, révéler et copier votre jeton d'accès dans un emplacement sécurisé:

![7c80e96791b36465b1494a2f81b41fb7](https://github.com/user-attachments/assets/0c55bab9-e313-4b71-b150-da95a94ef957)

5\. Ajoutez le jeton au script et exécutez-le pour télécharger tous les repos:

Terminal

```
[thm]$ python3.9 enumerator.py
Downloading project: Basic Build
3609db7f-0d07-440c-bdc6-1f78cb283f6a
Downloading project: Mobile App
836fe1fa-0fc2-4917-b1c1-61badef3b711
```

Maintenant, vous avez téléchargé avec succès tous les repos accessibles au public! À ce stade, il existe plusieurs façons de rechercher des informations sensibles. Le plus simple serait d'extraire tous les repos et d'exécuter un grep pour des mots clés spécifiques, tels que `secret`. Assurez-vous de lire les repos disponibles pour trouver le drapeau secret caché!

Sécuriser la Source de Construction

Le contrôle d'accès granulaire est essentiel à la gestion des référentiels et de la plateforme GitLab. Il s'agit de définir des autorisations et des restrictions spécifiques pour différents utilisateurs ou groupes, en veillant à ce que seules les personnes autorisées aient le niveau d'accès approprié aux ressources sensibles. Cela permet de maintenir la sécurité, la confidentialité et une collaboration efficace dans un environnement de développement.

Dans GitLab, le contrôle d'accès par groupe est un mécanisme puissant qui simplifie la gestion des autorisations sur plusieurs référentiels et projets. Voici comment cela fonctionne:

1.  **Contrôle d'Accès en Groupe**: GitLab vous permet d'organiser des projets en groupes. Au lieu de gérer l'accès pour chaque projet séparément, vous pouvez définir des autorisations au niveau du groupe. Cela signifie que les mêmes règles d'accès s'appliquent à tous les projets du groupe, ce qui facilite le maintien de politiques de sécurité cohérentes. Par exemple, vous pouvez créer un groupe pour l'équipe de développement et définir des autorisations, par exemple qui peut afficher, modifier ou contribuer à des projets au sein de ce groupe. Cette approche rationalise la gestion des accès et réduit les risques d'erreurs ou d'omissions lors de la configuration des autorisations pour les référentiels individuels.
2.  **Niveaux d'Accès** : GitLab offre différents niveaux d'accès, tels que Guest, Reporter, Developer, Maintainer et Owner. Chaque niveau est livré avec des capacités et des autorisations spécifiques. L'attribution du niveau d'accès approprié à chaque utilisateur ou groupe garantit qu'il dispose des privilèges nécessaires sans accorder d'autorisations inutiles.
3.  **Protection des Informations Sensibles** : Une considération critique est la prévention de l'exposition accidentelle d'informations sensibles. GitLab fournit des fonctionnalités pour vous aider:

1.  **GitLab .gitignore** : Ce fichier spécifie quels fichiers ou répertoires doivent être exclus du contrôle de version. Il est crucial pour prévenir les données sensibles comme les mots de passe, API clés et fichiers de configuration depuis leur engagement dans les référentiels.
2.  **Environnement Variables** : GitLab vous permet de définir et de gérer des variables d'environnement en toute sécurité, indépendamment du code source. Ceci est particulièrement utile pour stocker les données sensibles nécessaires pendant la CI/CD traiter sans l'exposer dans le référentiel.
3.  **Protection des Branches** : Les branches, comme master ou main, peuvent être protégées pour éviter les poussées directes, en veillant à ce que les modifications passent par l'examen du code et les tests automatisés avant la fusion.

N'oubliez pas que le maintien de la sécurité des référentiels et de l'instance GitLab elle-même nécessite une vigilance constante et de bonnes pratiques:

-   Examinez et mettez à jour régulièrement les autorisations d'accès lorsque les membres de l'équipe changent de rôle ou quittent l'organisation.
-   Implémentez l'authentification à deux facteurs (2FA) pour ajouter une couche de sécurité supplémentaire aux comptes d'utilisateurs.
-   Surveillez les journaux d'audit pour savoir qui a accédé ou modifié les référentiels et projets.
-   Analyser régulièrement les dépôts d'informations sensibles à l'aide d'outils conçus à cet effet.
