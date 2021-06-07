module ApplicationHelper
  def page_title(page_title = '')
    base_title = "emory"
    if page_title.empty?
      base_title
    else
      page_title + " - " + base_title
    end
  end

  def week_of_month(date = Date.today)
    first_week = (date - (date.day - 1)).cweek
    this_week = date.cweek

    # 年末は暦週が 1 になったり、逆に年始に暦週が 53 に
    # なることがあるため、その対処を以下でする
    if this_week < first_week
    
      if date.month == 12
        # 年末の場合は、前週同曜日の週番号を求めて + 1 してあげればよい
        # ここを通ることがあるのは、大晦日とその前の数日となる
        return week_of_month(date - 7) + 1
      
      else
        # 年始の場合は、月初の数日が 53 週目に組み込まれてしまっている
        # 二週目以降にここを通ることがある
        return this_week + 1
      end
    end
  
    return this_week - first_week + 1
  end
end
