<%@ page language="java" isELIgnored="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
$(document).ready(function(){
	$("#registbt").click(function(){
		$("#auth").val();
		var data = $("#scForm").serializeArray();
		
		if($("#kiosk").val()==""){
			alert("키오스크명을 입력하여 주시기 바랍니다.");
			$("#kiosk").focus();
			return false;
		}

		if($("#location").val()==""){
			alert("설치위치를 입력하여 주시기 바랍니다.");
			$("#location").focus();
			return false;
		} 
		
		if($("#ip").val()==""){
			alert("IP를 입력하여 주시기 바랍니다.");
			$("#ip").focus();
			return false;
		}
		
		if($("#schedule_start").val()==""){
			alert("스케쥴링 시작시간을 입력하여 주시기 바랍니다.");
			$("#schedule_start").focus();
			return false;
		} 
		
		if($("#schedule_end").val()==""){
			alert("스케쥴링 종료시간을 입력하여 주시기 바랍니다.");
			$("#schedule_end").focus();
			return false;
		}

		ProcessPage("kiosk/insert.htm",data,"kiosk/list.htm");
	});
	
	$("#nextbt").click(function(){
		var data = $("#scForm").serializeArray();
		MovePage("kiosk/list.htm", data);
	});	
});

</script>
<form name="scForm" id="scForm">
	<input type="hidden" name="curPage" id="curPage" value="${curPage}"/>
	<article>
			<section>
	       	<h1>키오스크 단말 -> 등록</h1>
	           <figure>			
					<table summary="키오스크 단말 정보 등록">						
						<colgroup>
						<col width="140"><col>
						<col width="120"><col>
						</colgroup>
						<tbody>
							<tr class="underline">
								<th scope="row"><label for="kiosk">키오스크 단말</label></th>
								<td>
									<input type="text" id="kiosk" name="kiosk" class="i_text" maxlength="30">
									* 필수 항목입니다.
								</td>
							</tr>
							<tr class="underline">
								<th scope="row"><label for="location">설치위치</label></th>
								<td><input type="text" id="location" name="location" class="i_text" size="50" maxlength="45">
								* 필수 항목입니다.
								</td>
							</tr>
							<tr class="underline">
								<th scope="row"><label for="ip">IP</label></th>
								<td><input type="text" id="ip" name="ip" class="i_text" maxlength="20">
								* 필수 항목입니다.
								</td>
							</tr>
							<tr class="underline">
								<th scope="row"><label for="obstacle_contents">장애공지</label></th>
								<td><textarea rows="10" cols="65" id="obstacle_contents" name="obstacle_contents"></textarea>
								</td>
							</tr>
							<tr class="underline">
								<th scope="row"><label for="schedule_start">스케쥴링</label></th>
								<td>
								<input type="text" id="schedule_start" name="schedule_start" class="i_text" maxlength="4" size="10"> ~ 
								<input type="text" id="schedule_end" name="schedule_end" class="i_text" maxlength="4" size="10">
								* 필수 항목입니다.
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
