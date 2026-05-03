# 🏦 Mini Core Banking System - COBOL Edition

Un système bancaire fonctionnel développé en COBOL, conçu pour explorer les concepts fondamentaux de l'informatique financière (Mainframe, traitement séquentiel, validation stricte). Ce projet a été réalisé dans le cadre d'une exploration technique à l'école 42.

## 💡 Pourquoi COBOL ?
Alors que la majorité des nouvelles architectures se tournent vers le Web3 ou l'IA, COBOL reste le pilier invisible de l'économie mondiale : on estime que **80 % des transactions financières quotidiennes** mondiales passent par un système COBOL. Ce projet vise à démystifier ce langage de niche, réputé pour sa robustesse, sa gestion positionnelle stricte et sa capacité à traiter des volumes massifs de données par lots.

## ⚙️ Architecture du Projet

Le système repose sur deux programmes distincts qui communiquent via des fichiers plats positionnels, simulant l'architecture standard d'un Mainframe :

1. **Le Transactionnel (`bank.cbl`)**
   - Simule un guichet bancaire (Online Transaction Processing).
   - Interaction utilisateur avec contrôles de saisie stricts (tests de classe `IS NUMERIC`, gestion des niveaux `88`).
   - Enregistrement des opérations (Dépôts/Retraits) à la volée dans `transactions.txt`.

2. **Le Traitement de Nuit (`batch.cbl`)**
   - Simule le Batch nocturne des institutions financières.
   - Charge le fichier maître (`master.txt`) dans un tableau en mémoire (`OCCURS`).
   - Lit le journal des transactions, vérifie la validité des opérations (ex: provision suffisante pour un retrait).
   - Sauvegarde les nouveaux soldes (Persistance) en réécrivant le fichier maître.

## 🚀 Comment l'utiliser

### Prérequis
- Un environnement Linux/macOS (ou WSL sous Windows)
- Le compilateur **GnuCOBOL** (`sudo apt install gnucobol` ou `brew install gnucobol`)
- `make`

### Installation et Exécution

1. Clonez le repository :
   ```bash
   git clone <ton-lien-github>
   cd <nom-du-dossier>
