ActiveAdmin.register_page "FeedBack" do
#
#  # content do
#  #   render partial: "feedback"
#  # end
  action_item :view_site do
    link_to( 'Show Feedback', '/feedback', :target => '_blank' )
  end
end
