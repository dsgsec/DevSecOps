# Cycle de vie du Développement de Logiciels Sécurisés (SSDLC')

Pendant SDLC, les tests de sécurité ont été introduits très tard dans le cycle de vie.Les bugs, les failles et autres vulnérabilités ont été identifiés tardivement, ce qui les rend beaucoup plus coûteux et fastidieux à corriger. Dans la plupart des cas, les tests de sécurité n'ont pas été pris en compte pendant la phase de test, de sorte que les utilisateurs finaux ont signalé des bogues après le déploiement. Sécurisé SDLC les modèles visent à introduire la sécurité à chaque étape du processus SDLC.

### Pourquoi est-il Sécurisé SDLC important?

Une étude menée par l'institut Systems and Sciences d'IBM a révélé qu'il en coûte six fois plus cher de corriger un bogue trouvé lors de la mise en œuvre que celui identifié dès la phase de conception. Il a également indiqué qu'il en coûte 15 fois plus si des défauts sont identifiés pendant les tests et jusqu'à 100 fois plus coûteux s'ils sont identifiés pendant les phases de maintenance et d'exploitation. Voir la figure ci-dessous:

![1688d77f6f6401862a668820ab96061e](https://github.com/user-attachments/assets/062e5af6-e6ba-4171-9cff-c7316181ffe8)

Source: Le document de recherche sur le coût de l'identification des vulnérabilités peut être trouvé [ici](https://www.researchgate.net/profile/Maurice-Dawson/publication/255965523_Integrating_Software_Assurance_into_the_Software_Development_Life_Cycle_SDLC/links/02e7e52114e5e1ba71000000/Integrating-Software-Assurance-into-the-Software-Development-Life-Cycle-SDLC.pdf?origin=publication_detail).

Outre un développement plus rapide et une réduction des coûts, l'intégration de la sécurité dans le SDLC permet de détecter et de réduire les vulnérabilités rapidement, réduisant considérablement les risques commerciaux. Des exemples d'introduction de la sécurité à toutes les étapes sont l'analyse d'architecture pendant la conception, l'examen du code et les scanners pendant la phase de développement et les évaluations de sécurité (par exemple, tests d'intrusion) avant le déploiement. Par exemple, dans les modèles en cascade, ce type de test a été effectué à la fin du cycle de vie, juste avant la production; dans des processus plus agiles, nous pouvons mettre en œuvre une "sécurité par conception" approche. Si les pentests entraînent des erreurs comme un SQLinjection dans un scénario en cascade, atténuer les bugs impliquerait de faire un autre cycle pour corriger le bug. Cela nécessiterait une refonte, l'application des modifications et un nouveau test pour vérifier qu'il a été remédié. Dans une approche plus agile, les discussions sur l'opportunité d'éviter de telles failles, telles que la décision de paramétrer pendant la phase de planification, peuvent éviter d'avoir à annuler les modifications, et cela ne coûte qu'une discussion de planification.

﻿### Résumé

-   La sécurité est une préoccupation constante, améliorant constamment la qualité et la sécurité des logiciels.

-   Renforcer l'éducation et la sensibilisation en matière de sécurité: toutes les parties prenantes connaissent les recommandations et les exigences de sécurité de chaque phase.
-   Les défauts sont détectés tôt avant le déploiement, ce qui réduit le risque de piratage ou de perturbation.
-   Les coûts sont réduits et la vitesse augmente grâce à la détection précoce et à la résolution des vulnérabilités. Les risques commerciaux, les dommages à la réputation de la marque et les amendes pouvant entraîner une catastrophe économique pour une entreprise sont évités.
