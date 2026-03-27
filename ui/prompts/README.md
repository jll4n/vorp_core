# 📋 Prompt System

Système de prompt interactif qui affiche un bouton personnalisable à l'écran.
L'utilisateur doit maintenir une touche du clavier enfoncée pour valider le prompt.

---

## 📦 Vue d'ensemble

Un système léger et performant pour créer des interactions contextuelles dans votre jeu.
Idéal pour les actions qui nécessitent une confirmation utilisateur.

### ✨ Caractéristiques

* ✅ Bouton interactif personnalisable
* ✅ Validation par touche clavier
* ✅ Interface responsive
* ✅ Pas de blocage du thread principal
* ✅ Simple à intégrer

---

## 🚀 Installation

Assurez-vous que les fichiers suivants sont présents dans le dossier `ui/prompts/` :

```
ui/prompts/
├── pindex.html   # Interface HTML
├── pstyles.css   # Styles CSS
├── cprompt.lua   # Logique client Lua
└── README.md     # Cette documentation
```

---

## 📖 Utilisation

### 🔹 Méthode 1 : Appel direct (recommandé - non exportable)

```lua
local prompt = openPrompt(holdMode, control, text)

Citizen.CreateThread(function()
    while not prompt.validate do
        Wait(10)
    end
    
    print("Prompt validé!")
end)
```

---

### 🔹 Méthode 2 : Via Event (pour export)

```lua
TriggerEvent("vorp:client:openPrompt", holdMode, control, text)
```

---

### 📊 Paramètres

| Paramètre | Type    | Description             | Exemple                    |
| --------- | ------- | ----------------------- | -------------------------- |
| holdMode  | boolean | Mode maintien (réservé) | `false`                    |
| control   | string  | Touche clavier          | `"G"`, `"E"`, `"F"`        |
| text      | string  | Texte affiché           | `"Appuyez pour interagir"` |

---

## 💡 Exemple complet

```lua
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
```

---

### 🔁 Alternative (vérification directe)

```lua
local prompt = openPrompt(false, "G", "Press G")

if prompt.validate then 
    print("Prompt validé!")
end
```

---

## ⚙️ Fonctionnement

### 🧠 Client Lua (`cprompt.lua`)

* `openPrompt()` crée une table `promptData` avec `validate = false`
* Envoie un message NUI au frontend (HTML)
* Quand l'utilisateur relâche la touche, le callback `closePrompt` passe `validate` à `true`

---

### 🎨 Frontend (`pindex.html` + `pstyles.css`)

* Bouton affiché en bas-centre de l'écran
* Interaction :

  * Survol → agrandissement + affichage du texte
  * Appui touche → animation visuelle
* Envoi du callback au Lua lors du relâchement

---

## 🎛️ Personnalisation

### 🎨 Couleur du bouton

Dans `pstyles.css` :

```css
.button:hover {
  background-color: rgb(253, 193, 27); /* Jaune */
}
```

---

### 📍 Position

```css
.button {
  bottom: 20px; /* Distance du bas */
  left: 50%;    /* Centré horizontalement */
}
```

---

### 📏 Taille du bouton

```css
.button {
  width: 50px;
  height: 50px;
}

.button:hover {
  width: 140px;
}
```

---

## 📝 Notes

* ⏱️ La première utilisation peut être légèrement plus lente (chargement NUI)
* ⚡ Utilisez `Citizen.CreateThread()` pour éviter de bloquer le thread principal
* 🔒 Un seul prompt peut être actif à la fois (variable globale `currentPrompt`)

---
