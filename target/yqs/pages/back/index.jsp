<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <base href="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/">
    <meta charset="UTF-8">
    <title>首页</title>
</head>
<body>
<jsp:include page="/pages/header.jsp"/>
<!--主体内容编写-->
<div id="page-wrapper">
    <h1>当前用户ID:${sessionScope.loginUser.id}</h1>
    <h2>用户姓名:${sessionScope.loginUser.name}</h2>
    <h2>用户权限:
        <c:if test="${sessionScope.loginUser.authority == 0}">药师</c:if>
        <c:if test="${sessionScope.loginUser.authority == 1}">医师</c:if>
        <c:if test="${sessionScope.loginUser.authority == 2}">管理员</c:if>
    </h2>
</div>

<jsp:include page="/pages/footer.jsp"/>
</body>
</html>
