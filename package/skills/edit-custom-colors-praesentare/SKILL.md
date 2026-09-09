---
name: edit-custom-colors-praesentare
description: Lädt die positionsgebundenen benutzerdefinierten Farben der aktuellen PowerPoint-Datei in ein 10-mal-5-Raster oder speichert die bearbeiteten Rasterfarben positionsgetreu zurück. Unterstützt load, laden, save und speichern; ohne Parameter wird load verwendet.
license: 0BSD
compatibility: Benötigt Python 3, python-pptx und einen lokalen beschreibbaren PPTX-Pfad.
metadata:
  author: Peter Claus Lamprecht
  version: "1.0.4"
---

# edit-custom-colors-praesentare

## Aufruf

Diese Aufrufe sind zulässig:

- `edit-custom-colors-praesentare`
- `edit-custom-colors-praesentare load`
- `edit-custom-colors-praesentare laden`
- `edit-custom-colors-praesentare save`
- `edit-custom-colors-praesentare speichern`

Ohne Parameter gilt `load`.

## Laden beziehungsweise load

Führe aus:

`python scripts/edit_custom_colors.py --presentation "<vollständiger lokaler PPTX-Pfad>" --mode load`

Regeln:

1. Lies `a:custClrLst` aus `ppt/theme/theme1.xml` positionsgetreu aus.
2. Ein benutzerdefinierter Farbeintrag mit leerem Namen und dem reservierten technischen Farbwert `FFFFFF` gilt als leerer Farbplatz und wird im Raster transparent dargestellt.
3. Ergänze das Raster bis Position 50 mit transparenten Quadraten.
4. Füge am Ende eine neue Folie ein. Wähle ein Layout namens `Blank` oder `Leer`; andernfalls das Layout mit den wenigsten Platzhaltern.
5. Entferne vor dem Einfügen des Rasters alle Platzhalter von der neuen Folie.
6. Füge oberhalb des Rasters ein eigenes Textfeld in der Standardschrift der Präsentation ein. Text exakt: `Skill edit-custom-colors-praesentare by Peter Claus Lamprecht, https://praesentare.com`
7. Erstelle darunter 50 quadratische Shapes im Raster mit 10 Spalten und 5 Zeilen.
8. Benenne die Shapes `PCL_CustomColor_01` bis `PCL_CustomColor_50`.
9. Fülle belegte Positionen mit ihrer Farbe. Leere Positionen bleiben transparent.
10. Alle Quadrate erhalten eine schwarze Outline von 0,75 Punkt.

## Speichern beziehungsweise save

Führe aus:

`python scripts/edit_custom_colors.py --presentation "<vollständiger lokaler PPTX-Pfad>" --mode save`

Regeln:

1. Verwende die letzte Folie mit einer vollständigen Matrix aus `PCL_CustomColor_01` bis `PCL_CustomColor_50`.
2. Lies die Füllfarben und den Text der Quadrate positionsgetreu aus.
3. Definierte Farben erhalten als Namen den Text im Quadrat, sofern der Text nach dem Entfernen äußerer Leerzeichen nicht leer ist.
4. Ohne Text erhält eine definierte Farbe ihren Hexwert einschließlich `#`, beispielsweise `#FF0000`.
5. Leere Farbplätze zwischen definierten Farben erhalten den leeren Namen `""` und technisch den reservierten Farbwert `FFFFFF`.
6. Nach dem letzten belegten Quadrat werden keine weiteren Einträge in `a:custClrLst` geschrieben. Die letzte Custom Color entspricht damit der letzten definierten Farbe.
7. Positionen vor oder zwischen definierten Farben dürfen nicht komprimiert oder verschoben werden.
8. Verändere beim Speichern weder Folien noch Shape-Füllungen.

## Ausgabe

Gib Modus, Erfolg, Anzahl belegter Farben, Anzahl geschriebener Custom-Color-Einträge und die letzte belegte Rasterposition aus.
