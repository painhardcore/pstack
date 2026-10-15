---
name: unslop-fr
description: Cut AI tells from French text and apply French (France) typography. Use whenever you write, rewrite, translate into, or review prose in French, including marketing copy, emails, letters, cover letters, docs, social posts, and commit messages, even when the user only asks for "a French version" or a translation. Complements unslop. Pour tout texte en français de France.
---

# Unslop FR

Rends un texte français précis et humain. Ce skill complète `unslop`, dont les principes valent aussi en français, avec ce qui est propre au français de France.

## Pourquoi un texte sent l'IA

Un modèle choisit la suite la plus probable. Il écrit donc la phrase moyenne : générale, équilibrée, polie, qui irait dans n'importe quel texte. Les tics sont les symptômes de trois causes. Corrige la cause, pas le mot : remplacer « crucial » par « essentiel » garde le même tic.

1. **Pas de référent.** La phrase ne dit ni qui, ni quoi, ni quand, ni combien. Mets le fait, ou coupe. S'il manque, demande-le ou laisse `[à préciser : …]`. N'invente jamais un chiffre, une source ou une citation.
2. **Symétrie.** Contrastes en série, triplets, trois parties de même longueur, conclusion qui répète l'introduction. Casse le moule et garde le nombre réel d'éléments.
3. **Anglais traduit.** Calques, typographie anglaise, formules d'e-mail traduites. Écris ce qu'un francophone dirait.

Un mot de la liste ne condamne pas un texte : c'est la densité qui trahit. Le français n'est pas de l'anglais raccourci. Garde la phrase longue qui se tient et les connecteurs qui relient vraiment. Le staccato de réseau social (« Résultat : », une phrase par ligne) est lui aussi un tic.

## Ce qu'il faut couper

| Tic | Exemples | À la place |
|---|---|---|
| Ouverture de décor | Dans un monde en constante évolution, À l'ère du numérique, À l'heure où | un fait daté |
| Cheville | Il est important de noter que, Il convient de souligner, Force est de constater | rien |
| Méta-discours | Dans cet article, nous allons explorer, Plongeons dans, Décryptons | le contenu |
| Emphase | joue un rôle clé, témoigne de, s'inscrit dans une dynamique, pierre angulaire, au cœur de | ce qui s'est passé |
| Verbe d'apparat | permet de, s'avère, constitue, se positionne comme, afin de | est, a, le verbe direct, pour |
| Participe de remorque | …, permettant ainsi de ; …, garantissant ; ce qui témoigne de | une phrase avec un vrai sujet, ou rien |
| Adjectif valise | crucial, incontournable, véritable, robuste, innovant, fluide | rien, ou un fait |
| Jargon de consultant | levier, écosystème, enjeux, accompagner, déployer, solution, au sein de, au niveau de | le mot dit à voix haute |
| Faux contraste | Ce n'est pas X, c'est Y ; Plus qu'un X ; non seulement… mais aussi ; Au-delà de | affirme Y |
| Question de théâtre | Le résultat ? La clé ? Pourquoi est-ce important ? | la réponse |
| Connecteur vide | Par ailleurs, En outre, De plus, Ainsi, en tête de chaque paragraphe | garde ceux qui portent une cause, une opposition, une conséquence |
| Conclusion-résumé | En conclusion, En somme, Au final, L'avenir nous le dira | le dernier point utile |
| Publicité | Découvrez, Sublimez, Libérez le potentiel, Que vous soyez A ou B, niché au cœur de, allie X et Y, expérience unique | le prix, la distance, l'horaire, le verbe de l'action |
| Voix de marque | Nous sommes ravis, notre équipe passionnée, votre partenaire de confiance | ce que l'entreprise fait, pour qui |
| Faux savoir | Selon les experts, De nombreuses études montrent | la source, ou rien |
| Reste de chatbot | Bien sûr !, Excellente question !, N'hésitez pas à, Souhaitez-vous que je… | rien |
| Poncif littéraire | un instant suspendu, comme si le temps s'était figé, un silence vibrant | un détail observé |
| Mise en forme | émojis, gras partout, titres En Casse Anglaise, markdown dans un courriel | des phrases, casse de phrase |

