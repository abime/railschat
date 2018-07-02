include Facebook::Messenger
require 'wit'
require 'facebook/messenger'



message_detail = Hash.new
Bot.on :message do |message|
  binding.pry
  # message_detail["_id"] = message.id          # => 'mid.1457764197618:41d102a3e1ae206a38'
  # message_detail["sender_id"] = message.sender      # => { 'id' => '1008372609250235' }
  # message_detail["sequence"] = message.seq         # => 73
  # message_detail["sent_at"] = message.sent_at     # => 2016-04-22 21:30:36 +0200
  # message_detail["text"] = message.text        # => 'Hello, bot!'
  # message_detail["attachments"] = message.attachments # => [ { 'type' => 'image', 'payload' => { 'url' => 'https://www.example.com/1.jpg' } } ]
  # message_detail["nlp" ]= message.nlp
  # message.reply(text: wit(message_detail))
end


# def wit(text)

#   # client = Wit.new(access_token: 'KD5OZVLQ6YWXRT3FVH2MQHC2HGRBIV4C')
#   # wit_reply_header = client.message(text)
#   # if reply=wit_reply_header["entities"]["intent"].present?
#     # return reply=wit_reply_header["entities"]["intent"].first["value"]
#   # else
#   # end    
# end

