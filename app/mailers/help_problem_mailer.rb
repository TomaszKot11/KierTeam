class HelpProblemMailer < ApplicationMailer
  default from: 'binarstack@binarlab.com'

  def help_request_email(problem, current_user)
    @problem = problem
    @user = current_user
    creator = User.find(@problem.creator_id)
    mail(to: creator.email, subject: "Someone needs your help with #{@problem.title}")
  end
end
