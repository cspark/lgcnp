class FctabletinterviewsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create, :calculate]
  skip_before_action :verify_authenticity_token

  def index
    tabletinterview = Fctabletinterview.all
    render json: api_hash_for_list(tabletinterview, page: 1), status: :ok
  end

  def find_interviews
    serial = params[:custserial].to_s
    tabletinterviews = Fctabletinterview.where(custserial: serial).where(is_quick_mode: "F")
    Rails.logger.info tabletinterviews.count
    if tabletinterviews.count.to_i > 0
      render json: api_hash_for_list(tabletinterviews), status: :ok
    else
      render json: "", status: 404
    end
  end

  def fctabletinterviews_quickmode
    tabletinterview = Fctabletinterview.new(permitted_param)
    tabletinterview.tablet_interview_id = Fctabletinterview.all.count
    t = Time.now
    tabletinterview.uptdate = t.strftime("%Y-%m-%d-%H-%M")
    tabletinterview.is_quick_mode = "T"

    tabletinterview.is_make_up = "T"
    if tabletinterview.a_1 == "2.0"
      tabletinterview.is_make_up = "F"
    end

    if tabletinterview.save
      render json: tabletinterview.to_api_hash, status: :ok
    else
      render json: "", status: 404
    end
  end

  def fctabletinterviews_update_lots
    Rails.logger.info params[:tablet_interview_id]
    existed_interview = Fctabletinterview.where(tablet_interview_id: params[:tablet_interview_id]).last
    if existed_interview.update(permitted_param)
      render json: existed_interview.to_api_hash, status: :ok
    else
      render json: "", status: 404
    end
  end

  def create
    tabletinterview = Fctabletinterview.new(permitted_param)
    tabletinterview.tablet_interview_id = Fctabletinterview.all.count
    t = Time.now
    tabletinterview.uptdate = t.strftime("%Y-%m-%d-%H-%M")

    if tabletinterview.save
      render json: tabletinterview.to_api_hash, status: :ok
    else
      render json: "", status: 404
    end
  end

  def update_interviews
    Rails.logger.info params[:tablet_interview_id]
    existed_interview = Fctabletinterview.where(tablet_interview_id: params[:tablet_interview_id]).last
    if existed_interview.update(permitted_param)
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
    Fctabletinterview.where(skin_type: nil).each do |fctabletinterview|
        calculate_value = 0
        calculate_value = calculate_value + get_answer(value: fctabletinterview.d_1)
        calculate_value = calculate_value + get_answer(value: fctabletinterview.d_2)
        calculate_value = calculate_value + get_answer(value: fctabletinterview.d_3)
        calculate_value = calculate_value + get_answer(value: fctabletinterview.d_4)
        calculate_value = calculate_value + get_answer(value: fctabletinterview.d_5)
        calculate_value = calculate_value + get_answer(value: fctabletinterview.d_6)
        calculate_value = calculate_value + get_answer(value: fctabletinterview.d_7)
        calculate_value = calculate_value + get_answer(value: fctabletinterview.d_8)
        calculate_value = calculate_value + get_answer(value: fctabletinterview.d_9)
        calculate_value = calculate_value + get_answer(value: fctabletinterview.d_10)

        sensitive_value = 0
        sensitive_value = sensitive_value + get_sensitive_value(value: fctabletinterview.d_1)
        sensitive_value = sensitive_value + get_sensitive_value(value: fctabletinterview.d_2)
        sensitive_value = sensitive_value + get_sensitive_value(value: fctabletinterview.d_3)
        sensitive_value = sensitive_value + get_sensitive_value(value: fctabletinterview.d_4)
        sensitive_value = sensitive_value + get_sensitive_value(value: fctabletinterview.d_5)
        sensitive_value = sensitive_value + get_sensitive_value(value: fctabletinterview.d_6)
        sensitive_value = sensitive_value + get_sensitive_value(value: fctabletinterview.d_7)
        sensitive_value = sensitive_value + get_sensitive_value(value: fctabletinterview.d_8)
        sensitive_value = sensitive_value + get_sensitive_value(value: fctabletinterview.d_9)
        sensitive_value = sensitive_value + get_sensitive_value(value: fctabletinterview.d_10)

        if calculate_value >= 17
          if sensitive_value >= 13 && sensitive_value <= 20
            fctabletinterview.skin_type = "skin_type_jisung_senstive"
          elsif (sensitive_value >= 5 && sensitive_value <= 12)
            fctabletinterview.skin_type = "skin_type_jisung"
          end
        end

        if calculate_value >= 13 && calculate_value <= 16
          if sensitive_value >= 13 && sensitive_value <= 20
            fctabletinterview.skin_type = "skin_type_jisung_boghab_senstive"
          elsif (sensitive_value >= 5 && sensitive_value <= 12)
            fctabletinterview.skin_type = "skin_type_jisung_boghab"
          end
        end

        if calculate_value >= 10 && calculate_value <= 12
          if sensitive_value >= 13 && sensitive_value <= 20
            fctabletinterview.skin_type = "skin_type_gun_boggab_senstive"
          elsif (sensitive_value >= 5 && sensitive_value <= 12)
            fctabletinterview.skin_type = "skin_type_gun_boggab"
          end
        end

        if calculate_value >= 5 && calculate_value <= 9
          if sensitive_value >= 13 && sensitive_value <= 20
            fctabletinterview.skin_type = "skin_type_gunsung_senstive"
          elsif (sensitive_value >= 5 && sensitive_value <= 12)
            fctabletinterview.skin_type = "skin_type_gunsung"
          end
        end

        if (fctabletinterview.d_4 == 5 && fctabletinterview.d_5 == 5) || (fctabletinterview.a_2 == 4 && ((fctabletinterview.d_4 == 2 && fctabletinterview.d_5 == 3) || (fctabletinterview.d_4 == 2 && fctabletinterview.d_5 == 5) || (fctabletinterview.d_4 == 5 && fctabletinterview.d_5 == 2)))
          if sensitive_value >= 13 && sensitive_value <= 20
            fctabletinterview.skin_type = "skin_type_jungsung_senstive"
          elsif (sensitive_value >= 5 && sensitive_value <= 12)
            fctabletinterview.skin_type = "skin_type_jungsung"
          end
        end

        fctabletinterview.save
      end
  end

  def permitted_param
    permitted = params.permit(:custserial, :tablet_interview_id, :a_1,:a_2,:a_3,:b_1,:b_2,:b_3,:b_4,:c_1,:d_1,:d_2,:d_3,:d_4,:d_5,:d_6,:d_7,:d_8,:d_9,:d_10,
    :skin_type,:before_solution_1,:after_solution_1,:before_solution_2,:after_solution_2,
    :before_serum,:after_serum,:before_ample_1,:after_ample_1,:before_ample_2,:after_ample_2,
    :before_made_cosmetic,:after_made_cosmetic,:ch_cd, :base_lot, :ampoule_1_lot, :ampoule_2_lot, :is_quick_mode, :mixer_name, :fcdata_id, :memo, :is_agree_cant_refund)
  end
end
