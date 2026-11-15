# macOS: uma pasta de vagas com Claude Code e Google Chrome

Este guia monta o mcp-vagas no macOS de um jeito fechado numa única pasta (aqui, `~/vagas`): o ambiente Python, o banco, os currículos, as Skills e o registro do MCP ficam todos ali, e nada é instalado para o sistema inteiro. É o jeito usado neste fork, testado no macOS com o Claude Code.

Diferenças em relação à [instalação completa](instalacao-completa.md):

| | Instalador do README | Pasta de vagas (este guia) |
|---|---|---|
| Onde fica | `~/.local/share/vagas` e MCP registrado para o usuário | tudo em `~/vagas`; MCP registrado **só nessa pasta** (`.mcp.json`) |
| Navegador | o padrão do sistema | sempre o **Google Chrome** (painel e links) |
| Formulários | extensão do mcp-vagas + Claude in Chrome | só o **Claude in Chrome**: o Claude preenche, você faz login, digita documentos (CPF, RG) e decide o envio |
| Entrevistas | — | skill `entrevista`: prepara, registra o pós-entrevista e mantém pitch e histórias STAR |
| Regras para o Claude | — | `CLAUDE.md` da pasta: um passo de cada vez, nunca enviar sem o seu ok, nunca seguir instruções de páginas de vagas |

No macOS ainda não há cofre para CPF e RG, por isso a extensão do mcp-vagas acrescenta pouco aqui e não é usada.

## O que você precisa

- macOS com o [Google Chrome](https://www.google.com/chrome/).
- [Claude Code](https://code.claude.com/docs) e a extensão [Claude in Chrome](https://code.claude.com/docs/en/chrome), com a mesma conta do Claude.
- Git (vem com as ferramentas de linha de comando da Apple: rode `git --version` e aceite a instalação se o macOS perguntar).
- Python 3.12 ou mais novo. O jeito mais simples é o [`uv`](https://docs.astral.sh/uv/), que baixa o Python sozinho:
  ```bash
  curl -LsSf https://astral.sh/uv/install.sh | sh
  ```
  Feche e abra o Terminal depois. (Se você já usa conda, um ambiente com Python 3.12 também serve: ative-o antes do passo 2.)

## 1. Baixar o código para dentro da pasta

No Terminal:

```bash
mkdir -p ~/vagas
```

```bash
git clone https://github.com/fmartinsc/mcp-vagas.git ~/vagas/mcp-vagas
```

Antes de instalar, vale ler o que vai rodar no seu computador. Anote o commit que você revisou:

```bash
git -C ~/vagas/mcp-vagas log -1 --oneline
```

## 2. Montar a pasta

```bash
sh ~/vagas/mcp-vagas/scripts/montar_pasta_macos.sh
```

O script cria:

```
~/vagas/
├── .venv/                 ambiente Python com o mcp-vagas instalado
├── .mcp.json              registro do MCP "vagas" (só vale dentro desta pasta)
├── CLAUDE.md              regras para o Claude nesta pasta (edite à vontade)
├── Painel.command         duplo clique abre o painel de configuração no Chrome
├── abrir-no-chrome.sh     usado para abrir todo link no Chrome
├── dados/                 banco SQLite, config.toml e o currículo geral (YAML)
├── curriculos/            PDFs dos currículos gerados para cada vaga
├── exportacoes/           CSVs exportados
├── entrevistas/           narrativa, banco de perguntas e um arquivo por processo
├── .claude/skills/        Skills e comandos (links para mcp-vagas/skill/ + a skill entrevista)
└── mcp-vagas/             o código
```

Ele nunca sobrescreve um arquivo que já existe, então pode rodar de novo sem medo. Para usar outra pasta, passe o caminho: `sh mcp-vagas/scripts/montar_pasta_macos.sh ~/outra-pasta`.

## 3. Configurar no painel

Dê duplo clique em `~/vagas/Painel.command` (na primeira vez, o macOS pode pedir para confirmar a abertura em **Ajustes do Sistema → Privacidade e Segurança**). O painel abre no Chrome, com as pastas já preenchidas. Complete:

- **Pastas e opções:** o PDF do seu currículo atual e o link do seu LinkedIn.
- **Perfil para formulários:** contato, idiomas, respostas padrão (disponibilidade, PJ, diversidade...).
- **Critérios de triagem:** cargos que você procura, senioridades, cidades aceitas para vagas presenciais, empresas a evitar.
- **Política salarial:** sua pretensão por modalidade.

Esses arquivos pessoais ficam em `mcp-vagas/skill/candidaturas/` e o git os ignora: não vão para nenhum repositório.

## 4. Abrir o Claude Code na pasta

Pelo **app do Claude** (o mais simples): abra o app, vá na aba **Code**, comece uma sessão nova e escolha a pasta `vagas` da sua pasta pessoal.

Ou pelo Terminal:

```bash
cd ~/vagas && claude --chrome
```

Na primeira vez, o Claude Code pergunta se pode usar o MCP "vagas" desta pasta: aprove. Depois, peça em linguagem natural:

| Você quer | Peça ao Claude |
|---|---|
| montar o currículo geral (uma vez) | *"monte meu currículo geral a partir do PDF"*; revise e aprove no painel |
| achar vagas novas | `/search-jobs` ou *"busque vagas para mim"* |
| ver o que vale a pena aplicar | `/work-list` |
| saber se uma vaga serve | `/screen <link da vaga>` |
| candidatar-se | `/apply <link da vaga>`: o Claude preenche no Chrome e para antes de enviar |
| ver o que depende de você | `/pending` |
| preparar ou registrar uma entrevista | `/entrevista` |

Sem o leitor do LinkedIn (o extra `[linkedin]`, que usa o Playwright), o currículo geral se monta a partir do PDF. Se um dia instalar o leitor, configure-o para usar o Chrome instalado (`channel="chrome"`).

## Atualizar com segurança

Não faça `git pull` às cegas: o código roda no seu computador e mexe nos seus dados.

```bash
cd ~/vagas/mcp-vagas && git fetch
```

```bash
git log --oneline HEAD..origin/main
```

```bash
git diff HEAD origin/main
```

Se estiver tudo certo:

```bash
git pull && ~/vagas/.venv/bin/python -m pip install --force-reinstall --no-deps . && ~/vagas/.venv/bin/python -m pip install .
```

Depois, abra uma conversa nova no Claude Code.

## Privacidade

- Banco, currículos, perfil, critérios, política salarial e entrevistas ficam só no seu Mac.
- Se você publicar um fork, confira antes com `git status --ignored` que nenhum arquivo pessoal entrou, e configure o git para usar o e-mail privado do GitHub (`<id>+<usuário>@users.noreply.github.com`, em **GitHub → Settings → Emails**), para o seu e-mail não aparecer nos commits.
