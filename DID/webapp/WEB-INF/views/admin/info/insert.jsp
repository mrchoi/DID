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
			alert("${CategoryName}을 입력하여 주시기 바랍니다.");
			$("#title").focus();
			return false;
		}
		
		if($("#location").val()==""){
			alert("위치정보를 입력하여 주시기 바랍니다.");
			$("#location").focus();
			return false;
		}


		if($("#contents").val()==""){
			alert("내용을 입력하여 주시기 바랍니다.");
			$("#contents").focus();
			return false;
		} 

		ProcessPage("info/insert.htm",data,"info/list.htm");
	});
	
	$("#nextbt").click(function(){
		var data = $("#scForm").serializeArray();
		MovePage("info/list.htm", data);
	});	
});

</script>
<form name="scForm" id="scForm">
	<input type="hidden" name="curPage" id="curPage" value="${curPage}"/>
	<input type="hidden" name="category" id="category" value="${category}"/>
	<input type="hidden" name="id" id="id" value="${ADMIN_ID}"/>
	<article>
			<section>
	       	<h1>${CategoryName} -> 등록</h1>
	           <figure>			
					<table summary= "${CategoryName} 등록">						
						<colgroup>
						<col width="140"><col>
						<col width="120"><col>
						</colgroup>
						<tbody>
							<!-- <tr class="underline">
								<th scope="row"><label for="title">${CategoryName}</label></th>
								<td>
									<select name="kiosk" id="kiosk">
									<c:forEach items="${list}" var="list">
										<option value="${list.kiosk}">${list.kiosk}</option>
									</c:forEach>
									</select>
								</td>
							</tr> -->
							<tr class="underline">
								<th scope="row"><label for="title">${CategoryName}</label></th>
								<td><input type="text" id="title" name="title" class="i_text" maxlength="45">
								* 필수 항목입니다.
								</td>
							</tr>
							<tr class="underline">
								<th scope="row"><label for="location">위치정보</label></th>
								<td><input type="text" id="location" name="location" class="i_text" maxlength="45" size="60">
								* 필수 항목입니다.
								</td>
							</tr>
							<tr class="underline">
								<th scope="row"><label for="contents">내용</label></th>
								<td><textarea rows="10" cols="65" id="contents" name="contents"></textarea>
								</td>
							</tr>
							
							<!--<c:if test="${fn:substring(category,0,1)=='1'}"></c:if>-->
							<tr class="underline">
								<th scope="row"><label for="file_url">이미지첨부</label></th>
								<td><input type="file" id="file_url" name="file_url" multiple="" size="40"/>
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
