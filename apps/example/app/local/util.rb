module Util
  def self.flash_message(model_nm, action_nm, level)
    resource = I18n.t("activerecord.models.#{model_nm}")
    I18n.t("view.#{level}.#{action_nm}", { resource: resource })
  end

  def self.flash_notice(model_nm, action_nm)
    flash_message(model_nm, action_nm, :notice)
  end

  def self.flash_alert(model_nm, action_nm)
    flash_message(model_nm, action_nm, :alert)
  end
end
