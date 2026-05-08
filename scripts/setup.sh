#!/usr/bin/env bash
set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Usage: $0 <target-repo-path>" >&2
  exit 1
fi

TARGET_REPO="$(cd "$1" && pwd)"
SKILLS_REPO="$(cd "$(dirname "$0")/.." && pwd)"
SKILLS_DIR="$SKILLS_REPO/skills"
TARGET_SKILLS_DIR="$TARGET_REPO/.claude/skills"

if [ ! -d "$SKILLS_DIR" ]; then
  echo "Error: skills directory not found: $SKILLS_DIR" >&2
  exit 1
fi

mkdir -p "$TARGET_SKILLS_DIR"

for skill_path in "$SKILLS_DIR"/*/; do
  skill_name="$(basename "$skill_path")"
  link_path="$TARGET_SKILLS_DIR/$skill_name"

  if [ -e "$link_path" ] || [ -L "$link_path" ]; then
    echo "skip: $skill_name (already exists)"
    continue
  fi

  # relative path from TARGET_SKILLS_DIR to skill_path
  rel_path="$(python3 -c "import os; print(os.path.relpath('$skill_path', '$TARGET_SKILLS_DIR'))")"
  ln -s "$rel_path" "$link_path"
  echo "created: $link_path -> $rel_path"
done

GITIGNORE="$TARGET_REPO/.gitignore"
PATTERN=".claude/skills/pca-*"

if [ ! -f "$GITIGNORE" ] || ! grep -qF "$PATTERN" "$GITIGNORE"; then
  echo "$PATTERN" >> "$GITIGNORE"
  echo "added to .gitignore: $PATTERN"
else
  echo "skip: .gitignore already contains $PATTERN"
fi
