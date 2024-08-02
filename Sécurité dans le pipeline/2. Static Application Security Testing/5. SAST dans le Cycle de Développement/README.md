SAST est l'un des premiers outils à apparaître pendant le cycle de développement. Il est souvent mis en œuvre pendant la phase de codage, car il n'est pas nécessaire d'avoir une application fonctionnelle pour l'utiliser.

![8d4c2f1e6b6b61d8e13d8e0c4597773e](https://github.com/user-attachments/assets/70f751bb-1059-43a8-a552-4e146711bad4)

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

![0409daf7cdf144dfaa3e9f1e4ab2fcb9](https://github.com/user-attachments/assets/e59dc0ad-f4ed-476c-8b19-fd5a24198eaa)

Pour chaque ligne où des problèmes sont détectés, vous pouvez obtenir des informations supplémentaires en passant le pointeur de la souris dessus. Voici ce que vous obtiendrez en survolant la ligne 46 de `login.php`:

![9b3cd323e1ef63bac1c9dab83171827f](https://github.com/user-attachments/assets/840ceeb2-0ca1-40f0-8eb2-25f6f1fb1901)

Vous pouvez également consulter la liste complète des problèmes en cliquant sur l'indicateur Erreurs en bas de l'écran de VS Code:

![a879e9d06f657dbfd45dcc874dc3c91f](https://github.com/user-attachments/assets/9b312430-c863-40f9-9226-2a265281929c)

Avoir votre IDE vérifier les problèmes vous permet de produire du code plus propre en tant que développeur, contribuant de manière significative à la sécurité globale de votre application finale.

En utilisant les deux outils dans votre IDE, répondez aux questions à la fin de la tâche.
