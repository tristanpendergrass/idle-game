#!/usr/bin/env node

/**
 * Custom Icon Generator
 *
 * Converts SVG files to Elm code with currentColor support for theme-aware coloring.
 *
 * Usage: node scripts/generate-custom-icons.js
 */

const fs = require('fs');
const path = require('path');

// Configuration
const SOURCE_DIR = path.join(__dirname, '..', 'public', 'skills');
const OUTPUT_FILE = path.join(__dirname, '..', 'src', 'IdleGame', 'Views', 'CustomIcons.elm');
const MODULE_NAME = 'IdleGame.Views.CustomIcons';

/**
 * Replace black colors with currentColor in SVG content
 */
function replaceColorsWithCurrent(svgContent) {
  return svgContent
    // Replace hex colors: #000000, #000
    .replace(/#000000/gi, 'currentColor')
    .replace(/="#000"/gi, '="currentColor"')
    // Replace rgb colors
    .replace(/rgb\s*\(\s*0\s*,\s*0\s*,\s*0\s*\)/gi, 'currentColor')
    // Replace named color
    .replace(/="black"/gi, '="currentColor"')
    .replace(/='black'/gi, "='currentColor'");
}

/**
 * Convert kebab-case to camelCase
 */
function toCamelCase(str) {
  return str.replace(/-([a-z])/g, (g) => g[1].toUpperCase());
}

/**
 * Convert filename to valid Elm function name
 */
function toFunctionName(filename) {
  const name = path.basename(filename, '.svg');
  // Convert kebab-case to camelCase
  return name.replace(/-(\w)/g, (_, letter) => letter.toUpperCase());
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
    attrs[toCamelCase(key)] = value;
  }

  return attrs;
}

/**
 * Parse attributes and convert to Elm Svg.Attributes
 */
function parseAttributesForElm(attrString) {
  const attrs = [];
  const attrRegex = /(\w+(?:-\w+)*)="([^"]*)"/g;
  let match;

  while ((match = attrRegex.exec(attrString)) !== null) {
    const key = match[1];
    const value = match[2];
    const camelKey = toCamelCase(key);

    // Use appropriate Elm attribute function
    if (['width', 'height', 'x', 'y', 'rx', 'ry', 'viewBox'].includes(camelKey)) {
      attrs.push(`Svg.Attributes.${camelKey} "${value}"`);
    } else {
      // For other attributes, use Html.Attributes.attribute
      attrs.push(`attribute "${key}" "${value}"`);
    }
  }

  return attrs;
}

/**
 * Parse SVG child elements
 */
function parseChildren(content) {
  const children = [];

  // Match self-closing tags like <rect .../> or <path .../>
  const selfClosingRegex = /<(\w+)([^>]*?)\/>/g;
  let match;

  while ((match = selfClosingRegex.exec(content)) !== null) {
    const tagName = match[1];
    const attrs = match[2].trim();

    // Parse attributes
    const attrList = parseAttributesForElm(attrs);

    if (attrList.length > 0) {
      children.push({
        tag: tagName,
        attrs: attrList
      });
    } else {
      children.push({
        tag: tagName,
        attrs: []
      });
    }
  }

  return children;
}

/**
 * Convert SVG element to Elm Svg code
 */
function svgToElm(svgContent) {
  // Extract the SVG opening tag
  const svgTagMatch = svgContent.match(/<svg[^>]*>/);
  if (!svgTagMatch) {
    throw new Error('Invalid SVG: no <svg> tag found');
  }

  const attrs = parseSvgAttributes(svgTagMatch[0]);

  // Extract viewBox for the wrapper
  const viewBox = attrs.viewBox || '0 0 32 32';

  // Extract the SVG content (everything between <svg> and </svg>)
  const contentMatch = svgContent.match(/<svg[^>]*>([\s\S]*)<\/svg>/);
  if (!contentMatch) {
    throw new Error('Invalid SVG: could not extract content');
  }

  const innerContent = contentMatch[1].trim();

  // Parse child elements
  const children = parseChildren(innerContent);

  return { viewBox, children };
}

/**
 * Generate Elm code for SVG children
 */
function generateChildrenCode(children) {
  if (children.length === 0) {
    return '[]';
  }

  const childCode = children.map(child => {
    const attrsCode = child.attrs.length > 0
      ? `[ ${child.attrs.join('\n                    , ')} ]`
      : '[]';

    return `Svg.${child.tag}\n                    ${attrsCode}\n                    []`;
  }).join('\n                , ');

  return `[ ${childCode}\n                ]`;
}

/**
 * Generate Elm code for a single icon
 */
function generateIconFunction(filename, svgContent) {
  const functionName = toFunctionName(filename);
  const processedSvg = replaceColorsWithCurrent(svgContent);

  try {
    const { viewBox, children } = svgToElm(processedSvg);

    const childrenCode = generateChildrenCode(children);

    return `
{-| ${functionName} icon -}
${functionName} : Icon
${functionName} =
    let
        svgContent =
            Svg.svg
                [ Svg.Attributes.viewBox "${viewBox}"
                , attribute "fill" "currentColor"
                , attribute "stroke" "currentColor"
                , attribute "xmlns" "http://www.w3.org/2000/svg"
                ]
                ${childrenCode}
    in
    IconSvg svgContent defaultParams
`;
  } catch (error) {
    console.error(`Error processing ${filename}:`, error.message);
    return null;
  }
}

/**
 * Generate the complete Elm module
 */
function generateElmModule(icons) {
  const iconFunctions = icons.filter(Boolean).join('\n');

  return `module ${MODULE_NAME} exposing (..)

{-| Custom SVG icons generated from public/skills/

This file is AUTO-GENERATED by scripts/generate-custom-icons.js
DO NOT EDIT MANUALLY

-}

import Html exposing (Html)
import Html.Attributes exposing (attribute)
import IdleGame.Views.Icon exposing (Icon(..), Params, defaultParams)
import Svg
import Svg.Attributes


${iconFunctions}
`;
}

/**
 * Main function
 */
function main() {
  console.log('🎨 Generating custom icons...\n');

  // Check if source directory exists
  if (!fs.existsSync(SOURCE_DIR)) {
    console.error(`❌ Source directory not found: ${SOURCE_DIR}`);
    process.exit(1);
  }

  // Read all SVG files
  const files = fs.readdirSync(SOURCE_DIR).filter(f => f.endsWith('.svg'));

  if (files.length === 0) {
    console.warn(`⚠️  No SVG files found in ${SOURCE_DIR}`);
    process.exit(0);
  }

  console.log(`📁 Found ${files.length} SVG file(s):\n`);

  // Process each SVG file
  const icons = files.map(filename => {
    console.log(`   - ${filename} → ${toFunctionName(filename)}`);
    const svgContent = fs.readFileSync(path.join(SOURCE_DIR, filename), 'utf8');
    return generateIconFunction(filename, svgContent);
  });

  // Generate Elm module
  const elmCode = generateElmModule(icons);

  // Write output file
  fs.writeFileSync(OUTPUT_FILE, elmCode, 'utf8');

  console.log(`\n✅ Generated ${OUTPUT_FILE}`);
  console.log(`\n💡 To use these icons, import ${MODULE_NAME} in your Elm files`);
}

// Run the script
if (require.main === module) {
  main();
}
