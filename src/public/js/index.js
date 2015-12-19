$(function(){
	const wpm = 150;
	const readCoentens = function(){
		console.log("start: read contents.");
		$.getJSON("news-list.json", {}, function(res){
			const items = res.map(function(x) {
				console.log(x.title);
				
				const time = (x.words_counts * 1.0 / wpm) * 60;
				const minute = ("0" + parseInt(time / 60)).slice(-2);
				const seconed = ( "0" + parseInt(time % 60)).slice(-2);
				
				const url = "./contents.html?page=" + x.key;
				const text = x.title + "(<span>" + minute + ":" + seconed + "</span>)";
				
				const li = $("<li>").append();
				const a = $("<a>").attr("href", url).html(text);
				return li.append(a);
			})
			const ul = $("<ul>").append(items);
			$("#items").html(ul);
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
	readCoentens();
});