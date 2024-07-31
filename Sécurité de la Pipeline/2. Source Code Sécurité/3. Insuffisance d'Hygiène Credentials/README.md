# Introduction:

Maintenir une bonne hygiène des titres de compétences CI/CD les environnements sont essentiels pour se protéger contre les risques de sécurité potentiels. Divers systèmes et individus au sein de l'écosystème de l'ingénierie utilisent des informations d'identification, telles que des secrets et des jetons, pour déployer et accéder à des ressources et à d'autres actions hautement privilégiées. Cependant, la gestion sécurisée des informations d'identification peut être difficile en raison des différents contextes dans lesquels elles sont utilisées et stockées. Problèmes tels que le stockage non sécurisé des informations d'identification dans les référentiels de code, une utilisation incorrecte dans les processus de construction et de déploiement, laissant les informations d'identification dans les couches d'image de conteneur, impression des informations d'identification, et négliger de faire pivoter les informations d'identification peut entraîner des failles de sécurité.

## Impact des Risques:

Les attaquants recherchent fortement les informations d'identification pour accéder à des ressources précieuses et activer les activités malveillantes. Les environnements d'ingénierie offrent de multiples possibilités aux attaquants d'obtenir des informations d'identification. Les erreurs humaines et les lacunes en matière de connaissances dans la gestion des titres de compétences peuvent accroître le risque d'exposition aux titres de compétences et de compromission des ressources critiques.

## Recommandations:

1.  Assurez-vous que les informations d'identification suivent le principe du moindre privilège du code au déploiement.
2.  Évitez de partager les mêmes informations d'identification dans plusieurs contextes pour maintenir la responsabilité et simplifier la gestion des privilèges.
3.  Utilisez des informations d'identification temporaires dans la mesure du possible et établissez des procédures pour faire pivoter les informations d'identification statiques et détecter périodiquement les informations d'identification obsolètes.
4.  Assurez-vous que les informations d'identification ne sont utilisées que dans des conditions prédéfinies, telles que la limitation de l'utilisation à une adresse IP ou à une identité spécifique.

5.  Détectez les secrets transférés et stockés dans des référentiels de code à l'aide des plugins Integrated Development Environments (IDE), de l'analyse automatique et des analyses périodiques des commits des référentiels.
6.  Utilisez des options de fournisseur intégrées ou des outils tiers pour empêcher l'impression de secrets sur les sorties de la console pendant les builds et vous assurer que les sorties existantes ne contiennent pas de secrets.
7.  Vérifiez que les secrets sont supprimés des artefacts, tels que les calques d'image de conteneur et les binaires.

Les organisations devraient envisager de mettre en œuvre les meilleures pratiques ci-dessus pour atténuer les risques d'une hygiène insuffisante des titres de compétences.

## Variables et Meilleures Pratiques:

L'utilisation de variables d'environnement est une excellente méthode pour promouvoir l'hygiène des diplômes. Dans le cadre des processus de développement et de déploiement de logiciels, les variables d'environnement sont couramment utilisées pour stocker et gérer les informations de configuration. Ils stockent des informations sensibles, telles que API clés, mots de passe et autres informations d'identification. Vous pouvez gérer les variables d'environnement en toute sécurité en suivant ces bonnes pratiques:

1.  Évitez de coder en dur des informations sensibles dans le code; utilisez plutôt des variables d'environnement.
2.  Examiner et faire pivoter régulièrement les informations d'identification stockées dans les variables d'environnement.
3.  Limiter l'accès aux variables d'environnement au personnel autorisé uniquement.

4.  Les variables d'environnement doivent être définies selon le principe du moindre privilège.
5.  Mettre en œuvre des mécanismes de surveillance et d'audit pour suivre les modifications des variables d'environnement.
6.  Si vous implémentez une solution de gestion des secrets (expliquée dans la tâche suivante), passez en revue ses mécanismes de cryptage et si elle convient bien à vos environnements de développement.

**Note:** Implémenter des variables d'environnement ne signifie pas que vous êtes libre de compromis. Il est essentiel de suivre les meilleures pratiques pour s'assurer qu'elles sont correctement mises en œuvre.
