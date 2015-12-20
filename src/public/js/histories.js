$(function(){
	const wpm = 150;
	const readCoentens = function(){
		console.log("start: read contents.");
		$.getJSON("histories", {}, function(res){
			const items = res.map(function(x) {
				console.log(x.title);
				
				const time = x.time;
				const minute = ("0" + parseInt(time / 60)).slice(-2);
				const seconed = ( "0" + parseInt(time % 60)).slice(-2);
				
				const url = "./contents.html?page=" + x.news_id;
				const text = x.news_title + "(<span>" + minute + ":" + seconed + "</span>)";
				
				const d = new Date(x.timestamp);
				var timestamp = d.getFullYear() + "/" + (d.getMonth() + 1) + "/" + d.getDate() + " ";
				timestamp += d.getHours() + ":" + d.getMinutes();
				
				const li = $("<li>").append($("<span>").text(timestamp + "\t"));
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