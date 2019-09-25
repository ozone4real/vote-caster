require './config/environment'

class ApplicationController < Sinatra::Base
  # configure(:development) do  
  #   register Sinatra::Reloader
  #   also_reload 'app/views'
  # end
  
  set :session_secret, "here be dragons"
  configure do
    enable :sessions
    set :environment, Sprockets::Environment.new
    environment.append_path "assets/stylesheets"
    environment.append_path "assets/javascripts"
    uglify = Uglifier.new(:harmony => true)
    environment.js_compressor  = uglify
    environment.css_compressor = :scss
    set :public_folder, 'public'
    set :views, 'app/views'
    register Sinatra::Flash
    # register Padrino::Helpers
  end

  helpers do
    include Sprockets::Helpers
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

  get "/assets/*" do
    # binding.pry
    env["PATH_INFO"].sub!("/assets", "")
    settings.environment.call(env)
  end

  get '/' do
    if logged_in?
      erb :'welcome.html'
    else
      erb :'sign_in_form.html'
    end
  end
end
