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
				var filename1 = "info_00"+k;
				$("#"+filename1).attr('src', path+"/"+filename1+".png");
			}
			
			$(this).attr('src', path+"/"+filename);
			festival = false;
			
			goFindMarker(this.id);
			
		});	
			
	   initialize();
   });
  
   function goFindMarker(categoryId){
	   console.log(categoryId.replace("info_",""));
	   
	   $.ajax({
			type : "POST",
			dataType : "json",
			url : "user/info/list.json",
			data : {"category":categoryId.replace("info_","")},
			success : function(data) {
				console.log(data[0]);
				initialize(data);
			},
			error : function() {
				alert("위치정보를 가져오지 못했습니다. 잠시 후 다시 해주세요.");
				return false;
			}
		});
   }   
   
   function initialize(data) {

   	var myLatlng = new google.maps.LatLng(35.3374507, 128.9560922);
   	 
   	var mapOptions = {													
   				zoom: 14,
   				center: myLatlng,
   				mapTypeId: google.maps.MapTypeId.ROADMAP
   			};
   	var map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
   	
   	var nowImage = '/did/resources/images/man.png';

   	if(data){
	   	for(var i=0;i<data.length;i++){
	   		var loc = data[i].location;
	   	}
   	}
   	
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
	 
			<div><img id="info_001" class="infoimg" src="${pageContext.request.contextPath}/resources/images/info_001_on.png"/><br/><b>관광지</b></div>
			<div><img id="info_002" class="infoimg" src="${pageContext.request.contextPath}/resources/images/info_002.png"/><br/><b>음식점</b></div>
			<div><img id="info_003" class="infoimg" src="${pageContext.request.contextPath}/resources/images/info_003.png"/><br/><b>숙박시설</b></div>
			<div><img id="info_004" class="infoimg" src="${pageContext.request.contextPath}/resources/images/info_004.png"/><br/><b>특산품</b></div>
			<div><img id="info_005" class="infoimg" src="${pageContext.request.contextPath}/resources/images/info_005.png"/><br/><b>대중교통</b></div>
			<div><img id="info_006" class="infoimg" src="${pageContext.request.contextPath}/resources/images/info_006.png"/><br/><b>관공서</b></div>
		
	</div>
</div>
