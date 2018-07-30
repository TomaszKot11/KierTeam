class SlackService

  def initialize(mail, msg)
    @email = mail
    @message = msg
  end

  def call
    send_message
  end

  private


  def send_message
    config_slack_bot
    client = Slack::Web::Client.new
    client.auth_test
    user_info = find_user_id(client)
    raise UnableToCreateShipments, 'Unable to send slack notification' if user_info.count > 1
    opened = client.im_open(user: user_info[0].id)
    channel_id = opened.channel.id
    client.chat_postMessage(channel: channel_id, text: 'Hello with direct message', as_user: true)
    client.im_close(channel: channel_id)
  end


  def config_slack_bot
    Slack.configure do |config|
      config.token = Rails.application.credentials.slack[:access_key]
    end
  end
  def find_user_id(client)
    user_list = client.users_list
    # filter out bots
    # left this code in case of strange Slack API behaviour
    # living_users = user_list.members.select { |user| user.is_bot == false }
    # SLACK WTF? slackbot is also bot...

    # left this code in case of strange Slack API behaviour
    #living_users.select { |member| member.profile.email ==  'kottomasz98@gmail.com' }
    user_list.members.select { |member| member.profile.email == 'kottomasz98@gmail.com' }
  end

end