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
	
	if('${loginCheck}' == 'F') {
		alert("아이디/비밀번호가 확인 되지 않습니다.");
	}
	
	$("#registbt").click(function(){
		if(!$("#id").val()){
			alert("아이디를 입력해주세요.");
			$("#id").focus();
	 		return false;
		} else if(!$("#password").val()){
			alert("비밀번호를 입력해주세요. ");
			$("#password").focus();
			return false; 
		} else {
			var data = $("#sendForm").serializeArray();

			$.ajax({
				type : "POST",
				url : "loginForm.htm",
				data : data,
				success : function(response) {
					console.log(response);
					//$("#content").html(response);
					location.href="index.htm";
					return false;
				},
				error : function() {
					
					alert("다시 Login해주세요.");
					return false;
				}
			});
						
		}
	});	
});

</script>

<body>

	<header> 
	    <hgroup class="clearfix"> 
	        <h1><a href="#">DID Admin </a></h1>	        
	    </hgroup>
	</header>
	
	<div id="main" class="clearfix">
	    
	    <div id="content">
	        <form name="sendForm" id="sendForm" method="post">
			<article>
					<section>
			       	<h1>Admin Login</h1>
			           <figure>
			           		<table style="width:80%">
			           				
			           				<tr>
			           					<th>id</th>
			           					<td><input type="text" name="id" id="id" size="20" value="admin"> * Enter your id.</td>
			           				</tr>
			           				<tr>
			           					<th>password</th>
			           					<td> <input type="password" name="password" id="password" maxlength="20" size="20" value="admin.123"> * Enter your password.</td>
			           				</tr>
			           		</table>
						</figure>
					</section>
					<div align="right">
						<input id="registbt" type="button" value="Login"/>
					</div>	
				</article>
			</form>              
	    </div>
	</div>
	
	<footer>
    	Design and code by <a href="http://www.red-team-design.com/">RedTeamDesign</a>
	</footer>
	
</body>
</html>
