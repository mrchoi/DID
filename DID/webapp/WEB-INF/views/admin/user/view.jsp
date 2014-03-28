<%@ page language="java" isELIgnored="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
$(document).ready(function(){
	$("#nextbt").click(function(){
		$("#auth").val();
		var data = $("#scForm").serializeArray();
		
		if($("#id").val()==""){
			alert("아이디를 입력하여 주시기 바랍니다.");
			$("#id").focus();
			return false;
		}

		if($("#password").val()==""){
			alert("비밀번호를 입력하여 주시기 바랍니다.");
			$("#password").focus();
			return false;
		} 
		
		if($("#password").val().length < 4){
			alert("비밀번호는 4글자 이상 입력할 수 있습니다.");
			$("#password").focus();
			return false;
		}
		
		if($("#password").val().length > 32){
			alert("비밀번호는 최대 32글자까지 입력할 수 있습니다.");
			$("#password").focus();
			return false;
		}		
		
		if($("#repassword").val()==""){
			alert("비밀번호확인을 입력하여 주시기 바랍니다.");
			$("#repassword").focus();
			return false;
		}

		if($("#repassword").val().length > 32){
			alert("비밀번호 확인은 최대 32글자까지 입력할 수 있습니다.");
			$("#repassword").focus();
			return false;
		} 
		
		if($("#password").val() != $("#repassword").val()){
			alert("비밀번호가 동일 하지 않습니다. 다시 입력하여 주시기 바랍니다.");
			$("#password").focus();
			return false;
		}

		if($("#name").val()==""){
			alert("이름을 입력하여 주시기 바랍니다.");
			$("#name").focus();
			return false;
		}
		
		ProcessPage("user/update.htm",data,"user/list.htm");
	});
	
	$("#registbt").click(function(){
		var data = $("#scForm").serializeArray();
		MovePage("user/list.htm", data);
	});	
	
	$("#deletebt").click(function(){
		var data = $("#scForm").serializeArray();
		if(confirm("삭제하시겠습니까?")){
			ProcessPage("user/delete.htm",data,"user/list.htm");
		}
	});	
});
	
	
</script>
<form name="scForm" id="scForm">
	<input type="hidden" name="chk" id="chk" />
	<input type="hidden" name="curPage" id="curPage" value="${curPage}"/>
	<input type="hidden" name="id" id="id" value="${user.id}" />
	<article>
			<section>
	       	<h1>Admin 관리 -> Admin 정보 수정</h1>
	           <figure>			
					<table summary="Admin 정보 수정">						
						<colgroup>
						<col width="140"><col>
						<col width="120"><col>
						</colgroup>
						<tbody>
							<tr class="underline">
								<th scope="row"><label for="id">ID</label></th>
								<td>${user.id}
								</td>
							</tr>
							<tr class="underline">
								<th scope="row"><label for="password">비밀번호</label></th>
								<td><input type="password" id="password" name="password" title="비밀번호는 최대 32자리까지 입력 가능합니다." class="i_text" maxlength="32">
								* 최대 32자리까지 가능합니다. 
								</td>
							</tr>
							<tr class="underline">
								<th scope="row"><label for="repassword">비밀번호 확인</label></th>
								<td><input type="password" id="repassword" name="repassword" title="비밀번호 확인" class="i_text" maxlength="32"> 
								* 비밀번호를 다시 입력해주세요.
								</td>
							</tr>
							<tr class="underline">
								<th scope="row"><label for="name">이름</label></th>
								<td><input type="text" id="name" name="name" title="이름" class="i_text" maxlength="16" value="${user.name}">
								* 필수 항목입니다.
								</td>
							</tr>
							<tr class="underline">
								<th scope="row"><label for="tel">전화번호</label></th>
								<td><input type="text" id="tel" name="tel" title="전화번호" class="i_text" maxlength="16" value="${user.tel}">
								</td>
							</tr>
						</tbody>
					</table>
				</figure>
			</section>
			
			<div align="center">
				<input id="nextbt" type="button" value="Update"/>
				<input id="deletebt" type="button" value="Delete"/>
				<input id="registbt" type="button" value="List"/>
			</div>	
					
		</article>
</form>
