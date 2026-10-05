---
name: gauntlet-loop
description: Fait tourner un objectif contre une référence réelle jusqu'à ce qu'il gagne — builders en parallèle, critique séparé au contexte frais, comparaison A/B à l'aveugle, boucle sans nombre de tours. Deux modes - exécuter (défaut) ou rendre le prompt seul. Déclencheurs - /gauntlet-loop, « gauntlet », « fais tourner ça jusqu'à ce que ce soit au niveau de X », « fan out des sous-agents avec un critique dur », « boucle jusqu'à ce que ça batte X ».
---

# Gauntlet loop

Un agent qui juge son propre travail vérifie seulement que le code fait ce qui a
été tapé. On le remplace par un critique payé pour ne pas être d'accord, et par
une chose réelle à côté de laquelle poser le résultat.

Technique de Matt Shumer, écrite en construisant Claude of Duty.

## Modes

- **exécuter** (défaut) — tu montes la boucle et tu la fais tourner.
- **prompt seul** — uniquement si l'utilisateur le demande (« rends juste le
  prompt », « donne-moi le prompt ») : tu rends le bloc de la section
  *Prompt à coller* et tu t'arrêtes. Rien après.

## 1. La barre

L'objectif est ce qu'on construit. La barre est la chose qui existe déjà et à
côté de laquelle on pose la nôtre. Elles se confondent parfois (« un FPS au
niveau de Call of Duty »), souvent non (« une page de tarifs »).

Trois tests, avant d'écrire quoi que ce soit :

- **nommée** — la page de tarifs de Stripe, pas « les meilleurs SaaS » ;
- **récupérable** — le critique peut la screenshoter, la lire, l'exécuter,
  l'ouvrir. S'il ne peut pas l'obtenir, il invente la comparaison et approuve
  tout. C'est l'échec numéro un, de loin ;
- **comparable** — les deux tiennent côte à côte et un juge peut en choisir une.

Si l'utilisateur a donné une référence, prends-la. Sinon propose-en **2 ou 3**,
une ligne chacune, et **arrête-toi**. Attends son choix. Prends la plus dure
qu'un agent puisse réellement atteindre : une barre trop basse est franchie au
premier tour et la boucle s'arrête là.

Barres qui marchent : le site en ligne d'un produit nommé, des captures d'un
jeu sorti, un article publié signé, un dépôt nommé avec sa suite de bench, un
rapport d'analyste, un livrable réel d'un cabinet connu.

**Pas de barre réelle atteignable ?** Ne laisse pas le critique en inventer une.
Bascule sur les critères observables du brief et dis-le en une ligne.

## 2. Le budget

Le fan-out multiplie la dépense. Avant de lancer quoi que ce soit, une question
(AskUserQuestion) : quelle part de la fenêtre de 5 h ce run peut consommer —
**50 %** (défaut), **75 %**, **95 %**. Si l'utilisateur l'a déjà dit, ne
redemande pas. Dimensionne le nombre d'agents et de tours là-dessus.

Modèle cher là où le jugement décide — critique, arbitrage. Modèle moins cher
sur les builders. Un agent sur un modèle plus fort que sa tâche est du gaspillage
à qualité constante.

Budget épuisé et la barre pas encore battue : tu t'arrêtes, tu dis ce que la
dépense a acheté, tu proposes le cran suivant. Jamais de montée sans accord.

## 3. Le découpage

Les plus petits morceaux qui peuvent être améliorés et jugés séparément.
Chaque builder reçoit un objectif, le contexte minimum, et **des fichiers à lui
seul**. Deux builders sur le même fichier coûtent plus en conflits que le
parallélisme ne rapporte. Ce qui est couplé reste séquentiel.

## 4. Les preuves, dans cet ordre

Le jugement du modèle passe en dernier, pas en premier :

1. déterministe — build, tests, types, lint, schémas ;
2. exécution — lance-le, rends-le, ouvre-le dans un navigateur ;
3. comparaison à la référence ;
4. jugement, pour ce que seul un œil voit.

