Avec notre serveur de build sécurisé, nous allons jeter un coup d'œil au pipeline lui-même! Même si nous faisons tout correctement, nous devons toujours considérer que l'un de nos développeurs peut être compromis. Que le développeur réel soit compromis par une attaque d'ingénierie sociale ou simplement que ses informations d'identification soient exposées, ce compromis pourrait être la chute de notre pipeline et de notre build. Heureusement, il existe des protections qui peuvent être appliquées!

Accès Gates

Les portes d'accès, également appelées portes ou points de contrôle, servent de "étapes" dans un pipeline de développement logiciel. Ils garantissent que le code progresse dans le pipeline uniquement après avoir satisfait aux critères de qualité et de sécurité prédéfinis. Les barrières d'accès sont cruciales pour améliorer le processus de développement *contrôle*, *assurance qualité*, et *sécurité*. C'est bénéfique pour tout le monde.

1.  **Contrôle Amélioré**: Les portes d'accès fournissent des points de contrôle dans le pipeline, permettant une progression contrôlée vers différentes étapes.
2.  **Contrôle Qualité**: Gates s'assure que le code répond aux normes de qualité prédéfinies avant d'avancer.
3.  **Vérifications de Sécurité**: Gates active les évaluations de sécurité, telles que les analyses de vulnérabilité, avant le déploiement.

**﻿Étapes de Mise en Œuvre**:

1.  **Manuel Approbation**: Exiger une approbation manuelle avant de passer à l'étape suivante, en assurant des examens approfondis.
2.  **Automatisé Tests**: Configurez des portes de test automatisées pour la qualité du code, les tests unitaires, les tests d'intégration, etc.
3.  **Sécurité Scans**: Intégrer des outils d'analyse de sécurité pour détecter les vulnérabilités dans la base de code.
4.  **Libérez Gates**: Utilisez des portes pour vérifier la documentation, le versionnage et la conformité appropriés.
5.  **Environnement Validation**: Valider la préparation de l'environnement cible avant le déploiement.
6.  **Plan de Rétro-Retour**: Inclure une barrière pour un plan de restauration bien défini en cas de problèmes post-déploiement.
7.  **Surveillance**: Mettre en œuvre des barrières de surveillance pour évaluer les performances post-déploiement.
8.  **Portes Parallèles**: Exécutez les portes en parallèle pour accélérer le pipeline sans compromettre la qualité.
9.  **Audit**: Examiner régulièrement les configurations et les résultats des portes pour en assurer l'efficacité.

Le Concept à Deux Personnes

Même si nous avons des portes d'accès, nous devons nous assurer qu'aucun utilisateur ne peut passer ces portes d'accès. Si vous êtes le développeur qui a lancé la construction, vous devriez être empêché de passer la porte d'accès suivante. Ça devrait toujours être quelqu'un d'autre. En appliquant cela avec un contrôle technique, il peut être assuré que dans le cas où un développeur est compromis, une construction ne peut pas être poussée à travers. C'est ce qu'on appelle la règle des deux personnes.

Certains serveurs de construction peuvent ne pas vous permettre d'assurer un contrôle sur la porte d'accès pour vous assurer qu'il s'agit d'une personne différente. Une bonne solution dans ces cas est simplement d'augmenter le nombre d'approbations nécessaires de 1 à 2. De cette façon, le développeur fournit une approbation, mais une personne secondaire doit fournir l'autre.

Exploitation de Portes d'accès mal configurées

Jetons un coup d'œil à un exemple où les portes d'accès ont été mal configurées. Dans cet exemple, nous vous fournirons un accès en tant qu'utilisateur Ana. Vous utiliserez cet utilisateur pour tous les exercices à venir. Vous pouvez utiliser les informations suivantes pour vous authentifier sur Gitlab en tant qu'Ana:

| **Nom d'utilisateur** | anatacker |
| **Mot de passe** | Password1@ |

Ash a fourni à Ana un accès développeur à son dépôt Approval-Test, qui peut être trouvé ici: <http://gitlab.tryhackme.loc/ash/approval-test>. Pour protéger la branche principale du dépôt, Ash a configuré la branche principale pour qu'elle soit une branche protégée, où les développeurs ne sont autorisés qu'à effectuer des demandes de fusion et à ne pas modifier directement le code. Testons cela en mettant à jour le fichier README et en essayant de valider la modification sur la branche principale. Accédez au fichier README et cliquez sur Modifier:

