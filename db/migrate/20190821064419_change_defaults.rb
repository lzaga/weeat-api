class ChangeDefaults < ActiveRecord::Migration[6.0]
  change_column_default :restaurants, :ten_bis, from: true, to: false
end
