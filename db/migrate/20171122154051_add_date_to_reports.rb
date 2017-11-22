class AddDateToReports < ActiveRecord::Migration
  def change
    add_column :reports, :report_date, :date
  end
end

#add_column(table_name, column_name, type, options)