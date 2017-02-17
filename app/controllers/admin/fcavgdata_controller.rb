class Admin::FcavgdataController < Admin::AdminApplicationController
  skip_before_action :verify_authenticity_token
  before_action :is_admin

  def list
    @fcavgdatas = Fcavgdata.all.order("n_index asc")
    @fcavgdatas_list = []
    temp_list = []

    @fcavgdatas.each do |data|
      if data.n_index.to_i >= 1 && data.n_index.to_i <= 6
        temp_list.push(data)
        if data.n_index.to_i == 6
          @fcavgdatas_list.push(temp_list)
          temp_list = []
        end
      end
      if data.n_index.to_i >= 7 && data.n_index.to_i <= 10
        temp_list.push(data)
        if data.n_index.to_i == 10
          @fcavgdatas_list.push(temp_list)
          temp_list = []
        end
      end
      if data.n_index.to_i >= 11 && data.n_index.to_i <= 14
        temp_list.push(data)
        if data.n_index.to_i == 14
          @fcavgdatas_list.push(temp_list)
          temp_list = []
        end
      end
      if data.n_index.to_i >= 15 && data.n_index.to_i <= 18
        temp_list.push(data)
        if data.n_index.to_i == 18
          @fcavgdatas_list.push(temp_list)
          temp_list = []
        end
      end
      if data.n_index.to_i >= 19 && data.n_index.to_i <= 22
        temp_list.push(data)
        if data.n_index.to_i == 22
          @fcavgdatas_list.push(temp_list)
          temp_list = []
        end
      end
      if data.n_index.to_i >= 23 && data.n_index.to_i <= 26
        temp_list.push(data)
        if data.n_index.to_i == 26
          @fcavgdatas_list.push(temp_list)
          temp_list = []
        end
      end
      if data.n_index.to_i >= 27 && data.n_index.to_i <= 30
        temp_list.push(data)
        if data.n_index.to_i == 30
          @fcavgdatas_list.push(temp_list)
          temp_list = []
        end
      end
      if data.n_index.to_i >= 31 && data.n_index.to_i <= 34
        temp_list.push(data)
        if data.n_index.to_i == 34
          @fcavgdatas_list.push(temp_list)
          temp_list = []
        end
      end
      if data.n_index.to_i >= 35 && data.n_index.to_i <= 38
        temp_list.push(data)
        if data.n_index.to_i == 38
          @fcavgdatas_list.push(temp_list)
          temp_list = []
        end
      end
      if data.n_index.to_i >= 39 && data.n_index.to_i <= 42
        temp_list.push(data)
        if data.n_index.to_i == 42
          @fcavgdatas_list.push(temp_list)
          temp_list = []
        end
      end
      if data.n_index.to_i >= 43 && data.n_index.to_i <= 46
        temp_list.push(data)
        if data.n_index.to_i == 46
          @fcavgdatas_list.push(temp_list)
          temp_list = []
        end
      end
      if data.n_index.to_i >= 47 && data.n_index.to_i <= 50
        temp_list.push(data)
        if data.n_index.to_i == 50
          @fcavgdatas_list.push(temp_list)
          temp_list = []
        end
      end
      if data.n_index.to_i >= 51 && data.n_index.to_i <= 54
        temp_list.push(data)
        if data.n_index.to_i == 54
          @fcavgdatas_list.push(temp_list)
          temp_list = []
        end
      end
      if data.n_index.to_i >= 55 && data.n_index.to_i <= 58
        temp_list.push(data)
        if data.n_index.to_i == 58
          @fcavgdatas_list.push(temp_list)
          temp_list = []
        end
      end
    end

    @fcavgdatas_list = Kaminari.paginate_array(@fcavgdatas_list).page(params[:page]).per(1)
  end
end
