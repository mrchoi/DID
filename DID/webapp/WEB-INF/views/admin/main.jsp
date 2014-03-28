<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.inc" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>DID</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/did.css">

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	if('${ADMIN_ID}' == '') {
		MovePage("login.htm","");
	}else{		
		MovePage("user/list.htm","");
	}
	
	initMenu();
});

function initMenu() {
    $('#menu ul').hide(); // Hide the submenu
    if ($('#menu li').has('ul')) $('#menu ul').prev().addClass('expandable'); // Expand/collapse a submenu when it exists  
    $('.expandable').click(
      function() {
          $(this).next().slideToggle();
          $(this).toggleClass('expanded');
        }
      );
    }

function MovePage(url, data) {

	$.ajax({
		type : "POST",
		url : url,
		data : data,
		success : function(response) {
			$("#content").html(response);
			return false;
		},
		error : function() {
			alert("메뉴를 다시 선택해주세요.");
			return false;
		}
	});
}

function LogOut(){

	$.ajax({
		type : "POST",
		url : "logout.htm",
		data : "",
		success : function(response) {
			//$("#content").html(response);
			location.href="index.htm";
			return false;
		},
		error : function() {
			alert("다시 Logout해주세요.");
			return false;
		}
	});
}

/*
 * insert, update, delete
 */
function ProcessPage(url, data, re_url) {
	//$("#loading").show();
	$.ajax({
		type : "POST",
		url : url,
		data : data,
		success : function(response) {
			//$("#loading").hide();
			alert(response);
			if (re_url.length > 0) {
				MovePage(re_url, data);
			}
		},
		error : function() {
			//$("#loading").hide();
			alert("다시 진행해주세요.");
			return false;
		}
	});
}
</script>

</head>
<body>

	<header> 
	    <hgroup class="clearfix"> 
	        <h1><a href="#">DID Admin </a></h1>
	         <c:if test="${ADMIN_ID!=null}"> 
	        <h2><a href="#"> ${ADMIN_NAME}</a> / <a href="#" onclick="javascript:LogOut();">Logout</a></h2> 
	        </c:if>
	    </hgroup>
	</header>
	
	<div id="main" class="clearfix">
	    <aside>
	        <nav>
	            <ul id="menu">
	                <li><a href="#" onclick="javascript:MovePage('user/list.htm','');">Admin 관리</a></li>
	                <!-- <li><a href="#">국토종주 자전거길 관리</a></li> -->
	                <li><a href="#" onclick="javascript:MovePage('info/list.htm?category=200','');">축제/행사 안내</a></li>
	                <li>
	                    <a href="#">종주길주변편의시설안내</a>
	                    <ul>                
	                        <li><a href="#" onclick="javascript:MovePage('info/list.htm?category=001','');">관광지 관리</a></li>
	                        <li><a href="#" onclick="javascript:MovePage('info/list.htm?category=002','');">음식점 관리</a></li>
	                        <li><a href="#" onclick="javascript:MovePage('info/list.htm?category=003','');">숙박시설 관리</a></li>
	                        <li><a href="#" onclick="javascript:MovePage('info/list.htm?category=004','');">특산품 판매점 관리</a></li> 
	                        <li><a href="#" onclick="javascript:MovePage('info/list.htm?category=005','');">대중교통 관리</a></li> 
	                        <li><a href="#" onclick="javascript:MovePage('info/list.htm?category=006','');">관공서 관리</a></li>                      
	                    </ul>        
	                </li>
	                <li>
	                    <a href="#">공공시설및부대시설안내</a>
	                    <ul>
	                        <li><a href="#" onclick="javascript:MovePage('info/list.htm?category=100','');">자전거 대여소 관리</a></li>
	                        <li><a href="#" onclick="javascript:MovePage('info/list.htm?category=101','');">화장실 관리</a></li>
	                        <li><a href="#" onclick="javascript:MovePage('info/list.htm?category=102','');">쉼터 관리</a></li>
	                        <li><a href="#" onclick="javascript:MovePage('info/list.htm?category=103','');">인증센터 관리</a></li> 
	                        <li><a href="#" onclick="javascript:MovePage('info/list.htm?category=104','');">자전거샾 관리</a></li>  
	                        <li><a href="#" onclick="javascript:MovePage('info/list.htm?category=105','');">병원,약국 관리</a></li>
	                        <li><a href="#" onclick="javascript:MovePage('info/list.htm?category=106','');">음수대 관리</a></li>                
	                    </ul>
	                </li>
	                <li>
	                    <a href="#" onclick="javascript:MovePage('kiosk/list.htm','');">키오스크 관리</a>
	                    <!-- <ul>
	                        <li><a href="#" onclick="javascript:MovePage('kiosk/list.htm','');">키오스크</a></li>
	                        <li><a href="#">키오스크 모니터링</a></li>
	                        <li><a href="#" onclick="javascript:MovePage('notice/list.htm','');">키오스크 매니저</a></li>
	                        <li><a href="#">메니저 관리</a></li> 
	                        <li><a href="#">시스템 캐시 관리</a></li>                                   
	                    </ul> -->	    
	                </li>
	                <li><a href="#" onclick="javascript:MovePage('qrcode/list.htm','');">QR코드 관리</a></li>                          
	            </ul>
	        </nav>
	    </aside>
	    
	    <div id="content">
	                      
	    </div>
	</div>
	
	<footer>
    	Design and code by <a href="http://www.red-team-design.com/">RedTeamDesign</a>
	</footer>
	
</body>
</html>
