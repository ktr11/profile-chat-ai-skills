---
name: pca-split-commits
description: 変更済みファイルを役割ごとに分割してコミットする。「commitを分けて」「役割ごとにcommit」のような依頼で使う。
---

# Split Commits

変更済みファイル（未ステージ含む）を役割ごとに分割し、わかりやすいコミットメッセージで個別にコミットします。

## 手順

1. `git status` と `git diff --name-only` で変更済みファイルの一覧を把握する
2. ファイルの役割をもとにコミット単位を設計し、グループをユーザーに提示して確認を取る
3. 各グループを順番に `git add <files>` → `git commit` で処理する

## コミットの分け方の基準

- **パッケージ・依存関係**: `package.json`, `pnpm-lock.yaml`, `package-lock.json` など
- **新規ライブラリ・共通ロジック**: `src/lib/*` など、複数ファイルから使われる基盤
- **新規エンドポイント・機能**: `src/app/api/*`, `src/app/*` などの新規追加
- **既存ファイルの移行・リファクタ**: 既存ファイルの修正・削除を伴う変更
- **設定・インフラ**: `next.config.*`, `tailwind.config.*`, `middleware.ts` など

## コミットメッセージの形式

```
<type>: <端的な日本語説明>

<変更の背景・理由を1〜2文で説明>（省略可）
- <変更ファイルや要点の箇条書き>（複数ある場合）

Co-Authored-By: Claude Sonnet 4.6 <noreply@anthropic.com>
```

- type は `feat` / `fix` / `refactor` / `chore` / `docs` から選ぶ
- メッセージは日本語で書く

## 注意

- グループ設計をユーザーに確認してからコミットを実行する
- 各コミット後に `git status` で残りの変更を確認しながら進める
