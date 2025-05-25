FROM python:3.11-slim AS builder

# Instalação do poetry
RUN pip3 install poetry==2.1.0
WORKDIR /app
COPY pyproject.toml poetry.lock /app

# Criação do ambiente virtual 
ENV POETRY_NO_INTERACTION=1 \
POETRY_VIRTUALENVS_IN_PROJECT=1 \
POETRY_VIRTUALENVS_CREATE=true \
POETRY_CACHE_DIR=/tmp/poetry_cache

# Instalação das dependências
RUN --mount=type=cache,target=/tmp/poetry_cache poetry install --only main --no-root
RUN poetry install --no-root

FROM python:3.11-slim AS runner
WORKDIR /app
COPY ./app /app
COPY --from=builder /app/.venv /app/.venv
ENV PATH="/app/.venv/bin:$PATH"

EXPOSE 8000

CMD [ "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000" ]