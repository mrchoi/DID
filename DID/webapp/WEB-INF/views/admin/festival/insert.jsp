<%@ page language="java" isELIgnored="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script type="text/javascript" src="http://malsup.github.com/jquery.form.js"></script>

<script type="text/javascript">
$(document).ready(function(){
	$("#registbt").click(function(){
		$("#auth").val();
		
		
		if($("#title").val()==""){
			alert("축제/행사 안내를 입력하여 주시기 바랍니다.");
			$("#title").focus();
			return false;
		}
		
		if($("#img_file").val() == ""){
			//alert("위치정보 이미지 파일을 입력하세요!");
			//return false;
		}
		
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
	});
	
	
	$("#nextbt").click(function(){
		var data = $("#scForm").serializeArray();
		MovePage("info/list.htm", data);
	});	
});

</script>
<form name="scForm" id="scForm" method="post" enctype="multipart/form-data" action="info/insert.htm">
	<input type="hidden" name="curPage" id="curPage" value="${curPage}"/>
	<input type="hidden" name="category" id="category" value="${category}"/>
	<input type="hidden" name="id" id="id" value="${ADMIN_ID}"/>
	<article>
			<section>
	       	<h1>축제/행사 안내 -> 등록</h1>
	           <figure>			
					<table summary= "축제/행사 안내 등록">						
						<colgroup>
						<col width="140"><col>
						<col width="120"><col>
						</colgroup>
						<tbody>
							<tr class="underline">
								<th scope="row"><label for="title">축제/행사명</label></th>
								<td><input type="text" id="title" name="title" class="i_text" maxlength="45" size="40">
								* 필수 항목입니다.
								</td>
							</tr>
							<tr class="underline">
								<th scope="row"><label for="img_file">위치정보</label></th>
								<td><input type="file" id="img_file" name="img_file" multiple=""/>
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
