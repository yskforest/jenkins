# Jenkins Configuration

## setup
```bash
sh setup.sh
docker compose build
docker compose up
```

## 閲覧制限
### フォルダ作成
  - 例：　team1 / team2

### Manage and Assign Roles
- Permission template作成
  - 認証情報アクセスとそれ以外の2つ程度
- Manage Roles
  - Global roles
    - 全体Readできるuser追加
  - Item roles
    - ^team-a/.*
  - Authenticated Usersに

## 参考リンク
- [Jenkins の HTML Publisher Plugin の設定](https://yufutech.hatenablog.com/entry/2021/03/07/201536)
