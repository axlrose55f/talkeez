// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
/* trees.js */
function expandCollapse() {
	for (var i = 0; i < expandCollapse.arguments.length; i++) {
		var element = document.getElementById(expandCollapse.arguments[i]);
		if (element != null)
			element.style.display = (element.style.display == "none") ? "" : "none";
	}
	document.getElementsByTagName('body')[0].style.position = 'static';
}
function expandElement() {
	for (var i = 0; i < expandElement.arguments.length; i++) {
		var element = document.getElementById(expandElement.arguments[i]);
		if (element != null)
			element.style.display = "";
	}
	document.getElementsByTagName('body')[0].style.position = 'static';
}
function collapseElement() {
	for (var i = 0; i < collapseElement.arguments.length; i++) {
		var element = document.getElementById(collapseElement.arguments[i]);
		if (element != null)
			element.style.display = "none";
	}
	document.getElementsByTagName('body')[0].style.position = 'static';
}