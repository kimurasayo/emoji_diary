class AEmojiNicknameValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    record.errors.add(attribute, '絵文字は1文字だけ入力してください') if value.scan(/\X/).size != 1
  end
end
