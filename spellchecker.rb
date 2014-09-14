require 'ffi/aspell'
require 'pry'
#
# speller = FFI::Aspell::Speller.new('en_US')
#
# if speller.correct?('cookie')
#   puts 'Cookie'
# else
#   puts 'Misspelled'
# end

# config  = FFI::Aspell.config_new
# speller = FFI::Aspell.speller_new(config)
# word    = 'cooke'
# valid   = FFI::Aspell.speller_check(speller, word, word.length)
#
# if valid
#   puts 'The word "cookie" is valid'
# else
#   puts 'The word "cookie" is invalid'
# end

speller  = FFI::Aspell.speller_new(FFI::Aspell.config_new)
word     = 'cookie'
list     = FFI::Aspell.speller_suggest(speller, word, word.length)
elements = FFI::Aspell.word_list_elements(list)
words    = []

while word = FFI::Aspell.string_enumeration_next(elements)
  words << word
  binding.pry
end

FFI::Aspell.string_enumeration_delete(elements)
FFI::Aspell.speller_delete(speller)
