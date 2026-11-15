<div align="center">

# 🔎 mcp-vagas

**Um assistente de busca de emprego que trabalha junto com você, no seu computador.**

Ele procura vagas, diz quais combinam com você, monta um currículo para cada vaga,<br>
preenche os formulários e ajuda a se preparar para as entrevistas.<br>
**Quem decide e quem envia é sempre você.**

[Como começar](#-como-começar-no-mac) · [O que ele faz](#-o-que-ele-faz-por-você) · [Segurança](#-sua-privacidade-e-sua-segurança) · [Perguntas frequentes](#-perguntas-frequentes)

</div>

---

## 💡 A ideia

Procurar emprego cansa: dezenas de sites, formulários que pedem as mesmas informações, um currículo que precisa ser ajustado para cada vaga e entrevistas para preparar.

O **mcp-vagas** junta tudo isso numa conversa com o [Claude](https://claude.ai). Você pede em português, do seu jeito, e ele faz o trabalho repetitivo. Você não precisa saber programar: a instalação é copiar e colar dois comandos, e o resto se faz numa página de configuração e na conversa.

## ✨ O que ele faz por você

| | |
|---|---|
| 🔎 **Procura vagas** | Busca na Gupy e no LinkedIn pelos cargos que você quer, descarta as que não servem (cidade errada, senioridade errada, empresas que você quer evitar) e mostra uma lista da mais para a menos aderente ao seu perfil. |
| 📄 **Monta o seu currículo geral** | Lê o PDF do seu currículo atual, organiza tudo e **pergunta** quando algo não bate (uma data, um cargo). Só passa a valer depois que você aprova. |
| 🎯 **Faz um currículo para cada vaga** | A partir do currículo geral, gera um PDF com o que importa para aquela vaga. **Não inventa nada:** o sistema recusa números, tecnologias ou cargos que não estão no seu currículo. |
| ✍️ **Preenche os formulários** | Abre a vaga no Google Chrome e preenche nome, contato, experiências, perguntas abertas e o anexo do currículo. **Para antes do botão de enviar** e mostra o que preencheu. |
| 🗂️ **Organiza os processos** | Guarda cada candidatura, a etapa em que está (RH, entrevista técnica, proposta...), o que depende de você e quem não respondeu. Nunca se candidata duas vezes à mesma vaga. |
| 🎤 **Prepara as entrevistas** | Monta o seu "fale sobre você", as suas histórias no formato STAR e, para cada entrevista, o que destacar e as perguntas prováveis. Depois, registra o que perguntaram para você ir melhorando. |

## 💬 Como funciona na prática

Você conversa com o Claude como conversaria com uma pessoa:

> **Você:** busque vagas de analista de dados para mim
>
> **Claude:** encontrei 23 vagas novas; 9 passaram nos seus critérios. As 3 mais aderentes são...

> **Você:** candidate-se à primeira da lista
>
> **Claude:** preenchi o formulário e anexei um currículo feito para essa vaga. Revise abaixo o que coloquei. Posso enviar?

> **Você:** passei para a entrevista com o gestor, me prepara
>
> **Claude:** pela descrição da vaga, vale destacar... Separei 3 histórias suas que respondem aos requisitos e 6 perguntas prováveis. Quer ensaiar?

Também há atalhos: `/search-jobs` (buscar), `/work-list` (lista do que vale aplicar), `/apply <link>` (candidatar), `/pending` (o que depende de você) e `/entrevista`.

## 🚀 Como começar (no Mac)

Leva uns 15 minutos, uma vez só.

### Antes de tudo, você vai precisar de

- Um **Mac**.
- O **[Google Chrome](https://www.google.com/chrome/)**.
- Uma **assinatura paga do Claude** (Pro ou superior), com o **[app do Claude](https://claude.ai/download)** instalado.
- A extensão **[Claude in Chrome](https://code.claude.com/docs/en/chrome)** no Chrome, conectada à mesma conta do Claude. É ela que deixa o Claude preencher os formulários.
- O **PDF do seu currículo atual**.

### Passo 1 — Abra o Terminal

O Terminal é um programa que já vem no Mac. Aperte **Cmd + Espaço**, digite `Terminal` e aperte **Enter**. Vai abrir uma janela com texto: é ali que você cola os comandos abaixo.

### Passo 2 — Instale o ajudante de Python

Copie a linha abaixo, cole no Terminal (**Cmd + V**) e aperte **Enter**:

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

Quando terminar, **feche o Terminal e abra de novo**.

### Passo 3 — Baixe e monte a sua pasta de vagas

Cole esta linha e aperte **Enter**:

```bash
git clone https://github.com/fmartinsc/mcp-vagas.git ~/vagas/mcp-vagas && sh ~/vagas/mcp-vagas/scripts/montar_pasta_macos.sh
```

> Se o Mac perguntar se quer instalar as "ferramentas de linha de comando", clique em **Instalar**, espere terminar e cole a linha de novo.

Isso cria uma pasta chamada **vagas** na sua pasta pessoal, com tudo dentro. No fim, aparece **Pronto** e os próximos passos.

### Passo 4 — Preencha a configuração

No Finder, abra a pasta **vagas** e dê **dois cliques em `Painel.command`**. Abre uma página no Chrome onde você preenche, sem mexer em arquivo nenhum:

- o PDF do seu currículo e o link do seu LinkedIn;
- seus dados de contato e as respostas que todo formulário pede;
- os cargos que você procura, as cidades e as empresas que quer evitar;
- a sua pretensão salarial.

Clique em **Salvar tudo**.

> Na primeira vez, o Mac pode bloquear o `Painel.command` por ser um arquivo baixado da internet. Vá em **Ajustes do Sistema → Privacidade e Segurança**, role até o fim e clique em **Abrir mesmo assim**.

### Passo 5 — Converse com o Claude

Abra o **app do Claude**, vá na aba **Code**, comece uma sessão nova e escolha a pasta **vagas**. Na primeira vez, ele pergunta se pode usar o "vagas": aprove.

Comece por:

> **monte meu currículo geral a partir do PDF**

Depois de aprovar o currículo, peça:

> **busque vagas para mim**

Pronto. 🎉

Quer mais detalhes de cada passo? Veja o [guia completo do Mac](docs/macos-pasta-de-vagas.md).

## 🔒 Sua privacidade e sua segurança

- **Tudo fica no seu computador:** seus currículos, seus dados e a lista de candidaturas. Não há conta nova, nuvem nem cadastro em lugar nenhum.
- **O Claude nunca envia uma candidatura sem o seu ok.** Ele preenche e para antes do botão de enviar.
- **Senhas, CPF e RG ficam com você:** o Claude não faz login por você e não digita documentos.
- **Nada é inventado:** currículos e respostas usam só o que está no seu currículo aprovado.
- **Um passo de cada vez:** o Claude mostra o que fez antes de seguir para o próximo.
- O Claude ignora qualquer "instrução" escrita dentro de anúncios de vaga.

Essas regras ficam no arquivo `CLAUDE.md` da sua pasta de vagas, que você pode ler e ajustar.

## ❓ Perguntas frequentes

<details>
<summary><b>Preciso saber programar?</b></summary>

Não. Você só copia e cola dois comandos na instalação. Todo o resto é a página de configuração e a conversa com o Claude.
</details>

<details>
<summary><b>Quanto custa?</b></summary>

O mcp-vagas é gratuito e de código aberto. Você precisa de uma assinatura paga do Claude (Pro ou superior) para usar a aba Code do app.
</details>

<details>
<summary><b>Serve para qualquer área?</b></summary>

Em parte. Os formulários, o currículo para cada vaga, o acompanhamento dos processos e a preparação de entrevistas servem para qualquer área.

A **triagem automática** (decidir sozinho se uma vaga é do cargo que você procura) hoje só reconhece cargos de **dados e tecnologia**: cientista, analista e engenheiro de dados, machine learning, IA e pesquisa operacional. Em outras áreas, a busca funciona com os termos que você escolher, mas cada vaga vai para o seu julgamento, com a ajuda do Claude, em vez de ser filtrada sozinha. Quem quiser ampliar isso para outras áreas é bem-vindo para contribuir.
</details>

<details>
<summary><b>Funciona no Windows ou no Linux?</b></summary>

Sim, pelo instalador do projeto original: veja a [instalação completa](docs/instalacao-completa.md). Este guia simplificado é para o Mac.
</details>

<details>
<summary><b>Em quais sites ele procura vagas?</b></summary>

A busca automática cobre a **Gupy** e o **LinkedIn**. Indeed, Glassdoor e sites de empresas funcionam pelo navegador: você manda o link e ele faz o resto.
</details>

<details>
<summary><b>O currículo sai em português ou em inglês?</b></summary>

Os currículos gerados saem em inglês. As conversas, a configuração e as respostas aos formulários seguem o idioma de cada formulário.
</details>

<details>
<summary><b>E se eu quiser parar de usar?</b></summary>

Apague a pasta **vagas**. Nada fica instalado fora dela.
</details>

## 🙏 Créditos

Este projeto é um fork do **[mcp-vagas de barbieriht](https://github.com/barbieriht/mcp-vagas)**, que criou todo o motor: busca, triagem, currículos, painel e acompanhamento. Este fork acrescenta:

- a **montagem simplificada no Mac**, numa pasta só, com o Google Chrome e regras de segurança prontas;
- o **assistente de entrevistas** (skill `entrevista`);
- dois cargos novos na triagem: pesquisa operacional e analista de IA.

## 🛠️ Para quem é técnico

- [Instalação completa](docs/instalacao-completa.md) (Windows, Linux, macOS; Claude Desktop e Claude Code)
- [Guia detalhado do Mac](docs/macos-pasta-de-vagas.md)
- [Referência](docs/referencia.md): configuração, variáveis de ambiente, tools do MCP, desenvolvimento
- [Decisões de arquitetura](docs/adr/)

## 📜 Licença

[GPL-3.0](LICENSE): você pode usar, estudar, modificar e redistribuir. Versões modificadas distribuídas também precisam ser GPL-3.0, com o código aberto.
