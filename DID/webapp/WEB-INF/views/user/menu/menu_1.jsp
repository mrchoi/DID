<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.inc" %> 

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/menu.css">

<script type="text/javascript">
    
   var lat = "";
   var lng = "";
   
   $(document).ready(function(){

		$(".infoimg").mouseover(function(){
			var file = $(this).attr('src').split("/");
			var filename = file[file.length-1];
			var path = "";
			for(var i=0;i<file.length-1;i++){
				path = (i==0)?path+file[i]:path+"/"+file[i];
			}
			
			$(this).attr('src', path+"/"+filename.replace('.png','_on.png'));

		}).mouseout(function(){
			var file = $(this).attr('src').split("/");
			var filename = file[file.length-1];
			var path = "";
			for(var i=0;i<file.length-1;i++){
				path = (i==0)?path+file[i]:path+"/"+file[i];
			}
			
			$(this).attr('src', path+"/"+filename.replace('_on.png','.png'));
			
			
		}).click(function(){
			
			var file = $(this).attr('src').split("/");
			var filename = file[file.length-1];
			var path = "";
			for(var i=0;i<file.length-1;i++){
				path = (i==0)?path+file[i]:path+"/"+file[i];
			}
			$(this).attr('src', path+"/"+filename.replace('_on.png','.png'));
			initialize();
			$("#map_pop").show();
			
		});	
			
   });
  
   function initialize() {

   	var myLatlng = new google.maps.LatLng(35.3374507, 128.9560922);
   	 
   	var mapOptions = {													
   				zoom: 14,
   				center: myLatlng,
   				mapTypeId: google.maps.MapTypeId.ROADMAP
   			};
   	var map = new google.maps.Map(document.getElementById("map_canvas1"), mapOptions);
   	
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
	<div id="map_pop" style="display:none;">		
		<div id="map_canvas1" class="full">
			<img id="festival_pop" src="${pageContext.request.contextPath}/resources/images/festival_1_pop.png"/>
		</div>
	</div>
	<div id="map">
		<img src="${pageContext.request.contextPath}/resources/images/back1.jpg" width="100%" height="100%"/>
	</div>
	
	<div id="bottom">
	 		<div style="width:100px;"></div>
			<div><img id="info_1" class="infoimg" src="${pageContext.request.contextPath}/resources/images/info_7.png"/><br/><b>낙동강</b></div>
			<div><img id="info_2" class="infoimg" src="${pageContext.request.contextPath}/resources/images/info_7.png"/><br/><b>한강</b></div>
			<div><img id="info_3" class="infoimg" src="${pageContext.request.contextPath}/resources/images/info_7.png"/><br/><b>금강</b></div>
			<div><img id="info_4" class="infoimg" src="${pageContext.request.contextPath}/resources/images/info_7.png"/><br/><b>영산강</b></div>
		
	</div>
	
</div>

