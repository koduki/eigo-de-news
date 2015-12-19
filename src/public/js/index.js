$(function(){
	var readCoentens = function(){
		console.log("start: read contents.");
		$.getJSON("news-list.json", {}, function(res){
			items = res.map(function(x) {
				console.log(x.title)
				return "<li><a href='./contents.html?page=" + x.key + "'>" + x.title + "</a></li>"
			})
			const html = "<ul>" + items.join("") + "</ul>";
			$("#items").html(html);
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