![b25688bbf71085e1c73f493123fa206e](https://github.com/user-attachments/assets/41ea3f86-e0f9-48d5-a212-62b6e961c75a)

Comme vous pouvez le voir, Gitlab demande automatiquement que nous commencions une demande de fusion avec les modifications que nous voulons apporter. Vous verrez également que nous ne pouvons pas désélectionner l'option de commettre directement. Effectuez une petite modification au fichier et cliquez sur Valider les modifications:

![c635e79ca83fc5914d68fd7818eb8116](https://github.com/user-attachments/assets/70840850-7955-47a4-a590-cd4d6cdb7e3f)

Immédiatement, vous verrez que nous devons faire une demande de fusion pour notre changement. Ajoutez une description et créez la demande de fusion. Le processus de pensée de Ash derrière cela était qu'il protégerait la branche principale, car la société a une politique selon laquelle les demandes de fusion doivent être approuvées par un gestionnaire. Puisque nous sommes maintenant obligés de faire une demande de fusion, la branche principale est protégée. Cependant, Ash a commis les deux erreurs suivantes dans son processus de pensée sécuritaire:

-   Les politiques qui ne sont pas appliquées par une technologie ne seront pas respectées par les attaquants. Bien sûr, la stratégie indique qu'un gestionnaire doit approuver la demande de fusion, mais si vous lisez la demande de fusion, vous verrez que d'un point de vue technique, Gitlab indique que l'approbation est facultative.
-   Bien que la branche principale soit protégée en n'autorisant aucune poussée directe, puisque les développeurs peuvent toujours faire des demandes de fusion, ils peuvent simplement pousser leur propre demande de fusion pour valider le code vers la branche principale. Le principe des deux personnes n'a pas été mis en œuvre pour s'assurer qu'une autre personne doit accepter la demande de fusion.

En exploitant ces erreurs, en tant qu'attaquant, vous pouvez simplement approuver votre propre demande de fusion (bien que ce ne soit même pas nécessaire) et vous pouvez ensuite la fusionner avec la branche principale, comme indiqué ci-dessous!

![35a2237a1b9a00e9323cc57fb43e78b3](https://github.com/user-attachments/assets/77597b8d-d46e-4806-b5d1-774738734ac4)

En examinant le code dans la branche principale, vous avez apporté une modification à la branche principale! Maintenant vient la partie amusante. Le runner GitLab a été configuré pour fonctionner uniquement sur la branche principale. Puisque nous pouvons maintenant pousser le code vers la branche principale, nous pouvons compromettre le coureur. Maintenant que vous savez comment obtenir votre code à la branche principale, apportez quelques modifications au fichier .gitlab-ci.yml pour obtenir l'exécution du code sur le coureur. Vous pouvez utiliser n'importe laquelle des techniques qui vous ont été enseignées jusqu'à présent!

Protéger le pipeline

Protéger votre GitLab CI/CD pipeline est essentiel pour assurer la sécurité de votre code et infrastructure. Voici les mesures que vous pouvez prendre pour protéger votre pipeline avec des portes d'accès et empêcher l'exécution de code non autorisé comme l'exemple ci-dessus:

**Limiter l'accès Branch**

Limitez qui peut pousser à la branche principale. Seuls les développeurs de confiance devraient avoir la possibilité de pousser du code vers cette branche. Vous pouvez le faire en configurant des règles de protection de branche dans vos paramètres de référentiel GitLab. Accédez à Paramètres > Repository > Branche par défaut. Configurez les règles pour exiger des avis avant d'autoriser les modifications.

<img width="1077" alt="3a14d7b5725b25ea005dabfa126cd276" src="https://github.com/user-attachments/assets/3ad50bdc-49be-4247-9151-3cf4af6b6ec8">

**Examiner les Demandes de Fusion**

Appliquer les demandes de fusion (ou pull requests) pour effectuer des modifications de branche principale. Les demandes de fusion permettent d'examiner et d'approuver les modifications de code avant la fusion. Vous pouvez configurer une approbation de demande de fusion pour vous assurer que plusieurs membres de l'équipe examinent et approuvent les modifications.

**Utiliser CI/CD Variables**

Évitez de stocker des informations sensibles directement dans votre fichier .gitlab-ci.yml. Utilisez plutôt GitLab CI/CD variables pour stocker des secrets comme API clés, mots de passe et jetons. Ces variables peuvent être protégées et limitées à des branches et des balises spécifiques.

**Accès Limit Runner**

Ne permettez qu'aux coureurs de confiance d'exécuter CI/CD emplois. En spécifiant des balises, vous pouvez enregistrer les coureurs avec des balises spécifiques, puis restreindre les coureurs qui peuvent être utilisés pour les travaux dans votre fichier .gitlab-ci.yml. Seuls les coureurs avec les balises appropriées peuvent exécuter des tâches sur la branche principale.

**Contrôle d'Accès et Autorisations**

Examiner et configurer les contrôles et autorisations d'accès au niveau du projet et du groupe. Il est toujours bon d'examiner et de vous assurer que vous avez le moins de privilèges en vérifiant les paramètres du projet et en modifiant le CI/CD configuration si nécessaire.

**Des Audits Réguliers**

Effectuer des audits de sécurité réguliers de votre configuration GitLab et CI/CD pipeline. Examiner qui a accès et autorisations et s'assurer que les meilleures pratiques sont suivies.

**Surveiller et Alerter**

Configurez la surveillance et les alertes pour votre pipeline. Mettre en œuvre des solutions de surveillance de la sécurité pour détecter les activités inhabituelles ou non autorisées dans votre environnement GitLab et CI/CD pipeline.
