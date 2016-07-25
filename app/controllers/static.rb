require 'byebug'
enable :sessions

get '/' do
	@error = session[:error]
	session[:error] = nil
  erb :"static/home"
end

get '/main' do
	erb :"static/index"
end

post '/signup' do
	user = User.new(params["user"])
	if user.valid?
		user.save
		redirect '/'
	else
		session[:error] = user.errors.full_messages
		redirect '/'
	end
end

post '/login' do
	user = User.authentication(params["user"]["email"], params["user"]["password"])
	if user != nil
		session[:id] = user.id
		redirect '/main'
	else
		session[:error] = "Invalid email or password"
		redirect '/'
	end
end

post '/logout' do
	session[:id] = nil
	redirect '/'
end



