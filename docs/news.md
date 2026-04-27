# Den Newsfeed erhalten

Der Newsfeed muss manuell erhalten werden. Neuigkeiten und Events sind in den jahr-getrennten
News-Dateien, im `json/news/` Unterordner, einzutragen (`news-2026.json`, `news-2027.json`, ...).

Die verschiedenen Dateien werden fortan `news-*.json` genannt (das Sternchen `*` steht hier als
Platzhalter für das Jahr).

## Welche Neuigkeiten sind wichtig?

Kurz gesagt: Alles was in der Herzogsägmühle gerade passiert oder für die Bewohner interssant sein
könnte.

> **Beispiele:**
>
> * Feste oder Veranstaltungen
> * Mühlenmarkt (zB: eine Aktion, temporäre Schließung, etc.)

## Neuigkeiten in `news-*.json`

Alle Neuigkeiten/Events sind in `news-*.json` Dateien als JSON gespeichert. Wie es aufgebaut ist, wird jetzt
erklärt!

> **Beispiele zur Orientierung:**
>
> Wiederkehrende Events, einzutragen in `json/news/news-repeat.json`:
> ```json
> {
>     "name": "Weihnachten",
>     "times": [{ "from": "*-12-24", "till": "*-12-26" }],
>     "level": "info",
>     "details": [
>         "Frohe Weihnachten!"
>     ]
> }
> ```
> ```json
> {
>     "name": "Heilig Abend",
>     "times": [{ "on": "*-12-24" }],
>     "level": "info",
>     "details": [
>         "Frohe Weihnachten!"
>     ]
> }
> ```
>
> Event an mehreren Tagen mit Uhrzeiten:
> ```json
> {
>     "name": "Weihnachtsmarkt",
>     "locations": ["Deckerhalle", "Dorfplatz"],
>     "times": [
>         { "from": "2025-11-28 11:00", "till": "2025-11-28 19:00" },
>         { "from": "2025-11-29 11:00", "till": "2025-11-29 19:00" },
>         { "from": "2025-11-30 11:00", "till": "2025-11-30 17:00" }
>     ],
>     "level": "info",
>     "details": []
> }
> ```
>
> Event mit Uhrzeit:
> ```json
> {
>     "name": "Lagerfeuer am Kapellenfeld",
>     "locations": ["Kapellenfeld"],
>     "times": [{ "from": "2025-09-20 18:30", "till": "2025-09-20 21:00" }],
>     "level": "info",
>     "details": [
>         "Start is um 18.30 Uhr. Gerne selbstständig Grillgut und Getränke mitnehmen."
>     ]
> }
> ```

### Wichtige Felder

#### Feld `name`

Das ist der Name des Events und wird ganz oben groß angezeigt.

#### Felder in `times`: `from`, `till` **ODER** `on`

Das `times` Array kann mehrere from-till/on Elemente beinhalten, siehe oben.

Diese Felder beinhalten Daten, welche im Format `yyyy-MM-dd` (deutsch: `YYYY-MM-TT`) sind. Bei
jährlichen Events, kann man das Jahr durch ein `*` Sternchen ersetzen.

##### Zeitfenster

Bei einem Zeitfenster, wie oben im Beispiel, gibt es ein Start-Tag (`from`) und ein End-Tag (`till`).
Im obigen Beispiel heißt das, dass Weihnachten jedes Jahr vom *24.12.* bis zum *26.12.* stattfindet.

Zusätzlich kann eine Uhrzeit hinzugefügt werden, die in so fortmatiert ist:
`hh:mm` (deutsch: `SS:MM`, Stunde und Minute). Die Uhrzeit muss vom Datum durch ein Leerzeichen getrennt sein.

> **Beispiel:**
>
> `yyyy-MM-dd HH:mm` (Format) -> `2025-09-20 18:30` (Zeitpunkt)

##### Tagesevent

Ein Tagesevent ist, im Gegensatz zum Zeitfenster, ein Event, welches den **ganzen** Tag stattfindet.

