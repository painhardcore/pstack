# Sources et limites

Recherche faite le 2026-10-15. Ce fichier dit ce que chaque partie du skill appuie, et ce qui n'a pas pu être vérifié.

## Sources de référence

| Source | Appuie | Limites |
|---|---|---|
| [OQLF, espacement avant et après les signes de ponctuation et les symboles](https://vitrinelinguistique.oqlf.gouv.qc.ca/22039/la-typographie/espacement/espacement-avant-et-apres-les-signes-de-ponctuation-et-les-symboles) | espaces autour de `: ; ! ? « » %`, usage québécois | décrit l'usage québécois, qui diffère de l'usage français sur `; ! ?` |
| [OQLF, formules de salutation dans la lettre](https://vitrinelinguistique.oqlf.gouv.qc.ca/22101/la-redaction-et-la-communication/redaction-administrative-et-commerciale/correspondance/lettre/formules-de-salutation-dans-la-lettre) | reprise de l'appel, échelle de déférence, participe au sujet identique | norme québécoise. « l'expression de mes salutations » reste courant en France |
| [OQLF, formules d'appel dans la lettre](https://vitrinelinguistique.oqlf.gouv.qc.ca/22099/la-redaction-et-la-communication/redaction-administrative-et-commerciale/correspondance/lettre/formules-dappel-dans-la-lettre) | majuscule et non-abréviation des civilités | idem |
| [Wikipédia, Conventions typographiques](https://fr.wikipedia.org/wiki/Wikip%C3%A9dia:Conventions_typographiques) | nombres, ordinaux, heures, « etc. », énumérations, majuscules accentuées, civilités | source secondaire. La page s'appuie sur l'Imprimerie nationale sans la citer au mot près |
| [Wikipédia, Tiret](https://fr.wikipedia.org/wiki/Tiret) | cadratin et demi-cadratin pour les incises et les dialogues, absence d'unanimité | source secondaire |
| [Wikipedia, Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing) | structure du catalogue (emphase, copules, faux contraste, formatage, artefacts) | en anglais. Les patterns sont transposés en français et complétés |
| [Geng et Trotta, Human-LLM Coevolution](https://arxiv.org/abs/2502.09606) | les mots de ChatGPT reculent une fois publicisés, d'autres progressent | résumés d'articles scientifiques, en anglais |
| [RTBF, dé-IA-iser nos écrits](https://www.rtbf.be/article/comment-de-ia-iser-nos-ecrits-pour-eviter-la-disparition-des-particularites-des-langues-11756072) | causes (prédiction, RLHF, corpus), uniformisation, manque de transfert vers le français québécois | article de vulgarisation |

## Listes de tics en français

Ces pages sont des guides de rédaction et des blogs, pas des études de corpus. Elles s'accordent sur le noyau (ouvertures de décor, chevilles, connecteurs, faux contraste, conclusions-résumé, tiret, typographie anglaise) et ce noyau fonde le catalogue. Les mots individuels viennent de leur recoupement.

- [Détecter-IA, reconnaître un texte IA](https://www.detecter-ia.fr/reconnaitre-un-texte-ia.php) : ouvertures, chevilles, connecteurs, métaphores de mouvement, contrastes équilibrés, structure symétrique, artefacts de copier-coller.
- [Loumina, les tics de ChatGPT](https://www.loumina.fr/blog-reconnaitre-un-texte-d-ia-les-tics-de-chatgpt) : poncifs littéraires (instant suspendu, promesse, vibrant, « comme si »), hyper-lissage émotionnel.
- [IA Signal, mots de ChatGPT en français](https://www.iasignal.com/blog/mots-chatgpt-trop-utilises) : verbes et adjectifs valises, connecteurs paresseux, clôtures corporate.
- [Prompt Inspiration, indices typographiques](https://prompt-inspiration.com/blog/chatgpt/comment-reconnaitre-un-texte-ecrit-par-chatgpt) : guillemets, tiret, espaces, ligatures, majuscules accentuées.
- [IA Espresso, 7 tournures](https://iaespresso.substack.com/p/7-tournures-qui-prouvent-que-ton) : contraste, ouverture, cheville, vocabulaire formel, règle de trois, conclusion-résumé, personnages inventés.
- [Slate, lettre de motivation avec ChatGPT](https://www.slate.fr/story/266396/ecrire-lettre-motivation-avec-chatgpt-intelligence-artificielle-bonne-mauvaise-idee-candidature-offre-emploi-recrutement-travail) : les recruteurs relèvent le contenu générique, répétitif et verbeux.

## Ce qui n'a pas été trouvé ou vérifié

- **Aucune étude de corpus en français** qui mesure la fréquence des mots d'IA. La recherche a trouvé des travaux anglais (stylométrie, mots en excès) et une étude de stylométrie sur des textes littéraires français (LaTeCH-CLfL 2026) dont le PDF n'a pas pu être lu. Les listes de ce skill reposent donc sur l'observation de praticiens, recoupée entre sources, et sur la connaissance de la langue.
- **Le Lexique des règles typographiques en usage à l'Imprimerie nationale** n'a pas été consulté directement. Les règles viennent de sources secondaires et de l'OQLF. Les spécifications d'espace (insécable, fine) varient selon les sources. Le skill recommande l'espace insécable U+00A0 comme défaut sûr.
- **Les chiffres de recruteurs** (pourcentages de candidatures rédigées par IA, de lettres écartées) circulent dans la presse et les blogs. Ils n'ont pas pu être rattachés à une étude, donc le skill ne les reprend pas.
- **Les calques et faux amis** de [lexique](lexique.md) viennent de la connaissance de la langue et des listes d'anglicismes de l'enseignement. Leur lien avec les sorties de modèles n'a pas été mesuré.

## Hypothèses

- L'abondance de connecteurs (« Par ailleurs », « En outre ») dans les textes d'IA en français s'explique peut-être aussi par la place des connecteurs dans l'écriture scolaire française (dissertation, plan en parties). Cette explication n'a pas de source. Elle justifie seulement de ne pas supprimer les connecteurs d'office.
- Les listes de tics vieillissent. Le skill privilégie les causes (généralité, symétrie, absence de référent, calque) aux mots.
