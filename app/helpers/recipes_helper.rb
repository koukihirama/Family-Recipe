module RecipesHelper
    def difficulty_label(level)
    case level
    when 1
      "⭐️ とても簡単"
    when 2
      "⭐️⭐️ 簡単"
    when 3
      "⭐️⭐️⭐️ 普通"
    when 4
      "⭐️⭐️⭐️⭐️ 少しむずかしい"
    when 5
      "⭐️⭐️⭐️⭐️⭐️ むずかしい"
    else
      ""
    end
  end
end
