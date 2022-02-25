class LotsOfEmojiValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    record.errors.add(attribute, '絵文字の数が多すぎます、少し減らしてください') if value.scan(/\X/).size > 50
  end
end
