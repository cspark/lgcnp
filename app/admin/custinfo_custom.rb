ActiveAdmin.register_page "Custinfo (New)" do
#
#  # content do
#  #   render partial: "feedback"
#  # end
  action_item :view_site do
    link_to( 'Show Custinfo', '/user_list', :target => '_blank' )
  end
end
