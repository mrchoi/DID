<%@ page language="java" isELIgnored="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<Script type="text/javascript">
$(document).ready(function(){
	if('${ADMIN_ID}' == '') {
		alert("로그인 후 이용해 주세요");
		location.href="index.htm";
		return false;
	}
	
	$("#registbt").click(function(){
		var data = $("#sendForm").serializeArray();
		MovePage('qrcode/insertForm.htm',data);
	});
});

	function goDetail(id){
		$("#sequence").val(id);
		MovePage('qrcode/updateForm.htm',$("#sendForm").serializeArray());
	}
	
	function goPage(curPage){

		$("#curPage").val(curPage);
		var data = $("#sendForm").serializeArray();
		MovePage("qrcode/list.htm", data);
		return false;
	}
	
	function goLocationView(addr){
		if(addr == ""){
			alert("잘못된 위치 정보입니다. 다시 위치정보를 확인해 주세요");
			return false;
		}
		$("#location").val(addr);
		
		popUp($("#locationForm"), "info/popup.htm");
	}
	
</Script>

<form name="locationForm" id="locationForm" method="post">
	<input type="hidden" name="location" id="location"/>
</form>
<form name="sendForm" id="sendForm" method="post">
<input type="hidden" id="id" name="id"  value="${ADMIN_ID}"/>
<input type="hidden" id="sequence" name="sequence"/>
<input type="hidden" id="curPage" name="curPage"  value="${pageHandler.curPage}"/>

	<article>
		<section>
       	<h1>QR코드 -> 목록</h1>
           <figure>
           	<table>
					<thead>
						 <tr align="center">
					        <th width="10%">순번</th>
					        <th width="20%">축제/행사</th>
					        <th width="20%">제목</th>
					        <th width="30%">QR코드 생성 URL</th>
					        <th width="20%">QR코드미리보기</th>
					    </tr> 
					</thead>
		    		<tbody> 
			
						<c:choose>
							<c:when test="${empty list}">
								<tr align="center">
									<td colspan="5">서비스가 없습니다.</td>
								</tr>
							</c:when>	
							<c:otherwise>
								<c:forEach items="${list}" var="qrcode" varStatus="status">
								
									<tr align="center">
									   <td width="10%">${status.count}</td>
									   <td width="20%">${qrcode.info_title}</td>
									   <td width="20%"><a href="#" onclick="javascript:goDetail('${qrcode.sequence}');" style="cursor:hand">${qrcode.title}</a></td>
									   <td width="30%">
									   <!--<c:if test="${qrcode.file_url !=''}">http://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}
									   ${url}${qrcode.file_url}</c:if>-->
									   <c:if test="${fn:length(qrcode.file_url) > 0}">http://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/admin/qrcode/movie.htm?seq=${qrcode.sequence}
									   </c:if>
									   </td>
									   <td width="20%">
									   <c:if test="${fn:length(qrcode.qrcode_url) > 0}">
								   		<img src="${pageContext.request.contextPath}/resources/fileupload/${qrcode.qrcode_url}" >
									   </c:if>
									   </td>
									</tr>
								</c:forEach>
							</c:otherwise>					
						</c:choose>
						
					</tbody>
				</table>						
           </figure>
        </section>
        <c:if test="${pageHandler.numbPageUrlList.size() > 0}"> 
		<div align="center" class="paginate">
			<a href="#" class="pre_end" onclick="javascript:goPage('${pageHandler.startPage}');return false;">처음</a>
			<a href="#" class="pre" onclick="javascript:goPage('${pageHandler.prevPage}');return false;">이전</a>
			<c:forEach items="${pageHandler.numbPageUrlList}" var="numbPageList">
				<c:choose>
					<c:when test="${pageHandler.curPage == numbPageList.pageNumb}">
						<strong>${numbPageList.pageNumb}</strong>
					</c:when>
					<c:otherwise>
						<a href="#" onclick="javascript:goPage('${numbPageList.pageNumb}');return false;">${numbPageList.pageNumb}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<a href="#" class="next" onclick="javascript:goPage('${pageHandler.nextPage}');return false;">다음</a>
			<a href="#" class="next_end" onclick="javascript:goPage('${pageHandler.endPage}');return false;">끝</a>
		</div>
		</c:if>
			
		<div align="right">
			<input id="registbt" type="button" value="Regist"/>
		</div>	
    </article>	

</form>
