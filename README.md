# HzgShowAround Data

## About

This repository is used at compile-time and runtime by [HzgShowAround](https://github.com/nirokay/HzgShowAround) as well as by browser-runtime javascript.

The following paragraphs will be written in German.

## Dateistrukturen

### Orte

Informationen über Orte befindet sich in `locations.json`.

#### Warum überhaupt JSON?

> Der Syntax ist nicht allzu schwer zu erlernen und JSON wird so ziemlich überall verwendet (vorallem im Web).

Warum nicht einfach HTML? Am Ende wird es doch ehh HTML...

> Alle Orte teilen den selben Aufbau, den jedes Mal zu wiederholen wäre sehr aufwändig, nicht effizient und fehlerreif.
>
> JSON lässt dich das wichtige Schreiben - den Content. Das langweilige HTML-Gedöns wird für dich übernommen. :)
>
> Dazu kommt noch, dass es alle Infos zentral gespeichert sind. Damit hat eine Änderung überall Effekt und muss nicht in 10 verschiedenen Orten geändert werden.

#### Beispiel

Das ist ein Beispielort, du kannst dich daran orientieren, wenn du einen neuen Ort hinzufügst oder updatest!

```json
{
    "name": "Ortname",
    "desc": {
        "Überschrift 1": [
            "Hier kommt Text rein.",
            "Dieser Text kommt auf die nächste Zeile."
        ],
        "Überschrift 2": [
            "Noch mehr Text!",
            "Und noch mehr Text!!!"
        ]
    },
    "open": {
        "Mo - Fr": "08.00 - 18.00",
        "Sa":      "08.00 - 12.00"
    },
    "pics": {
        "header": "Großes Bild  -> Name der Datei",
        "footer": "Kleines Bild -> Name der Datei (ohne 'resources/images/')"
    },
    "same": [
        "Ähnlicher Ort 1",
        "Ähnlicher Ort 2"
    ],
    "coords": [
        69,  420,
        169, 520
    ]
}
```

**Syntax:**

Der Inhalt zwischen ...

* `{}` ist ein Object.

* `[]` ist ein Array.

* `""` ist ein String.

Manche Felder sind **notwendig**! Diese wurden mit einem `*` Sternchen versehen.

##### `name` - Name *

Das ist der Ortsname, es ist ein einfacher String.

**Beispiel:** `"Mühlenmarkt"`, `"Deckerhalle"`

##### `desc` - (Description) Beschreibung

Puhh, das ist ein komplexer Bursche...

`desc` ist ein Table mit String Index und String-Array Values.

Der Index ist die Überschrift.

Der Value ist ein Paragraph, jeder String ist eine eigene Zeile.

**Beispiel:**

```json
"desc": {
    "Überschrift": [
        "Zeile 1",
        "Zeile 2"
    ],
    "Noch eine Überschrift": [
        "Zeile",
        "Neue Zeile"
    ]
}
```

##### `open` - Öffnungszeiten

`open` ist ein Table mit String Indexes und String Values.

**Beispiel:** `{"Mo - Fr": "bla bla", "Sa": "bla bla bla"}`

##### `pics` - (Pictures) Bilder

`pics` ist ein Table mit String Indexes und String Values:

* `header`: Großes Bild am Anfang des Artikels

* `footer`: Kleineres Bild am Ende des Artikels

Die Values sind die Dateinamen im Ordner `resources/images/`.

> Das heißt:
>
> `resources/images/ort_1_eingang.png` -> `ort_1_eingang.png`

##### `same` - Gleiches / Ähnliches

`same` ist ein Array von Strings, den Namen der Orte.

**Beispiel:** `["Mühlenmarkt", "Anderer Ort"]`

##### `coords` - (Coordinates) Koordinaten

Zur Einfachheit, wird angenommen, dass die Karte 2000x2000 Pixel groß ist.

SVGs (Dateiformat der Karte) haben keine Auflösung, deshalb ist es ratsam für Koordinaten das Bild als PNG zu exportieren und dort die Koordinaten abzuschauen.

`coords` ist ein Array von Integers im Format `x1, y1, x2, y2` für ein Rechteck.

**Beispiel:** `[10, 10, 30, 30]`, `[100, 150, 300, 500]`

### Tourdaten

Die Datei `tour_locations.json` beinhaltet ein einfache Array von den Ort-IDs. Diese IDs sind die Selben, die auch in der Url von einem Ort erscheinen (Mühlenmarkt -> `mühlenmarkt`; Werkstatt-Laden im Mühlenmarkt `werkstatt-laden_im_mühlenmarkt`; ...)

In der Tour werden diese der Reihenfolge nach abgerufen.

### Karte

Die Karte in `resources/images/map.svg` wird als Vorlage verwendet.

## Begriffserklärung

* `Array`: Liste

* `Integer / Int`: ganze Zahl ohne Kommas ( 1, 2, 3, ... )

* `String`: Text

* `Object / Table`: Objekt

* `Index`: Index / Verzeichnis

* `Value`: Wert
