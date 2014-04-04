<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/menu.css">
 <script type="text/javascript">
    
   $(document).ready(function(){
		$("#img1").click(function(){
			$("object").attr('data','http://www.naver.com');			
			$("#map_pop").show();
		});
		
		$("#img2").click(function(){
			$("object").attr('data','http://www.daum.net');			
			$("#map_pop").show();
		});
		
		$("#img3").click(function(){
			$("object").attr('data','http://www.yangsan.go.kr');			
			$("#map_pop").show();
		});
		
		$("#img4").click(function(){
			$("object").attr('data','http://www.mospa.go.kr');			
			$("#map_pop").show();
		});
		
		$("#img5").click(function(){
			$("object").attr('data','http://www.korail.com/etc/140401/letskorail.html');			
			$("#map_pop").show();
		});
		
		$("#img6").click(function(){
			$("object").attr('data','http://www.molit.go.kr');			
			$("#map_pop").show();
		});
		
		$("#img7").click(function(){
			$("object").attr('data','http://www.riverguide.go.kr');			
			$("#map_pop").show();
		});

		$("#w_close").click(function(){
			$("#map_pop").hide();
		});
		
		$("#w_keyboard").click(function(){
			var file = Components.class["@mozilla.org/file/local;1"].createInstance(Components.interfaces.nsILocalFile);
			file.initWithPage("${pageContext.request.contextPath}/resources/osk.exe");
			file.launch();
		});
   });
    
   </script>
 <div class="full">
	 <div id="map">
		<img src="${pageContext.request.contextPath}/resources/images/search_bg.png"/>	
	</div>

		<div id="img1" class="img_button" style="top:310px;left:150px;">
		 	<img src="${pageContext.request.contextPath}/resources/images/image110.png"/>
		</div>
		<div id="img2" class="img_button" style="top:310px;left:500px;">
		 	<img src="${pageContext.request.contextPath}/resources/images/image79.png"/>
		</div>
		<div id="img3" class="img_button" style="top:310px;left:850px;">
		 	<img src="${pageContext.request.contextPath}/resources/images/image80.png"/>
		</div>
		<div id="img4" class="img_button" style="top:630px;left:150px;">
		 	<img src="${pageContext.request.contextPath}/resources/images/image82.png"/>
		</div>
		<div id="img5" class="img_button" style="top:630px;left:500px;">
		 	<img src="${pageContext.request.contextPath}/resources/images/image104.png"/>
		</div>
		<div id="img6" class="img_button" style="top:630px;left:850px;">
		 	<img src="${pageContext.request.contextPath}/resources/images/image92.png"/>
		</div>
		<div id="img7" class="img_button" style="top:630px;left:1200px;">
		 	<img src="${pageContext.request.contextPath}/resources/images/image147.png"/>
		</div>
		
		<div id="map_pop" style="display:none;">	
			<div id="web_close">
				<div id="w_keyboard"><img src="${pageContext.request.contextPath}/resources/images/image89.png"/></div>
				<div id="w_close"><img src="${pageContext.request.contextPath}/resources/images/image62.png"/></div>
			</div>
			
			<object data="http://www.naver.com" type="text/html" title="korail" style="width:1200px;height:800px;background-color:white;">
				
			</object>
		</div>
</div>
   
