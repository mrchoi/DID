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
	
	function goLocationView(addr){
		if(addr == ""){
			alert("잘못된 위치 정보입니다. 다시 위치정보를 확인해 주세요");
			return false;
		}
		$("#location").val(addr);
		//window.open('info/popup.htm?location='+addr,'width=650,height=450');
		
		popUp($("#locationForm"), "info/popup.htm");
	}
	
	function popUp(formName, url) {
		  var screenSizeWidth,screenSizeHeight;
		  if (self.screen) { 
		   screenSizeWidth = screen.width ;  
		   screenSizeHeight = screen.height;
		  }  

		  intWidth = screenSizeWidth;
		  intHeight = screenSizeHeight;
		  intXOffset = 0 ;
		  intYOffset = 0 ;

		   obwindow = window.open("","popup", "toolbar=no, location=no, directories=no, status=0, menubar=no, scrollbars=1,resizable=1") ;
		   obwindow.resizeTo(intWidth, intHeight) ;
		   obwindow.moveTo(intXOffset, intYOffset);
		
			formName.attr({
				action : url,
				method : "POST",
				target : "popup"
			}).submit();

	}
</Script>
<form name="locationForm" id="locationForm" method="post">
	<input type="hidden" name="location" id="location"/>
</form>
<form name="sendForm" id="sendForm" method="post">
<input type="hidden" name="id" id="id" value="${ADMIN_ID}"/>
<input type="hidden" name="sequence" id="sequence"/>
<input type="hidden" name="curPage" id="curPage" value="${pageHandler.curPage}"/>
<input type="hidden" name="category" id="category" value="${category}"/>

	<article>
		<section>
       	<h1>${CategoryName} -> 목록</h1>
           <figure>
           	<table>
					<thead>
						 <tr align="center">
					        <th>순번</th>
					        <th>${CategoryName}</th>
					        <th>위치정보</th>
					        <th>등록자</th>
					        <th>등록일</th>
					        <th>미리보기</th>
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
								<c:forEach items="${list}" var="info" varStatus="status">
								
									<tr align="center">
									   <td>${status.count}</td>
									   <td><a href="#" onclick="javascript:goDetail('${info.sequence}');" style="cursor:hand">${info.title}</a></td>
									   <td>${info.location}</td>
									   <td>${info.id}</td>
									   <td><fmt:formatDate value="${info.register_date}" pattern="yyyy-MM-dd" /></td>
									   <td><a href="#" onclick="javascript:goLocationView('${info.location}');" style="cursor:hand">미리보기</a></td>
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