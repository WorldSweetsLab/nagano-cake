class CreateAdmins < ActiveRecord::Migration[8.0]
  def change
    create_table :admins do |t|
      
       # ログインに使うメールアドレス（NULL不可）
  t.string :email_address, null: false

        # ハッシュ化したパスワードを保存する（NULL不可）
  t.string :password_digest, null: false

      # 作成日時と更新日時を自動で記録する
      t.timestamps
    end
  end
end
