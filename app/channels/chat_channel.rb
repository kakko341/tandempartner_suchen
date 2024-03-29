class ChatChannel < ApplicationCable::Channel
  
  def subscribed
    stream_from "chat_channel_#{params[:room_id]}"
  end
  
  def unsubscribed
  end
  
  def speak(data)
    from_user = User.find_by(id: data['from_id'].to_s)
    to_user = User.find_by(id: data['to_id'].to_s)
    from_user.send_talk(to_user, data['room_id'], data['content'])
  end
end
