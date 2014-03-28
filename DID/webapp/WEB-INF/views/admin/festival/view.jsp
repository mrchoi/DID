<%@ page language="java" isELIgnored="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript" src="http://malsup.github.com/jquery.form.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	$("#registbt").click(function(){
		$("#auth").val();
		
		var data = $("#scForm").serializeArray();
		
		$("#scForm").ajaxSubmit({
			success : function(data){
				alert(data);
				var data = $("#scForm").serializeArray();
				MovePage("info/list.htm",data);
			},
			error : function(){
				alert("시스템 에러 입니다. 관리자에게 문의 하세요");
				return false;
			}
	 	});
		//ProcessPage("info/update.htm",data,"info/list.htm");
	});
	
	$("#nextbt").click(function(){
		var data = $("#scForm").serializeArray();
		MovePage("info/list.htm", data);
	});	
	
	$("#deletebt").click(function(){
		var data = $("#scForm").serializeArray();
		if(confirm("삭제하시겠습니까?")){
			ProcessPage("info/delete.htm",data,"info/list.htm");
		}
	});	
});
	
</script>
<form name="scForm" id="scForm" method="post" enctype="multipart/form-data" action="info/update.htm">
	<input type="hidden" name="curPage" id="curPage" value="${curPage}"/>
	<input type="hidden" name="category" id="category" value="${category}"/>
	<input type="hidden" name="id" id="id" value="${ADMIN_ID}"/>
	<input type="hidden" name="sequence" id="sequence" value="${info.sequence}"/>
	<article>
			<section>
	       	<h1>축제/행사 안내 -> 수정</h1>
	           <figure>			
					<table summary= "축제/행사 안내 수정">						
						<colgroup>
						<col width="140"><col>
						<col width="120"><col>
						</colgroup>
						<tbody>
							<tr class="underline">
								<th scope="row"><label for="title">축제/행사 안내</label></th>
								<td>${info.title}
								</td>
							</tr>
							<tr class="underline">
								<th scope="row"><label for="file_url">위치정보</label></th>
								<td><input type="file" id="file_url" name="file_url" multiple="" />
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
