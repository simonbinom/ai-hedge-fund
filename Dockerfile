FROM python:3.12-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl build-essential git libffi-dev \
    && apt-get clean

# Install poetry
ENV POETRY_VERSION=1.8.5
RUN curl -sSL https://install.python-poetry.org | python3 - \
 && ln -s /root/.local/bin/poetry /usr/local/bin/poetry

# Set working directory
WORKDIR /app

# Copy project files
COPY pyproject.toml poetry.lock* ./
RUN poetry config virtualenvs.create false \
 && poetry install --no-interaction --no-ansi
 COPY . .

# Start the application in the container
ENTRYPOINT ["poetry", "run", "python", "src/main.py"]
CMD ["--ticker", "AAPL,MSFT,NVDA", "--show-reasoning"]