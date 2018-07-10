namespace :custinfo_lcareuser do
  task :sync do
    n_cust_ids = []
    Custinfo.where(is_delete_cust: ["F",nil]).pluck(:n_cust_id).each do |n_cust_id|
      next if n_cust_id.nil?
      unless LcareUser.exists?(n_cust_id: n_cust_id)
        n_cust_ids << n_cust_id
      end
    end
    n_cust_ids.each do |n_cust_id|
      Custinfo.where(n_cust_id: n_cust_id).update_all(is_delete_cust: "T", delete_cust_dt: Time.now().strftime("%Y-%m-%d %H:%M"))
    end
  end
end
