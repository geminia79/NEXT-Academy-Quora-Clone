
get '/question/:id/upvote' do 
	QuestionVote.create(question_id)
	erb :'answers/edit'
end
