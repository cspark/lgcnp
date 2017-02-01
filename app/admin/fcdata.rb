ActiveAdmin.register Fcdata do
  config.clear_action_items!
  index do
    selectable_column
    Fctabletinterview.column_names.each do |c|
      column c.to_sym
    end
  end
end
