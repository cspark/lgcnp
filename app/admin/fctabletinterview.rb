ActiveAdmin.register Fctabletinterview do
  config.clear_action_items!
  index do
    selectable_column
    id_column
    Fctabletinterview.column_names.each do |c|
      column c.to_sym
    end

    # column :custname
    # column :sex
    # column :birthyy
    # column :birthmm
    # column :birthdd
    # column :phone
    # column :address
    # column :email
    # column :uptdate
    # actions
  end
end
