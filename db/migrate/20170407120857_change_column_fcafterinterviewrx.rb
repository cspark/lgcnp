class ChangeColumnFcafterinterviewrx < ActiveRecord::Migration[5.0]
  def change
    rename_column :fcafterinterviewrxes, :rx_tablet_interview_update, :rx_tablet_interview_uptdate
  end
end
