class TalkBroadcastJob < ApplicationJob

  def perform(talk)
    ActionCable.server.broadcast "chat_channel_#{talk.room_id}",
                                 talk: render_talk(talk)
  end
  
  private
  
    def render_talk(talk)
      ApplicationController.renderer.render(partial: 'talks/talk',
                                            locals: {talk: talk})
    end
end
