# Docker Build Anleitung für ai-hedge-fund (Aktualisiert)

Diese Anleitung beschreibt, wie Sie das ai-hedge-fund Repository in einem Docker Container ausführen können.

## Voraussetzungen

- Docker installiert auf Ihrem System
- Git installiert auf Ihrem System (optional, wenn Sie das Repository direkt herunterladen)

## Schritt 1: Repository klonen

Wenn Sie das Repository noch nicht haben, klonen Sie es mit:

```bash
git clone https://github.com/virattt/ai-hedge-fund.git
cd ai-hedge-fund
```

## Schritt 2: Dockerfile in das Repository kopieren

Kopieren Sie die Dockerfile in das Hauptverzeichnis des ai-hedge-fund Repositories:

```bash
# Angenommen, die Dockerfile befindet sich im aktuellen Verzeichnis
cp Dockerfile /pfad/zum/ai-hedge-fund/
```

## Schritt 3: Docker Image bauen

Navigieren Sie zum Hauptverzeichnis des ai-hedge-fund Repositories und führen Sie den Build-Befehl aus:

```bash
cd /pfad/zum/ai-hedge-fund/
docker build -t ai-hedge-fund .
```

Dieser Prozess kann einige Minuten dauern, da alle Abhängigkeiten installiert werden müssen.

## Schritt 4: Umgebungsvariablen konfigurieren

Erstellen Sie eine `.env`-Datei mit Ihren API-Schlüsseln. Sie können die `.env.example`-Datei als Vorlage verwenden:

```bash
cp .env.example .env
```

Bearbeiten Sie dann die `.env`-Datei und fügen Sie Ihre API-Schlüssel ein:

```
ANTHROPIC_API_KEY=your-anthropic-api-key
DEEPSEEK_API_KEY=your-deepseek-api-key
GROQ_API_KEY=your-groq-api-key
GOOGLE_API_KEY=your-google-api-key
FINANCIAL_DATASETS_API_KEY=your-financial-datasets-api-key
OPENAI_API_KEY=your-openai-api-key
```

## Schritt 5: Docker Container starten

Starten Sie den Container mit:

```bash
docker run -it --env-file .env ai-hedge-fund
```

Alternativ können Sie die Umgebungsvariablen direkt beim Start übergeben:

```bash
docker run -it \
  -e ANTHROPIC_API_KEY=your-anthropic-api-key \
  -e DEEPSEEK_API_KEY=your-deepseek-api-key \
  -e GROQ_API_KEY=your-groq-api-key \
  -e GOOGLE_API_KEY=your-google-api-key \
  -e FINANCIAL_DATASETS_API_KEY=your-financial-datasets-api-key \
  -e OPENAI_API_KEY=your-openai-api-key \
  ai-hedge-fund
```

## Wichtiger Hinweis zur Verzeichnisstruktur

Die Dockerfile muss sich im Hauptverzeichnis des ai-hedge-fund Repositories befinden, damit die Pfade zu den Dateien korrekt sind. Die Dockerfile erwartet, dass folgende Dateien im aktuellen Verzeichnis vorhanden sind:

- `pyproject.toml` und `poetry.lock` (für die Abhängigkeiten)
- `src/` Verzeichnis (für den Anwendungscode)
- `.env.example` (als Vorlage für die Umgebungsvariablen)

## Fehlerbehebung

- Wenn Sie die Fehlermeldung "failed to calculate checksum of ref ... not found" erhalten, stellen Sie sicher, dass die Dockerfile im Hauptverzeichnis des ai-hedge-fund Repositories liegt und der Build-Befehl auch von diesem Verzeichnis aus ausgeführt wird.
- Wenn Sie Probleme mit dem Zugriff auf die API-Schlüssel haben, stellen Sie sicher, dass die Umgebungsvariablen korrekt gesetzt sind.
- Wenn Sie Probleme mit dem Build-Prozess haben, versuchen Sie, das Image mit dem `--no-cache`-Flag neu zu bauen: `docker build --no-cache -t ai-hedge-fund .`
