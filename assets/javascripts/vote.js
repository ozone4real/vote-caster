class Vote {
  constructor() {
    this.submitVote()
  }

  submitVote() {
    $('.option').click((e) => {
      $.post("/vote", {option_id: e.target.id, poll_id: $('.poll-question').data('poll_id')},
        function (data, textStatus, jqXHR) {
          console.log(data)
        },
        "json"
      );
    })
  }
}