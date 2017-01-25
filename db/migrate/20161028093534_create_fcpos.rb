class CreateFcpos < ActiveRecord::Migration[5.0]
  def change
    create_table :fcpos do |t|
      t.string :custserial, null:false
      t.string :faceno
      t.string :measuredate
      t.integer :measureno
      t.string :uptdate
      t.integer :fh_x
      t.integer :fh_y
  	 	t.integer :fh_w
  	  t.integer	:fh_h
      t.integer	:ns_x
     	t.integer	:ns_y
    	t.integer	:ns_w
    	t.integer	:ns_h
    	t.integer	:res_x
    	t.integer :res_y
      t.integer	:res_w
    	t.integer	:res_h
    	t.integer	:reu_x
    	t.integer	:reu_y
    	t.integer	:reu_w
      t.integer	:reu_h
    	t.integer	:les_x
    	t.integer	:les_y
    	t.integer	:les_w
    	t.integer	:les_h
    	t.integer	:leu_x
    	t.integer	:leu_y
    	t.integer :leu_w
    	t.integer :leu_h
      t.integer :rs_x
    	t.integer :rs_y
    	t.integer :rs_w
    	t.integer :rs_h
    	t.integer :ls_x
    	t.integer :ls_y
    	t.integer :ls_w
      t.integer :ls_h
    	t.integer	:rt_re_l
    	t.integer	:rt_re_t
    	t.integer :rt_re_r
    	t.integer	:rt_re_b
    	t.integer	:rt_le_l
    	t.integer	:rt_le_t
    	t.integer	:rt_le_r
    	t.integer :rt_le_b
    	t.integer :rt_lip_l
      t.integer :rt_lip_t
    	t.integer :rt_lip_r
    	t.integer :rt_lip_b
    	t.integer :rt_res_x
   	  t.integer :rt_res_y
    	t.integer	:rt_les_x
    	t.integer :rt_les_y

      t.timestamps
    end
  end
end
