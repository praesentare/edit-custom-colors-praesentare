# edit-custom-colors-praesentare

*[English version](README.en.md)*

Ein Skill für **Microsoft 365 Copilot in PowerPoint**, der die benutzerdefinierten
Farben einer Präsentation sichtbar und bearbeitbar macht.

PowerPoint speichert bis zu 50 benutzerdefinierte Farben positionsgebunden im
Design. Über die Oberfläche kommt man an diese Liste nur einzeln und in der
Reihenfolge, die PowerPoint vorgibt. Dieser Skill legt sie als Raster auf eine
Folie: zehn Spalten, fünf Zeilen, eine Position je Quadrat. Farben ändern,
ergänzen, benennen oder leer lassen geschieht dann direkt auf der Folie. Ein
zweiter Aufruf schreibt das Raster positionsgetreu ins Design zurück.

## Voraussetzungen

- Microsoft 365 Copilot in PowerPoint mit aktivierten Skills
- Python 3 mit `python-pptx`
- Die Präsentation liegt lokal und ist beschreibbar

## Installation

**Persönlich, nur für Dich:** Den Ordner
`package/skills/edit-custom-colors-praesentare` in den lokalen Skill-Ordner
kopieren:

```text
%OneDrive%\Dokumente\Copilot\Microsoft PowerPoint\skills\
```

Ohne das mitgelieferte Skript bleibt davon allerdings nur der Anweisungstext
übrig, und der Skill kann nichts ausführen. Für den vollen Funktionsumfang ist
der zweite Weg gedacht.

**Organisationsweit:** Das ZIP aus `dist/` (oder aus den
[Releases](../../releases)) im Microsoft-365-Admin-Center unter „Integrierte
Apps“ hochladen und der gewünschten Nutzergruppe zuweisen.

## Aufruf

In PowerPoint mit Copilot, jeweils gleichwertig auf Deutsch und Englisch:

| Aufruf | Wirkung |
|---|---|
| `edit-custom-colors-praesentare` | wie `load` |
| `edit-custom-colors-praesentare load` bzw. `laden` | Raster auf einer neuen Folie anlegen |
| `edit-custom-colors-praesentare save` bzw. `speichern` | Raster zurück ins Design schreiben |

## Was dabei passiert

**Laden** liest `a:custClrLst` aus `ppt/theme/theme1.xml` positionsgetreu aus und
baut daraus am Ende der Präsentation eine neue Folie mit 50 Quadraten
(`PCL_CustomColor_01` bis `PCL_CustomColor_50`). Belegte Positionen tragen ihre
Farbe, leere bleiben transparent, jedes Quadrat bekommt eine schwarze Kontur von
0,75 pt.

**Speichern** liest die Füllfarben und Beschriftungen der Quadrate zurück. Der
Text im Quadrat wird zum Farbnamen; ohne Text nimmt der Skill den Hexwert mit
führendem `#`. Leerstellen zwischen belegten Positionen bleiben Leerstellen: sie
werden als Eintrag mit leerem Namen und dem reservierten Wert `FFFFFF`
geschrieben, damit sich nachfolgende Farben nicht verschieben. Hinter der letzten
belegten Position endet die Liste. Folien und Shape-Füllungen bleiben dabei
unberührt.

## Paket selbst bauen

```powershell
powershell -ExecutionPolicy Bypass -File build.ps1
```

Das Skript liest die Version aus `package/manifest.json` und legt
`dist/edit-custom-colors-praesentare-v<version>.zip` an. Die Versionsnummer ist
Bestandteil des Dateinamens, damit ausgelieferte Stände unterscheidbar bleiben.

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

Das Python-Skript ist bewusst dicht geschrieben. Es kommt ohne Abhängigkeiten
außer `python-pptx` aus und arbeitet direkt auf dem OOXML der Datei.

## Lizenz

[BSD Zero Clause License](LICENSE), Kennung `0BSD`. Nutzung, Änderung,
Weitergabe und Verkauf sind ohne jede Auflage erlaubt; nicht einmal der
Copyright-Hinweis muss mitwandern. Namensnennung ist also erwünscht, aber nicht
verlangt. Über einen Hinweis auf
[praesentare.com](https://praesentare.com) freue ich mich trotzdem.
