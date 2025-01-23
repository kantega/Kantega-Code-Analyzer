# Kantega Code Analyzer

## OBS: Dette er et eksperimentelt verktøy og er under utvikling. Vennligst lag en issue eller kontakt oss om du har spørsmål eller tilbakemeldinger.

Her er et verktøy for å hjelpe deg å angripe et eksisterende prosjekt når du er ny i prosjektet.

* Steg 1:
Sjekk ut repoet.
* Steg 2: Kjør scriptet `source setup.sh` for å installere Kantega Code Analyzer. Da kan du kjøre kommandoen `kca_init` fra et hvilket som helst repo du vil analysere.
* Steg 3: Kjør `kca_hotspots` for å finne ut hvilke filer som endres ofte.

### Installasjon

Krever at man er på linux/mac eller kjører i Windows Subsystem for Linux (WSL) eller Git Bash på Windows.
```bash
source setup.sh
```

Du må ha python og pandas installert.

```bash
python3 -m venv venv
source venv/bin/activate
pip install pandas
pip install matplotlib
```

#### Docker

Hvis du ikke har lyst til å installere noe lokalt kan du kjøre kca i Docker.

```bash
docker build -t kca .
docker run -it kca
```




### Tilgjengelige kommandoer
* `kca_init` kjøres som første kommando i et nytt prosjekt. Den vil lage en gitlog-fil som brukes til videre analyse av prosjektet.

* `kca_hotspots` gir deg en liste over aktuelle **hotspots** i koden din. Hotspots er filer som er mye endret over tid.
  * Denne kommandoen resulterer i et png-bilde med en graf. Dersom du bruker docker, kan du hente ut bildet fra containeren med følgende kommando. Den vil da kopiere bildet til der du står nå:
  ```docker cp <container-id>:/app/.kca/hotspot_plot.png <dit du vil ha filen>```

* `kca_complexity` gir deg en oversikt over hvilke filer som har stor grad av kompleksitet, sammen med en oversikt over hvilke filer som endres mye.

### Hva sier dataen?

Verktøyet er basert på boken Your Code As A Crime Scene av Adam Tornhill, som vi i Backend Boklubb leste høsten 2024. Poenget med boken er å ta i bruk informasjon
utenom selve koden for å si noe om helsen til et koderepo. Her inneholder Git uvurderlig informasjon. 

#### Hotspots
Hotspots er komplekse filer som er endret mye. I boken argumenteres det for at disse filene er filene man burde starte med dersom man skal gjøre en refactoring av en applikasjon. 
Hotspots-analysen er også praktisk om man er ny på et team, ettersom den forteller hvilke filer det er lurt å sette seg inn i først. Hotspotanalysen bruker prosjektets git log for å
finne ut hvor ofte en fil endres. Kompleksitet er beregnet basert på antall linjer i en fil, dette kan virke snodig, men forfatteren av boken argumenterer med at antall linjer i en fil 
er et like bra (eller like dårlig) tall på kompleksitet, som andre populære målestokker som syklomatisk kompleksitet. Disse to filene for kompleksitet og revisjoner slås så sammen til en
hotspot-analyse. 

#### Complexity
Kompleksitetsgrafen viser en enkelt fil, og hvordan den har endret seg i kompleksitet over tid. Her brukes antall innrykk som kompleksitetsfaktor, som forfatteren av boken også argumenterte for
var en god metrikk. Grafen bør kunne gjøre det tydelig når det ble innført kompleksitet, i tillegg til når det ble gjort refactoring for å få ned kompleksiteten. 