class AddFieldsToFctabletinterviews < ActiveRecord::Migration[5.0]
  def change
    add_column :fctabletinterviews, :fcdata_id, :integer
    add_column :fctabletinterviews, :tablet_interview_id, :integer
    add_column :fctabletinterviews, :is_quick_mode, :string
    add_column :fctabletinterviews, :base_lot, :string
    add_column :fctabletinterviews, :ampoule_1_lot, :string
    add_column :fctabletinterviews, :ampoule_2_lot, :string
    add_column :fctabletinterviews, :mixer_name, :string
    add_column :fctabletinterviews, :memo, :string
    add_column :fctabletinterviews, :is_agree_cant_refund, :string
    add_column :fctabletinterviews, :is_agree_after, :string
    add_column :fctabletinterviews, :shop_cd, :string
  end
end
