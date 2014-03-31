<%@ page language="java" isELIgnored="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript" src="http://malsup.github.com/jquery.form.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	$("#registbt").click(function(){
		$("#auth").val();
		
		$("#scForm").ajaxSubmit({
			success : function(data){
				alert(data);
				var data = $("#scForm").serializeArray();
				MovePage("qrcode/list.htm",data);
			},
			error : function(){
				alert("시스템 에러 입니다. 관리자에게 문의 하세요");
				return false;
			}
	 	});
	});
	
	$("#nextbt").click(function(){
		var data = $("#scForm").serializeArray();
		MovePage("qrcode/list.htm", data);
	});	
	
	$("#deletebt").click(function(){
		var data = $("#scForm").serializeArray();
		if(confirm("삭제하시겠습니까?")){
			ProcessPage("qrcode/delete.htm",data,"qrcode/list.htm");
		}
	});	
});
	
</script>
<form name="scForm" id="scForm" method="post" enctype="multipart/form-data" action="qrcode/update.htm">
	<input type="hidden" name="curPage" id="curPage" value="${curPage}"/>
	<input type="hidden" name="id" id="id" value="${ADMIN_ID}"/>
	<input type="hidden" name="sequence" id="sequence" value="${qrcode.sequence}"/>
	<article>
			<section>
	       	<h1>QR코드 -> 수정</h1>
	           <figure>			
					<table summary= "QR코드 수정">						
						<colgroup>
						<col width="140"><col>
						<col width="120"><col>
						</colgroup>
						<tbody>
							
							<tr class="underline">
								<th scope="row"><label for="title">축제/행사</label></th>
								<td>
								<select name="info_sequence_temp" disabled>
								<c:forEach items="${list}" var="info_list">
									<option value="${info_list.sequence}" <c:if test="${info_list.sequence == qrcode.info_sequence}"> selected </c:if>>${info_list.title}</option>
								</c:forEach>
								</select>
								<input type="hidden" name="info_sequence" value="${qrcode.info_sequence}">
								</td>
							</tr>
							<tr class="underline">
								<th scope="row"><label for="location">제목</label></th>
								<td><input type="text" id="title" name="title" class="i_text" maxlength="50" size="50" value="${qrcode.title}">
								* 필수 항목입니다.
								</td>
							</tr>
							<tr class="underline">
								<th scope="row"><label for="imgFile">동영상첨부</label></th>
								<td>
								${qrcode.file_url}
								<br>
								<input type="file" id="imgFile" name="imgFile" size="40"/>
								</td>
							</tr>
							
							<tr class="underline">
								<th scope="row"><label for="qrcodeFile">QR코드첨부</label></th>
								<td>
								${qrcode.qrcode_url}
								<br>
								<input type="file" id="qrcodeFile" name="qrcodeFile" size="40"/>
								</td>
							</tr>
							
						</tbody>
					</table>
				</figure>
			</section>
			
			<div align="right">
				<input id="registbt" type="button" value="Update"/>
				<input id="deletebt" type="button" value="Delete"/>
				<input id="nextbt" type="button" value="List"/>
			</div>	
					
		</article>
</form>
