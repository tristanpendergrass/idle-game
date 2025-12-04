#!/usr/bin/env node

/**
 * Custom Icon Generator
 *
 * Converts SVG files to individual Elm modules with currentColor support
 * for theme-aware coloring.
 *
 * OPTIMIZATION: Merges adjacent rectangles horizontally and converts to
 * a single SVG path for much smaller output files.
 *
 * Usage: npm run generate-icons
 *
 * Input:  src/icons/svgs/*.svg
 * Output: src/icons/IconName.elm (one per SVG file)
 */

const fs = require('fs');
const path = require('path');

// Configuration
const SOURCE_DIR = path.join(__dirname, '..', 'src', 'icons', 'svgs');
const OUTPUT_DIR = path.join(__dirname, '..', 'src', 'icons');

/**
 * Replace black colors with currentColor in SVG content
 */
function replaceColorsWithCurrent(svgContent) {
  return svgContent
    .replace(/#000000/gi, 'currentColor')
    .replace(/="#000"/gi, '="currentColor"')
    .replace(/rgb\s*\(\s*0\s*,\s*0\s*,\s*0\s*\)/gi, 'currentColor')
    .replace(/="black"/gi, '="currentColor"')
    .replace(/='black'/gi, "='currentColor'");
}

/**
 * Convert kebab-case to PascalCase for module name
 */
function toPascalCase(str) {
  return str
    .split('-')
    .map(part => part.charAt(0).toUpperCase() + part.slice(1))
    .join('');
}

/**
 * Convert filename to module name
 */
function getNames(filename) {
  const name = path.basename(filename, '.svg');
  return {
    moduleName: toPascalCase(name)
  };
}

/**
 * Parse SVG attributes from opening tag
 */
function parseSvgAttributes(svgTag) {
  const attrs = {};
  const attrRegex = /(\w+(?:-\w+)*)="([^"]*)"/g;
  let match;

  while ((match = attrRegex.exec(svgTag)) !== null) {
    const key = match[1];
    const value = match[2];
    attrs[key.replace(/-([a-z])/g, (g) => g[1].toUpperCase())] = value;
  }

  return attrs;
}

/**
 * Parse rectangle elements from SVG content
 * Returns array of { x, y, width, height, fill }
 */
function parseRectangles(content) {
  const rects = [];
  const rectRegex = /<rect([^>]*?)\/>/g;
  let match;

  while ((match = rectRegex.exec(content)) !== null) {
    const attrString = match[1];
    const rect = {};

    // Parse x, y, width, height
    const xMatch = attrString.match(/\bx="([^"]*)"/);
    const yMatch = attrString.match(/\by="([^"]*)"/);
    const wMatch = attrString.match(/\bwidth="([^"]*)"/);
    const hMatch = attrString.match(/\bheight="([^"]*)"/);
    const fillMatch = attrString.match(/\bfill="([^"]*)"/);

    rect.x = xMatch ? parseFloat(xMatch[1]) : 0;
    rect.y = yMatch ? parseFloat(yMatch[1]) : 0;
    rect.width = wMatch ? parseFloat(wMatch[1]) : 1;
    rect.height = hMatch ? parseFloat(hMatch[1]) : 1;
    rect.fill = fillMatch ? fillMatch[1] : 'currentColor';

    rects.push(rect);
  }

  return rects;
}

/**
 * Merge adjacent rectangles horizontally
 * Combines rects that are on the same row (same y, same height) and adjacent (x + width = next x)
 */
function mergeRectanglesHorizontally(rects) {
  if (rects.length === 0) return [];

  // Group by y position and height and fill
  const groups = new Map();
  for (const rect of rects) {
    const key = `${rect.y}-${rect.height}-${rect.fill}`;
    if (!groups.has(key)) {
      groups.set(key, []);
    }
    groups.get(key).push(rect);
  }

  const merged = [];

  for (const [, group] of groups) {
    // Sort by x position
    group.sort((a, b) => a.x - b.x);

    let current = { ...group[0] };

    for (let i = 1; i < group.length; i++) {
      const next = group[i];
      // Check if adjacent (allowing small floating point tolerance)
      if (Math.abs((current.x + current.width) - next.x) < 0.001) {
        // Merge: extend current width
        current.width += next.width;
      } else {
        // Not adjacent, push current and start new
        merged.push(current);
        current = { ...next };
      }
    }
    merged.push(current);
  }

  return merged;
}

/**
 * Convert rectangles to an SVG path d attribute
 * Each rectangle becomes: M x y h width v height h -width Z
 */
function rectsToPathD(rects) {
  const commands = rects.map(r => {
    // M = moveto, h = horizontal line (relative), v = vertical line (relative), Z = close
    return `M${r.x} ${r.y}h${r.width}v${r.height}h${-r.width}Z`;
  });
  return commands.join('');
}

/**
 * Convert SVG element to optimized Elm Svg code
 */
