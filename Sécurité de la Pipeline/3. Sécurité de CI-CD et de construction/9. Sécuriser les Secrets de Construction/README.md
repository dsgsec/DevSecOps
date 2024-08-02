On voit la ligne d'arrivée devant nous! Notre pipeline et notre construction sont presque sécurisés! Une dernière étape reste: s'assurer que nos secrets de construction sont correctement protégés!

Un Secret pour Les Gouverner Tous

Larry a enfin appris sa leçon et s'est assuré de mettre en œuvre des coureurs ségrégués pour les différents environnements. Mais il y a un autre problème. Bien que ces pipelines puissent être séparés, nous devons nous assurer que les secrets (ou les variables telles qu'elles sont connues dans Gitlab) sont également séparés. Si la portée des secrets n'est pas définie de manière étroite, nous pouvons demander l'utilisation de secrets PROD dans notre construction DEV, ce qui nous permet de compromettre l'environnement de production une dernière fois! Accédez au dernier repo que nous avons utilisé pour cet exploit: <http://gitlab.tryhackme.loc/ash/environments>.

Jetons un coup d'œil aux environnements et aux dernières versions pour eux, comme nous l'avons fait dans la tâche précédente. En examinant l'un des déploiements de production, nous pouvons voir que la version utilise une variable API_KEY:

![185933ee3b6b3b0b94f1a7e903c0de5b](https://github.com/user-attachments/assets/b57f5265-9a18-4c7f-9352-0a5eb0a02169)

En tant qu'Ana, nous n'avons pas les autorisations requises pour lister les différentes variables, mais en examinant celles de la branche DEV CI file, nous pouvons voir que notre variable DEV est différente:

![8096bf2504d99fce279d30e27f3da62c](https://github.com/user-attachments/assets/6ec7ff99-3e61-45a4-94a6-26c6fb72aa32)

Dans notre cas, la valeur est API_KEY_DEV. Faisons un changement à cette variable et faisons également écho à la valeur pour voir si nous pouvons accéder à la variable PROD. Faites le changement à la CI file dans la branche DEV et vois ce qui se passe!

Protéger les Secrets de Construction

La protection des secrets de construction, même lors de l'utilisation des variables GitLab CI/CD, est cruciale pour maintenir la sécurité de vos pipelines. GitLab CI/CD fournit une fonctionnalité appelée "variables masquées" pour aider à empêcher les secrets d'être exposés dans les journaux. Voici comment vous pouvez utiliser cette fonctionnalité:

**Masquer les Variables**

Vous pouvez masquer des variables dans votre fichier .gitlab-ci.yml en utilisant la variable prédéfinie CI_JOB_TOKEN. Ce jeton est automatiquement défini par GitLab et peut être utilisé pour masquer toute valeur de variable que vous souhaitez masquer.

Par exemple, si vous avez une variable nommée MY_SECRET_KEY, vous pouvez l'utiliser comme ceci:

```
my_job:
  script:
    - echo "$MY_SECRET_KEY" # This will expose the secret
    - echo "masked: $CI_JOB_TOKEN" # This will mask the secret
```

**Utilisez les Variables Sécurisées**

Si vous souhaitez stocker des secrets en toute sécurité dans GitLab, vous pouvez utiliser les variables CI/CD GitLab avec l'option "Masqué" activée. Ces variables sont stockées en toute sécurité et ne sont jamais exposées dans les journaux de tâches, même si vous les utilisez directement dans vos scripts. Pour créer une variable sécurisée:

-   Aller au projet GitLab.
-   Accédez à Paramètres > CI/CD > Variables.
-   Ajoutez une nouvelle variable, cochez la case "Masqué" et indiquez la valeur.
-   Une fois que vous avez ajouté une variable sécurisée, vous pouvez l'utiliser dans votre fichier .gitlab-ci.yml sans vous soucier de son exposition dans les journaux.

^Remarque: Assurez-vous que vos scripts de travail n'échosent pas par inadvertance ou n'impriment pas d'informations sensibles, même lorsque vous utilisez des variables masquées. Double-vérifiez vos scripts pour éviter l'exposition involontaire de secrets.^

**Contrôle d'Accès**

Limiter l'accès à CI/CD variables et journaux. Seul autorisé peut afficher les journaux de tâches et les variables dans GitLab. Vous pouvez configurer des contrôles d'accès au niveau projet et groupe pour y parvenir.