Si l'objectif a une moitié chiffrable — temps de chargement, score de bench,
nombre de mots, taux de tests verts — nomme-la à côté de la référence. Le goût
plus un nombre : le nombre ne dérive pas d'un tour à l'autre.

## 5. La boucle

Pour chaque morceau : un builder, puis un critique **séparé, contexte frais**,
qui ne sait pas combien le builder a peiné.

Le critique ouvre la sortie réelle, la pose à côté de la barre **étiquettes
retirées**, dit **laquelle gagne** — A ou B, jamais une note sur 10, les notes
montent à chaque tour — et nomme **le seul plus gros écart restant**. Puis ça
repart au builder.

Critiques partagés par angle (mise en page, couleur, mouvement, rigueur…), pas
un critique par builder : ça double la facture sans bouger la qualité. Ajoute
un critique sans angle imposé.

Sortie : le critique choisit le nôtre à l'aveugle, ou l'utilisateur arrête.
**Jamais un nombre de tours.**

Le travail reste ouvrable pendant tout le run — serveur de dev debout, build
lançable, et une page de progression qui se met à jour. Un fan-out est opaque
par construction ; c'est ce qui permet à l'utilisateur d'arrêter tôt.

## Prompt à coller

Adapte les mots à chaque fois, garde la langue de l'objectif, garde la dernière
ligne. 120 à 180 mots. S'il lui faut un titre pour rester lisible, il est trop
long. Pas de liste à puces dedans.

```
Construis [OBJECTIF].

La barre est [BARRE]. Récupère la vraie chose d'abord et compare-toi
directement à elle, pas à une description d'elle. [MOITIÉ CHIFFRÉE, si elle
existe.]

Découpe en les plus petits morceaux qui peuvent être améliorés et jugés
séparément. Sur chaque morceau, lance un builder et un critique séparé au
contexte frais. Le critique inspecte la sortie réelle, la pose à côté de la
barre étiquettes retirées, dit laquelle est la meilleure, et nomme le seul
plus gros écart restant. Puis ça repart au builder.

Le critique doit être un critique dur. Les compliments ne servent à rien. Si
la nôtre ne gagne pas, il continue.

/loop sur chaque morceau jusqu'à ce que le critique choisisse la nôtre à
l'aveugle. Ne t'arrête pas avant.

Tiens une page de progression à jour pendant le travail, que je puisse
regarder.

Fan out subagents and ultracode.
```

Ce qu'on met dedans : la barre comme chose concrète et récupérable (URL, nom de
produit, dépôt, titre). Un plafond de coût **seulement** si l'utilisateur en a
nommé un. Des noms d'outils seulement si l'objectif les exige (génération
d'images, navigateur, cible de déploiement).

Ce qu'on laisse dehors : l'archi, le découpage en fichiers, le nombre de tours,
la stack. Chaque instruction en plus est une décision en moins prise par l'agent
au moment où il a l'information.

## Ce qui casse la boucle

- **Une barre vague** — le critique invente la comparaison et approuve tout.
- **Le builder qui juge son propre travail** — contexte frais, obligatoire.
- **Un critique mou** — dis « dur » et donne-lui un choix binaire.
- **Une note sur 10** — elle monte à chaque tour.
- **Un nombre de tours** — la sortie est la victoire, ou l'utilisateur.
- **Le superlatif** (« parfait », « AAA », « époustouflant») — la barre fait déjà
  ce travail, l'adjectif n'ajoute que du bruit.
- **Sur-spécifier** — le minimum gagne.

## Portabilité

`/loop` et `ultracode` sont des fonctions de Claude Code. Ailleurs, remplace les
deux dernières lignes par : « Continue à boucler jusqu'à ce que le critique
choisisse la nôtre. Lance les builders et les critiques comme sous-agents
parallèles. » La structure ne bouge pas.
