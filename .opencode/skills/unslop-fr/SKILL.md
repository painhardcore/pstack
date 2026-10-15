---
name: unslop-fr
description: Cut AI tells and apply French typography to any prose written, rewritten, translated, or reviewed in French (copy, emails, letters, docs, posts, commit messages). Complements unslop with French patterns, English calques, and orthotypography. Pour tout texte en français, à appliquer avec unslop.
---

# Unslop FR

Retirer d'un texte français les tics de l'IA et lui rendre une voix. À appliquer à tout texte écrit, réécrit, traduit ou relu en français : courriel, lettre, publicité, article, documentation, message de commit, publication.

Ce skill complète `unslop`. Les principes de `unslop` valent aussi en français (emphase, fausses attributions, règle de trois, faux contraste, conclusions qui résument), mais ses listes de mots sont anglaises. Celles d'ici sont françaises, et ce skill se suffit à lui-même.

Le but n'est pas de passer un détecteur, qui se trompe souvent. Le but est un texte qu'un lecteur francophone croit, parce qu'il parle de quelque chose de précis, à quelqu'un de précis.

## Méthode

1. **Cadrer.** Fixer avant d'écrire la variété de français (France par défaut, Québec, Belgique ou Suisse si le texte ou l'utilisateur l'indique), le registre (soutenu, courant, familier), le vouvoiement ou le tutoiement, le support (texte brut ou édition) et l'écriture inclusive ou non. En cas de doute : France, vouvoiement, registre courant soutenu. Ne convertis jamais une variété en une autre.
2. **Chercher le référent.** Pour chaque phrase : de quoi, de qui, quand, combien ? Sans réponse, c'est du remplissage. Coupe-la ou remplace-la par le fait. Si le fait manque, demande-le ou laisse une marque `[à préciser : …]`. N'invente jamais un chiffre, une source, une citation ou un cas client.
3. **Réécrire depuis l'idée.** Ne remplace pas un mot par son voisin. « Crucial » devient « essentiel », puis « incontournable », et c'est toujours le même tic. Reformule la phrase autour de son vrai sujet. Garde le sens et le ton voulu.
4. **Donner une voix** (section suivante).
5. **Passer la typographie** (section dédiée). Passe mécanique, à faire en dernier.
6. **Auditer.** Relis à voix haute. Demande-toi : « Qu'est-ce qui sent encore la machine ? » Corrige. Vérifie que tu n'as pas échangé un tic contre un autre : le tiret contre « Ainsi, », la liste à puces contre « Voici trois raisons ».

## Quatre règles au-dessus du catalogue

- **Un tic est une densité, pas un mot.** « Crucial » seul peut être juste. « Crucial », « véritable » et « au cœur de » dans le même paragraphe, non. Un texte humain n'est pas coupable parce qu'il contient un mot de la liste.
- **Le rituel n'est pas un tic.** Le courrier français est formulaire, et omettre « Veuillez agréer » passe pour de la grossièreté. Garde la formule attendue, une seule fois. Coupe l'empilement. Voir [courrier](references/courrier.md).
- **Les listes vieillissent.** Une étude sur les résumés d'articles scientifiques a mesuré une baisse nette de « delve » et d'autres mots associés à ChatGPT dès qu'ils ont été rendus publics, pendant que d'autres mots progressaient. Quand un tic sort de la liste, sa cause reste : la généralité, la symétrie, l'absence de référent. Chasse la cause.
- **Le français n'est pas de l'anglais en plus court.** Il supporte la phrase longue qui se tient, les connecteurs qui servent, la subordonnée. Ne hache pas tout en phrases de quatre mots pour « faire humain ». Ce staccato est devenu un tic à lui seul.

## Donner une voix

Retirer les tics ne suffit pas. Un texte lisse, sans voix, se repère aussi vite.

