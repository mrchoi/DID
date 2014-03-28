<%@ page language="java" isELIgnored="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <style type="text/css">
      html { height: 100% }
      body { height: 100%; margin: 0; padding: 0 }
      #map_canvas { height: 100% }
    </style>
    
    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=AIzaSyDuER-nYuBvyniKkuCYRANZhRlQO_q7ZnE&sensor=false"></script>
	<script type="text/javascript" src="http://google-maps-utility-library-v3.googlecode.com/svn/trunk/infobox/src/infobox.js"></script>
    <script type="text/javascript">
    
    var lat = "";
    var lng = "";
   
    function geocode(){
    	
    	var address = "${location}";
    	var geocoder = new google.maps.Geocoder();
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
  </head>
  <body onload="geocode()">
   <div id="map_canvas" style="width:100%; height:100%"></div>
  </body>
</html>