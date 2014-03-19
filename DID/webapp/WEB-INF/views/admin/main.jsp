<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/resources/include/header.inc" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/defaults.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/system.css">

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	if('${ADMIN_ID}' == '') {
		//MovePage("admin/login.htm","");
	}else{		
		//MovePage("admin/list.htm","");
	}
	
});

function MovePage(url, data) {

	$.ajax({
		type : "POST",
		url : url,
		data : data,
		success : function(response) {
			$("#center").html(response);
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
		url : "admin/logout.htm",
		data : "",
		success : function(response) {
			$("#loginBefore").show();
			$("#loginAfter").hide();
			$("#center").html(response);
			return false;
		},
		error : function() {
			alert("메뉴를 다시 선택해주세요.");
			return false;
		}
	});
}
</script>

</head>
<body>
	<div id="wrapper">
		<div id="container" class="clear-block">
			<div id="header">
				<div id="logo-floater">
					<h1>DID </h1>
				</div>
			</div>
			<div id="sidebar-left" class="sidebar">
				<!-- user menu start -->
				<div id="block-user-1" class="clear-block block block-user">
					<h2>Menu</h2>
					<div id="menuList" class="content">
					</div>
				</div>
				<!-- user menu end -->
				<!-- admin menu start -->
				<div id="block-block-2" class="clear-block block block-block">
					<div id="hiddenMenu" class="content">
						<ul>
							<li class="leaf"><a href="#" onclick="javascript:MovePage('admin/user/user/list.htm','');">Admin User</a></li>
						</ul>
						<ul>
							<li class="leaf"><a href="#" onclick="javascript:MovePage('admin/contents/list.htm','');">Contents</a></li>
						</ul>
						
					</div>
				</div>
				<div id="block-block-3" class="clear-block">
					
					<ul>
						<li id="loginBefore" class="leaf"><a href="#" onclick="javascript:MovePage('login.htm','');">Login</a></li>
						<li id="loginAfter" class="leaf" style="display:none;"><a href="#" onclick="javascript:LogOut();">Logout</a></li>														
					</ul>
										
				</div>
				<!-- admin menu end -->
			</div>
			<!-- center start -->
			<div id="center">
				
					
							<h2>UXCUTOR</h2>
					 
					
			</div>
			
		</div>
		
		<div id="copyright">
							
		</div>
		
	</div>
</body>
</html>