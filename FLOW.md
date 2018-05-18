```
I, [2018-05-18T18:24:56.247061 #4412]  INFO -- : [bfda854f-2c63-4cde-802e-7651d614d45d] Started GET "/get_api_key" for 14.52.151.43 at 2018-05-18 18:24:56 +0900
I, [2018-05-18T18:24:56.248073 #4412]  INFO -- : [bfda854f-2c63-4cde-802e-7651d614d45d] Processing by CustinfosController#get_api_key as JSON
I, [2018-05-18T18:24:56.248247 #4412]  INFO -- : [bfda854f-2c63-4cde-802e-7651d614d45d]   Parameters: {"custinfo"=>{}}
I, [2018-05-18T18:24:56.249007 #4412]  INFO -- : [bfda854f-2c63-4cde-802e-7651d614d45d] Completed 200 OK in 1ms (Views: 0.3ms)



I, [2018-05-18T18:25:44.549852 #4412]  INFO -- : [356387d8-ef92-46fd-bdb4-485d6e4e2874] Started GET "/is_update?version_code=82" for 14.52.151.43 at 2018-05-18 18:25:44 +0900
I, [2018-05-18T18:25:44.550859 #4412]  INFO -- : [356387d8-ef92-46fd-bdb4-485d6e4e2874] Processing by UpdateController#is_update as JSON
I, [2018-05-18T18:25:44.550938 #4412]  INFO -- : [356387d8-ef92-46fd-bdb4-485d6e4e2874]   Parameters: {"version_code"=>"82", "update"=>{}}
I, [2018-05-18T18:25:44.551558 #4412]  INFO -- : [356387d8-ef92-46fd-bdb4-485d6e4e2874] Completed 200 OK in 1ms (Views: 0.1ms)




I, [2018-05-18T18:26:29.175339 #4412]  INFO -- : [08464456-ca73-482a-b717-e37bf9fe9ce5] Started GET "/api/tablet/cnp/find_lcare_user?cust_hnm=%EA%B9%80%EC%8A%B9%EB%A6%AC&birth_year=1990&birth_mmdd=0720&cell_phnno=01028105841&ch_cd=CLAB" for 14.52.151.43 at 2018-05-18 18:26:29 +0900
I, [2018-05-18T18:26:29.176666 #4412]  INFO -- : [08464456-ca73-482a-b717-e37bf9fe9ce5] Processing by Api::Tablet::Cnp::FctabletinterviewrxesController#find_lcare_user as JSON
I, [2018-05-18T18:26:29.176755 #4412]  INFO -- : [08464456-ca73-482a-b717-e37bf9fe9ce5]   Parameters: {"cust_hnm"=>"김승리", "birth_year"=>"1990", "birth_mmdd"=>"0720", "cell_phnno"=>"01028105841", "ch_cd"=>"CLAB", "fctabletinterviewrx"=>{}}




I, [2018-05-18T18:26:51.668385 #4412]  INFO -- : [70e12c50-3eef-4ade-b4bd-fef699122568] Started POST "/api/beau/
" for 14.52.151.43 at 2018-05-18 18:26:51 +0900
I, [2018-05-18T18:26:51.669544 #4412]  INFO -- : [70e12c50-3eef-4ade-b4bd-fef699122568] Processing by Api::Beau::FcAgreeMigenController#create as JSON
I, [2018-05-18T18:26:51.669629 #4412]  INFO -- : [70e12c50-3eef-4ade-b4bd-fef699122568]   Parameters: {"custserial"=>"18041636.0", "ch_cd"=>"CLAB", "fc_agree_migen"=>{"custserial"=>"18041636.0", "ch_cd"=>"CLAB"}}



I, [2018-05-18T18:27:31.610901 #4412]  INFO -- : [c7502ed3-ef42-48bf-8b61-205bd22143fe] Started GET "/find_interviews?custserial=18041636.0&ch_cd=CLAB" for 14.52.151.43 at 2018-05-18 18:27:31 +0900
I, [2018-05-18T18:27:31.611972 #4412]  INFO -- : [c7502ed3-ef42-48bf-8b61-205bd22143fe] Processing by FctabletinterviewsController#find_interviews as JSON
I, [2018-05-18T18:27:31.612051 #4412]  INFO -- : [c7502ed3-ef42-48bf-8b61-205bd22143fe]   Parameters: {"custserial"=>"18041636.0", "ch_cd"=>"CLAB", "fctabletinterview"=>{}}


인터뷰 히스토리 조회


I, [2018-05-18T18:28:26.469654 #7577]  INFO -- : [5ddec4b6-38ae-4019-9228-0d9c8bcc11f6] Started GET "/update_agreement?serial=18041636.0&is_agree_thirdparty_info=F&is_agree_marketing=F&is_agree_privacy_residence=F&is_agree_privacy=F&ch_cd=CLAB" for 14.52.151.43 at 2018-05-18 18:28:26 +0900


동의서 4개 전체 업데이트 하는 거


I, [2018-05-18T18:29:46.692516 #4412]  INFO -- : [aab182e5-d8d0-40f4-a320-9542bab03601] Started GET "/get_before_fcdata_count?custserial=18041636.0" for 14.52.151.43 at 2018-05-18 18:29:46 +0900
I, [2018-05-18T18:29:46.693853 #4412]  INFO -- : [aab182e5-d8d0-40f4-a320-9542bab03601] Processing by FcdatasController#get_before_fcdata_count as JSON
I, [2018-05-18T18:29:46.693947 #4412]  INFO -- : [aab182e5-d8d0-40f4-a320-9542bab03601]   Parameters: {"custserial"=>"18041636.0", "fcdata"=>{}}

I, [2018-05-18T18:31:07.932986 #7577]  INFO -- : [1a74c8e8-a13e-450f-898d-22eb6a1261fd] Started GET "/api/schedule/schedule_fcshop" for 14.52.151.43 at 2018-05-18 18:31:07 +0900
I, [2018-05-18T18:31:07.936751 #7577]  INFO -- : [1a74c8e8-a13e-450f-898d-22eb6a1261fd] Processing by Api::Schedule::ScheduleFcshopController#index as HTML

I, [2018-05-18T18:31:41.187876 #7577]  INFO -- : [785a0cd9-655c-4005-97c3-8e4953234844] Started GET "/api/admin/admin_fcshop?shop_cd=1004" for 14.52.151.43 at 2018-05-18 18:31:41 +0900
I, [2018-05-18T18:31:41.191501 #7577]  INFO -- : [785a0cd9-655c-4005-97c3-8e4953234844] Processing by Api::Admin::AdminFcshopController#index as HTML
I, [2018-05-18T18:31:41.191578 #7577]  INFO -- : [785a0cd9-655c-4005-97c3-8e4953234844]   Parameters: {"shop_cd"=>"1004"}

I, [2018-05-18T18:31:41.212923 #7577]  INFO -- : [6c2dbf4c-fe92-4bb4-aace-d135187ed96d] Started GET "/api/beau/beau_fcavgdata?his_date=2018-05-18" for 14.52.151.43 at 2018-05-18 18:31:41 +0900
I, [2018-05-18T18:31:41.213585 #7577]  INFO -- : [6c2dbf4c-fe92-4bb4-aace-d135187ed96d] Processing by Api::Beau::BeauFcavgdataController#index as HTML
I, [2018-05-18T18:31:41.213657 #7577]  INFO -- : [6c2dbf4c-fe92-4bb4-aace-d135187ed96d]   Parameters: {"his_date"=>"2018-05-18"}

I, [2018-05-18T18:29:50.185612 #7577]  INFO -- : [b63cf4dc-2d4f-4417-b262-af100852237b] Started GET "/check_yanus_status?custserial=18041636.0&before_count=4" for 14.52.151.43 at 2018-05-18 18:29:50 +0900
I, [2018-05-18T18:29:50.186791 #7577]  INFO -- : [b63cf4dc-2d4f-4417-b262-af100852237b] Processing by FcdatasController#check_yanus_status as JSON
I, [2018-05-18T18:29:50.186879 #7577]  INFO -- : [b63cf4dc-2d4f-4417-b262-af100852237b]   Parameters: {"custserial"=>"18041636.0", "before_count"=>"4", "fcdata"=>{}}




PC>
I, [2018-05-18T18:31:07.932986 #7577]  INFO -- : [1a74c8e8-a13e-450f-898d-22eb6a1261fd] Started GET "/api/schedule/schedule_fcshop" for 14.52.151.43 at 2018-05-18 18:31:07 +0900
I, [2018-05-18T18:31:07.936751 #7577]  INFO -- : [1a74c8e8-a13e-450f-898d-22eb6a1261fd] Processing by Api::Schedule::ScheduleFcshopController#index as HTML

I, [2018-05-18T18:31:41.289380 #7577]  INFO -- : [6847b0b3-214e-40c3-9a18-e1aa3a5268fa] Started GET "/api/beau/beau_fcavgdata?his_date=2018-05-18" for 14.52.151.43 at 2018-05-18 18:31:41 +0900
I, [2018-05-18T18:31:41.289956 #7577]  INFO -- : [6847b0b3-214e-40c3-9a18-e1aa3a5268fa] Processing by Api::Beau::BeauFcavgdataController#index as HTML
I, [2018-05-18T18:31:41.290027 #7577]  INFO -- : [6847b0b3-214e-40c3-9a18-e1aa3a5268fa]   Parameters: {"his_date"=>"2018-05-18"}


PC>
I, [2018-05-18T18:31:50.393827 #7577]  INFO -- : [99992314-ac4e-491e-b37a-ebbe4b84563d] Started GET "/api/cnp/cnp_user?custname=%25EA%25B9%2580%25EC%258A%25B9%25EB%25A6%25AC&birthyy=1990&birthmm=07&birthdd=20&ch_cd=CLAB" for 14.52.151.43 at 2018-05-18 18:31:50 +0900
I, [2018-05-18T18:31:50.394958 #7577]  INFO -- : [99992314-ac4e-491e-b37a-ebbe4b84563d] Processing by Api::Cnp::CnpUserController#index as HTML
I, [2018-05-18T18:31:50.395044 #7577]  INFO -- : [99992314-ac4e-491e-b37a-ebbe4b84563d]   Parameters: {"custname"=>"%EA%B9%80%EC%8A%B9%EB%A6%AC", "birthyy"=>"1990", "birthmm"=>"07", "birthdd"=>"20", "ch_cd"=>"CLAB"}


PC> 사진 촬영 후

I, [2018-05-18T18:35:09.017132 #7577]  INFO -- : [9ad001bf-c9d3-4b49-8de1-95000824cc9d] Started POST "/images/" for 14.52.151.43 at 2018-05-18 18:35:09 +0900
I, [2018-05-18T18:35:09.017939 #7577]  INFO -- : [9ad001bf-c9d3-4b49-8de1-95000824cc9d] Processing by ImagesController#create as HTML
I, [2018-05-18T18:35:09.018058 #7577]  INFO -- : [9ad001bf-c9d3-4b49-8de1-95000824cc9d]   Parameters: {"custserial"=>"18041636", "ch_cd"=>"CLAB", "measureno"=>"5", "type"=>"F_FM_UVGR_UVC", "number"=>"2", "image"=>#<ActionDispatch::Http::UploadedFile:0x00
7f092a44a5e0 @tempfile=#<Tempfile:/tmp/RackMultipart20180518-7577-14ookd5.jpg>, @original_filename="18041636-5_F_FM_UVGR_UVC_2.jpg", @content_type="image/jpeg", @headers="Content-Disposition: form-data; name=\"image\"; filename=\"18041636-5_F_FM_UVGR_UVC
_2.jpg\"\r\nContent-Type: image/jpeg\r\n">}


I, [2018-05-18T18:35:12.441795 #4412]  INFO -- : [46b7824b-ffcf-462d-9d23-6cf4f65bfb4f] Started POST "/api/beau/beau_fcdata" for 14.52.151.43 at 2018-05-18 18:35:12 +0900
I, [2018-05-18T18:35:12.443081 #4412]  INFO -- : [46b7824b-ffcf-462d-9d23-6cf4f65bfb4f] Processing by Api::Beau::BeauFcdataController#create as HTML
I, [2018-05-18T18:35:12.443334 #4412]  INFO -- : [46b7824b-ffcf-462d-9d23-6cf4f65bfb4f]   Parameters: {"custserial"=>"18041636", "ch_cd"=>"CLAB", "shop_cd"=>"1004", "measureno"=>"5", "measuredate"=>"2018-05-18-18-34-48", "faceno"=>"F", "mo_1"=>"65", "mo_7"=>"65", "mo_8"=>"65", "pr_1"=>"19", "pr_2"=>"17", "pr_7"=>"16", "pr_8"=>"22", "pr_avr"=>"19", "wr_3"=>"17", "wr_4"=>"12", "wr_5"=>"11", "wr_6"=>"10", "wr_avr"=>"13", "el_7"=>"23", "el_8"=>"11", "el_avr"=>"17", "el_angle_7"=>"59", "el_angle_8"=>"38.75", "sb_1"=>"14", "sb_2"=>"0", "sb_7"=>"21", "sb_8"=>"5", "sb_avr"=>"10", "pp_1"=>"0", "pp_2"=>"1", "pp_7"=>"0", "pp_8"=>"1", "pp_avr"=>"1", "pp_ratio_1"=>"0", "pp_ratio_2"=>"100", "pp_ratio_7"=>"0", "pp_ratio_8"=>"17", "pp_ratio_avr"=>"5", "sp_pl_1"=>"63", "sp_pl_2"=>"11", "sp_pl_3"=>"54", "sp_pl_4"=>"33", "sp_pl_5"=>"23", "sp_pl_6"=>"29", "sp_pl_7"=>"66", "sp_pl_8"=>"33", "sp_pl_avr"=>"39", "sp_uv_1"=>"56", "sp_uv_2"=>"18", "sp_uv_3"=>"61", "sp_uv_4"=>"84", "sp_uv_5"=>"52", "sp_uv_6"=>"31", "sp_uv_7"=>"76", "sp_uv_8"=>"29", "sp_uv_avr"=>"51", "sk_c_1"=>"41", "sk_c_2"=>"60", "sk_c_4"=>"19", "sk_c_6"=>"58", "sk_c_7"=>"31", "sk_c_8"=>"51", "sk_c_avr"=>"43", "sk_r_1"=>"133", "sk_r_2"=>"195", "sk_r_4"=>"61", "sk_r_6"=>"185", "sk_r_7"=>"104", "sk_r_8"=>"162", "sk_r_avr"=>"140", "sk_g_1"=>"105", "sk_g_2"=>"151", "sk_g_4"=>"48", "sk_g_6"=>"146", "sk_g_7"=>"79", "sk_g_8"=>"127", "sk_g_avr"=>"109", "sk_b_1"=>"79", "sk_b_2"=>"118", "sk_b_4"=>"37", "sk_b_6"=>"114", "sk_b_7"=>"59", "sk_b_8"=>"102", "sk_b_avr"=>"85", "lab_l"=>"46.0067", "lab_a"=>"8.7471", "lab_b"=>"17.3029", "e_sebum_t"=>"0.0357393", "e_sebum_u"=>"0.155489", "e_porphyrin_t"=>"0.0305781", "e_porphyrin_u"=>"0.0416487", "colortype"=>"4", "suntype"=>"2", "skintype"=>"1", "m_skintype"=>"0", "score_r"=>"94", "score_l"=>"98", "janus_status"=>"1", "uf_1"=>"47.9896", "uf_2"=>"10.088", "uf_3"=>"21.4348", "uf_4"=>"15.3937", "uf_5"=>"4.38597", "uf_6"=>"18.185", "uf_7"=>"14.9786", "uf_8"=>"12.9997", "uf_avr"=>"18.1819", "age"=>"27", "el_cnt_7"=>"2", "el_cnt_8"=>"4", "uf_l0"=>"49.5452", "uf_l_total"=>"22.0488"}




I, [2018-05-18T18:35:12.531431 #7577]  INFO -- : [4d6173b8-5299-45fb-81c7-bceed2ed94f6] Started PUT "/api/beau/beau_user/measure_update" for 14.52.151.43 at 2018-05-18 18:35:12 +0900
I, [2018-05-18T18:35:12.535872 #7577]  INFO -- : [4d6173b8-5299-45fb-81c7-bceed2ed94f6] Processing by Api::Beau::BeauUserController#measure_update as HTML
I, [2018-05-18T18:35:12.535964 #7577]  INFO -- : [4d6173b8-5299-45fb-81c7-bceed2ed94f6]   Parameters: {"custserial"=>"18041636", "lastanaldate"=>"2018-05-18-18-34-48"}




I, [2018-05-18T18:35:12.561783 #4412]  INFO -- : [cb82a63c-6f0b-46de-bbb7-b86007ae75ab] Started POST "/api/beau/beau_fcpos" for 14.52.151.43 at 2018-05-18 18:35:12 +0900
I, [2018-05-18T18:35:12.562672 #4412]  INFO -- : [cb82a63c-6f0b-46de-bbb7-b86007ae75ab] Processing by Api::Beau::BeauFcposController#create as HTML
I, [2018-05-18T18:35:12.562810 #4412]  INFO -- : [cb82a63c-6f0b-46de-bbb7-b86007ae75ab]   Parameters: {"custserial"=>"18041636", "ch_cd"=>"CLAB", "shop_cd"=>"1004", "measureno"=>"5", "measuredate"=>"2018-05-18-18-34-48", "faceno"=>"F", "fh_x"=>"581", "fh_y"=>"1296", "fh_w"=>"1380", "fh_h"=>"577", "ns_x"=>"983", "ns_y"=>"1873", "ns_w"=>"577", "ns_h"=>"577", "res_x"=>"283", "res_y"=>"1809", "res_w"=>"186", "res_h"=>"396", "reu_x"=>"498", "reu_y"=>"2054", "reu_w"=>"445", "reu_h"=>"156", "les_x"=>"2083", "les_y"=>"1809", "les_w"=>"186", "les_h"=>"396", "leu_x"=>"1604", "leu_y"=>"2054", "leu_w"=>"445", "leu_h"=>"156", "rs_x"=>"405", "rs_y"=>"2210", "rs_w"=>"499", "rs_h"=>"416", "ls_x"=>"1643", "ls_y"=>"2210", "ls_w"=>"499", "ls_h"=>"416", "rt_re_l"=>"454", "rt_re_t"=>"1882", "rt_re_r"=>"943", "rt_re_b"=>"2078", "rt_le_l"=>"1604", "rt_le_t"=>"1882", "rt_le_r"=>"2093", "rt_le_b"=>"2078", "rt_lip_l"=>"860", "rt_lip_t"=>"2689", "rt_lip_r"=>"1653", "rt_lip_b"=>"2983", "rt_res_x"=>"220", "rt_res_y"=>"1980", "rt_les_x"=>"2323", "rt_les_y"=>"2323"}



tablet>
I, [2018-05-18T18:35:16.868690 #4412]  INFO -- : [77837a1f-245d-403c-b730-564a5a14fc56] Started GET "/face_data?custserial=18041636.0" for 14.52.151.43 at 2018-05-18 18:35:16 +0900
I, [2018-05-18T18:35:16.870066 #4412]  INFO -- : [77837a1f-245d-403c-b730-564a5a14fc56] Processing by FcdatasController#face_data as JSON
I, [2018-05-18T18:35:16.870212 #4412]  INFO -- : [77837a1f-245d-403c-b730-564a5a14fc56]   Parameters: {"custserial"=>"18041636.0", "fcdata"=>{}}




I, [2018-05-18T18:40:03.181795 #7577]  INFO -- : [33787725-262f-40e4-b6a8-a4f62a0c1848] Started POST "/fctabletinterviews" for 14.52.151.43 at 2018-05-18 18:40:03 +0900
I, [2018-05-18T18:40:03.183798 #7577]  INFO -- : [33787725-262f-40e4-b6a8-a4f62a0c1848] Processing by FctabletinterviewsController#create as JSON
I, [2018-05-18T18:40:03.184028 #7577]  INFO -- : [33787725-262f-40e4-b6a8-a4f62a0c1848]   Parameters: {"custserial"=>"18041636.0", "tablet_interview_id"=>-1, "ch_cd"=>"CNP", "a_1"=>2, "a_2"=>2, "a_3"=>2, "b_1"=>8, "b_2"=>3, "b_3"=>3, "b_4"=>3, "c_1"=>3, "d_1"=>3, "d_2"=>3, "d_3"=>4, "d_4"=>5, "d_5"=>3, "d_6"=>2, "d_7"=>4, "d_8"=>3, "d_9"=>3, "d_10"=>4, "memo"=>"", "skin_type"=>"skin_type_jisung_boghab_senstive", "is_agree_cant_refund"=>"F", "before_solution_1"=>"pigment solution", "after_solution_1"=>"pigment solution", "before_solution_1_new"=>"pigment solution", "before_solution_2"=>"wrinkle solution", "after_solution_2"=>"wrinkle solution", "before_solution_2_new"=>"wrinkle solution", "before_serum"=>"skin control", "after_serum"=>"skin control", "before_ample_1"=>"luminus ampoule", "after_ample_1"=>"luminus ampoule", "before_ample_2"=>"regenerating ampoule", "after_ample_2"=>"regenerating ampoule", "before_made_cosmetic"=>"skin control Ex", "after_made_cosmetic"=>"skin control Ex", "uptdate"=>"", "fcdata_id"=>"5", "is_quick_mode"=>"F", "base_lot"=>"", "ampoule_1_lot"=>"", "ampoule_2_lot"=>"", "mixer_name"=>"", "fctabletinterview"=>{"custserial"=>"18041636.0", "tablet_interview_id"=>-1, "ch_cd"=>"CNP", "a_1"=>2, "a_2"=>2, "a_3"=>2, "b_1"=>8, "b_2"=>3, "b_3"=>3, "b_4"=>3, "c_1"=>3, "d_1"=>3, "d_2"=>3, "d_3"=>4, "d_4"=>5, "d_5"=>3, "d_6"=>2, "d_7"=>4, "d_8"=>3, "d_9"=>3, "d_10"=>4, "skin_type"=>"skin_type_jisung_boghab_senstive", "before_solution_1"=>"pigment solution", "after_solution_1"=>"pigment solution", "before_solution_2"=>"wrinkle solution", "after_solution_2"=>"wrinkle solution", "before_serum"=>"skin control", "after_serum"=>"skin control", "before_ample_1"=>"luminus ampoule", "after_ample_1"=>"luminus ampoule", "before_ample_2"=>"regenerating ampoule", "after_ample_2"=>"regenerating ampoule", "before_made_cosmetic"=>"skin control Ex", "after_made_cosmetic"=>"skin control Ex", "uptdate"=>"", "is_quick_mode"=>"F", "fcdata_id"=>"5", "base_lot"=>"", "ampoule_1_lot"=>"", "ampoule_2_lot"=>"", "mixer_name"=>"", "memo"=>"", "is_agree_cant_refund"=>"F", "before_solution_1_new"=>"pigment solution", "before_solution_2_new"=>"wrinkle solution"}}



I, [2018-05-18T18:41:16.054608 #4412]  INFO -- : [1d4db96f-1075-48ac-b8d2-8eee721b08f0] Started POST "/update_interviews" for 14.52.151.43 at 2018-05-18 18:41:16 +0900
I, [2018-05-18T18:41:16.056184 #4412]  INFO -- : [1d4db96f-1075-48ac-b8d2-8eee721b08f0] Processing by FctabletinterviewsController#update_interviews as JSON
I, [2018-05-18T18:41:16.056375 #4412]  INFO -- : [1d4db96f-1075-48ac-b8d2-8eee721b08f0]   Parameters: {"custserial"=>"18041636.0", "tablet_interview_id"=>37, "ch_cd"=>"CNP", "a_1"=>2, "a_2"=>2, "a_3"=>2, "b_1"=>8, "b_2"=>3, "b_3"=>3, "b_4"=>3, "c_1"=>3, "d_1"=>3, "d_2"=>3, "d_3"=>4, "d_4"=>5, "d_5"=>3, "d_6"=>2, "d_7"=>4, "d_8"=>3, "d_9"=>3, "d_10"=>4, "memo"=>"", "skin_type"=>"skin_type_jisung_boghab_senstive", "is_agree_cant_refund"=>"F", "before_solution_1"=>"pigment solution", "after_solution_1"=>"pigment solution", "before_solution_1_new"=>"pigment solution", "before_solution_2"=>"wrinkle solution", "after_solution_2"=>"trouble solution", "before_solution_2_new"=>"wrinkle solution", "before_serum"=>"skin control", "after_serum"=>"deep humect", "before_ample_1"=>"luminus ampoule", "after_ample_1"=>"luminus ampoule", "before_ample_2"=>"regenerating ampoule", "after_ample_2"=>"carming ampoule", "before_made_cosmetic"=>"skin control Ex", "after_made_cosmetic"=>"deep humect Ex", "uptdate"=>"2018-05-18-18-40", "fcdata_id"=>"5", "is_quick_mode"=>"F", "base_lot"=>"", "ampoule_1_lot"=>"", "ampoule_2_lot"=>"", "mixer_name"=>"", "fctabletinterview"=>{"custserial"=>"18041636.0", "tablet_interview_id"=>37, "ch_cd"=>"CNP", "a_1"=>2, "a_2"=>2, "a_3"=>2, "b_1"=>8, "b_2"=>3, "b_3"=>3, "b_4"=>3, "c_1"=>3, "d_1"=>3, "d_2"=>3, "d_3"=>4, "d_4"=>5, "d_5"=>3, "d_6"=>2, "d_7"=>4, "d_8"=>3, "d_9"=>3, "d_10"=>4, "skin_type"=>"skin_type_jisung_boghab_senstive", "before_solution_1"=>"pigment solution", "after_solution_1"=>"pigment solution", "before_solution_2"=>"wrinkle solution", "after_solution_2"=>"trouble solution", "before_serum"=>"skin control", "after_serum"=>"deep humect", "before_ample_1"=>"luminus ampoule", "after_ample_1"=>"luminus ampoule", "before_ample_2"=>"regenerating ampoule", "after_ample_2"=>"carming ampoule", "before_made_cosmetic"=>"skin control Ex", "after_made_cosmetic"=>"deep humect Ex", "uptdate"=>"2018-05-18-18-40", "is_quick_mode"=>"F", "fcdata_id"=>"5", "base_lot"=>"", "ampoule_1_lot"=>"", "ampoule_2_lot"=>"", "mixer_name"=>"", "memo"=>"", "is_agree_cant_refund"=>"F", "before_solution_1_new"=>"pigment solution", "before_solution_2_new"=>"wrinkle solution"}}



I, [2018-05-18T18:42:15.483018 #4412]  INFO -- : [0c659737-df54-4aee-a42f-5c46946192d0] Started POST "/fctabletinterviews_update_lots" for 14.52.151.43 at 2018-05-18 18:42:15 +0900
I, [2018-05-18T18:42:15.484605 #4412]  INFO -- : [0c659737-df54-4aee-a42f-5c46946192d0] Processing by FctabletinterviewsController#fctabletinterviews_update_lots as JSON
I, [2018-05-18T18:42:15.484798 #4412]  INFO -- : [0c659737-df54-4aee-a42f-5c46946192d0]   Parameters: {"custserial"=>"18041636.0", "tablet_interview_id"=>37, "ch_cd"=>"CNP", "a_1"=>2, "a_2"=>2, "a_3"=>2, "b_1"=>8, "b_2"=>3, "b_3"=>3, "b_4"=>3, "c_1"=>3, "d_1"=>3, "d_2"=>3, "d_3"=>4, "d_4"=>5, "d_5"=>3, "d_6"=>2, "d_7"=>4, "d_8"=>3, "d_9"=>3, "d_10"=>4, "memo"=>"tesr", "skin_type"=>"skin_type_jisung_boghab_senstive", "is_agree_cant_refund"=>"T", "before_solution_1"=>"pigment solution", "after_solution_1"=>"pigment solution", "before_solution_1_new"=>"pigment solution", "before_solution_2"=>"wrinkle solution", "after_solution_2"=>"trouble solution", "before_solution_2_new"=>"wrinkle solution", "before_serum"=>"skin control", "after_serum"=>"deep humect", "before_ample_1"=>"luminus ampoule", "after_ample_1"=>"luminus ampoule", "before_ample_2"=>"regenerating ampoule", "after_ample_2"=>"carming ampoule", "before_made_cosmetic"=>"skin control Ex", "after_made_cosmetic"=>"deep humect Ex", "uptdate"=>"2018-05-18-18-40", "fcdata_id"=>"5", "is_quick_mode"=>"F", "base_lot"=>"", "ampoule_1_lot"=>"", "ampoule_2_lot"=>"", "mixer_name"=>"", "fctabletinterview"=>{"custserial"=>"18041636.0", "tablet_interview_id"=>37, "ch_cd"=>"CNP", "a_1"=>2, "a_2"=>2, "a_3"=>2, "b_1"=>8, "b_2"=>3, "b_3"=>3, "b_4"=>3, "c_1"=>3, "d_1"=>3, "d_2"=>3, "d_3"=>4, "d_4"=>5, "d_5"=>3, "d_6"=>2, "d_7"=>4, "d_8"=>3, "d_9"=>3, "d_10"=>4, "skin_type"=>"skin_type_jisung_boghab_senstive", "before_solution_1"=>"pigment solution", "after_solution_1"=>"pigment solution", "before_solution_2"=>"wrinkle solution", "after_solution_2"=>"trouble solution", "before_serum"=>"skin control", "after_serum"=>"deep humect", "before_ample_1"=>"luminus ampoule", "after_ample_1"=>"luminus ampoule", "before_ample_2"=>"regenerating ampoule", "after_ample_2"=>"carming ampoule", "before_made_cosmetic"=>"skin control Ex", "after_made_cosmetic"=>"deep humect Ex", "uptdate"=>"2018-05-18-18-40", "is_quick_mode"=>"F", "fcdata_id"=>"5", "base_lot"=>"", "ampoule_1_lot"=>"", "ampoule_2_lot"=>"", "mixer_name"=>"", "memo"=>"tesr", "is_agree_cant_refund"=>"T", "before_solution_1_new"=>"pigment solution", "before_solution_2_new"=>"wrinkle solution"}}



I, [2018-05-18T18:42:15.583349 #4412]  INFO -- : [6f1015d9-796e-47e6-9509-18ce423af96d] Started GET "/update_after_service?serial=18041636.0&is_agree_after_service=T&tabletInterviewId=37&ch_cd=CLAB" for 14.52.151.43 at 2018-05-18 18:42:15 +0900
I, [2018-05-18T18:42:15.584279 #4412]  INFO -- : [6f1015d9-796e-47e6-9509-18ce423af96d] Processing by CustinfosController#update_after_service as JSON
I, [2018-05-18T18:42:15.584361 #4412]  INFO -- : [6f1015d9-796e-47e6-9509-18ce423af96d]   Parameters: {"serial"=>"18041636.0", "is_agree_after_service"=>"T", "tabletInterviewId"=>"37", "ch_cd"=>"CLAB", "custinfo"=>{}}

```