$(function(){
	const wpm = 150;
	const rate = wpm / 60 / 10;
	var index = 0;
	var progress = 0;
	var words = [];

	var params = location.search.substring(1).split('&').map((x) => x.split('=')).reduce((r, x) => {r[x[0]] = x[1]; return r}, {});
	var vanishWord = function(pg, color){
		if(pg >= 0) {
			$(words[pg]).css('color', color);
			$(words[pg + 1]).css('color', color);
		}
	}
	var vanishWords = function(){
		if(rate * index > 1){
			index = 0;
			vanishWord(progress, '#999999');
			vanishWord(progress - 1, '#BBBBBB');
			vanishWord(progress - 2, '#FFFFFF');

			progress += 2;
		}
		index += 1;
		setTimeout(vanishWords, 100);
	}

	var readCoentens = function(callback){
		console.log("start: read contents.");
		$.getJSON("contents/" + params.page, {}, function(res){
			$("#title").text(res['title']);
			$("#contents").html(res['contents']);
			console.log(res['contents']);
			callback(res['contents']);
		})
		.success(function(json) {
			console.log("success");
		})
		.error(function(jqXHR, textStatus, errorThrown) {
			console.log("error:" + textStatus);
			console.log("error-text:" + jqXHR.responseText);
		})
		.complete(function() {
			console.log("finish");
		});
	}

	var restart = function(){
		index = 0;
		progress = 0;
		words.each(function(){
			$(this).css('color', 'black');
		});
		window.scrollTo( 0 , 0) ;
	}

	var initContents = function(contents){
		const lines = $(contents).map((i, x) =>
		$(x).text()
		.split(" ")
		.map((x) => "<span class='word'>" + x.trim() + "</span>")
		.join("<span class='word'> </span>")
	).map((i, x) => "<p>" + x + "</p>")
	const text = Array.from(lines).reduce((r, x) => r + x);
	$("#contents").html(text);
	words = $(".word");
	vanishWords();
}

$("#btn-restart").click(restart);
readCoentens(initContents);

});