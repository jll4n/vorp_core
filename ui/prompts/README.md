# 📋 Prompt System

Système de prompt interactif qui affiche un bouton personnalisable à l'écran. L'utilisateur doit maintenir une touche du clavier enfoncée pour valider le prompt.

## 📦 Vue d'ensemble

Un système léger et performant pour créer des interactions contextuelles dans votre jeu. Idéal pour les actions qui nécessitent une confirmation utilisateur.

### ✨ Caractéristiques

- ✅ Bouton interactive personnalisable
- ✅ Validation par touche clavier
- ✅ Interface responsive
- ✅ Pas de blocage du thread principal
- ✅ Simple à intégrer

---

## 🚀 Installation

Assurez-vous que les fichiers suivants sont présents dans le dossier `ui/prompts/` :

ui/prompts/
├── pindex.html # Interface HTML
├── pstyles.css # Styles CSS
├── cprompt.lua # Logique client Lua
├── papp.js # Script JavaScript
└── README.md # Cette documentation

---

## 📖 Utilisation

### Méthode 1 : Appel direct (recommandé) invalide pour export

```lua
local prompt = openPrompt(holdMode, control, text)

Citizen.CreateThread(function()
    while not prompt.validate do
        Wait(10)
    end
    
    print("Prompt validé!")
end)

### Méthode 2 : Via Event (pour export)

TriggerEvent("vorp:client:openPrompt", holdMode, control, text)

Paramètre |	Type	| Description	           | Exemple
holdMode  |	boolean	| Mode maintien (réservé)  | 	false
control	  | string	| Touche clavier           |	"G", "E", "F"
text	  | string	| Texte au survol          |	"Appuyez pour interagir"

💡 Exemple complet

Citizen.CreateThread(function()
    -- Afficher le prompt
    local prompt = openPrompt(false, "G", "Appuyez sur G pour interagir")
    
    -- Attendre la validation
    while not prompt.validate do
        Wait(10)
    end
    
    -- Action après validation
    print("L'utilisateur a pressé G!")
    TriggerEvent("vorp:promptConfirmed")
end)

Ou avec la fonction

local prompt = openPrompt(false, "G", "Press G")

-- Vérifier dans une condition ou une boucle
if prompt.validate then 
    print("Prompt validé!")
end

Fonctionnement

Client Lua (cprompt.lua)

La fonction openPrompt() crée une table promptData avec validate = false
Elle envoie un message NUI au HTML avec les paramètres
Quand l'utilisateur relâche la touche, le callback closePrompt passe validate à true

Frontend (pindex.html + pstyles.css)

Le bouton s'affiche en bas centre de l'écran
Au survol ou lors de la pression de la touche définie, il s'agrandit et affiche le texte
Envoi du callback au Lua quand la touche est relâchée

Personnalisation

Changer la couleur du bouton
Dans pstyles.css, modifiez :

.button:hover {
  background-color: rgb(253, 193, 27); /* Jaune */
}

Changer la position
Dans pstyles.css :

.button {
  bottom: 20px;    /* Distance du bas */
  left: 50%;       /* Centré horizontalement */
}

Changer la taille du bouton

.button {
  width: 50px;
  height: 50px;
}

.button:hover {
  width: 140px;
}

Notes

La première utilisation du prompt prend légèrement plus de temps (chargement du NUI)
Utilisez Citizen.CreateThread() pour ne pas bloquer le thread principal
Un seul prompt peut être actif à la fois pour chaque client (enregistrement global currentPrompt)


