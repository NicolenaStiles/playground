# nicolena_dot_net

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Formatting/Style Guide

Font size recommendations taken from [this website](https://www.learnui.design/blog/mobile-desktop-website-font-size-guidelines.html),
which interestingly pointed out that Medium uses 21pt font. That's much larger than expected!
It is also recommended that no more than 4 font sizes are used.

| Usage | Font Size |
|---|---|
| Main Body/Article | 21 pt |
| Headers | 48 pt |
| Captions/Details | 18 pt |


| Color Name | Colors class entry | Hex Code | Usage |
|---|---|---|---|
| Black| `Colors.black` | `0x00000000` | Background, etc. |
| White| `Colors.white` | `0xFFFFFFFF` | Main text, graphics | 
| Cyan | `Colors.cyan` | `0xFF00BCD4` | Main accent color |
| Accent Cyan | `Colors.cyanAccent` | Brighter cyan for lit neon effect |


Font for everything is `ProFontIIx Monospaced`, the same NerdFont package I use 
for my terminal. 

## Packages


1. [Dotted Border](https://pub.dev/packages/dotted_border)
Turns out there's no simple way to add dotted borders in Flutter! Thankfully I 
found this package early on and it did everything I needed it to do for the tags
right out of the box. Schweet.


2. [Flutter Markdown](https://pub.dev/packages/flutter_markdown)
Main markdown rendering engine for blog entries. Need to write my own
stylesheet, but otherwise, this absolutely slaps and is exactly what I needed.

3. [Go Router](https://pub.dev/packages/go_router)
This is how I'm gonna get the links to work.
