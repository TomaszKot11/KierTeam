class CheckProjects < ApplicationJob
  queue_as :default

  def perform(*args)
	 	ProblemsController.check_projects
  end
end
