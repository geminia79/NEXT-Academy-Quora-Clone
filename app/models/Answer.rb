class Answer < ActiveRecord::Base
	belongs_to :question
	belongs_to :user

	def self.answer(question_id, user_id, answer)
		create(question_id: question_id, user_id: user_id, answer: answer)
	end
end





