<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.inc" %> 

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/menu2.css">

<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=AIzaSyDuER-nYuBvyniKkuCYRANZhRlQO_q7ZnE&sensor=false"></script>
<script type="text/javascript" src="http://google-maps-utility-library-v3.googlecode.com/svn/trunk/infobox/src/infobox.js"></script>
<script type="text/javascript">
    
   var lat = "";
   var lng = "";
   
   $(document).ready(function(){
	   console.log(1111);
	   initialize();
   });
  
   function geocode(){
   	console.log(2222);
   	var address = "${location}";
   	console.log(333);
   	var geocoder = new google.maps.Geocoder();
   	
   	console.log(444);
	  	geocoder.geocode({'address':address,'partialmatch':true},geocodeResult);
   }
   
   function geocodeResult(results,status){
   	if(status =='OK' && results.length >0){
   		lat = results[0].geometry.location.lat();
   		lng = results[0].geometry.location.lng();
   	}else{
   		alert(status);
   	}
  		
   	initialize();
   }
  
  
   function initialize() {
  console.log(5555);	  
   	var myLatlng = new google.maps.LatLng(35.3374507, 128.9560922);
   	 
   	var mapOptions = {													
   				zoom: 14,
   				center: myLatlng,
   				mapTypeId: google.maps.MapTypeId.ROADMAP
   			};
   	var map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
   	
   	var nowImage = '/did/resources/images/man.png';
   	var image = '/did/resources/images/info_icon001.png';
   	
   	new google.maps.Marker({
   		position: myLatlng,
   		map: map,
   		icon: nowImage,
   		title: '현재위치'
   	});
   	
   	var locationLatlng = new google.maps.LatLng(lat, lng);
   	
   	new google.maps.Marker({
   		position: locationLatlng,
   		map: map,
   		icon: image,
   		title: '위치'
   	});
   	
     }
   </script>
    	
<div id="center">
	<div id="map_canvas">		
	</div>
	<div id="bottom">
	
			<img id="info_1" class="infoimg" src="${pageContext.request.contextPath}/resources/images/info_icon01.png"/>
			<img id="info_2" class="infoimg" src="${pageContext.request.contextPath}/resources/images/info_icon02.png"/>
			<img id="info_3" class="infoimg" src="${pageContext.request.contextPath}/resources/images/info_icon03.png"/>
			<img id="info_4" class="infoimg" src="${pageContext.request.contextPath}/resources/images/info_icon04.png"/>
			<img id="info_5" class="infoimg" src="${pageContext.request.contextPath}/resources/images/info_icon05.png"/>
			<img id="info_6" class="infoimg" src="${pageContext.request.contextPath}/resources/images/info_icon06.png"/>
			
	</div>
</div>
