$(document).ready(function(){
	$('h1 span').on('click',function(){
		location.href="/free";
	});
	if (window.location.pathname.endsWith('/free') && !window.location.search) {
		location.href = "/free?category=fashion";
	}
});