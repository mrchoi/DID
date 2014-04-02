<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.inc" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>YangSan DID</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<!--[if IE]>
<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/style.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	var imgval = false;
	$(".menuimg").mouseover(function(){
		var file = $(this).attr('src').split("/");
		var filename = file[file.length-1];
		var path = "";
		for(var i=0;i<file.length-1;i++){
			path = (i==0)?path+file[i]:path+"/"+file[i];
		}
		if(filename.indexOf("_on") == -1){
			imgval = true;
			$(this).attr('src', path+"/"+filename.replace('.png','_on.png'));
		}else{
			imgval = false;
		}
		
	}).mouseout(function(){
		var file = $(this).attr('src').split("/");
		var filename = file[file.length-1];
		var path = "";
		for(var i=0;i<file.length-1;i++){
			path = (i==0)?path+file[i]:path+"/"+file[i];
		}
		
		if(imgval){
			$(this).attr('src', path+"/"+filename.replace('_on.png','.png'));
		}
		
	}).click(function(){
		
		var file = $(this).attr('src').split("/");
		var filename = file[file.length-1];
		var path = "";
		for(var i=0;i<file.length-1;i++){
			path = (i==0)?path+file[i]:path+"/"+file[i];
		}
		
		for(var k=1; k< $(".menuimg").length+1 ;k++){
			var filename1 = "menu_"+k;
			$("#"+filename1).attr('src', path+"/"+filename1+".png");
		}
		$(this).attr('src', path+"/"+filename);
		imgval = false;
		
		MovePage(this.id);
	});
	
	//MovePage("menu_1");
});


function MovePage(menuId) {
	

	$.ajax({
		type : "POST",
		url : "goMenu.htm",
		data : {"menuId": menuId},
		success : function(response) {
			$("#maincol").html(response);
			return false;
		},
		error : function() {
			alert("메뉴를 다시 선택해주세요.");
			return false;
		}
	});
}

</script>
</head>
<body>
<div id="pagewidth" >
	<div id="wrapper">
		<div id="twocols"> 
			<div id="maincol">
				<img src="${pageContext.request.contextPath}/resources/images/back1.jpg" width="100%" height="100%"/>
			</div>
			<div id="rightcol"> 
				<img id="menu_1" class="menuimg" src="${pageContext.request.contextPath}/resources/images/menu_1_on.png"/>
				<img id="menu_2" class="menuimg" src="${pageContext.request.contextPath}/resources/images/menu_2.png"/>
				<img id="menu_3" class="menuimg" src="${pageContext.request.contextPath}/resources/images/menu_3.png"/>
				<img id="menu_4" class="menuimg" src="${pageContext.request.contextPath}/resources/images/menu_4.png"/>
				<img id="menu_5" class="menuimg" src="${pageContext.request.contextPath}/resources/images/menu_5.png"/>
				
			</div>
		</div> 
	</div>	
	</div>
</body>
</html>

