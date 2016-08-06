require 'byebug'
post '/question' do
	if logged_in?
		question = Question.ask_question(session[:id], params["question"]["question"])
		redirect to '/question/' + question.id.to_s
	else
		@message = "Please log in first"
		erb :'sessions/new'
	end
end

get '/' do
	# most upvoted questions
	trending = {}
	@trending = []
	upvoted = QuestionVote.where(vote: 1) # extract all the upvoted questions
	question_ids = upvoted.distinct.pluck(:question_id) # extract distinct question ids from the upvoted pool
	question_ids.each do |id| 
	# storing question id and upvote counts in a hash
		trending[id.to_i] = upvoted.where(question_id: id.to_i).count
	end
	# sorting hash by value
	trending = trending.sort_by {|k,v| v}.reverse.to_h
	trending.first(5).each do |key, value|
		# store the first 5 sorted question id in an array
		@trending << key
	end
	# all questions
	@questions = Question.order(created_at: :desc).all.paginate(page: params[:page], per_page: 5)
	# new users
	@users = User.order(created_at: :desc).limit(5)

	erb :"static/index"
end

get '/question/:id' do # individual question page
	@question = Question.find(params[:id])
	erb :'questions/show'
end

get '/question/:id/edit' do # return form to edit question
	@question = Question.find(params[:id])
	erb :'questions/edit'
end

put '/question/:id' do # update question
	question = Question.find(params[:id])
	question.update(params[:question])
	redirect to '/question/' + question.id.to_s
end

delete '/question/:id' do
	Answer.where(question_id: params[:id]).delete_all
	QuestionVote.where(question_id: params[:id]).delete_all
	QuestionTag.where(question_id: params[:id]).delete_all
	Question.find(params[:id]).destroy
	redirect to '/'
end