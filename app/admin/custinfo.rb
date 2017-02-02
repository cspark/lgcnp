# ActiveAdmin.register Custinfo do
#   config.clear_action_items!
#   index do
#     selectable_column
#     id_column
#     column "시리얼", :custserial
#     column "이름", :custname
#     column "성별", :sex
#     column "생일 연도", :birthyy
#     column "생일 월", :birthmm
#     column "생일 일", :birthdd
#     column "전화번호", :phone
#     column "이메일", :email
#     column "업데이트날짜", :uptdate
#     # actions
#   end
#
#   filter :custserial, label: '시리얼'
#   filter :custname, label: '이름'
#   filter :sex, label: '성별'
#   filter :birthyy, label: '생일 연도'
#   filter :birthmm, label: '생일 월'
#   filter :birthdd, label: '생일 일'
#   filter :phone, label: '전화번호'
#   filter :email, label: '이메일'
#   filter :created_at, label: '진단 날짜'
# end

# ActiveAdmin.register_page "Custinfo" do
#  content do
#    render partial: "custinfo"
#  end
# end
