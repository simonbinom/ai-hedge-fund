FROM python:3.9-slim

# Arbeitsverzeichnis im Container setzen
WORKDIR /app

# Poetry installieren
RUN pip install poetry==1.7.1

# Kopieren der Poetry-Konfigurationsdateien
COPY pyproject.toml poetry.lock ./

# Poetry so konfigurieren, dass es keine virtuelle Umgebung erstellt
RUN poetry config virtualenvs.create false

# Abhängigkeiten installieren
RUN poetry install --no-interaction --no-ansi

# Kopieren des Anwendungscodes
COPY src ./src
COPY .env.example ./.env.example

# Umgebungsvariablen für API-Schlüssel (können beim Container-Start überschrieben werden)
ENV ANTHROPIC_API_KEY=""
ENV DEEPSEEK_API_KEY=""
ENV GROQ_API_KEY=""
ENV GOOGLE_API_KEY=""
ENV FINANCIAL_DATASETS_API_KEY=""
ENV OPENAI_API_KEY=""

# Startbefehl
CMD ["python", "src/main.py"]
