post '/questions/:id/tags' do 
	question = Question.find_by(id: params[:id])
	tag = params[:tag][:content].split(",")
	tag.each do |t|
		new_tag = Tag.find_by_content(t)
		if new_tag.nil?
			new_tag = Tag.create(content: t)
		end
		QuestionTag.create(question_id: params[:id], tag_id: new_tag.id)
	end
	redirect '/question/' + question.id.to_s
end

get '/tags/:id' do
	@tag = Tag.find(params[:id])
	@questions = @tag.questions
	erb :"tags/show"
end
