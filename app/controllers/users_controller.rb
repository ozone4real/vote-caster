class UsersController < ApplicationController
  post "/register" do
    @user = User.new(params.slice("email", "password", "first_name", "last_name"))
    if @user.save
      session[:user] = {id: @user.id}
      
      redirect '/'
    else
      @errors = @user.errors.messages
      erb :'sign_up_form.html'
    end
  end

  get '/login' do
    @user = User.new
    erb :'sign_in_form.html'
  end

  get '/register' do
    @user = User.new
    @errors = @user.errors.messages
    erb :'sign_up_form.html'
  end


  post '/login' do
    @user = User.find_by(email: params[:email])
    
    valid = @user&.authenticate(params[:password])
    if valid
      session[:user] = {id: @user.id}
      # flash[:now] = "Welcome #{@user.first_name}"
      redirect to '/' 
    end
    @error = "Invalid email or password"
    erb :'sign_in_form.html'
  end

  get'/logout' do
    session[:user] = nil
    redirect to '/login'
  end
end