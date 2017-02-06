ActiveAdmin.register_page "Input Feedback" do
#
#  # content do
#  #   render partial: "feedback"
#  # end
  action_item :view_site do
    link_to( 'Show Input Feedback', '/feedback', :target => '_blank' )
  end
end

ActiveAdmin.register_page "Feedback list" do
#
#  # content do
#  #   render partial: "feedback"
#  # end
  action_item :view_site do
    link_to( 'Show Feedback list', '/feedback_list', :target => '_blank' )
  end
end