- **Prends position.** Réagis aux faits au lieu de lister le pour et le contre. « Le résultat est correct mais fragile » vaut mieux que « des résultats prometteurs ».
- **Varie le rythme.** Une phrase courte. Puis une plus longue, qui prend son temps, porte sa subordonnée et sa relative, et retombe sur ses pieds. Le français a la période, sers-t'en.
- **Sois précis.** Un nom propre, un chiffre, un lieu, une date, un détail observé. Pas « une rue endormie » mais « la rue Mercière à six heures, quand les livreurs ouvrent les rideaux de fer ».
- **Prends le bon sujet.** « Je » quand une personne parle. « Nous » seulement quand un collectif agit. Le « nous » de marque qui ne désigne personne sonne creux.
- **Choisis un registre et tiens-le.** Ne colle pas une formule soutenue (« il convient de ») sur un fond familier. Le « ne » de la négation tombe à l'oral et dans le registre familier, pas dans une lettre.
- **Laisse un peu de désordre.** Une incise, une réserve, une phrase qui commence par « Mais ». Une prose sans aspérité est une prose de machine.
- **Garde l'ambivalence.** « Impressionnant, et un peu inquiétant » vaut mieux que « impressionnant ». L'IA lisse les sentiments.

## Catalogue des tics

Les listes complètes de mots, avec leur remplacement, sont dans [lexique](references/lexique.md). Lis-le quand tu réécris du texte promotionnel, administratif ou traduit.

### Fond

1. **Emphase sur l'importance.** « joue un rôle clé », « revêt une importance capitale », « témoigne de », « marque un tournant », « s'inscrit dans une dynamique de », « pierre angulaire », « au cœur de ». Dis ce qui s'est passé, avec la date et le chiffre.
2. **Prose de brochure.** « niché au cœur de », « écrin », « havre de paix », « joyau », « authentique », « incontournable », « d'exception », « expérience inoubliable », « symphonie de saveurs ». Décris de façon neutre et vérifiable : surface, prix, distance, horaires.
3. **Faux savoir.** « Selon les experts », « De nombreuses études montrent », « Les spécialistes s'accordent à dire », « Il est largement admis ». Nomme la source ou supprime. Une étude, une citation, un arrêt ou un chiffre inventés sont la pire version de ce tic.
4. **Personnages-types.** « Prenons l'exemple de Marie, cadre dynamique… ». Un vrai cas, ou rien.
5. **Équilibre par réflexe.** « Si X présente des avantages, il comporte aussi des défis », « Il convient toutefois de nuancer », « Tout dépend de votre situation », « Il n'existe pas de solution unique ». Tranche quand les faits tranchent. Sinon dis précisément de quoi cela dépend.
6. **Défis et perspectives.** « Malgré ces défis, X continue de prospérer », « L'avenir s'annonce prometteur ». Remplace par des faits ou coupe.
7. **Texte transposable.** Si la phrase pourrait figurer telle quelle dans le texte d'un concurrent, elle ne dit rien de celui-ci. Coupe-la.

### Langue

8. **Verbes d'apparat.** « permet de », « offre la possibilité de », « constitue », « représente », « se présente comme », « s'impose comme », « s'avère », « se révèle ». Écris « est », « a », ou le verbe de l'action. « Afin de » devient « pour ».
9. **Participes de remorque.** « …, permettant ainsi de », « …, soulignant l'importance de », « …, contribuant à », « …, garantissant », « ce qui témoigne de ». Coupe, ou fais une phrase avec un sujet réel. Un gérondif ne se rapporte qu'au sujet du verbe principal.
10. **Vocabulaire de consultant.** « tirer parti de », « mettre en exergue », « pallier », « implémenter », « problématique » pour « problème », « enjeux », « levier », « écosystème », « paysage », « feuille de route », « accompagner », « déployer », « valeur ajoutée », « démarche ». Dis le mot qu'on prononcerait à voix haute.
11. **Adjectifs valises.** « crucial », « essentiel », « majeur », « incontournable », « véritable », « riche », « précieux », « fascinant », « robuste », « innovant », « durable », « fluide », « performant ». Supprime, ou remplace par un fait.
12. **Connecteurs qui ne relient rien.** « Par ailleurs », « En outre », « De plus », « Ainsi », « Dès lors », « En effet » en tête de presque chaque paragraphe. Garde ceux qui portent une relation réelle (cause, opposition, conséquence). Test : remplace par « et » ou par rien. Si le sens ne bouge pas, supprime.
13. **Chevilles.** « Il est important de noter que », « Il convient de souligner que », « Force est de constater que », « Il va sans dire que », « Il ne fait aucun doute que », « Notons que », « Rappelons que ». Supprime.
14. **Intensifs et précautions.** « véritablement », « particulièrement », « profondément », « Il semblerait que », « on pourrait potentiellement penser que ». Un verbe plus fort, un chiffre, ou une seule réserve, la bonne.
15. **Synonymes en rotation.** « le logiciel », « l'outil », « la solution », « la plateforme » pour une seule chose. Un nom par chose, répété.
16. **Doublets et triplets.** « besoins et attentes », « clair, précis et concis », « simple, rapide, efficace ». Choisis le mot juste, ou le nombre réel d'éléments.
17. **Fausses fourchettes.** « de la startup à la multinationale », « du débutant à l'expert ». Cite les cas.

