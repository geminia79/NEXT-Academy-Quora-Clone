class QuestionVote < ActiveRecord::Base
	belongs_to :question
	belongs_to :user

	# scope :top5, -> {
 #    select("COUNT(vote)").
 #    group("question.id").
 #    order("COUNT(vote) DESC").
 #    limit(5)}
end
