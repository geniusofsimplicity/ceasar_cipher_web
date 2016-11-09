require "sinatra"
require "sinatra/reloader" if development?

helpers do
	def caesar_cipher(text, shift) 
		result = ""
		text.each_byte do |code|
			unless " !0123456789".scan(/./).include?(code.chr)
				code_init = code
				shift = shift % 26
				code += shift
				if ((code > 90 && code_init <= 90)||(code > 122 && code_init <= 122))
					code -= 26
				end
			end
			result += code.chr
		end
		result
	end
end

get '/' do
	text = params["normal_text"]
	shift_factor = params["shift_factor"]
	shift_factor = shift_factor ? shift_factor.to_i : 5
	ciphered_text = caesar_cipher(text, shift_factor) if text
  erb :index, {locals: {ciphered_text: ciphered_text}}
end