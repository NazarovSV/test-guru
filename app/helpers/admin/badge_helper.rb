module Admin::BadgeHelper
  def rules
    Badge.rule_types.map { |rule, _id| [translate_rule(rule), rule] }
  end

  def translate_rule(rule)
    t("custom_helper.rules.#{rule}")
  end
end
