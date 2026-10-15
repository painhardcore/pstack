# Typographie française

Dernière passe d'un texte, mécanique. Les règles décrivent l'usage de France. Là où le Québec diffère (OQLF), la colonne de droite le dit. Un texte belge ou suisse suit en général l'usage français pour les espaces.

Une règle domine toutes les autres : **une seule convention par texte**. Ne mélange pas guillemets français et droits, ni deux sortes de tirets pour la même fonction, ni apostrophe droite et courbe.

## Espaces insécables

Deux caractères à connaître :

| Caractère | Nom | Usage |
|---|---|---|
| U+00A0 | espace insécable | par défaut, partout, y compris HTML (`&nbsp;`) et courriel |
| U+202F | espace fine insécable | avant `;` `!` `?` quand le support et la police le gèrent (édition, web soigné) |

L'espace ordinaire ne convient pas aux endroits ci-dessous, parce qu'elle laisse le signe tomber seul au début de la ligne suivante. Dans un message de commit, un terminal ou du code, une espace ordinaire est tolérée.

## Ponctuation et symboles

| Signe | France | Québec (OQLF) |
|---|---|---|
| `:` | espace insécable avant, espace après. Pas d'espace dans une heure numérique (13:52) | idem |
| `;` `!` `?` | espace insécable avant (fine si possible), espace après | pas d'espace avant (recommandé). Une espace fine est acceptée |
| `.` `,` | pas d'espace avant, espace après | idem |
| `…` | un seul signe, pas d'espace avant, espace après | idem |
| `«` | espace avant, espace insécable après | idem |
| `»` | espace insécable avant, espace après | idem |
| `( )` `[ ]` | espace avant l'ouvrante, rien après. Rien avant la fermante, espace après | idem |
| `%` | espace insécable avant : `10 %` | idem |
| `€` `$` | après le nombre, espace insécable avant : `20 €`, `785,60 €`. Pas de « 785 € 60 » | idem, `10 $` |
| symboles d'unité | espace insécable avant : `5 kg`, `20 °C` | idem |
| `&`, `§` | espace avant, espace insécable après | idem |
| apostrophe | aucune espace de part et d'autre | idem |

Les guillemets internes à une citation sont les guillemets anglais : `« Il a dit “non” puis il est parti. »`. Ne mets pas d'espace insécable entre une apostrophe et un guillemet ouvrant.

## Guillemets et dialogue

- Citation : `« … »`. Jamais `"…"` ni `‘…’` dans un texte français.
- Dialogue de roman : un tiret cadratin ouvre chaque réplique, sans guillemets en plus. Beaucoup d'éditeurs emploient un demi-cadratin à la place. Choisis-en un et tiens-le.

## Tirets

Il existe quatre signes :

| Signe | Caractère | Emploi |
|---|---|---|
| trait d'union | `-` | mots composés (peut-être), inversions (a-t-il) |
| demi-cadratin | `–` (U+2013) | plages (1914–1918), liaisons (Paris–Lyon). Aussi incises et dialogues chez certains éditeurs |
| cadratin | `—` (U+2014) | dialogues. Incises, dans la tradition |
| signe moins | `−` (U+2212) | mathématiques |

L'incise entre tirets est correcte en français. Ce qui trahit un texte d'IA, c'est le nombre : un tiret d'incise par paragraphe, souvent collé à « et » ou à « c'est ». Dans un texte de non-fiction à nettoyer, remplace-les par une virgule, un deux-points ou une nouvelle phrase, et ne remplace pas la série par une série de parenthèses. En fiction, un tiret isolé et voulu peut rester. Dans tous les cas, n'emploie pas deux conventions différentes pour la même situation dans un même texte.

## Nombres, unités, dates, heures

| Sujet | Règle | Exemple |
|---|---|---|
| séparateur de milliers | espace insécable au-delà de trois chiffres | `12 345`, `1 000` |
| décimale | virgule | `3,5` |
| numéros (année, page, code postal, matricule) | pas de séparateur | `2026`, `75008` |
| milliard | en toutes lettres | « deux milliards d'euros » |
| ordinaux | `1er`, `1re`, `2e`, `3e`, `Ier`, `XXIe siècle` | jamais « 1ère », jamais « 2ème » |
| heures | `13 h 17`, `15 heures`, sans zéro devant les nombres inférieurs à dix | `2 h 5` |
| dates | jour en chiffres, mois en lettres et en minuscule | `le 5 mars 2026`, `le 1er mai` |
| jours et mois | minuscule | lundi, octobre |
| siècles | chiffres romains suivis de `e` | `le XXIe siècle` |
| pourcentage | espace insécable avant `%` | `50 %` |
| téléphone (France) | par paires | `01 23 45 67 89` |

