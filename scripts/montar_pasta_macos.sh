#!/bin/sh
# Monta uma "pasta de vagas" no macOS para usar o mcp-vagas com o Claude Code e o Google Chrome.
#
# Uso (com o repositório clonado dentro da pasta de vagas, ex.: ~/vagas/mcp-vagas):
#   sh ~/vagas/mcp-vagas/scripts/montar_pasta_macos.sh            # pasta = a que contém o repositório
#   sh ~/vagas/mcp-vagas/scripts/montar_pasta_macos.sh ~/outra    # pasta escolhida
#
# O que faz: cria o ambiente Python em <pasta>/.venv com o pacote instalado (sem modo editável),
# cria as pastas de dados, registra o MCP "vagas" só nesta pasta (.mcp.json), cria o Painel.command,
# o CLAUDE.md com as regras, a skill de entrevistas e os links das Skills do mcp-vagas.
# Nunca sobrescreve um arquivo que já existe: pode rodar de novo sem medo.
set -eu

REPO="$(cd "$(dirname "$0")/.." && pwd)"
PASTA="${1:-$(dirname "$REPO")}"
mkdir -p "$PASTA"
PASTA="$(cd "$PASTA" && pwd)"
MODELOS="$REPO/modelos/pasta-de-vagas"
VENV="$PASTA/.venv"
PY="$VENV/bin/python"

passo() { printf '\n==> %s\n' "$1"; }

[ "$(uname)" = "Darwin" ] || { echo "Este script é para macOS. Em Linux e Windows, use os instaladores do README." >&2; exit 1; }
[ -d "/Applications/Google Chrome.app" ] || echo "Aviso: não achei o Google Chrome em /Applications. Instale-o antes de usar o painel e os formulários."

passo "Pasta de vagas: $PASTA (repositório: $REPO)"

passo "Ambiente Python em $VENV"
if [ ! -x "$PY" ]; then
  if command -v uv >/dev/null 2>&1; then
    uv venv -q -p 3.12 "$VENV"
    uv pip install -q --python "$PY" pip
  else
    BASE=""
    for c in python3.12 python3.13 python3; do
      if command -v "$c" >/dev/null 2>&1 && "$c" -c 'import sys; sys.exit(0 if sys.version_info >= (3, 12) else 1)'; then
        BASE="$c"; break
      fi
    done
    [ -n "$BASE" ] || { echo "Preciso do Python 3.12 ou mais novo. Instale o uv (https://docs.astral.sh/uv/) e rode de novo." >&2; exit 1; }
    "$BASE" -m venv "$VENV"
  fi
fi
"$PY" -m pip install -q --disable-pip-version-check --upgrade --force-reinstall --no-deps "$REPO"
"$PY" -m pip install -q --disable-pip-version-check "$REPO"

passo "Pastas de dados"
mkdir -p "$PASTA/dados" "$PASTA/curriculos" "$PASTA/exportacoes" "$PASTA/entrevistas/processos" "$PASTA/.claude/skills"

# Copia um modelo trocando __PASTA__, __REPO__ e __PYTHON__, só se o destino ainda não existir.
modelo() {
  if [ -e "$2" ]; then echo "  já existe, mantido: $2"; return; fi
  "$PY" - "$1" "$2" "$PASTA" "$REPO" "$PY" <<'EOF'
import sys, pathlib
src, dst, pasta, repo, py = sys.argv[1:]
text = pathlib.Path(src).read_text(encoding="utf-8")
text = text.replace("__PASTA__", pasta).replace("__REPO__", repo).replace("__PYTHON__", py)
pathlib.Path(dst).write_text(text, encoding="utf-8")
EOF
  echo "  criado: $2"
}

passo "Arquivos da pasta"
modelo "$MODELOS/mcp.json.example" "$PASTA/.mcp.json"
modelo "$MODELOS/Painel.command.example" "$PASTA/Painel.command"
modelo "$MODELOS/abrir-no-chrome.sh" "$PASTA/abrir-no-chrome.sh"
modelo "$MODELOS/CLAUDE.md.example" "$PASTA/CLAUDE.md"
chmod +x "$PASTA/Painel.command" "$PASTA/abrir-no-chrome.sh"

passo "Entrevistas"
modelo "$MODELOS/entrevistas/narrativa.md" "$PASTA/entrevistas/narrativa.md"
modelo "$MODELOS/entrevistas/banco-de-perguntas.md" "$PASTA/entrevistas/banco-de-perguntas.md"
modelo "$MODELOS/entrevistas/processos/_modelo.md" "$PASTA/entrevistas/processos/_modelo.md"

passo "Skills do Claude Code (.claude/skills)"
mkdir -p "$PASTA/.claude/skills/entrevista"
modelo "$MODELOS/skills/entrevista/SKILL.md" "$PASTA/.claude/skills/entrevista/SKILL.md"
ligar() {
  if [ -e "$2" ] || [ -L "$2" ]; then echo "  já existe, mantido: $2"; else ln -s "$1" "$2"; echo "  ligado: $2"; fi
}
ligar "$REPO/skill/candidaturas" "$PASTA/.claude/skills/candidaturas"
for d in "$REPO"/skill/comandos/*/; do
  nome="$(basename "$d")"
  ligar "$REPO/skill/comandos/$nome" "$PASTA/.claude/skills/$nome"
done

passo "Pronto"
cat <<EOF
Próximos passos:
  1. Configure tudo no painel: duplo clique em $PASTA/Painel.command
     (pastas já vêm preenchidas; complete perfil, critérios de triagem e política salarial).
  2. Abra o Claude Code nesta pasta:  cd "$PASTA" && claude --chrome
     Na primeira vez, aprove o MCP "vagas" quando ele perguntar.
  3. Peça: "monte meu currículo geral a partir do PDF" e depois "busque vagas para mim".
Veja o guia completo em $REPO/docs/macos-pasta-de-vagas.md
EOF