function svgToElm(svgContent) {
  const svgTagMatch = svgContent.match(/<svg[^>]*>/);
  if (!svgTagMatch) {
    throw new Error('Invalid SVG: no <svg> tag found');
  }

  const attrs = parseSvgAttributes(svgTagMatch[0]);
  // Use viewBox if present, otherwise construct from width/height
  const viewBox = attrs.viewBox || `0 0 ${attrs.width || 32} ${attrs.height || 32}`;
  const shapeRendering = attrs.shapeRendering || null;

  const contentMatch = svgContent.match(/<svg[^>]*>([\s\S]*)<\/svg>/);
  if (!contentMatch) {
    throw new Error('Invalid SVG: could not extract content');
  }

  const innerContent = contentMatch[1].trim();

  // Parse rectangles
  const rects = parseRectangles(innerContent);

  if (rects.length === 0) {
    return { viewBox, shapeRendering, pathD: '', originalCount: 0, optimizedCount: 0 };
  }

  // Merge adjacent rectangles
  const merged = mergeRectanglesHorizontally(rects);

  // Convert to path
  const pathD = rectsToPathD(merged);

  return {
    viewBox,
    shapeRendering,
    pathD,
    originalCount: rects.length,
    optimizedCount: merged.length
  };
}

/**
 * Generate a complete Elm module for a single icon
 */
function generateElmModule(filename, svgContent) {
  const { moduleName } = getNames(filename);
  const processedSvg = replaceColorsWithCurrent(svgContent);

  const { viewBox, shapeRendering, pathD, originalCount, optimizedCount } = svgToElm(processedSvg);

  // Build the attribute list for the root <svg>
  const rootAttrs = [];
  rootAttrs.push(`Svg.Attributes.viewBox "${viewBox}"`);
  rootAttrs.push(`Svg.Attributes.width "100%"`);
  rootAttrs.push(`Svg.Attributes.height "100%"`);
  rootAttrs.push(`attribute "xmlns" "http://www.w3.org/2000/svg"`);

  if (shapeRendering) {
    rootAttrs.push(`attribute "shape-rendering" "${shapeRendering}"`);
  }

  const rootAttrsCode = `[ ${rootAttrs.join('\n                , ')} ]`;

  // Generate the path element
  const pathCode = pathD
    ? `[ Svg.path\n                    [ Svg.Attributes.d "${pathD}"\n                    , Svg.Attributes.fill "currentColor"\n                    ]\n                    []\n                ]`
    : '[]';

  return {
    code: `module Icons.${moduleName} exposing (icon)

{-| ${moduleName} icon

This file is AUTO-GENERATED by scripts/generate-custom-icons.js
DO NOT EDIT MANUALLY

Source: src/icons/svgs/${filename}
Optimization: ${originalCount} rects → ${optimizedCount} merged → 1 path

-}

import Html.Attributes exposing (attribute)
import IdleGame.Views.Icon exposing (Icon(..), defaultParams)
import Svg
import Svg.Attributes


{-| The icon with currentColor support for theme-aware coloring
-}
icon : Icon
icon =
    let
        svgContent =
            Svg.svg
                ${rootAttrsCode}
                ${pathCode}
    in
    IconSvg svgContent defaultParams
`,
    originalCount,
    optimizedCount
  };
}

/**
 * Main function
 */
function main() {
  console.log('🎨 Generating custom icons...\n');

  // Check if source directory exists
  if (!fs.existsSync(SOURCE_DIR)) {
    console.error(`❌ Source directory not found: ${SOURCE_DIR}`);
    console.log('   Create src/icons/svgs/ and add your SVG files there.');
    process.exit(1);
  }

  // Read all SVG files
  const files = fs.readdirSync(SOURCE_DIR).filter(f => f.endsWith('.svg'));

  if (files.length === 0) {
    console.warn(`⚠️  No SVG files found in ${SOURCE_DIR}`);
    process.exit(0);
  }

  console.log(`📁 Found ${files.length} SVG file(s):\n`);

  let totalOriginal = 0;
  let totalOptimized = 0;

  // Process each SVG file
  files.forEach(filename => {
    const { moduleName } = getNames(filename);
    const svgContent = fs.readFileSync(path.join(SOURCE_DIR, filename), 'utf8');

    try {
      const { code, originalCount, optimizedCount } = generateElmModule(filename, svgContent);
      const outputPath = path.join(OUTPUT_DIR, `${moduleName}.elm`);

      fs.writeFileSync(outputPath, code, 'utf8');

      totalOriginal += originalCount;
      totalOptimized += optimizedCount;

      const reduction = originalCount > 0
        ? Math.round((1 - optimizedCount / originalCount) * 100)
        : 0;

      console.log(`   ✓ ${filename} → Icons.${moduleName} (${originalCount} → ${optimizedCount} rects, ${reduction}% reduction)`);
    } catch (error) {
      console.error(`   ✗ ${filename}: ${error.message}`);
    }
  });

  const totalReduction = totalOriginal > 0
    ? Math.round((1 - totalOptimized / totalOriginal) * 100)
    : 0;

  console.log(`\n✅ Done! Total: ${totalOriginal} → ${totalOptimized} rectangles (${totalReduction}% reduction)`);
  console.log(`\n💡 Usage: import Icons.ModuleName exposing (icon)`);
}

// Run the script
if (require.main === module) {
  main();
}
