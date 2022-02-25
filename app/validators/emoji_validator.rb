class EmojiValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    unavailable_chars = value.scan(/\X/).any? { |i| !i.match?(/\p{Emoji}/) }
    record.errors.add(attribute, '絵文字以外の文字は入力できません') if unavailable_chars.present?
  end
end
