class SettingsController < ApplicationController
  def edit
    @setting = Setting.first
  end

  def update
    @setting = Setting.first
    @setting.update_attributes(setting_params)
    render :edit
  end

  private

  def setting_params
    params.require(:setting).permit(:root_path)
  end
end
