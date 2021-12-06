ActiveAdmin.register Course do
  permit_params :name, :prefecture, :introduction, :is_hid

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :user_id, :name, :prefecture, :map_id, :introduction, :image_id, :is_hid
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :name, :prefecture, :map_id, :introduction, :image_id, :is_hid]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

end
