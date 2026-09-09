# edit-custom-colors-praesentare

*[Deutsche Fassung](README.md)*

A skill for **Microsoft 365 Copilot in PowerPoint** that makes a presentation's
custom colors visible and editable.

PowerPoint stores up to 50 custom colors in the theme, each bound to its
position. The user interface only exposes them one at a time and in the order
PowerPoint chooses. This skill puts the whole list on a slide instead: ten
columns, five rows, one position per square. Changing, adding, naming or
clearing a color happens right there on the slide. A second call writes the grid
back into the theme, position by position.

## Requirements

- Microsoft 365 Copilot in PowerPoint with skills enabled
- Python 3 with `python-pptx`
- The presentation is stored locally and is writable

## Installation

**Personal, for a single user:** copy the folder
`package/skills/edit-custom-colors-praesentare` into the local skill folder:

```text
%OneDrive%\Documents\Copilot\Microsoft PowerPoint\skills\
```

Note that this leaves you with the instruction text only; without the bundled
script the skill cannot execute anything. Use the second route for the full
feature set.

**Organization-wide:** upload the ZIP from `dist/` (or from
[Releases](../../releases)) in the Microsoft 365 admin center under "Integrated
apps" and assign it to the intended group of users.

## Invocation

In PowerPoint with Copilot. German and English wording work alike:

| Call | Effect |
|---|---|
| `edit-custom-colors-praesentare` | same as `load` |
| `edit-custom-colors-praesentare load` or `laden` | build the grid on a new slide |
| `edit-custom-colors-praesentare save` or `speichern` | write the grid back into the theme |

## What happens

**Load** reads `a:custClrLst` from `ppt/theme/theme1.xml` position by position and
appends a new slide holding 50 squares (`PCL_CustomColor_01` through
`PCL_CustomColor_50`). Occupied positions carry their color, empty ones stay
transparent, and every square gets a black 0.75 pt outline.

**Save** reads the squares' fill colors and labels back. The text inside a square
becomes the color name; without text the skill uses the hex value including the
leading `#`. Gaps between occupied positions stay gaps: they are written as an
entry with an empty name and the reserved value `FFFFFF`, so the colors after
them do not shift. The list ends after the last occupied position. Slides and
shape fills are left untouched.

## Building the package

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
