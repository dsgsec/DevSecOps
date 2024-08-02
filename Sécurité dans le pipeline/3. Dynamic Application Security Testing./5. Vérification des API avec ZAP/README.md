De nos jours, les applications Web dépendent des API pour effectuer certaines ou toutes leurs tâches. Le processus DAST que nous avons montré jusqu'à présent implique de pouvoir spider une application Web traditionnelle, mais les API ne sont pas quelque chose qui peut être brodé facilement. Les points de terminaison d'une API n'exposent normalement pas d'informations sur d'autres points de terminaison, ce qui rend le processus de découverte plus difficile. De plus, même si nous obtenons le nom d'un point de terminaison, nous devons toujours savoir quels paramètres peuvent lui être transmis.

Au lieu d'utiliser des API, nous comptons sur l'équipe de développement pour nous donner une spécification précise des points de terminaison disponibles dans une API et de tous les paramètres que nous pouvons leur envoyer. De cette façon, nous n'avons pas besoin de passer du temps sur le processus de découverte, mais nous pouvons nous concentrer sur le test direct de sa sécurité.

API Descriptions

Plusieurs normes existent pour documenter les API, qui incluent généralement toutes les informations dont les développeurs auraient besoin pour créer des demandes appropriées et savoir à quoi s'attendre en tant que réponses pour chacun des points de terminaison disponibles. C'est aussi tout ce dont nous avons besoin pour commencer à tester les vulnérabilités de sécurité.

ZAP peut importer des API définies par **OpenAPI** (anciennement **Swag**), **SAVON** ou **GraphQL**. Selon le API vous testez, vous pourriez obtenir l'un de ces formats de l'équipe de développement.

Pour vous donner une meilleure idée de ce que ces fichiers contiennent, jetons un coup d'œil à celui publié sur [http://MACHINE_IP:8081/swagger.json](http://machine_ip:8081/swagger.json), qui suit la norme OpenAPI 2.0. Dans le fichier, vous trouverez une section appelée `paths`, où chaque point de terminaison unique de la API est répertorié. Pour chacun des points de terminaison, une liste complète des paramètres disponibles est présentée. Par exemple, vous avez ici la partie de la spécification sur la façon d'interagir avec `/asciiart/{art_id}`:

```
    "/asciiart/{art_id}": {
      "get": {
        "parameters": [
          {
            "description": "art id",
            "in": "path",
            "name": "art_id",
            "required": true,
            "type": "string"
          }
        ],
        "responses": {
          "default": {
            "description": "",
            "schema": {
              "$ref": "#/definitions/ASCIIArt"
            }
          }
        }
      }
    }
```

Le fichier indique que vous pouvez faire des appels à `/asciiart/{art_id}` utiliser la méthode GET en envoyant le `art_id` paramètre dans l'URL, qui est une chaîne. Vous pouvez trouver des définitions similaires pour d'autres chemins comme `/asciiart/generate` ou `/asciiart/add`.

Les fichiers de définition d'API doivent être traités par les machines, de sorte que leur format peut être difficile à lire. Pour faciliter leur compréhension, certaines API fourniront également une interface utilisateur plus conviviale que nous pouvons utiliser pour exécuter des tests rapides et explorer les points de terminaison disponibles. Vous pouvez aller à [http://MACHINE_IP:8081/swagger-ui/](http://machine_ip:8081/swagger-ui/) pour vérifier.

**Note:** Les applications de production peuvent se cacher API définitions pour empêcher les attaquants externes de savoir comment interagir avec eux. Rappelez-vous, vous pouvez toujours demander à l'équipe de développement pour eux si nécessaire (si elles existent).

Importation de définitions OpenAPI dans ZAP

ZAP prend en charge deux méthodes pour importer des définitions d'API: vous pouvez fournir un fichier hors ligne ou une URL à partir de laquelle les télécharger. Depuis que notre API expose son fichier de définition dans [http://MACHINE_IP:8081/swagger.json](http://machine_ip:8081/swagger.json), utilisons l'option URL. Aller à **Import -> Importer une définition OpenAPI à partir d'une URL**. Spécifiez l'URL correspondante et appuyez sur le **Importer** bouton.

![image](https://github.com/user-attachments/assets/785f560f-91f3-4c71-9d60-ab41f4178eb9)

Vous devriez maintenant voir tous les points de terminaison et paramètres disponibles chargés dans l'onglet Sites.

![image](https://github.com/user-attachments/assets/400e8eb5-c0c7-47fa-b692-dd0fd0ecf13b)

ZAP effectuera également automatiquement une analyse passive sur les points de terminaison et signalera certaines alertes. Après avoir importé le API définition, ZAP traitera le API comme toute autre page web normale.

Scanner le API

Une fois un API la définition est chargée dans ZAP, vous pouvez utiliser les outils disponibles comme avec n'importe quel autre site Web. Pour exécuter une analyse contre le API, cliquez avec le bouton droit sur son URL et sélectionnez **Attaque -> Active Scan**.

![image](https://github.com/user-attachments/assets/9a06f11a-320b-4a11-8ca3-be2e9ff67d77)

Après avoir exécuté l'analyse, ZAP aurait dû découvrir certaines vulnérabilités dans le API. Utilisez les résultats de l'analyse pour répondre aux questions à la fin de la tâche.
