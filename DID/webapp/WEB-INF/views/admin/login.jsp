<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
					
					$("#loginBefore").hide();
					$("#loginAfter").show();
					$("#content").html(response);
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