### Structure et rhétorique

18. **Faux contraste.** « Ce n'est pas X, c'est Y », « Plus qu'un X, c'est un Y », « Il ne s'agit pas de X mais de Y », « non seulement… mais aussi… », « Loin de X, … », « Au-delà de X, … ». Affirme Y. Le contraste reste légitime quand X est une croyance réelle du lecteur.
19. **Question-réponse de théâtre.** « Le résultat ? », « La clé ? », « Le secret ? », « Pourquoi est-ce important ? », « Et ce n'est pas tout. », « Spoiler : ». Donne la réponse. Une seule question rhétorique par texte, au plus.
20. **Anaphore, chiasme, aphorisme final.** « On n'attend pas d'être prêt pour commencer. On commence pour être prêt. », « Pas de jargon. Pas de blabla. Juste des résultats. » Coupe le dernier paragraphe qui répète le précédent.
21. **Méta-discours.** « Dans cet article, nous allons explorer… », « Plongeons dans… », « Décryptons », « Démystifions », « Tout ce que vous devez savoir ». Commence par le contenu. Annonce un plan seulement dans un long document où le lecteur navigue.
22. **Ouvertures de décor.** « Dans un monde où… », « À l'ère de… », « À l'heure où… », « Dans un paysage en constante évolution… », « De tout temps… ». La première phrase est un fait précis.
23. **Conclusions-résumé.** « En conclusion », « En résumé », « En somme », « En définitive », « Au final », « Pour conclure », « L'avenir nous le dira », « À vous de jouer ! ». Finis sur le dernier point utile.
24. **Architecture symétrique.** Introduction qui annonce, trois parties de même longueur, conclusion qui répète. Phrases de même longueur. Titres tous construits sur « X : Y ». Casse la symétrie.
25. **Hachage de réseau social.** Phrases de quatre mots, une par ligne, « Résultat : », « Voici pourquoi. ». Écris la phrase longue quand l'idée en a besoin.

### Publicité et voix de marque

26. **Impératifs et promesses génériques.** « Découvrez », « Plongez dans », « Laissez-vous séduire par », « Offrez-vous », « Sublimez », « Libérez le potentiel de », « Boostez », « Révolutionnez », « Réinventez ». Prends le verbe de la tâche réelle : réservez, essayez, comparez, installez. Pas de superlatif sans preuve.
27. **« Que vous soyez A ou B ».** Aussi « Qu'il s'agisse de A, de B ou de C ». Écris pour un lecteur précis.
28. **Voix corporate.** « Nous sommes ravis », « Notre équipe d'experts passionnés », « Votre satisfaction est notre priorité », « à votre écoute », « votre partenaire de confiance », « sur mesure », « clé en main », « allie X et Y », « parfait équilibre entre ». Dis ce que l'entreprise fait, pour qui, à quel prix, en combien de temps.

### Artefacts de conversation

29. **Restes de chatbot.** « Bien sûr ! », « Voici », « Excellente question ! », « Absolument ! », « Souhaitez-vous que je… ? », « N'hésitez pas à me dire si… ». Supprime. Remplis ou signale les marques laissées : `[Nom]`, `[insérer un exemple]`.
30. **Courtoisie creuse.** « J'espère que vous allez bien » (calque de *I hope this finds you well*), « Je me permets de revenir vers vous », trois formules de politesse empilées. Voir [courrier](references/courrier.md).
31. **Complaisance.** « C'est une excellente remarque », « Vous avez tout à fait raison ». Réponds au fond.
32. **Aveux de limite.** « Bien que les détails soient limités… », « À ma connaissance… ». Trouve la source ou retire.

