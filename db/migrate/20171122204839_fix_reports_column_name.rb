class FixReportsColumnName < ActiveRecord::Migration
  def change
    rename_column :reports, :url, :display_name
  end
end