Bei einem solchen Event werden die Felder `from` und `till` durch ein einziges Feld `on` ersetzt:
> **Beispiel:**
>
> ```json
> {
>     "name": "Heilig Abend",
>     "times": [{ "on": "*-12-24" }],
>     "level": "info",
>     "details": [
>         "Frohe Weihnachten!"
>     ]
> }
> ```

### Optionale Felder

#### Feld `level`

Das Feld `level` ist die Wichtigkeit des Events. Standartmäßig wird `level` zu `info` gesetzt und
kann weggelassen werden.

> **Alle levels in ansteigender Wichtigkeit:**
>
> * `info`: Standart-Level (Normale Events)
> * `warn`/`warning`/`warnung`: Warnung (Wichtige Events/Neuigkeiten)
>   * geänderte Öffnungszeiten
>   * Terminverschiebungen
>   * ...
> * `alert`/`alarm`/`achtung`: !!Achtung!! (Sehr wichtige Neuigkeiten)
>   * Katastrophen
>   * Starkes Umwetter
>   * ...

#### Feld `info`

> Nicht zu verwechseln mit dem `"level": "info"` Feld!

Hier kann ein optionaler Link eingefügt werden, der dem Leser mehr Informationen zu dem Event geben soll.

#### Feld `details`

Dieses Feld ist eine Liste mit Textzeilen, die den größten Teil des Events ausmacht.

> **Beispiel mit mehr Text in `details`:**
>
> ```json
> {
>     "name": "Event",
>     "times": [{ "on": "*-01-01" }],
>     "level": "info",
>     "details": [
>         "Frohes Neues Jahr!",
>         "Ich hoffe du hattest einen guten Rutsch :)"
>     ]
> }
> ```

Die zwei Linien werden auf eigenen Zeilen gezeigt.

#### Feld `locations`

Dies ist ein optionales Feld, wo man die Orte vermerken kann, die betroffen sind.

Diese Meldungen werden dann nicht nur im Newsfeed, sondern auf den jeweiligen Orten angezeigt.

> **Beispiel:**
>
> ```json
> {
>     "name": "MühlenMarkt geschlossen",
>     "locations": [
>         "MühlenMarkt", "Werkstatt-Laden im MühlenMarkt"
>     ],
>     "times": [{ "on": "2023-12-30" }],
>     "level": "warning",
>     "details": [
>         "MühlenMarkt hat heute Inventur."
>     ]
> }
> ```

## Gesundheitsbildung in `news-health.json`

Diese Datei beinhaltet eine Liste aller Termine der Gesundheitsbildungpräsentationen. Die Termine
sind anders strukturiert, da man sonst zu oft das Selbe tippen müsste.

> **Beispiel zur Orientierung:**
>
> ```json
> {
>     "topic": "Entspannung",
>     "desc": "Entspannung und Spannungsbewältigung",
>     "on": "2024-06-12",
>     "by": "Christina Igelmund"
> }
> ```
>
> Erscheint dann so ähnlich auf der Website:
>
> |                                                              | Gesundheitsbildung: Entspannung |     |
> |:-------------------------------------------------------------|:-------------------------------:|----:|
> |                                                              | am **Mittwoch, 12.06.2024**     |     |
> | von **13.00 - 14.00 Uhr** im **Festsaal** (Am Latterbach 13) |                                 |     |
> | zum Thema *"Entspannung und Spannungsbewältigung"*           |                                 |     |
> | *Geleitet von Christina Igelmund*                            |                                 |     |

### Wichtige Felder

#### Feld `topic`

*"Topic"* ist englisch für *"Thema"* und genau das ist es - das Thema der Präsentation.

#### Feld `on`

Hier befindet sich das Datum der Präsentation im üblichen `yyyy-MM-dd` (`YYYY-MM-TT`) Format.

> [!ATTENTION]
> Wichtig hier: Keine Uhrzeit eintragen, die ist nämlich immer fest!

### Optionale Felder

#### Feld `desc`

Dieses Feld ist eine detailiertere, verkürzte oder vereinfachte Themenangabe als das `topic` Feld.

#### Feld `by`

Dieses Feld ist der Name von dem Präsentationsleiter.
