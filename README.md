# Enterprise Boilerplate

Este é um projeto de arquitetura sênior demonstrando um sistema escalável, seguro e multi-tenant.

## Tecnologias Utilizadas

- **Backend:** Django Rest Framework (DRF)
- **Frontend:** Next.js (App Router)
- **Banco de Dados:** PostgreSQL (via Docker)
- **Autenticação:** JWT (Simple JWT) com Refresh Tokens
- **Documentação:** Swagger/OpenAPI (drf-spectacular)
- **Testes:** Pytest
- **Containerização:** Docker & Docker Compose
- **CI/CD:** GitHub Actions (Linter + Tests)

## Como rodar o projeto

Certifique-se de ter o Docker e o Docker Compose instalados.

```bash
docker-compose up --build
```

A API estará disponível em `http://localhost:8000` e o Frontend em `http://localhost:3000`.

## Documentação da API

Acesse a documentação interativa em:
- Swagger UI: `http://localhost:8000/api/docs/`
- Redoc: `http://localhost:8000/api/redoc/`

## Testes

Para rodar os testes localmente (dentro do container backend):

```bash
docker-compose exec backend pytest
```

## Estrutura do Projeto

- `/backend`: Código fonte do Django.
- `/frontend`: Código fonte do Next.js.
- `.github/workflows`: Configurações de CI/CD.
- `docker-compose.yml`: Orquestração dos serviços.
