class Api::Tablet::Cnprx::FctabletinterviewrxesController < Api::ApplicationController
  def self.calculate_push_is_agree
    custinfos = Custinfo.all
    custinfos.each do |custinfo|
      interviews = Fctabletinterviewrx.where(custserial: custinfo.custserial).all
      interviews.each do |interview|
        interview.is_agree_after = custinfo.is_agree_after
        interview.save
      end
    end
  end

  def index
    tabletinterview = Fctabletinterviewrx.all
    render json: api_hash_for_list(tabletinterview, page: 1), status: :ok
  end

  def find_interviews
    serial = params[:custserial].to_s
    tabletinterviews = Fctabletinterviewrx.where(custserial: serial)
    Rails.logger.info tabletinterviews.count
    if tabletinterviews.count.to_i > 0
      render json: api_hash_for_list(tabletinterviews), status: :ok
    else
      render json: "", status: 404
    end
  end

  def fctabletinterviews_quickmode
    tabletinterview = Fctabletinterviewrx.new(permitted_param)
    tabletinterview.tablet_interview_id = Fctabletinterviewrx.all.count
    t = Time.now
    tabletinterview.uptdate = t.strftime("%Y-%m-%d-%H-%M")
    tabletinterview.is_quick_mode = "T"

    tabletinterview.is_make_up = "T"
    if tabletinterview.a_1 == "2.0"
      tabletinterview.is_make_up = "F"
    end

    user = Custinfo.where(custserial: tabletinterview.custserial).first
    if !user.nil?
      tabletinterview.ch_cd = user.ch_cd
    end
    if tabletinterview.save
      render json: tabletinterview.to_api_hash, status: :ok
    else
      render json: "", status: 404
    end
  end

  def fctabletinterviews_update_lots
    Rails.logger.info params[:tablet_interview_id]
    existed_interview = Fctabletinterviewrx.where(tablet_interview_id: params[:tablet_interview_id]).last
    if existed_interview.update(permitted_param)
      user = Custinfo.where(custserial: existed_interview.custserial).first
      if !user.nil?
        existed_interview.ch_cd = user.ch_cd
        existed_interview.save
      end

      render json: existed_interview.to_api_hash, status: :ok
    else
      render json: "", status: 404
    end
  end

  def create
    tabletinterview = Fctabletinterviewrx.new(permitted_param)
    tabletinterview.tablet_interview_id = Fctabletinterviewrx.all.count
    t = Time.now
    tabletinterview.uptdate = t.strftime("%Y-%m-%d-%H-%M")
    tabletinterview.is_agree_after = "T"

    user = Custinfo.where(custserial: tabletinterview.custserial).first
    if !user.nil?
      tabletinterview.ch_cd = user.ch_cd
    end

    if tabletinterview.save
      render json: tabletinterview.to_api_hash, status: :ok
    else
      render json: "", status: 404
    end
  end

  def update_interviews_just_refund
    existed_interview = Fctabletinterviewrx.where(tablet_interview_id: params[:tablet_interview_id]).last
    existed_interview.is_agree_cant_refund = params[:is_agree_cant_refund]
    if existed_interview.save
      render json: existed_interview.to_api_hash, status: :ok
    else
      render json: "", status: 404
    end
  end

  def update_interviews
    Rails.logger.info params[:tablet_interview_id]
    existed_interview = Fctabletinterviewrx.where(tablet_interview_id: params[:tablet_interview_id]).last
    if existed_interview.update(permitted_param)
      user = Custinfo.where(custserial: existed_interview.custserial).first
      if !user.nil?
        existed_interview.ch_cd = user.ch_cd
        existed_interview.save
      end

      render json: existed_interview.to_api_hash, status: :ok
    else
      render json: "", status: 404
    end
  end

  def get_answer(value: value)
    if value == 5
      return 3
    elsif value == 6
      return 4
    end
    return value
  end

  def get_sensitive_value(value: value)
    if value == 5
      return 5
    else
      return 0
    end
  end

  def calculate
    Fctabletinterviewrx.all.each do |fctabletinterview|
      # if fctabletinterview.skin_type == nil || fctabletinterview.skin_type == "null"
        calculate_value = 0
        calculate_value = calculate_value + get_answer(value: fctabletinterview.d_1)
        calculate_value = calculate_value + get_answer(value: fctabletinterview.d_2)
        calculate_value = calculate_value + get_answer(value: fctabletinterview.d_3)
        calculate_value = calculate_value + get_answer(value: fctabletinterview.d_4)
        calculate_value = calculate_value + get_answer(value: fctabletinterview.d_5)

        sensitive_value = 0
        sensitive_value = sensitive_value + get_sensitive_value(value: fctabletinterview.d_6)
        sensitive_value = sensitive_value + get_sensitive_value(value: fctabletinterview.d_7)
        sensitive_value = sensitive_value + get_sensitive_value(value: fctabletinterview.d_8)
        sensitive_value = sensitive_value + get_sensitive_value(value: fctabletinterview.d_9)
        sensitive_value = sensitive_value + get_sensitive_value(value: fctabletinterview.d_10)

        fctabletinterview.skin_type = ""
        if calculate_value >= 17
          if sensitive_value >= 13 && sensitive_value <= 20
            fctabletinterview.skin_type = "skin_type_jisung_senstive"
          else
            fctabletinterview.skin_type = "skin_type_jisung"
          end
        end

        if calculate_value >= 13 && calculate_value <= 16
          if sensitive_value >= 13 && sensitive_value <= 20
            fctabletinterview.skin_type = "skin_type_jisung_boghab_senstive"
          else
            fctabletinterview.skin_type = "skin_type_jisung_boghab"
          end
        end

        if calculate_value >= 10 && calculate_value <= 12
          if sensitive_value >= 13 && sensitive_value <= 20
            fctabletinterview.skin_type = "skin_type_gun_boggab_senstive"
          else
            fctabletinterview.skin_type = "skin_type_gun_boggab"
          end
        end

        if calculate_value >= 5 && calculate_value <= 9
          if sensitive_value >= 13 && sensitive_value <= 20
            fctabletinterview.skin_type = "skin_type_gunsung_senstive"
          else
            fctabletinterview.skin_type = "skin_type_gunsung"
          end
        end

        if (fctabletinterview.d_4 == 5 && fctabletinterview.d_5 == 5) || (fctabletinterview.a_2 == 4 && ((fctabletinterview.d_4 == 2 && fctabletinterview.d_5 == 3) || (fctabletinterview.d_4 == 2 && fctabletinterview.d_5 == 5) || (fctabletinterview.d_4 == 5 && fctabletinterview.d_5 == 2)))
          if sensitive_value >= 13 && sensitive_value <= 20
            fctabletinterview.skin_type = "skin_type_jungsung_senstive"
          else
            fctabletinterview.skin_type = "skin_type_jungsung"
          end
        end

        fctabletinterview.save
      # end
    end
  end

  def find_lcare_user
    # L-Care 통합회원 조회 이름, 생년월일, 핸드폰번호, 통합회원여부 조건으로 고객정보 조회 (* Next 조회 필요)
    lcare_user = LcareUser.where(cust_hnm: params[:cust_hnm], birth_year: params[:birth_year], birth_mmdd: params[:birth_mmdd], cell_phnno: params[:cell_phnno], u_cust_yn: "Y").first
    if !lcare_user.nil?
      render json: lcare_user.to_api_hash, status: :ok
    else
      render json: "", status: 404
    end
  end

  def find_n_cust_id
    user = Custinfo.where(n_cust_id: params[:n_cust_id]).first
    if !user.nil?
      render json: user.to_api_hash, status: :ok
    else
      render json: "", status: 404
    end
  end

  def permitted_param
    permitted = params.permit(:custserial, :tablet_interview_id, :a_1,:a_2,:a_3,:b_1,:b_2,:b_3,:b_4,:b_5,:b_6,:c_1,:d_1,:d_2,:d_3,:d_4,:d_5,:d_6,:d_7,:d_8,:d_9,:d_10,:d_11,
    :skin_type,:before_solution_1,:after_solution_1,:before_solution_2,:after_solution_2, :before_production, :after_production,
    :before_ample_1,:after_ample_1,:before_ample_2,:after_ample_2,:uptdate,:is_agree_after,:mmode,:brefore_production,:after_production,:bb_base,
    :before_cushion_1,:after_cushion_1,:before_cushion_2,:after_cushion_2,:fcdata_id,:is_agree_cant_refund,:turnover_value,:corneous_value,:stress_value,:bb_base_before,:bb_base_after)
  end
end
