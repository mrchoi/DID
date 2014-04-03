<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.inc" %> 

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/menu.css">

<script type="text/javascript">
    
   var lat = "";
   var lng = "";
   
   $(document).ready(function(){
	   var festival = false;
		$(".infoimg").mouseover(function(){
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
			
			
			var file = $(this).attr('src').split("/");
			var filename = file[file.length-1];
			var path = "";
			for(var i=0;i<file.length-1;i++){
				path = (i==0)?path+file[i]:path+"/"+file[i];
			}
			
			for(var k=0; k< $(".infoimg").length ;k++){
				var filename1 = "info_10"+k;
				$("#"+filename1).attr('src', path+"/"+filename1+".png");
			}
			
			$(this).attr('src', path+"/"+filename);
			festival = false;
			
		});	
			
	   initialize();
   });
  
   function initialize() {

   	var myLatlng = new google.maps.LatLng(35.3374507, 128.9560922);
   	 
   	var mapOptions = {													
   				zoom: 14,
   				center: myLatlng,
   				mapTypeId: google.maps.MapTypeId.ROADMAP
   			};
   	var map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
   	
   	var nowImage = '/did/resources/images/man.png';

   	new google.maps.Marker({
   		position: myLatlng,
   		map: map,
   		icon: nowImage,
   		title: '현재위치'
   	});
   	
   	
     }
   
   </script>
    	
<div class="full">
	<div id="map_canvas" style="width:100%;height:1200px;">
			
	</div>
	
	<div id="bottom">
	 
			<div><img id="info_100" class="infoimg" src="${pageContext.request.contextPath}/resources/images/info_100_on.png"/><br/><b>자전거</b></div>
			<div><img id="info_101" class="infoimg" src="${pageContext.request.contextPath}/resources/images/info_101.png"/><br/><b>화장실</b></div>
			<div><img id="info_102" class="infoimg" src="${pageContext.request.contextPath}/resources/images/info_102.png"/><br/><b>쉼터</b></div>
			<div><img id="info_103" class="infoimg" src="${pageContext.request.contextPath}/resources/images/info_103.png"/><br/><b>인증센터</b></div>
			<div><img id="info_104" class="infoimg" src="${pageContext.request.contextPath}/resources/images/info_104.png"/><br/><b>자전거샾</b></div>
			<div><img id="info_105" class="infoimg" src="${pageContext.request.contextPath}/resources/images/info_105.png"/><br/><b>병원,약국</b></div>
			<div><img id="info_106" class="infoimg" src="${pageContext.request.contextPath}/resources/images/info_106.png"/><br/><b>음수대</b></div>
		
	</div>
</div>
