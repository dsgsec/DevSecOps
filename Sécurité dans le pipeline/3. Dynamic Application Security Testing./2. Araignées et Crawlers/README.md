Araignée une application avec ZAP

La première étape que nous allons prendre est d'obtenir une carte de toutes les ressources dans notre application Web cible pour identifier la portée de notre analyse. ZAP fournit un module d'araignée que nous pouvons utiliser à cette fin. A **Araignée** naviguera vers une page de départ que vous fournissez et explorera fondamentalement le site Web en suivant tous les liens qu'il peut détecter.

![9a6c2409ddb76cc7d67e97dc4ab9e118](https://github.com/user-attachments/assets/758dfa32-36da-4ffe-869f-95abd1413791)

Pour créer un site Web, nous pouvons aller à **Outils -> Spider**. Cela nous montrera le dialogue Spider, où il suffit de spécifier un site Web comme point de départ. Pour l'instant, nous laisserons les zones Context et User vides. Vous pouvez vérifier les options supplémentaires suivantes si nécessaire:

-   **Recours:** Araignée le site Web pour les liens récursivement.
-   **Spider Subtree Seulement:** Limitez le spidering aux sous-dossiers de l'URL du Point de départ.
-   **Afficher Options Avancées:** Activez l'onglet Avancé, où vous pouvez spécifier des paramètres supplémentaires pour régler votre spidering.

![1cc8aecf25ac7dd193f23eda02aaf643](https://github.com/user-attachments/assets/e7c9b329-8471-4c45-ab48-7af76f900c7f)

Pointez vers [http://MACHINE_IP:8082/](http://machine_ip:8082/) et appuyez sur Start Scan. Après un certain temps, vous devriez voir toutes les URL que l'araignée a trouvées sur l'onglet Sites:

![70b413458e34d59dfab7730076a6d299](https://github.com/user-attachments/assets/8da717e7-a6f2-4f1f-91aa-48b5146162ca)

Vous devriez maintenant voir la liste Sites remplie de toutes les URL trouvées pendant l'araignée. Tout élément en dehors de l'URL de votre page de départ est considéré comme hors de portée et ne sera pas ajouté à la liste.

Vous remarquerez peut-être que si vous naviguez manuellement [http://MACHINE_IP:8082/](http://machine_ip:8082/), vous devriez voir un lien dans le menu qui pointe vers `/nospiders-gallery.php`, mais si vous développez la liste des sites sur ZAP, vous ne verrez pas cette URL.

![d3cc974c61c619d9d1c8ad3a105693e9](https://github.com/user-attachments/assets/480b7be9-42d4-4576-84f3-c7488b17e8d9)

Cela se produit parce que ce lien particulier n'est pas directement intégré dans le code HTML de la page, mais est généré à la volée en utilisant javascript sur votre navigateur (comme le font de nombreuses applications modernes). Puisque l'araignée régulière dans ZAP n'a pas de moteur javascript, elle n'a aucun moyen de trouver ce lien.

Plus d'araignées

Pour surmonter les limites de l'araignée régulière de ZAP, ZAP peut tirer parti d'un vrai navigateur comme Firefox ou Chrome pour traiter tous les scripts attachés au site Web et récupérer le code HTML résultant. Au lieu d'analyser les liens directement à partir de HTTP réponses, il le fera à partir du résultat d'un navigateur traitant le site. Cela peut être réalisé en utilisant le **AJAX araignée**.

![5dd02378d74d65fd218806179a7bee7c](https://github.com/user-attachments/assets/75b4c024-d26d-4eff-bd28-b9c9a676be66)

Tirer parti d'un vrai navigateur est très avantageux, car ZAP n'a pas à gérer toutes les subtilités des moteurs javascript actuels, mais délègue plutôt cette tâche à un navigateur, garantir que le résultat correspond à ce qu'un utilisateur verra s'il utilise le même navigateur.

L'utilisation de l'araignée AJAX est un processus similaire à l'araignée régulière. Allez juste à **Outils -> AJAX Spider**, configurez une URL comme point de départ et vérifiez les options qui vous conviennent. La seule nouvelle option que vous avez est la sélection du navigateur, où nous allons choisir Firefox cette fois. La liste des navigateurs a également des options sans tête, qui exécuteront le navigateur sélectionné sans vous montrer son interface graphique, mais pour l'instant, nous allons nous en tenir à Firefox régulier, comme il est plus facile de comprendre comment fonctionne l'araignée AJAX. Votre configuration devrait ressembler à ceci:

![279812c28d032528c9e21a242556a55d](https://github.com/user-attachments/assets/ab5dd071-2a8e-427b-a7e6-7c045069fac5)

Appuyons Start Scan pour le faire fonctionner. Vous devriez voir Firefox apparaître et naviguer sur le site Web pendant un moment. Lorsque l'araignée AJAX est terminée, elle va peupler les Sites dans ZAP, tout comme l'araignée régulière. Puisque l'araignée AJAX exploite la puissance de Firefox pour obtenir de meilleurs résultats, vous devriez maintenant voir `/nospiders-gallery.php` dans votre liste de sites dans ZAP.
