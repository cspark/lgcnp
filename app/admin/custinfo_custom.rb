ActiveAdmin.register_page "Custinfo" do
  action_item :view_site do
    link_to( 'Show Custinfo', '/user_list', :target => '_blank' )
  end
end
