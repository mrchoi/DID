<%@ page language="java" isELIgnored="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<Script type="text/javascript">
$(document).ready(function(){
	if('${ADMIN_ID}' == '') {
		alert("로그인 후 이용해 주세요");
		location.href="index.htm";
		return false;
	}
	
	$("#registbt").click(function(){
		MovePage("kiosk/insertForm.htm","");
	});
});

	function goDetail(id){
		$("#sequence").val(id);
		MovePage('kiosk/updateForm.htm',$("#sendForm").serializeArray());
	}
	
	function goPage(curPage){

		$("#curPage").val(curPage);
		var data = $("#sendForm").serializeArray();
		MovePage("kiosk/list.htm", data);
		return false;
	}
	
	function clientCommand(ip,command,sequence){
		ProcessPage("kiosk/clientCommand.htm",{ ip : ip , command : command, sequence : sequence },"kiosk/list.htm");
		
/* 		$.ajax({
			url : "kiosk/clientCommand.htm",
			data : { ip : ip , command : command, sequence : sequence },
			success : function(msg) {
				alert(msg);
				return false;
			}
		}); */
	}
	
	function serverWakeOnLan(ip,mac){
		$.ajax({
			url : "kiosk/serverWakeOnLan.htm",
			data : { ip : ip , mac : mac },
			success : function(msg) {
				alert(msg);
				return false;
			}
		});
	}
</Script>
<form name="sendForm" id="sendForm" method="post">
<input type="hidden" name="sequence" id="sequence"/>
<input type="hidden" name="id" id="id" value="${ADMIN_ID}"/>
<input type="hidden" name="curPage" id="curPage" value="${pageHandler.curPage}"/>

	<article>
		<section>
       	<h1>키오스크 단말 -> 목록</h1>
           <figure>
           	<table>
					<thead>
						 <tr align="center">
					        <th>순번</th>
					        <th>키오스크단말</th>
					        <th>IP</th>
					        <th>MAC 주소</th>
					        <th>상태</th>
					        <th>비고</th>
					    </tr> 
					</thead>
		    		<tbody> 
			
						<c:choose>
							<c:when test="${empty list}">
								<tr align="center">
									<td colspan="6">서비스가 없습니다.</td>
								</tr>
							</c:when>	
							<c:otherwise>
								<c:forEach items="${list}" var="kiosk" varStatus="status">
								
									<tr align="center">
									   <td>${status.count}</td>
									   <td><a href="#" onclick="javascript:goDetail('${kiosk.sequence}');" style="cursor:hand">${kiosk.kiosk}</a></td>
									   <td>${kiosk.ip}</td>
									   <td>${kiosk.mac_address}</td>
									   <td><c:if test="${kiosk.status=='0'}">장애</c:if><c:if test="${kiosk.status=='1'}">정상</c:if></td>
									   <td>
									   <c:if test="${kiosk.status=='0'}"><input id="statusbt" type="button" value="ON" onclick="serverWakeOnLan('${kiosk.ip}','${kiosk.mac_address}');"/></c:if>
									   <c:if test="${kiosk.status=='1'}"><input id="statusbt" type="button" value="OFF" onclick="clientCommand('${kiosk.ip}','0','${kiosk.sequence}');"/></c:if>
									   <c:if test="${kiosk.status=='1'}"><input id="timebt" type="button" value="시계보정" onclick="clientCommand('${kiosk.ip}','1','${kiosk.sequence}');"/></c:if>
									   <c:if test="${kiosk.status=='1'}"><c:if test="${kiosk.obstacle_status=='0'}"><input id="obstaclebt" type="button" value="장애공지" onclick="clientCommand('${kiosk.ip}','2','${kiosk.sequence}');"/></c:if></c:if>				
									   <c:if test="${kiosk.status=='1'}"><input id="restartbt" type="button" value="재시작" onclick="clientCommand('${kiosk.ip}','3','${kiosk.sequence}');"/></c:if>
									   </td>
									</tr>
								</c:forEach>
							</c:otherwise>					
						</c:choose>
						
					</tbody>
				</table>						
           </figure>
        </section>
        	
			<c:if test="${pageHandler.numbPageUrlList.size() >1}"> 
			<div align="center">
				<input id="nextbt" type="button" value="Next"/>
			</div>
			</c:if>
			
			<div align="right">
				<input id="registbt" type="button" value="Regist"/>
			</div>	
    </article>	

</form>
