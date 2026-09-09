# edit-custom-colors-praesentare

*[Deutsche Fassung](README.md)*

A skill for **Microsoft 365 Copilot in PowerPoint** that makes a presentation's
custom colors editable.

PowerPoint stores up to 50 custom colors but offers no interface to manage them.
The skill puts them on a slide as a grid: ten columns, five rows, one position
per square. You change, add, name or clear them right there. A second call
writes the grid back into the theme.

## Requirements

- Microsoft 365 Copilot in PowerPoint with skills enabled

Nothing else. Python and `python-pptx` come with the skill runtime.

## Installation

Upload the ZIP from the [Releases](../../releases) in the Microsoft 365 admin
center under "Agents > Tools > Skills" and assign it to the intended group of
users.

## Usage

One example, from the call to the changed color:

1. In PowerPoint, type `edit-custom-colors-praesentare` in Copilot.
2. A slide with 50 squares appears at the end of the presentation. Occupied
   positions show their color, free ones stay transparent.
3. Recolor a square, fill an empty one, type a name into a square.
4. Type `edit-custom-colors-praesentare save`. The colors are in the theme and
   show up in every color picker of the presentation.

All calls, German and English alike:

| Call | Effect |
|---|---|
| `edit-custom-colors-praesentare` | same as `load` |
| `edit-custom-colors-praesentare load` or `laden` | build the grid on a new slide |
| `edit-custom-colors-praesentare save` or `speichern` | write the grid back into the theme |

## What the skill does

**Load** reads `a:custClrLst` from `ppt/theme/theme1.xml` and builds the grid
slide with 50 squares, named `PCL_CustomColor_01` through `PCL_CustomColor_50`.
With no colors defined yet, every square stays empty.

**Save** reads each square's fill color and label. The text inside a square
becomes the color name; without text the skill uses the hex value with a leading
`#`. Empty squares between occupied ones are preserved: the skill writes them as
an entry with an empty name and the value `FFFFFF`, so the colors after them
keep their position. The list ends after the last occupied position. Slides and
shapes stay untouched.

## Building the package (Windows)

```powershell
powershell -ExecutionPolicy Bypass -File build.ps1
```

The script reads the version from `package/manifest.json` and writes
`dist/edit-custom-colors-praesentare-v<version>.zip`.

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

## License

[0BSD](LICENSE). Commercial use permitted, attribution not required.
