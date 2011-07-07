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
	var asSearchElm = document.getElementById("asSearch");
	var BoxLinkElm = document.getElementById("AdvancedSearchLink");
var openingState="hidden";		
function toggleAdvansedSearch(){

			if(openingState=="shown"){
				BoxLinkElm.innerHTML="<span class='flat_icon arrow3down_green'></span> Show advanced search and search tips";
				openingState="hidden";
				asSearchElm.style.height="0px";
			    //Effect.SlideUp('asSearch',{ duration: 0.50 });
			}else{
				BoxLinkElm.innerHTML="<span class='flat_icon arrow3up_green'></span> Hide advanced search and search tip examples";
				openingState="shown";
				asSearchElm.style.height="100px";
				//Effect.SlideDown('asSearch',{ duration: 0.50 });
			}
		}