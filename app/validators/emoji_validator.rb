class EmojiValidator < ActiveModel::EachValidator
  # ひらがなカタカナ、漢字、半角ローマ字大文字小文字、半角数字、全角数字、全角ローマ字大文字小文字、全角半角記号、ハングル等の入力を許可しない
  def validate_each(record, attribute, value)
    return if value.blank?

    unavailable_chars = value.scan(/\X/).any?{ |i| !i.match?(/[\p{Emoji}]/) }
    record.errors.add(attribute, '絵文字以外の文字は入力できません') if unavailable_chars.present?
  end
end
