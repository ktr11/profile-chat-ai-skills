# profile-chat-ai-skills

profile-chat-ai プロジェクト共通の Claude Code スキル管理リポジトリ。

各リポジトリの `.claude/skills/` にシンボリックリンクを張って共有する。

## 構造

```
profile-chat-ai-skills/
├── scripts/
│   └── setup.sh            # セットアップスクリプト
└── skills/
    ├── pca-create-issue/   # issue作成スキル
    └── pca-create-pr/      # PR作成スキル
```

## セットアップ

新しいリポジトリにスキルを追加する場合：

```bash
./scripts/setup.sh /path/to/target-repo
```

実行すると以下を行う：

- `skills/` 配下のスキルを `.claude/skills/` に相対シンボリックリンクとして作成
- `.gitignore` に `.claude/skills/pca-*` を追記（未記載の場合のみ）
- 既存のリンクや設定はスキップ（冪等）

## スキル一覧

| スキル名 | 説明 |
|----------|------|
| `pca-create-issue` | 会話の内容をもとに `ktr11/profile-chat-ai-docs` に issue を作成する |
| `pca-create-pr` | 現在のブランチの変更内容をもとに PR を作成する |

## 新しいスキルの追加

1. `skills/pca-<skill-name>/SKILL.md` を作成
2. 各リポジトリで `./scripts/setup.sh` を再実行
