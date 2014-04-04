<%@ page language="java" isELIgnored="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\r\n"); %>

<!DOCTYPE html>
<html>
  <head>
  	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/admin_popup.css">
    
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.11.0.min.js"></script>
    <script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?sensor=false"></script>
	<script type="text/javascript" src="http://google-maps-utility-library-v3.googlecode.com/svn/trunk/infobox/src/infobox.js"></script>
	<script type="text/javascript">
    
    var lat = "";
    var lng = "";
    var infowindow = "";
   
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
    	
    	var nowImage = '${pageContext.request.contextPath}/resources/images/man.png';
    	var image = '${pageContext.request.contextPath}/resources/images/info_icon${info.category}.png';
    	
    	new google.maps.Marker({
    		position: myLatlng,
    		map: map,
    		icon: nowImage,
    		title: '현재위치'
    	});
    	    	
    	var locationLatlng = new google.maps.LatLng(lat, lng);
    	
    	var beachMarker = new google.maps.Marker({
    		position: locationLatlng,
    		map: map,
    		icon: image,
    		title: '${info.title}'
    	});
    	
    	var filesize = "${info.file_url}";
    	var category = "${info.category}";
    	var popImage = "facility_pop_t1.png";
    	var cloaseImage = "facility_pop_close.png";
    	var css ="popup";
   	
    	if(category.substring(0, 1)=="0") {
    		popImage="info_pop_t1.png";
    		cloaseImage = "info_pop_close1.png";
    		if(category.substring(0, 3)=="001") css ="tour_popup";
    		else css ="info_popup";
     	}
    	    	
    	var contentString = null;
    	if(category.substring(0, 3)=="001") {
    		contentString = 
        		'<div class='+css+'>'+
    				'<div class="con_s">'+
    					'<h1 class="h1_title">${info.title}</h1>'+
    					'<div class="con_txt">'+
    						'<div class="txt_s">${fn:replace(info.contents,newLineChar, '<br/>')}</div>'+
    					'</div>'+
    				'</div>'+
    				'<div class="title_s">'+
    					'<p><img src="${pageContext.request.contextPath}/resources/images/info_pop_t1.png" alt="" /></p>'+
    				'</div>'+
    			'</div>'+
    			'<div style="width:886px;">'+
    				'<p style="float:left;"><img src="${pageContext.request.contextPath}/resources/images/info_pop_bottom2.png" alt="" /></p>'+
    				'<p style="float:right;"><a href="javascript:closeInfobox()"><img src="${pageContext.request.contextPath}/resources/images/info_pop_close1.png" alt="" /></a></p>'+
    			'</div>';
    	
    	}else{
    		contentString = 
        		'<div class='+css+'>'+
        			'<div class="con_s">'+
        				'<h1 class="h1_title">${info.title}</h1>'+
        				'<div class="con_txt">';
        					
        					if(filesize.length >0 ){
        						contentString += '<ul id="showImage" class="info_list">'+
        						'<img src="${pageContext.request.contextPath}/resources/fileupload/${info.file_url}" alt="" width="120px" height="160px"/>'+
            					'</ul>';
        					}
        	
        					contentString += '<ul class="map_list">'+
        						'<li>${fn:replace(info.contents,newLineChar, '<br/>')}</li>'+
        					'</ul>'+
        				'</div>'+
        			'</div>'+
        			'<div class="title_s">'+
        				'<p><img src="${pageContext.request.contextPath}/resources/images/'+popImage+'" alt="" /></p>'+
        				'<p><a href="javascript:closeInfobox();"><img src="${pageContext.request.contextPath}/resources/images/'+cloaseImage+'" alt="" /></a></p>'+
        			'</div>'+
        		'</div>';
    	}
    		

    	var InfoBoxOptions = {
    			content: contentString,
    			disableAutoPan: false,
    			maxWidth: 0,
    			alignBottom: true,
    			pixelOffset: new google.maps.Size(-140, -70),
    			zIndex: null,
    			boxClass: "info-windows",
    			closeBoxURL: "",
    			pane: "floatPane",
    			enableEventPropagation: false,
    			infoBoxClearance: "10px",
    			position: beachMarker.getPosition(),
    			boxStyle: { 
    				opacity: 0.9
    				,width: "656px"
    				,height: "378px"
    			}
    	};
    	
    	infowindow = new InfoBox(InfoBoxOptions);
    	
    	google.maps.event.addListener(beachMarker, 'click', function() {
      		selectMarker(map,beachMarker);
    	});
    	
      }
    
    function selectMarker(map,beachMarker) {
     	infowindow.open(map,beachMarker);
    }
    
    function closeInfobox(){
	   	infowindow.close();
    }
    
    </script>
  </head>
  <body onload="geocode()">
	<div id="map_canvas" style="width:100%; height:100%"></div>
 </body>
</html>