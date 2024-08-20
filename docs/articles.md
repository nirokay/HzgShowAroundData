# Artikel

Du kannst Artikel in zwei Formen schreiben.

Egal welches der Zwei du wählst, musst du in der `articles.json` Datei deinen Artikel hinzufügen.

**Beispiel:**

```json
{
    "title": "Artikel Titel",
    "author": "Dein Name",
    "date": "Datum im format 'dd.MM.yyyy'",
    "desc": "Kurze Beschreibung worum es im Artikel geht (wird in der Artikel-Preview angezeigt).",
    "image": "Pfad zum Bild (wird als Vorschau verwendet) im Ordner resources/images/articles/",
    "body": null,
    "remote": null
}
```

Die Felder `"body"` und `"remote"` werden hier erklärt:

## HTML

> **Pro:**
> 
> * volle Kontrolle über HTML (und CSS zu einem gewissen Grad)
> 
> **Contra:**
> 
> * komplizierter als JSON -> braucht Kenntnisse über HTML

Alles was geschrieben ist, wird in die `<body> *dein HTML* </body>` Tags gepackt.

**Beispiel:**

```html
<h1>Größte Überschrift</h1>

<h2>Große Überschrift</h2>
<p>Paragraph mit Text</p>

<h2>Neue Überschrift</h2>
<p>Bla bla Text</p>
<img src="pfad/zur/bild/datei.png" alt="Text, der erscheint, wenn das Bild unverfügbar ist.">
```

... wird zu:

```html
<!DOCTYPE html>
<html>
    <head>
        ...
    </head>
    <body>
        <h1>Größte Überschrift</h1>

        <h2>Große Überschrift</h2>
        <p>Paragraph mit Text</p>

        <h2>Neue Überschrift</h2>
        <p>Bla bla Text</p>
        <img src="pfad/zur/bild/datei.png" alt="Text, der erscheint, wenn das Bild unverfügbar ist.">
    </body>
</html>
```

**Verzeichnis in der `articles.json` Datei:**

```json
{
    ...,
    "remote": "name_deines_artikels.html"
}
```

**Anmerkung:** Du kannst das CSS für Artikel [hier finden](https://github.com/nirokay/HzgShowAround/blob/master/article/article-styles.css)!

## JSON

> **Pro:**
>
> * leichter zu verfassen
> * braucht nur Basiskenntnisse über JSON
>
> **Contra:**
>
> * eingeschränkteres Styling

**Beispiel:**

```json
{
    ...,
    "body": [
        "# Größte Überschrift",

        "## Große Überschrift",
        "Paragraph mit Text",

        "## Neue Überschrift",
        "Bla bla Text",
        "<img>pfad/zur/bild/datei.png</img>"
    ]
}
```

*Header Tags (Überschriften):*

Headers sind eins-zu-eins wie in [Markdown](https://en.wikipedia.org/wiki/Markdown).

* `#` *(-> entspricht HTML: h1)*
* `##` *(-> entspricht HTML: h2)*
* `###` *(-> entspricht HTML: h3)*
* `####` *(-> entspricht HTML: h4)*
* `#####` *(-> entspricht HTML: h5)*
* `######` *(-> entspricht HTML: h6)*

*Bilder Tags:*

* `<img>...</img>`

* `<img=...>`

* `<bild>...</bild>`

* `<bild=...>`

* `<pic>...</pic>`

* `<pic=...>`

**Anmerkung:** Alle Tags müssen am Anfang einer Zeile sein, wenn sie mitten in einer Zeile auftauchen,
dann werden sie als normaler Text interpretiert.

* `"Bla bla, Bild?: <img=bild.png>"` wird als normaler Paragraph angezeigt.
* `"Text # Überschrift?"` ebenfalls als normaler Paragraph.
* `#Überscrift?` ist ein normaler Paragraph, Überschrift-Tags müssen mit einem Leerzeichen gefolgt werden!

Es ist möglich HTML Tags in einem JSON-Artikel zu verwenden, aber das ist nicht sonderlich empfehlenswert.

**Beispiel für HTML im JSON-Artikel:**

```json
[
    {
        ...,
        "body": [
            "# Thema",
            "Sehr interessant weil ist halt so!",

            "<small>ACHTUNG: Das ist ein HTML-Tag! Der Text wird klein :)</small>",
            "<b>Das wird fett,</b> genauso wie <strong>das hier... weil HTML komisch ist.</strong>",

            "Das aber nicht, weil <img>...</img> schon vom Programm interpretiert wird!",
            "<img>bild/zur/überzeugung.png</img>",

            "Das wiederum ist schon ein HTML-Tag:",
            "<img src=\"pfad/zu/einer/datei.png\" alt=\"Ups, Bild nicht da...\">"
        ]
    }
]
```

Bedenke, dass jede Linie im JSON-Artikel in `<p>...</p>` Paragraph-Tags plaziert wird! Das heißt,
es ist nicht möglich HTML-Tags wie `div` zu verwenden (wenn schon, dann sollte man es trotzdem nicht...)!

Wenn du auf solche Tags zurückgreifen willst, ist es ratsam den kompletten Artikel in HTML zu schreiben. :)
