Sequel.migration do
  up do
    create_table(:bots) do
      primary_key :id
      String :authname, null: false, unique: true
      String :password_digest, null: false
      String :added_by, null: false
      DateTime :added_at, null: false
      DateTime :last_login
      String :last_login_nick
    end
  end

  down do
    drop_table(:bots)
  end
end
