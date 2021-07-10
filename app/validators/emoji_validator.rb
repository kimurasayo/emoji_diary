class EmojiValidator < ActiveModel::EachValidator
  # ひらがなカタカナ、漢字、半角ローマ字大文字小文字、半角数字、全角数字、全角ローマ字大文字小文字、全角半角記号、ハングル入力を許可しない
  def validate_each(record, attribute, value)
    return if value.blank?

    unavailable_chars = value.scan(/\A(?=.*?[ぁ-んァ-ン一-龥ｧ-ﾝﾞﾟ!-~０-９ａ-ｚＡ-Ｚ！-／：-＠［-｀｛-～、-〜”’・가-힣
    \p{Arabic}\p{Armenian}\p{Bengali}\p{Bopomofo}\p{Braille}\p{Buhid}\p{Canadian_Aboriginal}\p{Cherokee}\p{Cyrillic}\p{Devanagari}
    \p{Ethiopic}\p{Georgian}\p{Greek}\p{Gujarati}\p{Gurmukhi}\p{Hangul}\p{Han}\p{Hanunoo}\p{Hebrew}\p{Kannada}
    \p{Khmer}\p{Lao}\p{Latin}\p{Limbu}\p{Malayalam}\p{Mongolian}\p{Myanmar}\p{Ogham}\p{Oriya}\p{Runic}\p{Sinhala}\p{Syriac}\p{Tagalog}
    \p{Tagbanwa}\p{TaiLe}\p{Tamil}\p{Telugu}\p{Thaana}\p{Thai}\p{Tibetan}\p{Yi}\p{Egyptian Hieroglyphs}])/)
    record.errors.add(attribute, '絵文字だけ入力できます', chars: unavailable_chars.uniq.join(', ')) if unavailable_chars.present?
  end
end
