# Den Newsfeed erhalten

Der Newsfeed muss manuell erhalten werden. Neuigkeiten und Events sind in `news.json` einzutragen.

## Welche Neuigkeiten sind wichtig?

Kurz gesagt: Alles was in der Herzogsägmühle gerade passiert oder für die Bewohner interssant sein
könnte.

> **Beispiele:**
>
> * Mühlenmarkt (zB: eine Aktion, temporäre Schließung, etc.)
> * Feste oder Veranstaltungen

## JSON

Alle Neuigkeiten/Events sind in `news.json` als JSON gespeichert. Wie es aufgebaut ist, wird jetzt
erklärt!

> **Beispiel zur Orientierung:**
>
> ```json
> {
>     "name": "Weihnachten",
>     "from": "*-12-24",
>     "till": "*-12-26",
>     "level": "info",
>     "details": [
>         "Frohe Weihnachten!"
>     ]
> }
> ```

### Feld `name`

Das ist der Name des Events und wird ganz oben groß angezeigt.

### Felder `from`, `till` ODER `on`

Diese Felder beinhalten Daten, welche im Format `yyyy-MM-dd` (deutsch: `YYYY-MM-TT`) sind. Bei
jährlichen Events, kann man das Jahr durch ein `*` Sternchen ersetzen.

#### Zeitfenster

Bei einem Zeitfenster, wie oben im Beispiel, gibt es ein Start-Tag (`from`) und ein End-Tag (`till`).
Im obigen Beispiel heißt das, dass Weihnachten jedes Jahr vom 24.12. bis zum 26.12. stattfindet.

#### Tagesevent

Ein Tagesevent ist, im Gegensatz zum Zeitfenster, ein Event, welches nur an einem Tag stattfindet.
Dies ist der größte Teil der Events.

Bei einem solchen Event werden die Felder `from` und `till` durch ein einziges Feld `on` ersetzt:

```json
{
    "name": "Heilig Abend",
    "on": "*-12-24",
    "level": "info",
    "details": [
        "Frohe Weihnachten!"
    ]
}
```

### Feld `level`

Das Feld `level` ist die Wichtigkeit des Events. Standartmäßig ist `level` zu `info` gesetzt und
kann weggelassen werden.

> **Alle levels in steigender Wichtigkeit:**
>
> * `info`: Standart-Level - für Veranstaltungen und Feste (weiß eingezeichnet)
> * `warn`/`warning`/`warnung`: Warnung - für wichtige Infos (gelb eingezeichnet)
> * `alert`/`alarm`/`achtung`: !!Achtung!! - spezielle (Not-)Fälle, die sehr wichtig sind (rot eingezeichnet)

### Feld `info`

> Nicht zu verwechseln mit dem `"level": "info"`!

Hier kann ein optionaler Link eingefügt werden, der dem Leser mehr Informationen zu dem Event geben soll.

### Feld `details`

Dieses Feld ist eine Liste mit Text, die den größten Teil des Events ausmacht.

> **Beispiel mit mehr Text in `details`:**
>
> ```json
> {
>     "name": "Event",
>     "on": "*-01-01",
>     "level": "info",
>     "details": [
>         "Frohes Neues Jahr!",
>         "Ich hoffe du hattest einen guten Rutsch :)"
>     ]
> }
> ```

Die zwei Linien werden auf eigenen Zeilen gezeigt.
