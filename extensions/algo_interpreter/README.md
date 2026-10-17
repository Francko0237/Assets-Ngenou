# Extension : Interpréteur Algorithmique Ngenou

Ce dossier contient le **micro-logiciel / extension** de l'interpréteur d'algorithmes de Ngenou.

## ⚠️ Important
- Ce code est **séparé du dépôt principal** de l'application Ngenou.
- Il sera hébergé dans son **propre dépôt GitHub** et téléchargeable dynamiquement depuis l'application.
- Le dossier `extensions/` est listé dans le `.gitignore` du projet principal.

## Contenu
- `lexer.dart` : Analyse lexicale du pseudo-code
- `parser.dart` : Construction de l'AST (Arbre Syntaxique Abstrait)
- `interpreter.dart` : Exécution du code pseudo-algorithmique
- `debugger.dart` : Débogueur pas-à-pas
- `syntax_highlighter.dart` : Coloration syntaxique

## Utilisation future
Ce module sera distribué comme une **extension téléchargeable** depuis le catalogue d'extensions
de l'application Ngenou, uniquement pour les utilisateurs ayant besoin de l'outil (Informatique,
Algorithmique - Secondaire / Supérieur).
