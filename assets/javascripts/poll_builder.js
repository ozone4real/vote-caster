$(document).ready(() => {
	$('.q-option').keydown(e => {
    if(e.keyCode !== 13) return;
    if(e.target.value) {
      const optionContainer = document.createElement('div')
      optionContainer.className = "option-container"
      optionContainer.innerHTML = e.target.value
      $('.options-container').append(
        `<div class="option-container">${e.target.value} 
        <i class="fa fa-times" style="font-size: 18px" aria-hidden="true"></i></div>`
        )
    }
	});

	$('#poll-builder').submit(e => {
		e.preventDefault();
	});
});
