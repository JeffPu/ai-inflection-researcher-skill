#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
skill_name="${SKILL_NAME:-ai-inflection-researcher}"
source_dir="${repo_root}/skill/${skill_name}"
codex_home="${CODEX_HOME:-${HOME}/.codex}"
target_root="${1:-${codex_home}/skills}"
target_dir="${target_root}/${skill_name}"

if [[ ! -d "${source_dir}" ]]; then
  echo "Source skill not found: ${source_dir}" >&2
  exit 1
fi

mkdir -p "${target_dir}/references" "${target_dir}/agents"

cp "${source_dir}/SKILL.md" "${target_dir}/SKILL.md"
cp "${source_dir}/references/ibkr-tools.md" "${target_dir}/references/ibkr-tools.md"
cp "${source_dir}/agents/openai.yaml" "${target_dir}/agents/openai.yaml"

echo "Installed ${skill_name} to ${target_dir}"
echo "Restart Codex if the skill does not appear immediately."
