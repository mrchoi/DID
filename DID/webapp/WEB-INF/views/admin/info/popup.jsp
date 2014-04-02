<%@ page language="java" isELIgnored="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\r\n"); %>

<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <style type="text/css">
      html { height: 100% }
      body { height: 100%; margin: 0; padding: 0 }
      #map_canvas { height: 100% }
      .pop-layer {display:none; position: absolute; top: 50%; left: 50%; width: 410px; height:auto;  background-color:#fff; border: 5px solid #3571B5; z-index: 10;} 
	  .pop-layer .pop-container {padding: 20px 25px;}
	  .pop-layer p.ctxt {color: #666; line-height: 25px;}
	  .pop-layer .btn-r {width: 100%; margin:10px 0 20px; padding-top: 10px; border-top: 1px solid #DDD; text-align:right;}
	  a.cbtn {display:inline-block; height:25px; padding:0 14px 0; border:1px solid #304a8a; background-color:#3f5a9d; font-size:13px; color:#fff; line-height:25px;}
	  a.cbtn:hover {border: 1px solid #091940; background-color:#1f326a; color:#fff;}
    </style>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6/jquery.min.js"></script>
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
   
    var infowindow = "";
    function initialize() {
    	
    	var myLatlng = new google.maps.LatLng(35.3374507, 128.9560922);
    	 
    	var mapOptions = {													
    				zoom: 14,
    				center: myLatlng,
    				mapTypeId: google.maps.MapTypeId.ROADMAP
    			};
    	var map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
    	
    	
    	
    		
    	
      }
    
    function layer_open(el) {
    	
		var temp = $('#' + el);
		var bg = temp.prev().hasClass('bg');
		
		if(bg){
			$('.layer').fadeIn();
		}else{
			temp.fadeIn();
		}
	
		if (temp.outerHeight() < $(document).height() ) temp.css('margin-top', '-'+temp.outerHeight()/2+'px');
		else temp.css('top', '0px');
		
		if (temp.outerWidth() < $(document).width() ) temp.css('margin-left', '-'+temp.outerWidth()/2+'px');
		else temp.css('left', '0px');
		
		temp.find('a.cbtn').click(function(e){
			if(bg){
				$('.layer').fadeOut();
			}else{
				temp.fadeOut();    
			}
			
			e.preventDefault();
		});
		
		$('.layer .bg').click(function(e){
			$('.layer').fadeOut();
			e.preventDefault();
		});
    }
    </script>
  </head>
  <body onload="geocode()">
	<div id="map_canvas" style="width:100%; height:100%"></div>
	<div id="layer1" class="pop-layer">
		<div class="pop-container">
			<div class="pop-conts">
				<p class="ctxt mb20"><B>${info.title}</B><br>
				${fn:replace(info.contents,newLineChar, '<br/>')}
				</p>
				<div class="btn-r">
					<a href="#" class="cbtn">Close</a>
				</div>
			</div>
		</div>
	</div>
  </body>
</html>