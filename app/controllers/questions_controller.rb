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
	@questions = Question.all
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
	Question.find(params[:id]).destroy
	redirect to '/'
end