<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <base href="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/">
    <title>人员列表</title>
    <script type="text/javascript" src="../../../myjs/jquery-3.2.1.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".update").click(function () {
                var obj = this;

                $.ajax({
                    url:"/getInfo",
                    type:"GET",
                    data:{
                        id:obj.value
                    },
                    success:function (data) {
                        if (data.flag == false){
                            alert("系统异常,请稍后再试")
                        }else{
                            $("#id").val(data.data.id);
                            $("#name").val(data.data.name);
                            $("#password").val(data.data.password);
                            $("#authority").val(data.data.authority);
                            $("#userInfo").modal();
                        }
                    },
                    fail:function () {
                        alert("请检查网络连接");
                    }
                });
            });

            $("#completeUpdate").click(function () {
                var id = $("#id").val();
                var name = $("#name").val();
                var password = $("#password").val();
                var authority = $("#authority").val();

                if (id == "" || id == null || password == "" || password == null || name == "" || name == null
                    || authority == "" || authority == null
                ){
                    alert("请补全信息");
                    return false;
                }

                $.ajax({
                    url:"/update",
                    type:"POST",
                    data:{
                        editUser:id,
                        name:name,
                        password:password,
                        authority:authority
                    },
                    success:function (data) {
                        console.log(data);
                        alert(data.data);
                    },
                    fail:function () {
                        alert("请检查网络连接")
                    }
                });
            });
        });
    </script>
</head>
<body>
<jsp:include page="/pages/header.jsp"/>
<!--主体内容编写-->
<c:if test="${sessionScope.loginUser.authority == 2}">
<div id="page-wrapper">
    <div class="col-md-12">
        <table class="table table-bordered table-hover" id="studentTable">
            <tr>
                <th class="text-center">用户编号</th>
                <th class="text-center">用户姓名</th>
                <th class="text-center">用户权限</th>
                <th class="text-center">修改</th>
                <th class="text-center">删除</th>
            </tr>
            <c:if test="${!empty requestScope.pageUsers}">
                <c:forEach var="user" items="${requestScope.pageUsers}">
                    <tr>
                        <th class="text-center">${user.id}</th>
                        <th class="text-center">${user.name}</th>
                        <th class="text-center">
                            <c:if test="${user.authority == 0}">
                                药师
                            </c:if>
                            <c:if test="${user.authority == 1}">
                                医师
                            </c:if>
                            <c:if test="${user.authority == 2}">
                                管理员
                            </c:if>
                        </th>
                        <th class="text-center">
                            <button class="btn btn-success btn-sm update" id="updateBtn" type="button"  value="${user.id}" >修改</button>
                        </th>
                        <th class="text-center">
                           <a href="/delete?deleteId=${user.id}" class="btn btn-danger btn-sm " id="deleteBtn" role="button">删除</a>
                        </th>
                    </tr>
                </c:forEach>
            </c:if>
            <c:if test="${empty requestScope.pageUsers}">
                <strong style="color: red">很遗憾没有记录</strong>
            </c:if>
        </table>

        <div class="text-right">
            <h3><strong style="color: red;">${requestScope.error}</strong></h3>
            <c:if test="${requestScope.pageMessage.sumPage > 1}">
                <a href="/pageQuery?record=${requestScope.pageMessage.record}&sumPage=${requestScope.pageMessage.sumPage}
                &page=${requestScope.pageMessage.page == 1 ? 1 : requestScope.pageMessage.page - 1}" class="btn btn-primary btn-lg active" role="button">上一页</a>
                <a href="/pageQuery?record=${requestScope.pageMessage.record}&sumPage=${requestScope.pageMessage.sumPage}
                &page=${requestScope.pageMessage.page == requestScope.pageMessage.sumPage ? requestScope.pageMessage.sumPage : requestScope.pageMessage.page + 1}" class="btn btn-primary btn-lg active" role="button">下一页</a>
            </c:if>
        </div>
    </div>
</div>
</c:if>
<c:if test="${sessionScope.loginUser.authority == 1 || sessionScope.loginUser.authority == 0}">
    <div id="page-wrapper">
        <h3><strong style="color: red">很遗憾你没有此权限</strong></h3>
    </div>
</c:if>
<div class="modal fade" id="userInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">修改用户信息</h4>
            </div>
            <div class="modal-body">
                <form action="#" method="post" class="form-horizontal" id="insertForm">
                    <div class="form-group">
                        <label for="id" class="control-label col-md-3">人员编号</label>
                        <div class="col-md-5">
                            <input type="text" class="form-control" name="id" id="id" placeholder="请输入人员编号" disabled>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="name" class="control-label col-md-3">人员姓名</label>
                        <div class="col-md-5">
                            <input type="text" class="form-control" name="name" id="name" placeholder="请输入人员姓名">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="password" class="control-label col-md-3">密码</label>
                        <div class="col-md-5">
                            <input type="password" class="form-control" name="password" id="password" placeholder="请输入密码">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3" for="authority">权限等级</label>
                        <div class="col-md-5">
                            <select name="authority" id="authority" class="form-control">
                                <option value="0">药师</option>
                                <option value="1">医师</option>
                                <option value="2">管理员</option>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="completeUpdate">修改</button>
            </div>
        </div>
    </div>
</div>
<jsp:include page="/pages/footer.jsp"/>
</body>
</html>
