# Kantega Code Analyzer

Vi ønsker å tilby et verktøy for å angripe nye prosjekter.

* Steg 1:
Sjekk ut repoet.
* Steg 2: Kjør scriptet `source setup.sh` for å installere Kantega Code Analyzer. Da kan du kjøre kommandoen `kca_init` fra et hvilket som helst repo du vil analysere.

### Installasjon

Krever at man er på linux/mac eller kjører i Windows Subsystem for Linux (WSL) eller Git Bash på Windows.
```bash
source setup.sh
```

Use docker to run the code analyzer.

```bash
docker build -t kca .
docker run -it kca
```

Alternatively, you can install the code analyzer locally.

You need to have python and pandas installed.

```bash
# Create a virtual environment
python3 -m venv venv
source venv/bin/activate
pip install pandas
```




### Tilgjengelige kommandoer
* `kca_init` kjøres som første kommando i et nytt prosjekt. Den vil lage en gitlog-fil som brukes til videre analyse av prosjektet.

* `kca_hotspots` gir deg en liste over aktuelle **hotspots** i koden din. Hotspots er filer som er mye endret over tid.

* `kca_complexity` gir deg en oversikt over hvilke filer som har stor grad av kompleksitet, sammen med en oversikt over hvilke filer som endres mye.

