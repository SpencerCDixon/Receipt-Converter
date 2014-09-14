require 'tesseract'
require 'ffi/aspell'
require 'pry'

class String
  def cost_to_f
    self.delete('$,').to_f
  end
end

class Receipt
  attr_reader :path

  def initialize(path)
    @engine = Tesseract::Engine.new {|e| e.language = :eng}
    @path = path
  end

  def transcribe
    @engine.text_for(path)
  end

end

path = '~/Desktop/trader2.jpg'
codepen = Receipt.new(path)
text = codepen.transcribe

# confidence = codepen.confidence(path)

sentences = text.split("\n")
split_sentence = sentences[-4].split(' ')

new_sentence = []
split_sentence.each do |w|
  # Try and fix an individual sentence
  speller  = FFI::Aspell.speller_new(FFI::Aspell.config_new)
  word     = w
  valid = FFI::Aspell.speller_check(speller, w, w.length)
  if valid
    new_sentence << word
  elsif word.cost_to_f > 0
    new_sentence << word
  else

    list     = FFI::Aspell.speller_suggest(speller, word, word.length)
    elements = FFI::Aspell.word_list_elements(list)
    words    = []

    while word = FFI::Aspell.string_enumeration_next(elements)
      words << word
      if word == "SUBTOTAL"
        new_sentence << words[1]
      end
    end

    FFI::Aspell.string_enumeration_delete(elements)
    FFI::Aspell.speller_delete(speller)
  end
end


puts new_sentence
