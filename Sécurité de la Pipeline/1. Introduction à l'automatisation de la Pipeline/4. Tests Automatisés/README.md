![d532d7168eaa7553b54464a6736f42fd](https://github.com/user-attachments/assets/a67f2a0c-2a5e-4df8-a2d8-2be62a804d16)

Examinons de plus près les tests automatisés. Autrefois, les tests étaient un processus assez fastidieux et manuel. Un testeur devrait exécuter manuellement et documenter chaque cas de test et espérer que la couverture était suffisante pour s'assurer que l'application ou le service fonctionne et restera stable. Cependant, dans les pipelines modernes, les tests automatisés peuvent en faire une partie importante.

## Tests d'Unités

Quand on parle de tests automatisés dans un pipeline, ce sera le premier type de tests que la plupart des développeurs et des ingénieurs logiciels connaissent. Un test unitaire est un cas de test pour une petite partie de l'application ou du service. L'idée est de tester l'application dans des pièces plus petites pour s'assurer que toutes les fonctionnalités fonctionnent comme il se doit.

Dans les pipelines modernes, les tests unitaires peuvent être utilisés comme portes de qualité. Les cas de test peuvent être intégrés dans l'Intégration Continue et le Déploiement Continu (CI/CD) une partie du pipeline, où la construction sera arrêtée de progresser si ces cas de test échouent. Cependant, les tests unitaires sont généralement axés sur la fonctionnalité et non la sécurité.

## Test d'Intégration

Une autre méthode de test courante est le test d'intégration. Lorsque les tests unitaires se concentrent sur de petites parties de l'application, les tests d'intégration se concentrent sur la façon dont ces petites parties fonctionnent ensemble. Semblable aux tests unitaires, des tests seront effectués pour chacune des intégrations et peuvent également être intégrés dans le CI/CD une partie du pipeline. Un sous-ensemble de tests d'intégration est le test de régression, qui vise à s'assurer que les nouvelles fonctionnalités n'ont pas d'impact négatif sur les fonctionnalités existantes. Cependant, comme pour les tests unitaires, les tests d'intégration, y compris les tests de régression, ne sont généralement pas effectués à des fins de sécurité.

## Test de Sécurité

Donc, si les deux premiers types de tests automatisés ne sont pas destinés aux tests de sécurité, lesquels le sont? Il existe deux principaux types de tests de sécurité automatisés.

## SAST

Static Application Security Testing (SAST) fonctionne en examinant le code source de l'application ou du service pour identifier les sources de vulnérabilités. Les outils SAST peuvent être utilisés pour analyser le code source des vulnérabilités. Cela peut être intégré dans le processus de développement pour déjà mettre en évidence les problèmes potentiels pour les développeurs pendant qu'ils écrivent du code. Nous pouvons également intégrer cela dans le CI/CD processus. Pas comme des portes de qualité, mais comme des portes de sécurité, empêchant le pipeline de continuer si le SAST l'outil détecte toujours les vulnérabilités qui n'ont pas été signalées comme faux positifs.

## DAST

Test de Sécurité Dynamique des Applications (DAST) est similaire à SAST mais effectue des tests dynamiques en exécutant le code. Cela permet DAST outils pour détecter des vulnérabilités supplémentaires qui ne seraient pas possibles avec juste un examen du code source. Une méthode qui DAST les outils utilisés pour trouver des vulnérabilités supplémentaires, telles que Cross Site Scripting (XSS), consistent à créer des sources et des puits. Quand a DAST tool provides input to a field in the application, it marks it as a source. When data is returned by the application, it looks for this specific parameter again and, if it finds it, will mark it as a sink. It can then send potentially malicious data to the source and, depending on what is displayed at the sink, determine if there is a vulnerability such as XSS. Similar to SAST, DAST tools can be integrated into the CI/CD pipeline as security gates.

## Penetration Testing

Malheureusement, SAST et DAST les outils ne peuvent pas remplacer complètement les tests manuels, tels que les tests de pénétration. Il y a eu des progrès significatifs dans les tests automatisés et même dans certains cas, ces techniques ont été combinées avec des approches plus modernes pour créer de nouvelles techniques de test telles que Interactive Application Security Testing (IAST) et Runtime Application Self-Protection (RASP). Cependant, le principal problème reste que ces outils, y compris ces techniques de test modernes, ne fonctionnent pas bien contre les vulnérabilités contextuelles. Prenez le flux de processus d'un paiement, par exemple. Une vulnérabilité commune est quand une partie du processus peut être contournée, par exemple, l'étape de validation de carte de crédit. C'est un cas de test facile à effectuer manuellement, mais comme il nécessite un contexte, même DASTl'outillage aura du mal à découvrir le contournement. De même, la logique métier et les défauts de contrôle d'accès sont difficiles à découvrir à l'aide d'outils automatisés, alors que les tests manuels peuvent les découvrir assez rapidement. Ce n'est pas que l'outillage automatisé ne sera jamais en mesure de trouver ces défauts, il est tout simplement plus rentable d'utiliser des tests manuels.

## Outils Communs

Il existe plusieurs outils communs qui peuvent être utilisés pour les tests automatisés. Les deux [GitHub](https://github.com/features/security/code) et [Gitlab](https://docs.gitlab.com/ee/user/application_security/sast/) avoir l'outillage intégré de SAST. Outils tels que [Snyk](https://snyk.io/) et [Sonarqube](https://www.sonarqube.org/) sont également populaires pour SAST et DAST.

Case Study: She cannae take any more captain, She's gonna blow!\
A common issue with SAST and DAST tooling is that the tool is simply deployed into the pipeline, even simply for a Proof-of-Concept (PoC). However, you need to take several things into consideration:

-   Performance cost
-   Integration points
-   Calibration of results
-   Quality and security gate implementation

Le premier et le dernier point est très important et peut être coûteux s'il est ignoré. L'initiale PoC de l'outil devrait probablement se produire après des heures car il devra parcourir tout le code. Ce processus peut avoir un impact significatif sur les performances de votre outil de contrôle de code source. Imaginez que cela se produise juste avant une grande sortie, et les développeurs ne peuvent pas mettre en scène et pousser leurs derniers commits.

En outre, à mesure que de plus en plus d'organisations adoptent une approche plus agile du développement logiciel, la plupart des repos reçoivent plusieurs centaines de commits par jour. Si vous introduisez une nouvelle barrière de sécurité, même juste pour un PoC, qui analyse chaque demande de fusion pour les vulnérabilités avant l'approbation, cela peut avoir un coût de performance drastique sur votre infrastructure et la vitesse à laquelle les développeurs peuvent effectuer des demandes de fusion.

Lors de l'introduction de nouveaux outils de test automatisés, il convient d'examiner attentivement PoC doit être effectué pour s'assurer qu'aucune perturbation n'est causée, mais aussi pour s'assurer que le PoC est représentatif de la façon dont l'outillage va interagir quand il est finalement intégré. Un bel équilibre à essayer de réaliser!
