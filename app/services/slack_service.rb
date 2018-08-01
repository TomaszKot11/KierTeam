class SlackService
  def initialize(mail, problem_title, full_name, url)
    @email = mail
    @problem_title = problem_title
    @full_name = full_name
    @url = url
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
    raise ArgumentError, 'Unable to send slack notification' if user_info.count > 1 || user_info[0].nil?
    msg = prepare_message(user_info[0])
    opened = client.im_open(user: user_info[0].id)
    channel_id = opened.channel.id
    client.chat_postMessage(
      channel: channel_id,
      text: msg,
      as_user: false,
      icon_emoji: ':ghost:',
      username: 'BinarStackNotifier'
    )
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

    # left this code in case of strange Slack API behaviour
    user_list.members.select { |member| member.profile.email == @email }
  end

  # maybe should be parsed from view?
  def prepare_message(user_info)
    "Hey <@#{user_info.id}>, I need your help with '#{@problem_title}'.\nSee it at: <#{@url}>\nBest,\n#{@full_name}"
  end
end
