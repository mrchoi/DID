<%@ page language="java" isELIgnored="false" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
  </head>
  <body>
  	<div><img src="${pageContext.request.contextPath}/resources/fileupload/${url}" ></div>
  	<div align="right"><a href="javascript:self.close();"><input id="registbt" type="button" value="닫기"/></a></div>
  </body>
</html>