module InternationalStringGenerator
  CHINESE_RANGE=[*"\u4E00".."\u9FFF"]
  GERMAN_RANGE=['\uXC4', '\uXE4', '\uXC9', '\uXE9', '\uXD6', '\uXF6', '\uXDC', '\uXFC', '\uXDF']
  ENGLISH_RANGE=['']
  NUMERICAL_RANGE=['']
  WHITE_SPACE_CHARACTERS=['\u00A0', '\u3000', [*"\u2002".."\u200B"]].flatten
  MAX_LENGTH_CHARACTERS=['\u00DF', '\u2070E']

  SYNTAX_CHARACTERS=['&', '+', '/', '\\', '"', "'",  '(', ')',  '?', '.', '#', '@', '_', '-', '~']

  def random_multi_lang(length)
    random_characters([[CHINESE_RANGE], [ENGLISH_RANGE], [GERMAN_RANGE]], length)
  end

  def random_multi_lang_sentence(length)
    random_characters([[CHINESE_RANGE], [ENGLISH_RANGE], [GERMAN_RANGE], [WHITE_SPACE_CHARACTERS], []], length)
  end

  # The Chinese, Japanese and Korean (CJK) scripts share a common background, collectively known as CJK characters
  def random_chinese_japanese_korean_characters(length)
    random_characters([CHINESE_RANGE], length)
  end

  def random_english(length)
    random_characters([ENGLISH_RANGE], length)
  end

  def random_english_and_numerical(length)
    random_characters([ENGLISH_RANGE, NUMERICAL_RANGE], length)
  end

  # Some specific german characters such as any that use the umlaut need to be tested
  def random_german(length)
    random_characters(GERMAN_RANGE, length)
  end

  # Generate random characters from various utf8 ranges. Can repeat characters.
  def random_characters(utf8_ranges, length)
    length.times.map { utf8_ranges.flatten.sample(length) }.join("")
  end

  # If a value is required to be less than a certain length, try using this.
  # When the first character is converted to uppercase, the length changes!
  # This can cause problems if a developer is upper-casing strings for a case insensitive compare
  # The second character is a 4 byte character.  If a field has a memory limitation, which it uses
  # a max number of characters to enforce, this could break it.
  def max_length_test_string(length)
    (length / 2).times.map(MAX_LENGTH_CHARACTERS.join(""))
  end

  # If white space is being trimmed, prepend or append this to your string to ensure all white space is being trimmed
  # This includes non breaking spaces, as well as various 'space' characters from various languages.
  #
  # Always 12 characters
  def white_space_test_string
    WHITE_SPACE_CHARACTERS.join("")
  end

  # Syntax significant characters often need to be escaped and then unescaped.
  # It is easy for characters to accidentally get double-escaped, or get escaped differently
  # multiple times in one order and get unescaped in a different order.
  # If a field does not outright disallow these characters,
  # ensure they come back the same as they were entered.
  #
  # Always 15 characters
  def syntax_significant_characters
    SYNTAX_CHARACTERS.join("")
  end

end
