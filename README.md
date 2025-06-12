# HzgShowAround Data

## About

This repository is used at compile-time and runtime by [HzgShowAround](https://github.com/nirokay/HzgShowAround) as well as by browser-runtime javascript.

The following paragraphs will be written in German.

## Werbeplakate

Die Werbeplakate sind in [dem Flyer GitHub-Release](https://github.com/nirokay/HzgShowAroundData/releases/latest).

## Dokumentationen

Alle JSON-Dateien haben ein [JSON Schema](https://json-schema.org/), welche sich [in diesem Unterordner](./templates/.schemas/) befinden.

Die JSON-Dateien werden bei einem Push nach Integrität und Syntax überprüft. Es ist aber auch möglich diese lokal mit dem
[`./scripts/validate-jsons.sh`](./scripts/validate-jsons.sh) Script zu überprüfen.

**Dateistrukturen:**

* [Artikel](docs/articles.md)
* [Newsfeed](docs/news.md)
* [Orte](docs/locations.md)

**Schritt-für-Schritt Anleitungen:**

* [Deinen ersten Artikel schreiben](docs/wrting_first_article.md)

### Tourdaten

Die Datei `tour_locations.json` beinhaltet ein einfache Array von den Ortsnamen.

In der Tour werden diese der Reihenfolge nach abgerufen.

### Karte

Die Karte in `resources/images/map.svg` wird als Vorlage verwendet.

## Begriffserklärung für Dokumentation

* `Array`: Liste `[...]`

* `Integer / Int`: ganze Zahl ohne Kommas ( 1; 2; 3; ... )

* `String`: Text `"..."`

* `Object / Table`: Objekt `{...}`

* `Index`: Index / Verzeichnis

* `Value`: Wert
