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
	
	$("#registbt").click(function(){
		var data = $("#sendForm").serializeArray();
		MovePage('info/insertForm.htm',data);
	});
});

	function goDetail(id){
		$("#sequence").val(id);
		MovePage('info/updateForm.htm',$("#sendForm").serializeArray());
	}
	
	function goPage(curPage){

		$("#curPage").val(curPage);
		var data = $("#sendForm").serializeArray();
		MovePage("info/list.htm", data);
		return false;
	}
	
</Script>
<form name="sendForm" id="sendForm" method="post">
<input type="hidden" name="id" id="id" value="${ADMIN_ID}"/>
<input type="hidden" name="sequence" id="sequence"/>
<input type="hidden" name="curPage" id="curPage" value="${pageHandler.curPage}"/>
<input type="hidden" name="category" id="category" value="${category}"/>

	<article>
		<section>
       	<h1>축제/행사 안내 -> 목록</h1>
           <figure>
           	<table>
					<thead>
						 <tr align="center">
					        <th>순번</th>
					        <th>축제/행사명</th>
					        <th>파일첨부 이미지</th>
					        <th>등록자</th>
					        <th>등록일</th>
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
								<c:forEach items="${list}" var="info" varStatus="status">
								
									<tr align="center">
									   <td>${status.count}</td>
									   <td><a href="#" onclick="javascript:goDetail('${info.sequence}');" style="cursor:hand">${info.title}</a></td>
									   <td>${info.file_url}</td>
									   <td>${info.id}</td>
									   <td><fmt:formatDate value="${info.register_date}" pattern="yyyy-MM-dd" /></td>
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