## Calques de l'anglais

- adresser un problème : traiter. Impacter : affecter. Réaliser que : se rendre compte que. Opportunité : occasion. Supporter : soutenir, prendre en charge. Éventuellement (*eventually*) : finalement. Délivrer : livrer, fournir. Initier : lancer. À travers (*through*) : par, grâce à. Sur une base régulière : régulièrement. Faire du sens : avoir du sens.
- Pas de virgule avant le « et » final d'une énumération.
- Pas de passif en « est réalisé par ». Préfère « on », le pronominal ou l'actif.
- « Il haussa les épaules », pas « ses épaules ».

## Typographie

- Guillemets « » avec une espace insécable à l'intérieur. Jamais de guillemets droits.
- Espace insécable (U+00A0, ou fine U+202F) avant `:` `;` `!` `?`. Ni espace ordinaire, ni absence d'espace.
- Pas de tiret cadratin ni demi-cadratin pour une incise, sauf dans un dialogue de fiction. Virgule, deux-points ou point.
- `1 000`, `3,5`, `10 %`, `20 €`, `14 h 30`, `1er`, `1re`, `2e` (jamais « 2ème »).
- Titres en casse de phrase. Accents sur les capitales (À, É). Jours, mois et langues en minuscule. `M.` et `Mme`, jamais « Mr ».
- « cœur », « œuvre », jamais « coeur ». « etc. » sans points de suspension. `…` en un seul signe.
- Écriture inclusive : suis le texte d'origine, n'en ajoute pas et n'en retire pas.

Dans un message de commit ou du code, une espace ordinaire suffit. Le détail (nombres, dates, majuscules, apostrophes) est dans [typographie](references/typographie.md).

## Courrier

Le courrier français est formulaire. Garde la formule attendue, une fois, et coupe l'empilement.

- Ouvre sur l'objet (« Je vous écris au sujet de… »), pas sur « J'espère que vous allez bien » ni « Je me permets de revenir vers vous ».
- La formule finale reprend l'appel : « Madame la Directrice, » appelle « Je vous prie d'agréer, Madame la Directrice, l'expression de ma considération distinguée. »
- Une seule formule de politesse, pas « Restant à votre disposition… Dans l'attente de votre retour… Veuillez agréer… ».
- « Espérant une réponse rapide, je vous prie d'agréer… » : le sujet du participe est « je ». « Espérant…, veuillez agréer » est fautif.
- Dans un courriel, « Cordialement, » suffit.
- Une lettre de motivation contient un fait sur l'employeur et une réalisation chiffrée du candidat. Pas de « Fort de mon expérience », « passionné », « dynamique et motivé ».

## Exemple

Avant :

> Niché au cœur de la vallée, notre hôtel allie élégance et authenticité pour vous offrir une expérience unique. Que vous soyez en quête de détente ou d'aventure, notre équipe passionnée vous accompagne pour faire de votre séjour un moment magique.

Après (faits fournis par le client) :

> L'hôtel compte quatorze chambres, toutes tournées vers le lac. Le petit-déjeuner se prend sur la terrasse dès 7 h 30, et le sentier du tour du lac part à cent mètres de la porte.

## Avant de rendre

Relis à voix haute. Cherche ce qui sent encore la machine, et vérifie que tu n'as pas échangé un tic contre un autre.

Vérifie ensuite les espaces avant `:` `;` `!` `?` et à l'intérieur des guillemets. C'est la faute la plus fréquente, parce que l'espace insécable est invisible et qu'un modèle tape par réflexe une espace ordinaire. Si tu écris dans un fichier et que tu as un terminal, une recherche suffit : `grep -nP ' [:;!?»]|« ' fichier` ne doit rien renvoyer.

Rends le texte seul. N'ajoute un commentaire que pour signaler un fait manquant.
