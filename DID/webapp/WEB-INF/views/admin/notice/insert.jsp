<%@ page language="java" isELIgnored="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
$(document).ready(function(){
	$("#registbt").click(function(){
		$("#auth").val();
		var data = $("#scForm").serializeArray();
		
		if($("#title").val()==""){
			alert("제목을 입력하여 주시기 바랍니다.");
			$("#title").focus();
			return false;
		}

		if($("#contents").val()==""){
			alert("내용을 입력하여 주시기 바랍니다.");
			$("#contents").focus();
			return false;
		} 

		ProcessPage("notice/insert.htm",data,"notice/list.htm");
	});
	
	$("#nextbt").click(function(){
		var data = $("#scForm").serializeArray();
		MovePage("notice/list.htm", data);
	});	
});

</script>
<form name="scForm" id="scForm">
	<input type="hidden" name="curPage" id="curPage" value="${curPage}"/>
	<article>
			<section>
	       	<h1>키오스크 매니저 -> 등록</h1>
	           <figure>			
					<table summary="키오스크 매니저 정보 등록">						
						<colgroup>
						<col width="140"><col>
						<col width="120"><col>
						</colgroup>
						<tbody>
							<tr class="underline">
								<th scope="row"><label for="kind">키오스크 단말</label></th>
								<td><input type="text" id="kind" name="kind" class="i_text">
								</td>
							</tr>
							<tr class="underline">
								<th scope="row"><label for="title">제목</label></th>
								<td><input type="text" id="title" name="title" class="i_text" maxlength="45">
								* 필수 항목입니다.
								</td>
							</tr>
							<tr class="underline">
								<th scope="row"><label for="contents">내용</label></th>
								<td><textarea rows="5" cols="50" id="contents" name="contents"></textarea>
								</td>
							</tr>
							<tr class="underline">
								<th scope="row"><label for="status">상태</label></th>
								<td>
									<select name="status" id="status">
										<option value="1">실행</option>
										<option value="2">종료</option>
									</select>
								</td>
							</tr>
						</tbody>
					</table>
				</figure>
			</section>
			
			<div align="center">
				<input id="registbt" type="button" value="Regist"/>
				<input id="nextbt" type="button" value="List"/>
			</div>	
					
		</article>
</form>
