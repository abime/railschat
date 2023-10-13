include Facebook::Messenger

Facebook::Messenger::Profile.set({
  get_started: {
    payload: 'MENU',

  }
}, access_token: ENV['ACCESS_TOKEN'])


message_array = []
Bot.on :message do |message|
  message.mark_seen
  message.typing_on
  message_array << message.text
  visitor_id = message.sender["id"]
  # visitor = Visitor.where(s_id: visitor_id).first
  # visitor.messages = message_array
  # visitor.save  
  
  p "###______________________________" 
  p message_array
   message.reply(text: "Hello Human, I am TWB's personal assistent.") 
   message.reply(
    attachment: {
      type: 'template',
      payload: {
        template_type: 'button',
        text: "Want to know What we do ??",
        buttons: [
          { type: 'postback', title: 'Yes', payload: 'MENU' },
          { type: 'postback', title: 'No', payload: 'negetive' }
        ]
      }
    }
  )
end



Bot.on :postback do |postback|
  postback.mark_seen
  postback.typing_on
  
  visitor_id = postback.sender["id"]
  response = HTTParty.get('https://graph.facebook.com/v2.6/'+visitor_id+'?fields=first_name,last_name,profile_pic&access_token='+ENV['ACCESS_TOKEN']  , format: :plain)
  visitor_hash = JSON.parse response, symbolize_names: true
  # if Visitor.where(s_id: visitor_id).count < 1
  #   visitor = Visitor.new
  #   visitor.s_id = visitor_id
  #   visitor.first_name = visitor_hash[:first_name]
  #   visitor.last_name = visitor_hash[:last_name]
  #   visitor.messages = message_array
  #   visitor.save
  # end

  case postback.payload 
  when "MENU"  
    postback.reply(
      attachment: {
      type: 'template',
      payload: {
        template_type: 'button',
        text: 'WELCOME TO WEDDING BOOTH !!',
        buttons: [
          { type: 'postback', title: 'Prospectus', payload: 'prospectus' },
          { type: 'postback', title: 'Gallery', payload: 'photo_galleries' },
          { type: 'postback', title: 'Know us', payload: 'know_us' }
        ]
      }
    }
  )

  when "prospectus"
    postback.reply(
      attachment: {
        type: 'file',
        payload: {
          url: 'https://drive.google.com/uc?export=download&id=1TmRGbZoY2Km7xaXWwd5pV9fX1TegiiAU'
        }
      }
    )
  

  when 'photo_galleries'
    image_ids = []
    session = GoogleDrive::Session.from_config("config.json") 
    a = session.folders_by_name("The Wedding Booth")
    a.files.each{|a| image_ids<< a.id }
    images_to_show = image_ids.sample(3)
    postback.reply(text: "Wait. . . Fetching best from our collection")

    postback.reply(
      attachment: {
        type: 'image',
        payload: {
          url: 'https://drive.google.com/uc?export=download&id='+images_to_show[0]
        }
      }
    )

    postback.reply(
      attachment: {
      type: 'template',
      payload: {
        template_type: 'button',
        text: "want to see more ? ",
        buttons: [
          { type: 'postback', title: 'Show more', payload: 'photo_galleries' },
          { type: 'postback', title: 'Menu', payload: 'MENU' },
        ]
      }
    }
  )



  when 'know_us'
    postback.reply(
      attachment: {
      type: 'template',
      payload: {
        template_type: 'button',
        text: 'We are a photography based firm incorporated in Bhopal. Holding Expertisement in Candid
Wedding Photography, Wedding Films, Pre/Post Wedding Shoots, Baby Shoots and Documentaries.',
        buttons: [
          { type: 'postback', title: 'Know Team', payload: 'team' },
          { type: 'postback', title: 'Collaborate', payload: 'collaborate' }
        ]
      }
    }
  )

  when 'team'
    postback.reply(
      attachment: {
        type: 'template',
        payload: {
          template_type: 'button',
          text: 'The Three Musketeers',
          buttons: [
            { type: 'web_url', title: 'ANAND', url: 'https://www.facebook.com/BabaPhotonath' },
            { type: 'web_url', title: 'APOORV', url: 'https://www.facebook.com/apoorv.shrivastava3' },
            { type: 'web_url', title: 'SWAPNIL', url: 'https://www.facebook.com/swapnil.namdev'}
          ]
        }
      }
    )
          
  when "collaborate"
    postback.reply(text: "Thank you for showing interest in WB.")
    postback.reply(text: "Drop in your portfolio link at dweddingbooth@gmail.com")


  else   
    postback.reply(text: "Thank you for visiting. BYEBYE")
  end

end




# Text-message
# Bot.on :message do |message|
#   message_detail = Hash.new
#   message_detail["_id"] = message.id          # => 'mid.1457764197618:41d102a3e1ae206a38'
#   message_detail["sender_id"] = message.sender      # => { 'id' => '1008372609250235' }
#   message_detail["sequence"] = message.seq         # => 73
#   message_detail["sent_at"] = message.sent_at     # => 2016-04-22 21:30:36 +0200
#   message_detail["text"] = message.text        # => 'Hello, bot!'
#   message_detail["attachments"] = message.attachments # => [ { 'type' => 'image', 'payload' => { 'url' => 'https://www.example.com/1.jpg' } } ]
#   to_reply = reply_gen(message_detail)
#   message.typing_on
#   message.reply(text: to_reply)
#   message.typng_off
# end