Une date complète s'écrit sans majuscule (« le 14 juillet 1789 »). Le nom d'une fête en prend une (« le 14 Juillet », « le 1er Mai »).

## Majuscules

- **Accents sur les capitales.** Les majuscules s'écrivent avec leurs accents : À, É, È, Ç, Œ. Leur omission est une faute d'orthographe.
- **Titres de section** et intertitres : casse de phrase. Première lettre et noms propres seulement.
- **Titres d'œuvres** : en italique. Majuscule au premier mot et, si le titre commence par un article, au premier nom (*Le Rouge et le Noir*, *Les Misérables*). Pas de guillemets.
- **Jours, mois, langues, adjectifs de nationalité** : minuscule (« lundi », « le français », « la cuisine italienne »). Le nom de l'habitant prend une majuscule (« un Italien »).
- **Civilités** : `M.`, `Mme`, `MM.`, `Mmes`, devant un nom, pour parler d'un tiers. Jamais pour s'adresser à quelqu'un (« Monsieur » en toutes lettres). Jamais « Mr » ni « Mrs ».
- **Appel et salutation** : Madame, Monsieur, Madame la Directrice en toutes lettres, avec une majuscule, sans abréviation.

## Ligatures

`œ` et `æ` sont des lettres du français : cœur, sœur, œuvre, œuf, bœuf, nœud, vœu, chœur, œil, manœuvre. Écrire « coeur » est une faute. Quelques mots n'en prennent pas, parce que « o » et « e » n'y forment pas un seul son : coexister, coefficient, moelle, poêle.

## Énumérations et abréviations

- **Pas de virgule avant le « et » final** : « Paris, Lyon et Marseille ».
- **Points-virgules** quand un élément contient lui-même des virgules.
- **etc.** : après au moins deux éléments, précédé d'une virgule, jamais suivi de points de suspension ni utilisé après « comme » ou « tels que ».
- **Abréviations** à éviter dans le corps du texte : c.-à-d., par ex., env. Écris « c'est-à-dire », « par exemple », « environ ».
- **Listes à puces** : choisis un système et garde-le. Soit des fragments en minuscule avec point-virgule et point final, soit des phrases complètes avec majuscule et point.
- **Numéro** : `n° 5` ou `no 5`. Choisis-en un.

## Apostrophe

L'apostrophe typographique `’` est la forme soignée en édition. L'apostrophe droite `'` convient au texte brut, au code, au courriel et aux messages de commit. Ne mélange jamais les deux dans un même texte. Les sorties de ChatGPT et de DeepSeek emploient souvent `’`, parfois de façon incohérente.

## Italique, gras

- Italique : titres d'œuvres, mots étrangers non intégrés, mot cité en tant que mot.
- Gras : rare, pour la première mention d'un terme défini ou pour une consigne essentielle. Pas sur chaque nom propre.

## Écriture inclusive

Contestée en France (l'Académie française a mis en garde en 2017 contre une écriture jugée illisible) et usuelle dans d'autres contextes. Un skill de style ne tranche pas. Si le texte d'origine, le projet ou l'utilisateur emploie le point médian, les doublets ou le féminin des titres, garde la convention. S'ils ne l'emploient pas, n'en introduis pas. Ne mélange pas.

## Variantes du français

| Domaine | France | Québec | Belgique, Suisse |
|---|---|---|---|
| e-mail | courriel ou mail | courriel | courriel, mail |
| fin de semaine | week-end | fin de semaine | week-end |
| 70, 90 | soixante-dix, quatre-vingt-dix | idem | septante, nonante (huitante dans certains cantons suisses) |
| repas du soir | dîner | souper | souper |
| titres | « Madame la Ministre » | « Madame la Ministre » | « Madame la Ministre » |

Ne remplace jamais un mot de l'une de ces variétés par celui de l'autre. Une étude canadienne rapportée par la RTBF note que les modèles généralistes transfèrent mal leurs acquis au français québécois : relis les mots régionaux avec soin au lieu de les normaliser.
