
## usersテーブル

| Column             | Type   | Options                   |                            |
| ------------------ | ------ | ------------------------- |----------------------------|
| full_name          | string | null: false               | 氏名（全角）                 |
| employee_number    | string | null: false, unique: true | 従業員番号                   |
| email              | string | null: false, unique: true | メールアドレス（ログインID）   |
| encrypted_password | string | null: false               | 暗号化されたパスワード         |
| t.string :position | string | null: false               | 暗号化されたパスワード         |




### Association
- has_many :
- has_many :


## invoicesテーブル

| Column            | Type     | Options                     | 備考                               |
|-------------------|----------|-----------------------------|------------------------------------|
| file              | string   |                             | 請求書ファイル（PDF/画像）             |
| status            | string   | null: false                 | 処理ステータス（必須）（ActiveHash）   |
| receipt_method    | string   | null: false                 | 受領形態（必須）  （ActiveHash）      |
| vendor_code       | string   | null: false                 | 取引先番号（必須）                    |
| handler           | string   | null: false                 | 担当者番号（必須）                    |
| due_date          | date     | null: false                 | 期日（カレンダー・必須）               |
| received_date     | date     | null: false                 | 受領日（カレンダー・必須）             |
| tags              | string   |                             | タグ（カンマ区切りなどで保存）         |
| memo              | text     |                             | メモ欄                             |
| created_at        | datetime | null: false, default: now() | 作成日時                           |
| updated_at        | datetime | null: false, default: now() | 更新日時                           |



### Association
- has_many :
- has_many :


## clientsテーブル
| Column             | Type   | Options                   |                            |
| ------------------ | ------ | ------------------------- |----------------------------|
|           | string | null: false               |                             |
|           | string | null: false, unique: true |                             |





### Association
- has_many :
- has_many :


