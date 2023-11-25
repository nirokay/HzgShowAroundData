# HzgShowAround Data

## About

This repository is used at compile-time and runtime by [HzgShowAround](https://github.com/nirokay/HzgShowAround). The following paragraphs will be written in German.

## Dateistrukturen

### Orte

Informationen über Orte befindet sich in `locations.json`.

(Todo: documentation)

### Tourdaten

Die Datei `tour_locations.json` beinhaltet ein(e) einfache(s) Array/Liste von den Ort-IDs. Diese IDs sind die selben, die auch in der Url von einem Ort erscheinen (Mühlenmarkt -> `mühlenmarkt`; Werkstatt-Laden im Mühlenmarkt `werkstatt-laden_im_mühlenmarkt`; ...)

In der Tour werden diese der Reihenfolge nach abgerufen.

### Karte

Die Karte in `resources/images/map.svg` wird als Vorlage verwendet.