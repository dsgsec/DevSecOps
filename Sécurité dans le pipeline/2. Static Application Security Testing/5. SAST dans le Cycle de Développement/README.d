SAST est l'un des premiers outils à apparaître pendant le cycle de développement. Il est souvent mis en œuvre pendant la phase de codage, car il n'est pas nécessaire d'avoir une application fonctionnelle pour l'utiliser.


Selon chaque cas, SAST peut être mis en œuvre de l'une des manières suivantes:

-   **CI/CD intégration:** Chaque fois qu'une pull request ou une fusion est faite, SAST les outils vérifieront le code pour les vulnérabilités. La vérification des demandes d'extraction garantit que le code qui permet de fusionner a subi au moins une vérification de sécurité de base. À certaines occasions, au lieu de vérifier chaque demande de pull unique, exécuter SAST les analyses uniquement lors des fusions peuvent aider à prévenir les ralentissements dans le pipeline de développement, car elles évitent de faire attendre tous les développeurs SAST scans.
-   **IDE intégration:** Les outils SAST peuvent être intégrés dans les IDE préférés des développeurs au lieu d'attendre qu'une pull request ou une fusion se produise. De cette façon, le code peut être corrigé le plus tôt possible, ce qui permet de gagner du temps dans le projet.

Notez que vous voudrez peut-être que SAST s'exécute sur les IDE des développeurs et CI/CD pipeline, qui serait valide. Par exemple, les outils IDE peuvent exécuter des vérifications structurelles de base et appliquer des directives de codage sécurisé, tout en CI/CD les intégrations peuvent exécuter des analyses de flux de données/taignets plus longues. Rappelez-vous que votre configuration spécifique dépendra des exigences de chaque projet et devrait être évaluée par l'équipe avec soin.

Si vous voulez savoir comment les outils de sécurité peuvent être intégrés dans un pipeline CI/CD, vérifiez [DAST chambre ](https://tryhackme.com/room/dastzap)pour un exemple d'intégration d'un outil DAST dans un pipeline Jenkins. Le processus avec les outils SAST est assez similaire, donc nous ne le répéterons pas ici.

Intégration SAST dans les IDE

Votre machine virtuelle a l'éditeur de code VS installé et déjà configuré pour utiliser quelques SAST outils:

-   **Psaume:** L'outil que nous avons utilisé prend en charge l'intégration IDE en installant le plugin Psalm dans VS Code directement à partir du [Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=getpsalm.psalm-vscode-plugin). Ce plugin vérifiera tout ce que vous tapez en temps réel et vous montrera les mêmes alertes que la version console directement dans votre code. L'analyse des taches ne sera pas disponible, vous ne verrez donc que les problèmes structurels rapportés sur une analyse de base du Psaume.

-   **Semgrep:** Encore un autre outil SAST qui peut être installé dans VS Code directement à partir du [Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=Semgrep.semgrep). Tout comme avec Psalm, il affichera des alertes en ligne directement dans votre code. Semgrep nous permet même de créer des règles personnalisées si nécessaire. Vous pouvez vérifier les règles qui sont chargées pour ce projet sur `semgrep-rules` répertoire dans le répertoire du projet. Les détails sur la façon de construire des règles Semgrep seront laissés pour une future pièce, alors ne vous inquiétez pas à leur sujet maintenant. Vous pouvez vérifier les règles dans le répertoire, mais cela ne sera pas nécessaire pour cette pièce.

Les deux outils fonctionneront de la même manière en affichant tous les problèmes détectés directement en ligne dans votre code. La seule différence notable est que Semgrep fonctionnera lorsque vous démarrez VS Code et vous montrera les problèmes qu'il détecte sur tous les fichiers, alors que Psalm ne vous montrera que les problèmes liés au fichier que vous modifiez actuellement. Les plugins ajouteront les informations suivantes à votre écran IDE:

![SAST dans VS Code](https://tryhackme-images.s3.amazonaws.com/user-uploads/5ed5961c6276df568891c3ea/room-content/0409daf7cdf144dfaa3e9f1e4ab2fcb9.png)

Pour chaque ligne où des problèmes sont détectés, vous pouvez obtenir des informations supplémentaires en passant le pointeur de la souris dessus. Voici ce que vous obtiendrez en survolant la ligne 46 de `login.php`:

![Problèmes d'intégration dans VS Code](https://tryhackme-images.s3.amazonaws.com/user-uploads/5ed5961c6276df568891c3ea/room-content/9b3cd323e1ef63bac1c9dab83171827f.png)

Vous pouvez également consulter la liste complète des problèmes en cliquant sur l'indicateur Erreurs en bas de l'écran de VS Code:

![Problèmes Panel](https://tryhackme-images.s3.amazonaws.com/user-uploads/5ed5961c6276df568891c3ea/room-content/a879e9d06f657dbfd45dcc874dc3c91f.png)

Avoir votre IDE vérifier les problèmes vous permet de produire du code plus propre en tant que développeur, contribuant de manière significative à la sécurité globale de votre application finale.

En utilisant les deux outils dans votre IDE, répondez aux questions à la fin de la tâche.
