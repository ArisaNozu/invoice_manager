
## usersテーブル

| Column             | Type   | Options                   |                            |
| ------------------ | ------ | ------------------------- |----------------------------|
| full_name          | string | null: false               | 氏名（全角）                 |
| employee_number    | string | null: false, unique: true | 従業員番号                   |
| department         | integer | null: false               | 部署名（ActiveHash）        |
| email              | string | null: false, unique: true | メールアドレス（ログインID）   |
| encrypted_password | string | null: false               | 暗号化されたパスワード         |



### Association
- has_many : invoices


## invoicesテーブル

| Column                      | Type     | Options                        | 備考                                      |
|-----------------------------|----------|--------------------------------|------------------------------------------|
| file                        | string   |                                | 請求書ファイル（PDF/画像） （ActiveStorage）  |
| status                      | integer  | null: false                    | 処理ステータス（必須）（ActiveHash）          |
| receipt_method              | integer  | null: false                    | 受領形態（必須）  （ActiveHash）             |
| due_date                    | date     | null: false                    | 支払期日（カレンダー・必須）                      |
| received_date               | date     | null: false                    | 受領日（カレンダー・必須）                    |
| net_amount               	  | integer	 | null: false	                  | 本体金額（税抜金額）                         |
| tax_amount	                | integer	 | null: false	                  | 消費税額                                   |
| tax_rate	                  | integer	 | null: false	                  | 消費税率（ActiveHash）                     |
| memo                        | text     |                                | メモ欄（500文字まで）                        | 
|receipt_frequency            | integer  | null: false                    | 請求書受領頻度（ActiveHash）                 |
|client_code                  | integer  | null: false , foreign_key: true| 取引先ID（clientsテーブルの取引先番号（社内管理用コード））              |
| transaction_date            | date     | null: false                    | 取引日（カレンダー・必須）                    |
| user                        | references | null: false, foreign_key: true | 請求書データ登録のユーザーID            |



### Association
- belongs_to : user
- belongs_to : client
- acts_as_taggable_on :tags



## clientsテーブル
| Column             | Type     | Options                   |                            |
| ------------------ | -------- | ------------------------- |----------------------------|
| client_code     	 | string	  | null: false, unique: true	| 取引先番号（社内管理用コード）11桁の数字  |
| name             	 | string	  | null: false	              | 取引先名（例：株式会社ABC）    |
| invoice_registration_number | string   |                                | 適格請求書発行事業者番号（T + 13桁の数字）      |
| is_qualified_invoice_issuer | boolean  | null: false                    | 適格請求書発行事業者かどうか（true: 適格事業者） |
| contact_person     | string	  |                           | 担当者名                    |
| phone_number       | string	  |                           | 電話番号                    |
| address            | text	    |                           | 請求書送付先住所              |
| notes              | text	    |                           | 備考・メモ欄                 |




### Association
- has_many :invoices


## tagsテーブル（acts-as-taggable-on により自動生成）

| Column           | Type     | Options                     |                                  |
| ---------------- | -------- | --------------------------- |----------------------------------|
| name	           | string	  |	                            |	タグ名（例：システム開発、水光熱費など）|

- has_many :taggings



## taggingsテーブル（acts-as-taggable-on により自動生成）
| Column           | Type     | Options                     |                                        |
| ---------------- | -------- | --------------------------- |----------------------------------------|
| tag_id           | integer  |	                            |	tagsテーブルへの外部キー                  |
| taggable_id  		 | integer  |	                            |	タグ付け対象のレコードID（今回：invoiceのID）|
| taggable_type	   | string	  |	                            |	対象モデル名（今回：'Invoice'）            |
| context		       | string	  |	                            |	タグの種類（例：:tags）                   |



- belongs to : invoices

