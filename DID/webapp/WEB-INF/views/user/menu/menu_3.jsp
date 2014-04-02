<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.inc" %> 

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/menu2.css">

<script type="text/javascript">
    
   var lat = "";
   var lng = "";
   
   $(document).ready(function(){
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
	<div id="map_canvas" class="full">
			
	</div>
	
	<div id="bottom">
	 
			<img id="info_1" class="infoimg" src="${pageContext.request.contextPath}/resources/images/info_icon001.png"/>
			<img id="info_2" class="infoimg" src="${pageContext.request.contextPath}/resources/images/info_icon002.png"/>
			<img id="info_3" class="infoimg" src="${pageContext.request.contextPath}/resources/images/info_icon003.png"/>
			<img id="info_4" class="infoimg" src="${pageContext.request.contextPath}/resources/images/info_icon004.png"/>
			<img id="info_5" class="infoimg" src="${pageContext.request.contextPath}/resources/images/info_icon005.png"/>
			<img id="info_6" class="infoimg" src="${pageContext.request.contextPath}/resources/images/info_icon006.png"/>
		
	</div>
</div>
