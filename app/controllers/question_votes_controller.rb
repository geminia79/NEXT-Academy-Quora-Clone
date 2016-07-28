post '/question/:id/upvote' do 
	if logged_in?
		vote = QuestionVote.find_by(question_id: params[:id], user_id: current_user.id)
		if vote # Check if question has been voted by user
			if vote.vote == 1 # Check if vote is an upvote
				@message = "You can only upvote once per question"
				@question = Question.find(params[:id])
				erb :'questions/show'
			else # If vote is a downvote, change vote to upvote
				@message = "Your vote has been changed to upvote"
				vote.update(vote: 1)
				@question = Question.find(params[:id])
				erb :'questions/show'
			end
		else # If question has not been voted, create new vote
			@message = "You have upvoted for this question"
			current_user.question_votes.create(question_id: params[:id], vote: 1)
			@question = Question.find(params[:id])
			erb :'questions/show'
		end
	else
		@message = "Please login to vote"
		erb :'sessions/new'
	end
end

post '/question/:id/downvote' do 
	if logged_in?
		vote = QuestionVote.find_by(question_id: params[:id], user_id: current_user.id)
		if vote # Check if question has been voted by user
			if vote.vote == 0 # Check if vote is an downvote
				@message = "You can only downvote once per question"
				@question = Question.find(params[:id])
				erb :'questions/show'
			else # If vote is a upvote, change vote to downvote
				@message = "Your vote has been changed to downvote"
				vote.update(vote: 0)
				@question = Question.find(params[:id])
				erb :'questions/show'
			end
		else # If question has not been voted, create new vote
			@message = "You have downvoted for this question"
			current_user.question_votes.create(question_id: params[:id], vote: 0)
			@question = Question.find(params[:id])
			erb :'questions/show'
		end
	else
		@message = "Please login to vote"
		erb :'sessions/new'
	end
end
