class VotesController < ApplicationController
  post '/vote' do
    poll = Poll.find(params[:poll_id])
    if current_user.voted? poll
      return [422, {message: "You have voted already"}.to_json]
    end
    vote = Vote.create!(user_id: current_user.id, question_option_id: params[:option_id])
    [200, {message: "Your vote has been recorded"}.to_json]
  rescue => e
    [500, {message: e.message}.to_json]
  end
end