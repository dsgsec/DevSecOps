Configuration d'une stratégie d'analyse dans ZAP

Lors de l'exécution d'outils DAST, il est crucial de personnaliser les types de tests qui seront exécutés par rapport à l'application. Plus vous adaptez votre profil de numérisation à votre application Web, moins le scanner passera de temps à envoyer des charges utiles qui ne sont pas pertinentes pour votre scénario spécifique. Étant donné que les outils DAST seront principalement utilisés dans une configuration de boîte blanche, tous les détails des technologies sous-jacentes utilisées pour prendre en charge votre application sont connus. Voici les détails de l'application que nous allons utiliser dans toute la salle:

-   **Système Opérationnel:** Linux
-   **Serveur Web:** Apache 2.4
-   **Langage de Programmation:** PHP (Aucun framework utilisé)
-   **Bases de données:** Aucun

Par exemple, notre application n'utilise pas de base de données. Si vous exécutez le profil d'analyse par défaut, le scanner essaiera des choses comme SQL des injections qui n'auraient aucun sens dans ce contexte. Cela rendrait vos analyses plus longues, ce qui pourrait convenir à de petites applications comme celle de cette pièce, mais l'augmentation de temps deviendra perceptible lors de la numérisation d'applications plus complexes.

Pour créer ou modifier des stratégies de numérisation dans ZAP, allez à **Analyse -> Scan Policy Manager**. Là, nous allons cliquer sur le bouton Ajouter pour en créer un nouveau:

![1ac88f365d495e2e16d2c08a3b72f1f8](https://github.com/user-attachments/assets/bd74938b-d720-4c80-96a1-1ba9bd482155)

À partir de là, vous pouvez contrôler les types de tests à exécuter dans le cadre de votre politique. Pour chaque catégorie, vous aurez deux paramètres à configurer:

-   **Seuil: **Ce paramètre contrôle la verbosité de chaque catégorie. Un seuil inférieur signifie ZAP est plus susceptible de signaler une vulnérabilité basée sur peu d'informations. Cela vous donnerait plus de résultats au risque d'avoir ZAP signaler les vulnérabilités qui peuvent ne pas être présentes (Faux positifs). Un seuil plus élevé indiquera ZAP ne communiquer que les résultats avec un degré élevé de certitude. Cela vous donnera moins de résultats, mais ceux-ci sont plus probablement confirmés. Le risque d'utiliser des seuils plus élevés est que ZAP peut ne pas signaler certaines vulnérabilités qui pourraient effectivement être présentes (Faux négatifs). Vous pouvez également définir le seuil sur OFF pour désactiver une catégorie.
-   **Force:** Ce paramètre contrôle le nombre de tests exécutés pour chaque catégorie. Des niveaux de résistance plus élevés sont susceptibles de signaler des résultats supplémentaires au détriment de l'augmentation significative des temps de numérisation.

Comme chaque application est différente, ces paramètres doivent être réglés en conséquence. Considérez cela comme un processus d'essai et d'erreur à améliorer au fil du temps.

Dans le cas de notre application, puisqu'il n'y a pas de base de données utilisée, ni aucune XML traitement fait, nous pouvons désactiver en toute sécurité tous les tests connexes, comme indiqué dans l'image suivante:

![66f829c81447674a82d4471f20ee5415](https://github.com/user-attachments/assets/af9b0493-bd08-416e-8c83-66b64488014d)

Assurez-vous également de désactiver les tests Cross Site Scripting (DOM Based) cette fois, car ils prennent beaucoup de ressources et sont susceptibles de ralentir vos analyses pour cette pièce: 

![3d6bb6853578feee1cf0244963e4a666](https://github.com/user-attachments/assets/899cb489-a64d-4cea-bcbb-2dfa9534f504)

Exécuter notre premier scan

Maintenant que nous avons une politique de numérisation personnalisée, exécutons une analyse de vulnérabilité en allant sur **Outils -> Active Scan** dans le menu. Ici, nous pouvons sélectionner un point de départ à partir des ressources précédemment brodées et de notre politique d'analyse nouvellement créée. Utilisons [http://MACHINE_IP:8082/](http://machine_ip:8082/) comme point de départ et cochez la case Recurse pour vous assurer que toutes les pages autres que le point de départ sont numérisées. Ignorons le reste des options pour l'instant et cliquons **Démarrer Scan**.

![9c098496f5c0fde49e12cd2cc8dd8665](https://github.com/user-attachments/assets/d18da886-ad97-4168-b2e0-08b42827a826)

Après un certain temps, nous devrions voir quelques résultats dans le **Alertes** section. Vous pouvez obtenir une description pour chacun des résultats qui devrait indiquer ce qui a été trouvé en termes généraux. Vous pouvez également vérifier la demande spécifique et la réponse correspondante qui ZAP utilisé pour détecter la vulnérabilité.

![1fccaddf7d53f1d4ff346ccb3a0c5dcb](https://github.com/user-attachments/assets/3204937b-9449-4964-812f-565cc826b10c)

Cela vous permet d'examiner les résultats pour vous assurer qu'ils sont tous corrects. Si vous pensez que l'un d'entre eux est un faux positif, vous pouvez le marquer comme tel en cliquant avec le bouton droit sur la conclusion et en sélectionnant Marquer comme Faux Positif.
