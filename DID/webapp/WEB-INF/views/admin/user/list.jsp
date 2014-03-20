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
		MovePage('user/updateForm.htm',$("#sendForm").serializeArray());
	}
	
	function goPage(curPage){

		$("#curPage").val(curPage);
		var data = $("#sendForm").serializeArray();
		MovePage("user/list.htm", data);
		return false;
	}
</Script>
<form name="sendForm" id="sendForm" method="post">
<input type="hidden" name="id" id="id"/>
<input type="hidden" name="curPage" id="curPage" value="${pageHandler.curPage}"/>
	<article>
		<section>
       	<h1>Admin 관리</h1>
           <figure>
           	<table>
					<thead>
						 <tr align="center">
					        <th>ID</th>
					        <th>name</th>
					        <th>등록일</th>
					    </tr> 
					</thead>
		    		<tbody> 
			
						<c:choose>
							<c:when test="${empty list}">
								<tr align="center">
									<td colspan="3">서비스가 없습니다.</td>
								</tr>
							</c:when>	
							<c:otherwise>
								<c:forEach items="${list}" var="user">
									<tr align="center" onclick="javascript:goDetail('${user.id}');" style="cursor:hand">
									   <td>${user.id}</td>
									   <td>${user.name}</td>
									   <td><fmt:formatDate value="${user.register_date}" pattern="yyyy-MM-dd" /></td>
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
