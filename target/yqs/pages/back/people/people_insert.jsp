<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <base href="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/">
    <title>人员添加</title>
    <script type="text/javascript" src="../../../myjs/jquery-3.2.1.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#submit").click(function () {
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
                    url:"/register",
                    type:"POST",
                    data:{
                        id:id,
                        name:name,
                        password:password,
                        authority:authority
                    },
                    success:function (data) {
                        console.log(data);
                        alert(data.data);
                        if(data.flag === true){
                            $("#id").val("");
                            $("#name").val("");
                            $("#password").val("");
                            $("#authority").val("");
                        }
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
        <h2 class="h2" style="text-align: center">添加人员</h2>
    </div>
    <form action="" method="post" class="form-horizontal" id="insertForm">
        <div class="form-group">
            <label for="id" class="control-label col-md-3">人员编号</label>
            <div class="col-md-5">
                <input type="text" class="form-control" name="id" id="id" placeholder="请输入人员编号">
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
        <div class="form-group">
            <div class="col-md-4 col-md-offset-6">
                <button type="button" class="btn btn-success btn-sm" id="submit">增加</button>
                <button type="reset" class="btn btn-danger btn-sm">重置</button>
            </div>
        </div>
    </form>
</div>
</c:if>
<c:if test="${sessionScope.loginUser.authority == 0 || sessionScope.loginUser.authority == 1}">
    <div id="page-wrapper">
        <h3><strong style="color: red">很遗憾你没有此权限</strong></h3>
    </div>
</c:if>
<jsp:include page="/pages/footer.jsp"/>
</body>
</html>
