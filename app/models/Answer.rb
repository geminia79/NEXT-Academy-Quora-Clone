class Answer < ActiveRecord::Base
	belongs_to :question
	belongs_to :user
	has_many :answer_votes

	def self.answer(question_id, user_id, answer)
		create(question_id: question_id, user_id: user_id, answer: answer)
	end

	def count_upvotes
		self.answer_votes.where(vote: 1).count
	end

	def count_downvotes
		self.answer_votes.where(vote: 0).count
	end
end





