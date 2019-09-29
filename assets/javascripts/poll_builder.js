class PollBuilder extends Main {
	constructor() {
		super()
		this.handleQuestionChange();
		this.handleAddOption();
		this.handleQuestionTypeSelect();
		this.handlePollSubmit();
		this.handleDurationSelect();
		this.data = {
			options: [],
			questionData: { type: 'text' }
		};
	}

	

	handleAddOption() {
		$('.q-option').keydown(e => {
			if (e.keyCode !== 13) return;
			e.preventDefault();
			const { value } = e.target;
			if (value) {
				$('.options-container').append(
					`<div class="option-container">${value} 
          <i class="fa fa-times" aria-hidden="true"></i></div>`
				);
				this.data.options.push(value);
				$('.q-option').val('');
				this.handleRemoveOption();
			}
		});
	}

	handleQuestionChange() {
		$('#question').change(({ target: { value } }) => {
			this.data.questionData.question = value.trim();
		});
	}

	handleRemoveOption() {
		$('.fa-times').click(e => {
			$(e.target.parentNode).remove();
			let options = this.data.options;
			this.data.options = options.filter(elem => elem !== e.target.previousSibling.textContent.trim());
		});
	}

	handleQuestionTypeSelect() {
		$('.select-question-type').change(({ target }) => {
			$('.options-container').html('');
			$('.option-input').html('');
			this.data.questionData.type = $(target).val();
			this.data.options = [];
			switch ($(target).val()) {
				case 'yes/no':
					$('.options-container').html(
						`<div class="option-container">
              Yes
            </div>
            <div class="option-container">
              No
            </div>`
					);
					break;
				case 'text':
					$('.option-input').html(
						`<input type="text" name="option" class="q-option" placeholder="Add Option" />`
					);
					break;
				case 'date-time':
					$('.option-input').html(
						`<input type="datetime-local" name="option" class="q-option" placeholder="Add Option" />`
					);
					break;
				case 'time':
					$('.option-input').html(
						`<input type="time" name="option" class="q-option" placeholder="Add Option" />`
					);
					break;
				default:
					break;
			}
			this.handleAddOption();
		});
	}

	handleDurationSelect() {
		$('.duration-elem').change(({ target }) => {
			if (target.id === 'days') {
				if (target.value == 7) {
					$('.duration-elem:not(#days)').val(0);
					$('.duration-elem:not(#days)').prop('disabled', true);
				} else {
					$('.duration-elem:not(#days)').prop('disabled', false);
				}
			}
		});
	}

	buildPollData() {
		const { questionData } = this.data
		if (questionData.type === 'yes/no') {
			this.data.options = ['Yes', 'No'];
		}

		this.data.duration = {
			days: parseInt($('#days').val()) || 0,
			hours: parseInt($('#hours').val()) || 0,
			minutes: parseInt($('#minutes').val()) || 0
		};
		// data.question.duration
	}

	validatePollData() {
		let isValid = true;
		if (this.data.options.length < 2) {
			$('#options-error').html('There must be at least 2 options');
			isValid = false;
		} else {
			$('#options-error').html('');
		}
		const { duration } = this.data;
		if (Object.values(duration).toString() === [0, 0, 0].toString()) {
			$('#duration-error').html('Duration must be valid');
			isValid = false;
		} else {
			$('#duration-error').html('');
		}

		return isValid;
	}

	handlePollSubmit() {
		$('#poll-builder').submit(e => {
			e.preventDefault();
			console.log(this.data)
			this.buildPollData();
			if (!this.validatePollData()) return;

			$.ajax({
				type: 'POST',
				url: '/create_poll',
				data: JSON.stringify(this.data),
				dataType: 'json',
				contentType: 'application/json',
				success: ({message, poll}) => {
					this.flash.success(message)
					window.location.href = `/poll/${poll.id}`
			}
			});
		});
	}
}

// $(document).ready(() => {
