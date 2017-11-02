class Admin::FcafterinterviewrxesController < Admin::AdminApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create, :calculate]
  skip_before_action :verify_authenticity_token
  before_action :is_admin

  def show
    custserial = params[:custserial]
    tablet_interview_id = params[:tablet_interview_id]
    after_interview_id = params[:after_interview_id]

    @after_interview = Fcafterinterviewrx.where(custserial: custserial).where(rx_tablet_interview_id: tablet_interview_id).where(after_interview_id: after_interview_id).first
  end

  def show_1
    custserial = params[:custserial]
    tablet_interview_id = params[:tablet_interview_id]
    after_interview_id = params[:after_interview_id]

    @after_interview = Fcafterinterviewrx.where(custserial: custserial).where(rx_tablet_interview_id: tablet_interview_id).where(after_interview_id: after_interview_id).first
  render 'show_1'
  end

  def create_show_1
    tabletinterviewrx = Fctabletinterviewrx.where(custserial: params[:custserial]).where(tablet_interview_id: params[:tablet_interview_id]).first

    @after_interview = Fcafterinterviewrx.new
    @after_interview.custserial = params[:custserial]
    @after_interview.rx_tablet_interview_id = params[:tablet_interview_id]
    @after_interview.after_interview_id = Fcafterinterviewrx.all.count
    @after_interview.rx_tablet_interview_uptdate = tabletinterviewrx.uptdate
    @after_interview.order = 0

    t = Time.now

    time_string = t.strftime("%Y")[2,4]
    time_string = time_string.concat("-")
    time_string = time_string.concat(t.strftime("%m"))
    time_string = time_string.concat("-")
    time_string = time_string.concat(t.strftime("%d"))
    time_string = time_string.concat("-")
    time_string = time_string.concat(t.strftime("%H"))
    time_string = time_string.concat("-")
    time_string = time_string.concat(t.strftime("%M"))
    time_string = time_string.concat("-")
    time_string = time_string.concat(t.strftime("%S"))

    @after_interview.uptdate = time_string
    @after_interview.save

    render 'show_1'
  end

  def update
    custserial = params[:custserial]
    tablet_interview_id = params[:tablet_interview_id]
    after_interview_id = params[:after_interview_id]
    order = params[:order]

    after_interview = Fcafterinterviewrx.where(custserial: custserial).where(rx_tablet_interview_id: tablet_interview_id).where(after_interview_id: after_interview_id).where(order: order).first
    if params[:is_agree_after].present?
      fctabletinterview = Fctabletinterviewrx.where(custserial: custserial, tablet_interview_id: tablet_interview_id).first
      fctabletinterview.is_agree_after = params[:is_agree_after]
      fctabletinterview.save

      custinfo = Custinfo.where(custserial: custserial).where(ch_cd: fctabletinterview.ch_cd).where(measureno: fctabletinterview.fcdata_id).first
      if !custinfo.nil?
        custinfo.is_agree_after = params[:is_agree_after]
        custinfo.save
      end
    end

    after_interview.a1 = params[:a1]

    after_interview.a3 = params[:a3]
    after_interview.a4 = params[:a4]
    after_interview.a5 = params[:a5]
    after_interview.a5 = params[:a6]

    if params.has_key?(:a2)
      after_interview.a2 = params[:a2]
    end
    if params.has_key?(:a1_1)
      after_interview.a1_1 = params[:a1_1]
    end
    if params.has_key?(:a5)
      after_interview.a5 = params[:a5]
    end
    if params.has_key?(:a5_1)
      after_interview.a5_1 = params[:a5_1]
    end
    if params.has_key?(:a6)
      after_interview.a6 = params[:a6]
    end
    if params.has_key?(:a6_1)
      after_interview.a6_1 = params[:a6_1]
    end

    t = Time.now

    time_string = t.strftime("%H")
    time_string = time_string.concat("-")
    time_string = time_string.concat(t.strftime("%m"))
    time_string = time_string.concat("-")
    time_string = time_string.concat(t.strftime("%d"))
    time_string = time_string.concat("-")
    time_string = time_string.concat(t.strftime("%H"))
    time_string = time_string.concat("-")
    time_string = time_string.concat(t.strftime("%M"))
    time_string = time_string.concat("-")
    time_string = time_string.concat(t.strftime("%S"))

    after_interview.uptdate = time_string
    after_interview.save
  end

  def delete
    custserial = params[:custserial]
    tablet_interview_id = params[:tablet_interview_id]
    after_interview_id = params[:after_interview_id]
    order = params[:order]

    after_interview = Fcafterinterviewrx.where(custserial: custserial).where(rx_tablet_interview_id: tablet_interview_id).where(after_interview_id: after_interview_id).where(order: order).first

    after_interview.a1 = nil
    after_interview.a1_1 = nil
    after_interview.a2 = nil
    after_interview.a3 = nil
    after_interview.a3_1 = nil
    after_interview.a4 = nil
    after_interview.a5 = nil
    after_interview.a5_1 = nil
    after_interview.a6 = nil
    after_interview.a7 = nil

    after_interview.save

    fctabletinterview = Fctabletinterviewrx.where(custserial: custserial).where(tablet_interview_id: tablet_interview_id).first
    fctabletinterview.is_agree_after = "F"
    fctabletinterview.save
  end
end
