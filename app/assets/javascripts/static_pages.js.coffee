# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

(jQuery) $ -> 

	scrollAboutPage = (offset) -> 
		$('html, body').animate
			scrollTop: $(offset).offset().top 
			2000

	$('button.btn.btn-info').click -> 
		scrollAboutPage ".steps"

	$('header h1').click ->
		window.location = "/"
