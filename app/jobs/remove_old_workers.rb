class RemoveOldAuthors < ApplicationJob
	queue_as :default

	def perform(*args)
		Users.old.destroy_all
	end


end