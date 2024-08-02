L'Échelle des Dépendances

Bien que vous puissiez penser que vous écrivez une quantité incroyable de code lorsque vous développez une application, il pâlit par rapport à la quantité de code qui effectue réellement des actions pour vous dans les différentes dépendances que vous incluez. Jetons un coup d'œil à un exemple Python simple.

exemple.py

```
#!/usr/bin/python3
#Import the OS dependency
import numpy

x = numpy.array([1,2,3,4,5])
y = numpy.array([6])
print(x * y)
```

Dans cet exemple, nous utilisons la bibliothèque NumPy pour créer deux tableaux, puis les multiplier les uns avec les autres. Nous avons effectivement écrit environ quatre lignes de code. Mais juste cette première ligne, `import numpy`, exécute un `__init__.py` fichier en arrière-plan qui contient 400 lignes de code avec 30 importations supplémentaires. Avec une estimation prudente de 250 lignes de code par importation, cela signifie que notre seule ligne de code a exécuté environ 8000 lignes de code de dépendance!

Si nous extrapolons ces données, vous n'êtes probablement responsable que de 0,01% de tout le code de votre application, et les dépendances constituent les 99,99% restants du code! C'est pourquoi la gestion des dépendances est vitale pour la sécurité de tout cycle de vie de développement de pipeline ou de logiciel (SDLC) processus.

Gestion des Dépendances

La gestion des dépendances est le processus de gestion de vos dépendances à travers SDLC processus et DevOps pipeline. Nous effectuons la gestion des dépendances pour plusieurs raisons:

-   Savoir quelles dépendances notre application utilise peut nous permettre de mieux la supporter.
-   Nous voulons souvent verrouiller les dépendances de version pour améliorer la stabilité de notre application, car les versions plus récentes peuvent ajouter de nouvelles fonctionnalités ou déprécier les fonctionnalités que notre application utilise activement.
-   Nous pouvons construire des images dorées qui ont déjà toutes nos dépendances installées, ce qui signifie que nous pouvons effectuer des cycles de déploiement plus rapides.
-   Lorsque de nouveaux développeurs sont intégrés, nous pouvons les aider à configurer leur machine de développement en installant toutes les dépendances requises.
-   Nous pouvons surveiller les dépendances que nous utilisons pour les problèmes de sécurité afin de nous assurer que les dépendances sont mises à niveau avec les correctifs de sécurité nécessaires.

La plupart des grandes organisations utilisent des outils de gestion des dépendances, tels que [JFrog Artefactory](https://jfrog.com/artifactory/). Cela permet à l'organisation de gérer toutes ses dépendances à partir d'un emplacement central et permet à la gestion des dépendances d'être intégrée dans notre DevOps pipeline. Les serveurs et agents de build peuvent envoyer des requêtes au gestionnaire de dépendances pour qu'il leur fournisse des dépendances lors de la construction ou du déploiement de l'application.
