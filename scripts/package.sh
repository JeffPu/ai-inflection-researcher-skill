#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
skill_name="${SKILL_NAME:-ai-inflection-researcher}"
source_dir="${repo_root}/skill/${skill_name}"
dist_dir="${repo_root}/dist"
output="${dist_dir}/${skill_name}.skill"

if [[ ! -d "${source_dir}" ]]; then
  echo "Source skill not found: ${source_dir}" >&2
  exit 1
fi

command -v zip >/dev/null 2>&1 || {
  echo "zip is required to package the skill." >&2
  exit 1
}

mkdir -p "${dist_dir}"

if [[ -f "${output}" ]]; then
  rm "${output}"
fi

(
  cd "${repo_root}/skill"
  zip -r "${output}" "${skill_name}" -x "*.DS_Store" -x "__MACOSX/*"
)

echo "Packaged ${output}"
