<%@ page language="java" isELIgnored="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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

		if($("#file_url").val()==""){
			alert("동영상을 첨부하여 주시기 바랍니다.");
			$("#file_url").focus();
			return false;
		}
		
		$("#scForm").ajaxSubmit({
			success : function(data){
				alert(data);
				var data = $("#scForm").serializeArray();
				MovePage("qrcode/list.htm",data);
			},
			error : function(e){
				alert("시스템 에러 입니다. 관리자에게 문의 하세요");
				return false;
			}
	 	});

	});
	
	$("#nextbt").click(function(){
		var data = $("#scForm").serializeArray();
		MovePage("qrcode/list.htm", data);
	});
});

</script>
<form name="scForm" id="scForm" method="post" enctype="multipart/form-data" action="qrcode/insert.htm">
	<input type="hidden" name="curPage" id="curPage" value="${curPage}"/>
	<input type="hidden" name="id" id="id" value="${ADMIN_ID}"/>
	<article>
			<section>
	       	<h1>QR코드 -> 등록</h1>
	           <figure>			
					<table summary= "QR코드 등록">						
						<colgroup>
						<col width="140"><col>
						<col width="120"><col>
						</colgroup>
						<tbody>
							
							<tr class="underline">
								<th scope="row"><label for="title">축제/행사</label></th>
								<td>
								<select name="info_sequence">
								<c:forEach items="${list}" var="qrcode">
									<option value="${qrcode.sequence}">${qrcode.title}</option>
								</c:forEach>
								</select>
								
								</td>
							</tr>
							<tr class="underline">
								<th scope="row"><label for="location">제목</label></th>
								<td><input type="text" id="title" name="title" class="i_text" maxlength="50" size="50">
								* 필수 항목입니다.
								</td>
							</tr>
							<tr class="underline">
								<th scope="row"><label for="imgFile">동영상첨부</label></th>
								<td><input type="file" id="imgFile" name="imgFile" size="40"/>
								</td>
							</tr>
							
							<tr class="underline">
								<th scope="row"><label for="QrcodeFile">QR코드첨부</label></th>
								<td><input type="file" id="QrcodeFile" name="QrcodeFile" size="40"/>
								</td>
							</tr>
							
						</tbody>
					</table>
				</figure>
			</section>
			
			<div align="right">
				<input id="registbt" type="button" value="Regist"/>
				<input id="nextbt" type="button" value="List"/>
			</div>	
					
		</article>
</form>
