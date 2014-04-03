<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.inc" %> 

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/menu.css">
<script type="text/javascript">

$(document).ready(function(){
	var festival = false;
	$(".festivalimg").mouseover(function(){
		var file = $(this).attr('src').split("/");
		var filename = file[file.length-1];
		var path = "";
		for(var i=0;i<file.length-1;i++){
			path = (i==0)?path+file[i]:path+"/"+file[i];
		}
		if(filename.indexOf("_on") == -1){
			festival = true;
			$(this).attr('src', path+"/"+filename.replace('.png','_on.png'));
		}else{
			festival = false;
		}
		
	}).mouseout(function(){
		var file = $(this).attr('src').split("/");
		var filename = file[file.length-1];
		var path = "";
		for(var i=0;i<file.length-1;i++){
			path = (i==0)?path+file[i]:path+"/"+file[i];
		}
		
		if(festival){
			$(this).attr('src', path+"/"+filename.replace('_on.png','.png'));
		}
		
	}).click(function(){
		
		if(this.id=="festival_close"){
			$("#pop").hide();
		}else if(this.id=="festival_sch"){
			var filename = "";
			
			for(var k=1; k< $(".festivalimg").length+1 ;k++){
				var filename1 = "#festival_"+k;
				var file = $(filename1).attr('src').split("/");
				
				filename = file[file.length-1];
				
				if(filename.indexOf("_on")!=-1){
					break;
				}
				
			}

			$("#festival_pop").attr('src', '/did/resources/images/'+filename.replace('_on.png','_pop.png'));
			$("#pop").show();
		}else{
			
			var file = $(this).attr('src').split("/");
			var filename = file[file.length-1];
			var path = "";
			for(var i=0;i<file.length-1;i++){
				path = (i==0)?path+file[i]:path+"/"+file[i];
			}
			
			for(var k=1; k< $(".festivalimg").length+1 ;k++){
				var filename1 = "festival_"+k;
				$("#"+filename1).attr('src', path+"/"+filename1+".png");
			}
			
			$(this).attr('src', path+"/"+filename);
			festival = false;
			$("#festival_img").attr('src',path+"/"+filename.replace('_on.png','_con.jpg'));
		}
	});
	
	
	$("#festival_img").attr('src','${pageContext.request.contextPath}/resources/images/festival_1_con.jpg');
});


</script>
<div id="left">
	<img id="festival_img" src="${pageContext.request.contextPath}/resources/images/festival_1_con.jpg" width="100%" height="100%"/>
</div>
<div id="right">
	<div id="right-top">
		<img id="festival_sch" class="festivalimg" src="${pageContext.request.contextPath}/resources/images/festival_sch.png"/>
	</div>
	<div id="right-center">
		<img id="festival_1" class="festivalimg" src="${pageContext.request.contextPath}/resources/images/festival_1_on.png"/>
		<img id="festival_2" class="festivalimg" src="${pageContext.request.contextPath}/resources/images/festival_2.png"/>
		<img id="festival_3" class="festivalimg" src="${pageContext.request.contextPath}/resources/images/festival_3.png"/>
		<img id="festival_4" class="festivalimg" src="${pageContext.request.contextPath}/resources/images/festival_4.png"/>
		<img id="festival_5" class="festivalimg" src="${pageContext.request.contextPath}/resources/images/festival_5.png"/>
		<img id="festival_6" class="festivalimg" src="${pageContext.request.contextPath}/resources/images/festival_6.png"/>
		<img id="festival_7" class="festivalimg" src="${pageContext.request.contextPath}/resources/images/festival_7.png"/>
		<img id="festival_8" class="festivalimg" src="${pageContext.request.contextPath}/resources/images/festival_8.png"/>
		<img id="festival_9" class="festivalimg" src="${pageContext.request.contextPath}/resources/images/festival_9.png"/>
	</div>
</div>
<div id="pop" style="display:none;">
	<div id="fe_close">
		<img id="festival_close" class="festivalimg" src="${pageContext.request.contextPath}/resources/images/close.png"/>
	</div>
	<div id="fe_pop">
		<img id="festival_pop" src="${pageContext.request.contextPath}/resources/images/festival_1_pop.png"/>
	</div>
</div>
