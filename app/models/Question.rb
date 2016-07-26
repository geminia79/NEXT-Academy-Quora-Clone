class Question < ActiveRecord::Base
	belongs_to :user
	has_many :answers
	has_many :question_votes
	
	def self.ask_question(user_id, question)
		create(user_id: user_id, question: question)
	end

	def count_upvotes
		self.question_votes.where(vote: 1).count
	end

	def count_downvotes
		self.question_votes.where(vote: 0).count
	end
end