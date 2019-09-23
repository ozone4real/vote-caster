class PollsController < ApplicationController
  get '/create_poll' do
    erb :'poll_builder.html'
  end
end