<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <base href="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/">
    <title>代理添加</title>
    <script type="text/javascript" src="../../../myjs/jquery-3.2.1.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#add").click(function () {
                var pattern = /^[0-9]*$/;
                var id = $("#id").val();
                var name = $("#name").val();
                var chargePerson = $("#chargePerson").val();
                var sex = $('input[name="sex"]:checked').val();
                var phone = $("#phone").val();

                if (!pattern.test(id).valueOf() || !pattern.test(phone).valueOf()){
                    alert("编号,电话格式不正确");
                    return ;
                }
                if(chargePerson == "" || name == ""){
                    alert("请补全相关项");
                    return;
                }

                $.ajax({
                    url:"/addAgency",
                    type:"POST",
                    data:{
                        id:id,
                        name:name,
                        chargePerson:chargePerson,
                        sex:sex,
                        phone:phone
                    },
                    success:function (data) {
                        console.log(data);
                        alert(data.data);
                        if(data.flag == true){
                            $("#id").val("");
                            $("#name").val("");
                            $("#chargePerson").val("");
                            $("#phone").val("");
                        }
                    },
                    fail:function () {
                        alert("请检查网络连接");
                    }
                });
            });


        })
    </script>
</head>
<body>
<jsp:include page="/pages/header.jsp"/>
<!--主体内容编写-->
<c:if test="${sessionScope.loginUser.authority == 2}">
<div id="page-wrapper">
   <div class="col-md-12">
       <h2 class="h2" style="text-align: center">增加代理</h2>
   </div>
            <form action="" method="post" class="form-horizontal" id="insertForm">
                <div class="form-group">
                    <label for="id" class="control-label col-md-3">代理编号</label>
                    <div class="col-md-5">
                        <input type="text" class="form-control" name="id" id="id" placeholder="请输入代理编号">
                    </div>
                </div>
                <div class="form-group">
                    <label for="name" class="control-label col-md-3">代理名称</label>
                    <div class="col-md-5">
                        <input type="text" class="form-control" name="name" id="name" placeholder="请输入代理名称">
                    </div>
                </div>
                <div class="form-group">
                    <label for="chargePerson" class="control-label col-md-3">代理联系人</label>
                    <div class="col-md-5">
                        <input type="text" class="form-control" name="chargePerson" id="chargePerson" placeholder="请输入代理联系人">
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-md-3">性别</label>
                    <div class="col-md-5">
                        <label class="radio-inline">
                            <input type="radio" name="sex" value="1" checked="checked">男
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="sex" value="0">女
                        </label>
                    </div>
                </div>
                <div class="form-group">
                    <label for="phone" class="control-label col-md-3">联系电话</label>
                    <div class="col-md-5">
                        <input type="text" class="form-control" name="phone" id="phone" placeholder="请输入代理联系人电话">
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-md-4 col-md-offset-6">
                        <button type="button" class="btn btn-success btn-sm" id="add">增加</button>
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