### Calques de l'anglais

33. **Syntaxe d'anglais.** Virgule avant le « et » final d'une énumération (« A, B, et C »). Passif en « est réalisé par » (préfère « on », le pronominal ou l'actif). Possessif devant une partie du corps (« il haussa les épaules », pas « ses épaules »). « à travers » pour *through* (préfère « par », « grâce à », « dans »). « sur une base régulière » (« régulièrement »). « faire du sens » (« avoir du sens »).
34. **Faux amis et glissements.** « adresser un problème », « impacter », « supporter », « réaliser que », « éventuellement » pour *eventually*, « délivrer », « initier », « challenge », « implémenter ». Remplacements dans [lexique](references/lexique.md).

### Fiction et ton littéraire

35. **Poncifs.** « un instant suspendu », « une promesse murmurée », « comme si le temps s'était figé », « comme si le monde retenait son souffle », « un silence vibrant », « baigné de lumière », « le murmure du vent ». Remplace par un détail observé, propre à la scène. Surveille les mots qui reviennent à courte distance (promesse, suspendu, vibrant).

### Mise en forme

36. **Gras mécanique.** Évite le gras sur chaque nom propre. Une étiquette en gras suivie de deux-points qui répète la ligne (« **Performance :** la performance… ») devient une phrase. Une amorce en gras qui finit par un point, nomme l'élément et précède un détail neuf reste correcte.
37. **Émojis décoratifs** dans les titres ou les puces. Supprime.
38. **Titres en casse anglaise.** « Les Avantages Du Télétravail » devient « Les avantages du télétravail ». Seuls la première lettre et les noms propres prennent une majuscule.
39. **Markdown dans un canal en texte brut** (courriel, SMS, lettre) : `**`, `##`, tirets de liste. Écris en phrases.

## Typographie

Dernière passe, mécanique. Le détail, les variantes (Québec, Belgique, Suisse) et les caractères à employer sont dans [typographie](references/typographie.md).

- **Guillemets.** `« texte »` avec une espace insécable à l'intérieur. Guillemets internes `“ ”`. Jamais `"…"` dans un texte français. Dialogue : tiret cadratin en début de réplique, sans guillemets en plus.
- **Espaces avant `:` `;` `!` `?`.** En France, une espace insécable (U+00A0), ou fine insécable (U+202F) si le support le permet, jamais une espace ordinaire ni l'absence d'espace. Au Québec, l'OQLF recommande de ne pas mettre d'espace avant `;` `!` `?`, mais d'en mettre une avant `:`.
- **Tiret.** Hors dialogue et fiction, n'utilise ni le tiret cadratin ni le demi-cadratin pour détacher une incise. Virgule, deux-points ou nouvelle phrase. Les parenthèses restent pour une précision brève (une date, un sigle), pas pour remplacer le tiret en série.
- **Nombres.** `1 000` (espace insécable), `3,5` (virgule), `10 %`, `20 €`, `14 h 30`, `1er`, `1re`, `2e` (jamais « 2ème », jamais « 1ère »).
- **Énumérations.** Pas de virgule avant le « et » final. « etc. » sans points de suspension, après au moins deux éléments. Points de suspension : un seul signe `…`, sans espace avant.
- **Majuscules.** Accents obligatoires sur les capitales (À, É, Ç, Œ). Casse de phrase dans les titres. Jours, mois, langues et adjectifs de nationalité en minuscule. `M.` et `Mme`, jamais « Mr » ni « Mrs ».
- **Ligatures.** « cœur », « sœur », « œuvre », « bœuf », jamais « coeur ».
- **Apostrophe.** Droite (`'`) en texte brut, code et courriel, typographique (`’`) en édition. Ne mélange pas dans un même texte.
- **Italique** pour les titres d'œuvres. **Gras** avec parcimonie.
- **Écriture inclusive.** Ne l'introduis pas et ne la retire pas. Suis le texte d'origine et le projet.

Dans un message de commit, un terminal ou du code, une espace ordinaire est tolérée à la place de l'espace insécable.

## Registres et variantes

Les règles ci-dessus décrivent le français de France. Un texte québécois, belge ou suisse garde ses mots (« courriel » au Québec, « septante » et « nonante » en Belgique et en Suisse, « souper » pour le repas du soir) et ses usages typographiques. Ne les « corrige » pas vers l'Hexagone. Un français qui sonne comme une traduction de l'anglais est aussi un tic en France, au Québec, en Belgique et en Suisse.

## Courrier

Le courrier et le courriel suivent des conventions que l'IA empile au lieu de choisir. Quatre règles :

1. Ouvre sur l'objet de la lettre, pas sur « J'espère que vous allez bien ».
2. La formule finale reprend l'appel. Une lettre qui s'ouvre sur « Madame la Directrice, » se ferme sur « Je vous prie d'agréer, Madame la Directrice, … ».
3. Une seule formule de politesse, de niveau adapté au destinataire. Pas de « Restant à votre disposition », puis « Dans l'attente de votre retour », puis « Veuillez agréer ».
4. Une lettre de motivation contient un fait sur l'employeur et une preuve venant du candidat. Pas de « Fort de mon expérience » ni de « dynamique et motivé ».

Détails, tableau de déférence et lettre de motivation : [courrier](references/courrier.md).

## Exemples

Les faits des « après » sont inventés pour la démonstration. Dans un vrai texte, demande-les.

**Publicité.**

Avant :

> Niché au cœur de la vallée, notre hôtel allie élégance et authenticité pour vous offrir une expérience unique et inoubliable. Que vous soyez en quête de détente ou d'aventure, notre équipe passionnée vous accompagne pour faire de votre séjour un moment magique.

Après :

> L'hôtel compte quatorze chambres, toutes tournées vers le lac. Le petit-déjeuner se prend sur la terrasse dès 7 h 30, et le sentier du tour du lac part à cent mètres de la porte.

Ce qui a changé : le décor (« niché au cœur »), la fausse fourchette (« détente ou aventure »), le superlatif et la voix de marque ont disparu. Chaque phrase porte un fait qu'on peut vérifier.

**Courriel.**

Avant :

> Bonjour Madame, J'espère que vous allez bien. Je me permets de revenir vers vous suite à notre échange afin de faire un point sur l'avancement du dossier. N'hésitez pas à me contacter pour tout complément d'information. Dans l'attente de votre retour, je vous remercie par avance. Cordialement

Après :

> Bonjour Madame,
>
> Où en est le dossier Martin ? Le notaire attend votre signature avant le 28 octobre.
>
> Cordialement,

**Documentation.**

Avant :

> Dans un paysage numérique en constante évolution, la gestion des erreurs joue un rôle crucial dans la robustesse des applications, permettant ainsi d'offrir une expérience utilisateur fluide tout en garantissant la fiabilité du système.

Après :

> Quand une requête échoue, l'application doit le dire à l'utilisateur et ne pas planter. Ici, `fetchUser` renvoie une erreur typée que l'interface affiche dans un bandeau.

## Audit final

1. Chaque phrase a-t-elle un référent (qui, quoi, quand, combien) ?
2. Reste-t-il une ouverture de décor, une cheville, un faux contraste, une conclusion-résumé ?
3. Les connecteurs en tête de paragraphe relient-ils quelque chose ?
4. Un nom par chose, d'un bout à l'autre ?
5. Le registre, le vouvoiement ou le tutoiement et la variété de français tiennent-ils jusqu'à la fin ?
6. Une phrase sonne-t-elle comme une traduction de l'anglais ?
7. La typographie est-elle passée : guillemets, espaces insécables, nombres, majuscules, tiret ?
8. Un fait, une source ou une citation a-t-il été inventé en chemin ?

Rends le texte réécrit. Si l'utilisateur demande un audit sans réécriture, liste les tics trouvés par numéro, avec la phrase concernée. N'ajoute aucun commentaire sur ton propre travail, sauf pour signaler un fait manquant.
