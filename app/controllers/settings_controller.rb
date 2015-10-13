class SettingsController < ApplicationController
  def edit
    @setting = Setting.first_or_initialize
  end

  def update
    @setting = Setting.first_or_initialize
    @setting.attributes = setting_params
    @setting.save
    render :edit
  end

  private

  def setting_params
    params.require(:setting).permit(:root_path)
  end
end
