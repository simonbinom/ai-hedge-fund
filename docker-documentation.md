# Docker-Setup für ai-hedge-fund

Diese Dokumentation beschreibt die vollständige Docker-Konfiguration für das ai-hedge-fund Projekt.

## Übersicht der Dateien

- `Dockerfile`: Definiert das Docker-Image für die Anwendung
- `docker-compose.yml`: Vereinfacht die Bereitstellung mit Docker Compose
- `build-instructions.md`: Detaillierte Anleitung zum Bauen und Ausführen des Docker-Containers

## Dockerfile-Erklärung

Die Dockerfile verwendet Python 3.9 als Basis und richtet die Anwendung wie folgt ein:

```dockerfile
FROM python:3.9-slim

# Arbeitsverzeichnis im Container setzen
WORKDIR /app

# Poetry installieren
RUN pip install poetry==1.7.1

# Kopieren der Poetry-Konfigurationsdateien
COPY ai-hedge-fund/pyproject.toml ai-hedge-fund/poetry.lock ./

# Poetry so konfigurieren, dass es keine virtuelle Umgebung erstellt
RUN poetry config virtualenvs.create false

# Abhängigkeiten installieren
RUN poetry install --no-interaction --no-ansi

# Kopieren des Anwendungscodes
COPY ai-hedge-fund/src ./src
COPY ai-hedge-fund/.env.example ./.env.example

# Umgebungsvariablen für API-Schlüssel (können beim Container-Start überschrieben werden)
ENV ANTHROPIC_API_KEY=""
ENV DEEPSEEK_API_KEY=""
ENV GROQ_API_KEY=""
ENV GOOGLE_API_KEY=""
ENV FINANCIAL_DATASETS_API_KEY=""
ENV OPENAI_API_KEY=""

# Startbefehl
CMD ["python", "src/main.py"]
```

## Verwendung mit Docker Compose

Docker Compose vereinfacht die Bereitstellung durch Automatisierung der Container-Erstellung und -Konfiguration.

### Voraussetzungen

- Docker und Docker Compose auf Ihrem System installiert
- Das ai-hedge-fund Repository geklont oder heruntergeladen

### Einrichtung

1. Kopieren Sie die `docker-compose.yml` in das Hauptverzeichnis des Projekts:

```bash
cp docker-setup/docker-compose.yml ai-hedge-fund/
```

2. Erstellen Sie eine `.env`-Datei basierend auf der `.env.example`:

```bash
cd ai-hedge-fund
cp .env.example .env
```

3. Bearbeiten Sie die `.env`-Datei und fügen Sie Ihre API-Schlüssel ein.

### Starten mit Docker Compose

Navigieren Sie zum Projektverzeichnis und führen Sie aus:

```bash
docker-compose up
```

Oder im Hintergrund:

```bash
docker-compose up -d
```

### Stoppen des Containers

```bash
docker-compose down
```

## Vorteile der Docker-Compose-Methode

- Einfachere Konfiguration durch die `.env`-Datei
- Automatische Volumen-Einrichtung für Datenpersistenz
- Einfaches Starten und Stoppen mit einem Befehl
- Bessere Isolation der Anwendungsumgebung

## Anpassungsmöglichkeiten

### Anpassen des Basis-Images

Wenn Sie eine andere Python-Version benötigen, ändern Sie die erste Zeile der Dockerfile:

```dockerfile
FROM python:3.10-slim
```

### Hinzufügen weiterer Abhängigkeiten

Wenn Sie zusätzliche Systemabhängigkeiten benötigen, können Sie diese in der Dockerfile installieren:

```dockerfile
RUN apt-get update && apt-get install -y \
    package-name \
    another-package \
    && rm -rf /var/lib/apt/lists/*
```

### Anpassen der Volumen

In der `docker-compose.yml` können Sie weitere Volumen hinzufügen:

```yaml
volumes:
  - ./data:/app/data
  - ./custom_models:/app/custom_models
```

## Fehlerbehebung

### Container startet nicht

Überprüfen Sie die Logs mit:

```bash
docker-compose logs
```

### Probleme mit API-Schlüsseln

Stellen Sie sicher, dass die `.env`-Datei korrekt formatiert ist und keine Leerzeichen um die Gleichheitszeichen enthält.

### Build-Fehler

Versuchen Sie einen Clean-Build:

```bash
docker-compose build --no-cache
```
