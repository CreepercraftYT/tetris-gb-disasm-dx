# Tetris "DX" 2
This is a Better version of my Gameboy Tetris Colorization hack, which i jokingly nicknamed 'Tetris "DX"'.

This version will include an in-game clock and palettes changing depending on the time of the day!

It will also look a lot more like the Original Tetris DX.

W.I.P

Hard Mode ("Heart" mode) is now enabled by holding Up on the title screen

# Credits
Inspired by Tetris DX

RTC Functions inspired by Pokemon G/S/C

Original Tetris Rosy Retrospection hack by Ospin

Special Thanks to:

Leafycup: Background Colors

Tolstoj: Testing

gbdev discord server: tips and certain pieces of code

In Memory of RHDN (ROMHacking.net)

# Options
"Turn On The Lights": uses Daytime piece palettes during night

"Classic Rule": uses Sega Colors instead of Guideline colors

"No Day-Night Cycle": disables time-based palettes

"Rosy Retro. Mode": enables Rosy Retrospection Features, if "Classic Rule" is enabled along with this one, the ruleset used will be similar to the one in Tetris: The Grand Master 3 Terror-Instinct by Arika

## Common
* Place `tetris.gb` in the `tools/` directory, and `web/` directory
* Former is used for scripts, and `tools/cmp.sh`, and the latter for web visualisations

# Building
* Install RGBDS v0.6.1
* Run `make` within the `disasm` directory
* Run `tools/cmp.sh` to compare built ROM against original ROM

## Web
* Start a web server within the `web/` directory, eg `python3 -m http.server`
* Navigate to the root page to see a list of game screens and sprites

## Project Structure
* `disasm`
  * `code` - dissected and commented asm that runs the game
  * `data` - large blocks of data, layouts are in `.bin` files
  * `gfx` - pngs of 1bpp and 2bpp data
  * `include` - constants, hardware definitions, ram, macros and structs
  * `includes.s` - imported definitions, excluding those that need building, eg ram
* `tools` - misc tools to help with disassembly
* `web` - the html+js in 1 file to visualise
  * `docs` - reference images, and flow .drawio

## ROM Bank Structure
(Leftover space is outdated)
* `Bank 0`
  * Gamestate and update logic
  * GFX pipeline
  * Sound engine code (+ SFX, will be moving this to bank 2 in the future)
  * `Leftover space - 0x0b1a (2842) bytes`
* `Bank 1`
  * Sprite tilesets & specifications
  * Background tilesets
  * Background layouts
  * `Leftover space - $08b8 (2232) bytes`
* `Bank 2`
  * Song Data
  * Sunrise/Sunset Layouts
  * some functions
  * `Leftover space - $2e05 (11787) bytes`
* `Bank 3`
  * Demo Mode button inputs
  * Demo mode piece selections
  * Night Layouts
  * some functions
  * palettes
  * `Leftover space - $3e50 (15952) bytes`

`Total space added - $8027 (32807) bytes`

## Note on improvements
The project serves to describe everything that makes the game function as it does. Some things are not completely clear from the outset. If you need a full guide on a particular concept, eg sound engine, or some part of the disassembly needs further clarification, please feel free to raise an issue
