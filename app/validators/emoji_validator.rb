class EmojiValidator < ActiveModel::EachValidator
  # ひらがなカタカナ、漢字、半角ローマ字大文字小文字、半角数字、全角数字、全角ローマ字大文字小文字、全角半角記号、ハングル等の入力を許可しない
  def validate_each(record, attribute, value)
    return if value.blank?

    unavailable_chars = value.scan(/\A(?=.*?[\p{Separator}\p{Math_Symbol}\p{Currency_Symbol}\p{Number}\p{Punctuation}゛｀`゜ー⌘^＾♭〒⌒▽
 \p{Arabic}\p{Armenian}\p{Bengali}\p{Bopomofo}\p{Braille}\p{Buhid}\p{Canadian_Aboriginal}\p{Cherokee}\p{Cyrillic}\p{Devanagari}\p{Ethiopic}\p{Georgian}\p{Greek}\p{Gujarati}\p{Gurmukhi}\p{Hangul}\p{Han}\p{Hanunoo}\p{Hebrew}\p{Kannada}\p{Hiragana}\p{Katakana}\p{Khmer}\p{Lao}\p{Latin}\p{Limbu}\p{Malayalam}\p{Mongolian}\p{Myanmar}\p{Ogham}\p{Oriya}\p{Runic}\p{Sinhala}\p{Syriac}\p{Tagalog}\p{Tagbanwa}\p{TaiLe}\p{Tamil}\p{Telugu}\p{Thaana}\p{Thai}\p{Tibetan}\p{Yi}\p{Egyptian Hieroglyphs}])/)
    record.errors.add(attribute, '絵文字以外の文字は入力できません', chars: unavailable_chars.uniq.join(', ')) if unavailable_chars.present?
  end
end
