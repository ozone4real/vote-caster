require './config/environment'

class ApplicationController < Sinatra::Base
  configure(:development) { set :session_secret, "here be dragons" }
  
  configure do
    enable :sessions
    set :public_folder, 'public'
    set :views, 'app/views'
    register Sinatra::Flash
    # register Padrino::Helpers
  end

  helpers do
    def current_user
      @current_user ||= session[:user] && User.find(session[:user][:id])
    end

    def logged_in?
      !!current_user
    end

    def is_admin?
      current_user&.admin
    end
  end

  get '/' do
    if logged_in?
      erb :'welcome.html'
    else
      erb :'sign_in_form.html'
    end
  end
end
