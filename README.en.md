# edit-custom-colors-praesentare

*[Deutsche Fassung](README.md)*

A skill for **Microsoft 365 Copilot in PowerPoint** that makes a presentation's
custom colors visible and editable.

PowerPoint can store up to 50 custom colors. There is no way to edit those
custom colors in PowerPoint itself. This skill puts them on a slide as a grid:
ten columns, five rows, one position per square. Changing, adding, naming or
clearing a color then happens right there on the slide. A second call writes the
colors back into the theme as laid out in the grid.

## Requirements

- Microsoft 365 Copilot in PowerPoint with skills enabled

## Installation

**Organization-wide:** upload the ZIP from `dist/` (or from the
[Releases](../../releases)) in the Microsoft 365 admin center under "Agents >
Tools > Skills" and assign it to the intended group of users.

## Invocation

In PowerPoint with Copilot. German and English wording work alike:

| Call | Effect |
|---|---|
| `edit-custom-colors-praesentare` | same as `load` |
| `edit-custom-colors-praesentare load` or `laden` | build the grid on a new slide |
| `edit-custom-colors-praesentare save` or `speichern` | write the grid back into the theme |

## What happens

**Load** reads `a:custClrLst` from `ppt/theme/theme1.xml` and appends a new slide
to the presentation holding 50 squares (`PCL_CustomColor_01` through
`PCL_CustomColor_50`). That grid is a picture of the custom colors. If no colors
are defined yet, every square stays empty.

**Save** reads the squares' fill colors and labels and writes the values back.
The text inside a square becomes the color name; without text the skill uses the
hex value including the leading `#`. Empty squares stay gaps: they are written as
an entry with an empty name and `FFFFFF`, so the colors after them keep their
position in the grid. The list ends after the last occupied position. Slides and
shape fills are left untouched.

## Building the package (Windows)

```powershell
powershell -ExecutionPolicy Bypass -File build.ps1
```

The script reads the version from `package/manifest.json` and writes
`dist/edit-custom-colors-praesentare-v<version>.zip`. The version is part of the
file name so that shipped builds stay distinguishable.

## Repository layout

```text
package/                 ← contents of the ZIP, in exactly this structure
├── manifest.json        ← Teams app manifest (version, id, icons)
├── color.png            ← color icon, 192 x 192
├── outline.png          ← outline icon, 32 x 32
└── skills/edit-custom-colors-praesentare/
    ├── SKILL.md         ← instructions for Copilot
    └── scripts/
        └── edit_custom_colors.py
build.ps1                ← builds the versioned ZIP into dist/
dist/                    ← build output, not versioned
```

The Python script is deliberately terse. It needs no dependency beyond
`python-pptx` and works directly on the file's OOXML.

## License

[BSD Zero Clause License](LICENSE), SPDX `0BSD`. Use, modification,
distribution and sale are permitted without any condition; not even the
copyright notice has to travel along. Attribution is therefore welcome but not
required. A pointer to [praesentare.com](https://praesentare.com) is
appreciated all the same.
