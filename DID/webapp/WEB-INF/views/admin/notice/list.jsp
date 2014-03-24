<%@ page language="java" isELIgnored="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<Script type="text/javascript">
$(document).ready(function(){
	if('${ADMIN_ID}' == '') {
		$("#center").html("");
		alert("로그인 후 이용해 주세요");
		MovePage("admin/login.htm","");
		return false;
	}
});

	function goDetail(id){
		 $("#id").val(id);
		MovePage('notice/updateForm.htm',$("#sendForm").serializeArray());
	}
	
	function goPage(curPage){

		$("#curPage").val(curPage);
		var data = $("#sendForm").serializeArray();
		MovePage("notice/list.htm", data);
		return false;
	}
</Script>
<form name="sendForm" id="sendForm" method="post">
<input type="hidden" name="id" id="id"/>
<input type="hidden" name="curPage" id="curPage" value="${pageHandler.curPage}"/>
	<article>
		<section>
       	<h1>키오스크 매니저 -> 목록</h1>
           <figure>
           	<table>
					<thead>
						 <tr align="center">
					        <th>순번</th>
					        <th>키오스크단말</th>
					        <th>제목</th>
					        <th>상태</th>
					        <th>등록자</th>
					        <th>등록일</th>
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
								<c:forEach items="${list}" var="notice">
									<tr align="center" onclick="javascript:goDetail('${notice.id}');" style="cursor:hand">
									   <td>${notice.id}</td>
									   <td>${notice.kind}</td>
									   <td>${notice.title}</td>
									   <td>${notice.status}</td>
									   <td>${notice.id}</td>
									   <td><fmt:formatDate value="${notice.register_date}" pattern="yyyy-MM-dd" /></td>
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
