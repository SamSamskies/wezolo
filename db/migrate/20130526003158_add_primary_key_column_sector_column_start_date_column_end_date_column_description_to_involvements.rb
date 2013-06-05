class AddPrimaryKeyColumnSectorColumnStartDateColumnEndDateColumnDescriptionToInvolvements < ActiveRecord::Migration
  def change
    add_column :involvements, :id, :primary_key
    add_column :involvements, :description, :text
    add_column :involvements, :sector, :string
    add_column :involvements, :start_date, :date
    add_column :involvements, :end_date, :date
  end
end
