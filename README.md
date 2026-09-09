# edit-custom-colors-praesentare

*[English version](README.en.md)*

Ein Skill für **Microsoft 365 Copilot in PowerPoint**, der die benutzerdefinierten
Farben einer Präsentation bearbeitbar macht.

PowerPoint speichert bis zu 50 benutzerdefinierte Farben, bietet aber keine
Oberfläche, um sie zu verwalten. Der Skill legt sie als Raster auf eine Folie:
zehn Spalten, fünf Zeilen, eine Position je Quadrat. Dort ändert, ergänzt,
benennt oder leert man sie. Ein zweiter Aufruf schreibt das Raster zurück ins
Design.

## Voraussetzungen

- Microsoft 365 Copilot in PowerPoint mit aktivierten Skills

Sonst nichts. Python und `python-pptx` bringt die Skill-Laufzeit mit.

## Installation

Das ZIP aus den [Releases](../../releases) im Microsoft-365-Admin-Center unter
„Agents > Tools > Skills“ hochladen und der gewünschten Nutzergruppe zuweisen.

## Anwendung

Ein Beispiel, vom Aufruf bis zur geänderten Farbe:

1. In PowerPoint bei Copilot `edit-custom-colors-praesentare` eingeben.
2. Am Ende der Präsentation entsteht eine Folie mit 50 Quadraten. Belegte
   Positionen zeigen ihre Farbe, freie bleiben transparent.
3. Ein Quadrat anders einfärben, ein leeres füllen, in ein Quadrat einen Namen
   schreiben.
4. `edit-custom-colors-praesentare speichern` eingeben. Die Farben stehen im
   Design und erscheinen in jeder Farbauswahl der Präsentation.

Alle Aufrufe, deutsch und englisch gleichwertig:

| Aufruf | Wirkung |
|---|---|
| `edit-custom-colors-praesentare` | wie `load` |
| `edit-custom-colors-praesentare load` bzw. `laden` | Raster auf einer neuen Folie anlegen |
| `edit-custom-colors-praesentare save` bzw. `speichern` | Raster zurück ins Design schreiben |

## Was der Skill dabei tut

**Laden** liest `a:custClrLst` aus `ppt/theme/theme1.xml` und baut daraus die
Rasterfolie mit 50 Quadraten, benannt `PCL_CustomColor_01` bis
`PCL_CustomColor_50`. Sind noch keine Farben definiert, bleiben alle Quadrate
leer.

**Speichern** liest Füllfarbe und Beschriftung jedes Quadrats. Der Text im
Quadrat wird zum Farbnamen; ohne Text nimmt der Skill den Hexwert mit führendem
`#`. Leere Quadrate zwischen belegten bleiben erhalten: Der Skill schreibt sie
als Eintrag mit leerem Namen und dem Wert `FFFFFF`. So behalten die folgenden
Farben ihre Position. Hinter der letzten belegten Position endet die Liste.
Folien und Formen bleiben unverändert.

## Paket selbst bauen (Windows)

```powershell
powershell -ExecutionPolicy Bypass -File build.ps1
```

Das Skript liest die Version aus `package/manifest.json` und legt
`dist/edit-custom-colors-praesentare-v<version>.zip` an.

## Aufbau des Repos

```text
package/                 ← Inhalt des ZIPs, genau in dieser Struktur
├── manifest.json        ← Teams-App-Manifest (Version, ID, Icons)
├── color.png            ← Icon farbig, 192 x 192
├── outline.png          ← Icon einfarbig, 32 x 32
└── skills/edit-custom-colors-praesentare/
    ├── SKILL.md         ← Anweisungen für Copilot
    └── scripts/
        └── edit_custom_colors.py
build.ps1                ← baut das versionierte ZIP nach dist/
dist/                    ← Bauergebnisse, nicht versioniert
```

## Lizenz

[0BSD](LICENSE). Kommerzielle Nutzung erlaubt, Namensnennung nicht verlangt.
