# Custom SVG Icons

This folder contains custom SVG icons that are converted to Elm code for inline rendering with theme-aware coloring.

## Folder Structure

```
src/icons/
├── README.md          # This file
├── svgs/              # Source SVG files (input)
│   └── wild-magic-1.svg
├── WildMagic1.elm     # Generated Elm module
└── ...
```

## Workflow

### 1. Create your icon

Create pixel art in Aseprite (or any editor) with **black (`#000000`) fill** for elements that should inherit the theme color.

### 2. Export as SVG

Export your icon to `src/icons/svgs/your-icon-name.svg`

The filename will be converted to a module name:
- `wild-magic-1.svg` → `Icons.WildMagic1`
- `herb-gathering.svg` → `Icons.HerbGathering`

### 3. Run the generator

```bash
npm run generate-icons
```

This will:
- Read all SVG files from `src/icons/svgs/`
- Replace all black colors (`#000000`, `#000`, `black`) with `currentColor`
- Generate individual Elm modules in `src/icons/`

### 4. Use the icon

```elm
import Icons.WildMagic1 exposing (icon)

view =
    div [ class "text-primary" ]  -- The icon inherits this color
        [ icon
            |> Icon.withSize Icon.Large
            |> Icon.toHtml
        ]
```

## How Theme Coloring Works

The generated icons use `currentColor` for their fill attribute. This CSS value inherits the `color` property from the parent element.

```elm
-- Icon in a success-colored container
div [ class "text-success" ] [ Icon.toHtml Icons.WildMagic1.icon ]

-- Icon in an error-colored container
div [ class "text-error" ] [ Icon.toHtml Icons.WildMagic1.icon ]
```

This means the same icon automatically adapts to:
- Different semantic colors (`text-primary`, `text-error`, `text-success`)
- Light/dark theme switches
- Any DaisyUI theme

## Important Notes

- **DO NOT edit the generated `.elm` files** - they will be overwritten
- Edit the source SVG files in `src/icons/svgs/` instead
- Re-run `npm run generate-icons` after any SVG changes
- Use black (`#000000`) for elements that should be colored
- Use other colors for elements that should stay fixed
