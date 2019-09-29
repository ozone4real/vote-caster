class Vote extends Main {
	constructor() {
		super();
		this.submitVote();
	}

	submitVote() {
		$('.option').click(e => {
			$.post({
				url: '/vote',
				data: { option_id: e.target.id, poll_id: $('.poll-question').data('poll_id') },
				success: data => {
          // window.location.reload()
          this.flash.success(data.message);
				},
				error: ({responseJSON: {message}}) => {
					this.flash.error(message);
				},
				dataType: 'json'
			});
		});
	}
}
