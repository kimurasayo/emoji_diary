class EmojiValidator < ActiveModel::EachValidator
  # ひらがなカタカナ、漢字、半角ローマ字大文字小文字、半角数字、全角数字、全角ローマ字大文字小文字、全角半角記号、ハングル入力を許可しない
  def validate_each(record, attribute, value)
    return if value.blank?

    unavailable_chars = value.scan(/\A(?=.*?[ぁ-んァ-ン一-龥ｧ-ﾝﾞﾟ!-~０-９ａ-ｚＡ-Ｚ！-／：-＠［-｀｛-～、-〜”’・가-힣])/)
    record.errors.add(attribute, 'only emoji', chars: unavailable_chars.uniq.join(', ')) if unavailable_chars.present?
  end
end
