require './config/environment'
require 'sinatra/respond_with'

class ApplicationController < Sinatra::Base
  # configure(:development) do  
  #   register Sinatra::Reloader
  #   also_reload 'app/views'
  # end
  register Sinatra::RespondWith
  include ActionView::Helpers::DateHelper
  set :session_secret, "here be dragons"
  before do
   if @env["CONTENT_TYPE"] == "application/json"
     request.body.rewind
     params.merge!(JSON.parse(request.body.read))
   end
  end
  configure do
    p File.join(settings.root + 'locales')
    I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
    I18n.load_path += Dir[File.join(settings.root, 'locales', '*.yml')]
    I18n.backend.load_translations
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
