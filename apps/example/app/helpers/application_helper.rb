module ApplicationHelper

  def i18n_attr(attr_key)
    I18n.t("activerecord.attributes.#{attr_key}")
  end

  def i18n_datetime(value)
    I18n.l(value, format: :datetime_minute)
  end

  def multiline_format(content)
    content.blank? ? (tag :br) : safe_join(content.split("\n"), (tag :br))
  end
end
