module Admin::BadgeHelper
  def rules
    output = []

    Badge::RULES.each do |rule|
      output << [translate_rule(rule), rule]
    end
    output
  end

  def translate_rule(rule)
    t("custom_helper.rules.#{rule}")
  end
end
