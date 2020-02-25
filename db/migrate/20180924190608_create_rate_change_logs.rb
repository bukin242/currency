class CreateRateChangeLogs < ActiveRecord::Migration[5.2]
  def up
    create_table :rate_change_logs do |t|
      t.decimal :value, precision: 10, scale: 4, null: false, comment: 'Значение курса валюты'
      t.datetime :created_at, null: false
    end

    execute <<-SQL
      ALTER TABLE rate_change_logs
      ADD CONSTRAINT check_positive_value
      CHECK (value > 0)
    SQL
  end

  def down
    drop_table :rate_change_logs
  end
end
