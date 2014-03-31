/**
 *  공통 팝업 화면 
 */
function popUp(formName, url) {
	var screenSizeWidth = "";
	var screenSizeHeight = "";
  
	if (self.screen) { 
		screenSizeWidth = screen.width ;  
		screenSizeHeight = screen.height;
	}  

	var intWidth = screenSizeWidth;
	var intHeight = screenSizeHeight;
	var intXOffset = 0 ;
	var intYOffset = 0 ;

	obwindow = window.open("","popup", "toolbar=no, location=no, directories=no, status=0, menubar=no, scrollbars=1,resizable=1") ;
	obwindow.resizeTo(intWidth, intHeight) ;
	obwindow.moveTo(intXOffset, intYOffset);

	formName.attr({
		action : url,
		method : "POST",
		target : "popup"
	}).submit();
}