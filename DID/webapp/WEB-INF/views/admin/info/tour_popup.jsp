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
    <style type="text/css">
      /* Base */
	html { height: 100% }
	body { height: 100%; margin: 0; padding: 0 }
	*{margin:0;padding:0}
	body{font-size:12px;font-family:'나눔고딕',NanumGothic,'돋움',dotum,AppleGothic;line-height:18px;color:#636262;text-align:center}
	ul,ol,dl,li,dt,dd{margin:0;padding:0;list-style:none}
	h1,h2,h3,h4,h5,h6{margin:0;padding:0}
	p{margin:0;padding:0;text-align:justify}
	img{border:none;vertical-align:top}
	textarea{overflow:auto}
	form,fieldset,button{margin:0;padding:0;border:none}
	a{text-decoration:none}
	a:link,a:visited{color:#444;text-decoration:none}
	a:hover,a:active,a:focus{text-decoration:none}
	hr{display:none;margin:0;padding:0}
	label{cursor:pointer}
	address,em{font-style:normal;font-weight:normal}
	html:first-child select{height:20px;padding-right:6px}
	.png24{tmp:expression(setPng24(this))}

	/* Opera 9 & Below Fix */
	option{padding-right:6px}

	/* hidden contents */
	#accessibility,.skip,hr,legend,caption{visibility:hidden;overflow:hidden;z-index:-1;width:0;height:0;font-size:0;line-height:0}

	@font-face{
	font-family:NanumGothic;src:url(${pageContext.request.contextPath}/resources/images/NanumGothic.eot)}
	@font-face{
	font-family:NanumGothic;src:url(${pageContext.request.contextPath}/resources/images/NanumGothic.ttf)}
    
    .popup{overflow:hidden;background:url(${pageContext.request.contextPath}/resources/images/info_pop_top.png) no-repeat 0 0;width:886px;}
	.popup .con_s{float:left;width:815px;text-align:left;}
	.popup .title_s{float:left;width:71px;}
	h1.h1_title{font-family:'나눔고딕',NanumGothic,'돋움',dotum,AppleGothic;font-size:33px;padding-top:40px;padding-left:65px;padding-bottom:35px;color:#1b1c20;}
	.popup .con_txt{font-size:21px;padding-left:65px;line-height:34px;color:#636363;overflow:hidden;}
	.popup .con_txt ul.info_list{float:left;width:510px;}
	.popup .con_txt ul.map_list{float:left;padding-left:30px;border-left:1px dashed #bababa;}
	.popup .con_txt ul li{font-size:21px;font-family:'나눔고딕',NanumGothic,'돋움',dotum,AppleGothic;line-height:34px;color:#636262;}
	span.t1{font-size:21px;font-family:'나눔고딕',NanumGothic,'돋움',dotum,AppleGothic;line-height:34px;color:#282626;}
	li.bl{background:url(${pageContext.request.contextPath}/resources/images/bl.gif) no-repeat 0 15px;padding-left:15px;}
	.popup .con_txt .txt_s{font-size:21px;font-family:'나눔고딕',NanumGothic,'돋움',dotum,AppleGothic;clear:both;padding-top:30px;padding-right:40px;}
 	#map_canvas { height: 100% }
 	
    </style>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6/jquery.min.js"></script>
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
    	    	
    	var contentString = null;	
    	contentString = 
    		'<div class="popup">'+
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