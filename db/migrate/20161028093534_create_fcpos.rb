class CreateFcpos < ActiveRecord::Migration[5.0]
  def change
    create_table :fcpos do |t|
      t.string :CUSTSERIAL, null:false
      t.string :FACENO
      t.string :MEASUREDATE
      t.integer :MEASURENO
      t.string :UPTDATE
      t.integer :FH_X
      t.integer :FH_Y
  	 	t.integer :FH_W
  	  t.integer	:FH_H
      t.integer	:NS_X
     	t.integer	:NS_Y
    	t.integer	:NS_W
    	t.integer	:NS_H
    	t.integer	:RES_X
    	t.integer :RES_Y
      t.integer	:RES_W
    	t.integer	:RES_H
    	t.integer	:REU_X
    	t.integer	:REU_Y
    	t.integer	:REU_W
      t.integer	:REU_H
    	t.integer	:LES_X
    	t.integer	:LES_Y
    	t.integer	:LES_W
    	t.integer	:LES_H
    	t.integer	:LEU_X
    	t.integer	:LEU_Y
    	t.integer :LEU_W
    	t.integer :LEU_H
      t.integer :RS_X
    	t.integer :RS_Y
    	t.integer :RS_W
    	t.integer :RS_H
    	t.integer :LS_X
    	t.integer :LS_Y
    	t.integer :LS_W
      t.integer :LS_H
    	t.integer	:RT_RE_L
    	t.integer	:RT_RE_T
    	t.integer :RT_RE_R
    	t.integer	:RT_RE_B
    	t.integer	:RT_LE_L
    	t.integer	:RT_LE_T
    	t.integer	:RT_LE_R
    	t.integer :RT_LE_B
    	t.integer :RT_LIP_L
      t.integer :RT_LIP_T
    	t.integer :RT_LIP_R
    	t.integer :RT_LIP_B
    	t.integer :RT_RES_X
   	  t.integer :RT_RES_Y
    	t.integer	:RT_LES_X
    	t.integer :RT_LES_Y

      t.timestamps
    end
  end
end
