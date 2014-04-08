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
			
			for(var k=1; k< $(".infoimg").length+1 ;k++){
				var filename1 = "info_"+k;
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
	 
			<div><img id="info_1" class="infoimg" src="${pageContext.request.contextPath}/resources/images/info_1_on.png"/><br/><b>관광지</b></div>
			<div><img id="info_2" class="infoimg" src="${pageContext.request.contextPath}/resources/images/info_2.png"/><br/><b>음식점</b></div>
			<div><img id="info_3" class="infoimg" src="${pageContext.request.contextPath}/resources/images/info_3.png"/><br/><b>숙박시설</b></div>
			<div><img id="info_4" class="infoimg" src="${pageContext.request.contextPath}/resources/images/info_4.png"/><br/><b>특산품</b></div>
			<div><img id="info_5" class="infoimg" src="${pageContext.request.contextPath}/resources/images/info_5.png"/><br/><b>대중교통</b></div>
			<div><img id="info_6" class="infoimg" src="${pageContext.request.contextPath}/resources/images/info_6.png"/><br/><b>관공서</b></div>
		
	</div>
</div>
