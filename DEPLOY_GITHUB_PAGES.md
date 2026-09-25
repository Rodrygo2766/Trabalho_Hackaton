# Colocar a Nexa no GitHub Pages e testar cadastro real

O GitHub Pages hospeda apenas o **frontend estático**. Ele não executa NestJS e não hospeda PostgreSQL. Para o cadastro funcionar de verdade, use esta arquitetura:

**GitHub Pages (frontend) → backend NestJS público → PostgreSQL público**

## 1. PostgreSQL
Crie um PostgreSQL hospedado (por exemplo Neon, Supabase Postgres ou o banco do seu provedor) e execute o conteúdo de `database.sql` **sem repetir `CREATE DATABASE nexa;` se o provedor já criou o banco**.

Copie a connection string `postgresql://...` fornecida pelo provedor.

## 2. Backend
Publique este repositório em um host Node compatível. O arquivo `render.yaml` já deixa o projeto pronto para Render.

Configure as variáveis:
- `DATABASE_URL`: connection string do PostgreSQL
- `DB_SSL=true`
- `CORS_ORIGIN`: URL exata do seu GitHub Pages, por exemplo `https://SEU-USUARIO.github.io`

Depois do deploy, teste no navegador:
`https://SUA-API/api/v1/health`

A resposta deve indicar `status: ok` e `database: connected`.

## 3. Conectar o GitHub Pages à API
Abra `frontend/config.js` e troque:

```js
API_URL: 'http://localhost:3000/api/v1'
```

por:

```js
API_URL: 'https://SUA-API/api/v1'
```

Faça commit e push.

## 4. Ativar GitHub Pages
No GitHub, abra **Settings → Pages → Build and deployment → Source** e escolha **GitHub Actions**.

O workflow `.github/workflows/pages.yml` publica automaticamente a pasta `frontend` a cada push na branch `main`.

## 5. Testar pelo site
Abra a URL do GitHub Pages, clique em **Criar conta**, preencha os campos e envie. Se der certo, a interface mostra “Conta criada com sucesso!” e entra automaticamente na Nexa.

Depois clique em sair e tente entrar novamente com o mesmo e-mail e senha. Isso confirma que a conta persistiu no PostgreSQL, e não apenas no navegador.

### Senha de teste
A API exige pelo menos 8 caracteres, com letra maiúscula, minúscula e número. Exemplo: `Nexa1234`.

## Segurança
Nunca coloque `DATABASE_URL`, senha do PostgreSQL ou outras credenciais em `frontend/config.js`, no HTML ou no GitHub Pages. O navegador conhece apenas a URL pública da API.
