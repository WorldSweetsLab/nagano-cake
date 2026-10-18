class AddUniqueIndexToAdminsEmailAddress < ActiveRecord::Migration[8.0]
  def change
    # 同じメールアドレスの管理者を重複登録できないようにする
    add_index :admins, :email_address, unique: true
  end
end