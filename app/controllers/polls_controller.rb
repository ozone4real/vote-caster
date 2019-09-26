class PollsController < ApplicationController
  get '/create_poll' do
    erb :'poll_builder.html'
  end

  post '/create_poll' do
    questionData, duration, options = params.slice("questionData", "duration", "options").values
    poll = Poll.create!(question: questionData[:question],
     expires_at: Time.now + duration[:days].days + duration[:hours].hours + duration[:minutes].minutes,
      question_type: questionData[:question_type], user_id: current_user.id)
    unless questionData[:type] === 'yes/no'
      poll.question_options.build(options.map {|option| {option: option} }).each(&:save!)
    end
    [200, { message: "Poll successfully created", poll: poll }.to_json]
  rescue => e
    [501, { message: e.message }.to_json]
  end

  get '/polls' do
    if params[:active] === "true"
      @polls = Poll.active_polls
      @heading = "Active Polls"
    end

    if params[:active] === "false"
      @polls = Poll.expired_polls
      @heading = "Expired Polls"
    end

    erb :'polls.html'
  end

  get '/poll/:id' do
    erb :'poll.html'
  end
end