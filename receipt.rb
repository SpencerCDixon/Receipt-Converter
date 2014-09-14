require 'tesseract'
require 'pry'


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


path = '~/Desktop/receipt1.png'
codepen = Receipt.new(path)
text = codepen.transcribe
# confidence = codepen.confidence(path)

sentences = text.split("\n")
sentences[9]
binding.pry
