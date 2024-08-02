Notre pipeline est sécurisé; nous y sommes presque! Deux pas de plus à faire! La prochaine étape de la liste est de s'assurer que nos environnements sont sécurisés. Le dernier point où un acteur de la menace peut tenter de compromettre notre build est le moment où nous déployons la build dans son environnement.

Environnement Ségrégation

Un principe de sécurité clé dans notre pipeline est de s'assurer que nos différents environnements sont séparés. Les environnements ne sont pas créés égaux, surtout en ces temps modernes où les principes Agiles sont utilisés. Les développeurs disposent souvent de nombreux accès et capacités dans des environnements autres que la production (PROD) et la pré-production (PREPROD). Si vous avez besoin d'un rappel sur les différents types d'environnements, jetez un oeil à [cette chambre](http://tryhackme.com/jr/introtopipelineautomation). Avec ces autorisations supplémentaires, nous devons nous assurer qu'il existe une ségrégation adéquate entre les différents environnements.

À première vue, vous pouvez penser qu'il s'agit d'une entreprise simple. Tout ce que nous devons faire est de nous assurer que les développeurs n'ont pas accès à ces environnements sensibles. Cependant, avec l'introduction de pipelines, cela devient un peu plus complexe. Même si nous limitons l'accès direct à ces environnements, il peut y avoir des canaux latéraux dans le pipeline qui peuvent être exploités. Dans cette tâche, nous examinerons une mauvaise configuration courante lorsque les agents de construction eux-mêmes ne sont pas séparés.

Un Agent de Construction pour Les Gouverner Tous

Dans notre prochain exemple, Ash a appris de ses erreurs et s'est assuré de ne donner à Ana qu'un accès à la branche développement (DEV). Main est maintenant entièrement restreint. Nous avons toujours accès à la branche DEV puisque Ash veut que ses développeurs adoptent un processus de développement Agile. Heureusement pour nous, la branche DEV a un coureur Gitlab attaché à elle. Accédez au nouveau dépôt à <http://gitlab.tryhackme.loc/ash/environments/> pour commencer. Accédez à la section Operate->Environment pour voir les deux environnements:

<img width="944" alt="181b067e9f88c1e4d0345ec6605e3d9d" src="https://github.com/user-attachments/assets/e1b4d01e-2df4-41c8-9863-9998d018a27e">

Regardons de plus près la dernière construction réalisée pour la production. Cliquez sur la version et sélectionnez l'onglet Pipeline pour voir la version qui a été exécutée pour la production:

![030f82f88a240d910122561278d1b65f](https://github.com/user-attachments/assets/77da8af3-04cf-44fc-b0a2-03c1cabe57b7)

Enquêter sur le pipeline et examiner l'un des travaux exécutés pour le pipeline principal. En cliquant sur une tâche qui a la balise principale, faites attention au coureur spécifié dans le coin supérieur droit:

![d0c3156bd636b42c42d02ae635a354c9](https://github.com/user-attachments/assets/2b1306dc-d434-4cf8-8c24-93baef594b2b)

Comme nous pouvons le voir, le coureur numéro 6 a été utilisé pour la construction. En suivant les étapes de la tâche précédente, dans la branche DEV, apportez une petite modification au fichier README et observez quel coureur est utilisé pour le travail.

Intéressant! Il semble que Ash essaie d'économiser un peu de budget en ayant un seul coureur pour le projet. Responsable des constructions DEV et PROD. Par conséquent, si nous compromettons le coureur grâce à notre accès DEV, nous pouvons intercepter une construction de production! Tirez parti de l'une des techniques précédentes pour compromettre l'agent de construction et lire des informations sensibles du coureur! Une fois que vous avez compromis le coureur, vous pouvez accéder à la fois DEV et PROD!

Protéger l'Environnement de Construction

La protection de votre environnement de construction est cruciale pour éviter de compromettre votre pipeline de production grâce à un seul canal partagé entre DEV et PROD. Voici quelques mesures que vous pouvez prendre pour améliorer la sécurité:

**Environnements Isolés**

Séparez vos pipelines DEV et PROD autant que possible. Utilisez des balises runner ou runner séparées pour les versions DEV et PROD. S'assurer que tout compromis dans l'environnement DEV n'a pas d'impact direct sur PROD. De cette façon, vous ne pouvez pas compromettre PROD comme indiqué dans cette tâche.

**Accès restreint pour CI/CD Emplois**

Limiter l'accès à l'hôte du coureur. Seul le personnel autorisé doit avoir accès à la machine(s) exécutant GitLab Runner. Mettre en œuvre des contrôles d'accès forts et surveiller les accès non autorisés. GitLab fournit une fonctionnalité "Environnements CI/CD protégés" qui vous permet de définir des contrôles d'accès pour les environnements, en limitant qui peut les déployer. Permission les fonctionnalités limitent et assignent qui peut modifier CI/CD configuration, y compris le fichier .gitlab-ci.yml.

**Surveillance et Alerte**

Implémentez la surveillance et les alertes pour votre pipeline et votre runner CI/CD. Configurez des alertes pour les activités suspectes ou les builds échoués, ce qui pourrait indiquer un compromis. Examiner et auditer périodiquement les autorisations d'accès, en particulier pour les environnements et CI/CD configuration. Révoquer l'accès pour les utilisateurs ou les rôles qui n'en ont plus besoin.
