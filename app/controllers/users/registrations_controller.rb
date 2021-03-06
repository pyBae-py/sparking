class Users::RegistrationsController < Devise::RegistrationsController
  # POST /resource
  def create
    super
    
    resource.update_attribute(:phone, params[:user][:phone].gsub(/\D/, ''))
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    change_password = true
    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
      new_params = params.require(:user).permit(:name, :email, :phone, :avatar)
      change_password = false
    end

    @user = User.find(current_user.id)
    is_valid = false

    if change_password
      is_valid = @user.update_with_password(new_params)
    else
      is_valid = @user.update_without_password(new_params)
    end

    if is_valid
      set_flash_message :notice, :updated
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end

    unless params[:user][:phone].nil?
      resource.update_attribute(:phone, params[:user][:phone].gsub(/\D/, ''))
    end
  end

  protected

  def after_sign_up_path_for(resource)
    user_path(@user.id)
  end

  def after_update_path_for(resource)
    user_path(@user.id)
  end
  
  def sign_up_params
    params.require(:user).permit(:name, :email, :phone, :password, :password_confirmation, licenseplates_attributes: Licenseplate.attribute_names.map(&:to_sym).push(:_destroy))
  end

end
