class CryptoController < ApplicationController
  def encrypt
    cipher = OpenSSL::Cipher::AES128.new(:CBC)
    cipher.encrypt
    cipher.key = Rails.application.config.very_secure_key
    cipher.iv = "16bytesofyour iv"
    if params[:text]
      binary_string = cipher.update(params[:text]) + cipher.final
      @text = [binary_string].pack('m')
    end
  end

  def decrypt
    cipher = OpenSSL::Cipher::AES128.new(:CBC)
    cipher.decrypt
    cipher.key = Rails.application.config.very_secure_key
    cipher.iv = "16bytesofyour iv"
    cipher.padding = 0
    if params[:text]
      binary_string = params[:text].unpack('m')[0]
      @text = cipher.update(binary_string) + cipher.final
    end
  end
end
