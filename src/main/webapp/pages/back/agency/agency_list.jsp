<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <base href="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/">
    <title>代理列表</title>
    <script type="text/javascript" src="../../../myjs/jquery-3.2.1.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".update").click(function () {
                var obj = this;

                $.ajax({
                    url:"/getAgencyInfo",
                    type:"GET",
                    data:{
                        id:obj.value
                    },
                    success:function (data) {
                        if (data.flag == false){
                            alert("系统异常，请稍后再试");
                        }else {
                            $("#id").val(data.data.id);
                            $("#name").val(data.data.name);
                            $("#chargePerson").val(data.data.chargePerson);
                            if (data.data.sex === 1) {
                                $("#check1").attr("checked", "checked");
                            } else {
                                $("#check2").attr("checked", "checked");
                            }
                            $("#phone").val(data.data.phone);
                            $("#agencyInfo").modal();
                        }
                    },
                    fail:function () {
                        alert("请检查网络连接")
                    }
                });
            });


            $("#completeUpdate").click(function () {
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
                    url:"/updateAgency",
                    type:"POST",
                    data:{
                        editAgency:id,
                        name:name,
                        chargePerson:chargePerson,
                        sex:sex,
                        phone:phone
                    },
                    success:function (data) {
                        console.log(data);
                        alert(data.data);
                    },
                    fail:function () {
                        alert("请检查网络连接");
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
        <table class="table table-bordered table-hover" id="classesTable">
            <tr>
                <th class="text-center">代理编号</th>
                <th class="text-center">代理名称</th>
                <th class="text-center">代理联系人</th>
                <th class="text-center">联系人性别</th>
                <th class="text-center">联系人电话</th>
                <th class="text-center">修改</th>
                <th class="text-center">删除</th>
            </tr>
            <c:if test="${!empty requestScope.pageAgency}">
                <c:forEach var="agency" items="${requestScope.pageAgency}">
                    <tr>
                        <th class="text-center">${agency.id}</th>
                        <th class="text-center">${agency.name}</th>
                        <th class="text-center">${agency.chargePerson}</th>
                        <th class="text-center">
                            <c:if test="${agency.sex == 1}">男</c:if>
                            <c:if test="${agency.sex == 0}">女</c:if>
                        </th>
                        <th class="text-center">${agency.phone}</th>
                        <th class="text-center">
                            <button class="btn btn-success btn-sm update"  type="button"  value="${agency.id}">修改</button>
                        </th>
                        <th class="text-center">
                            <a href="/deleteAgency?deleteId=${agency.id}" class="btn btn-danger btn-sm " id="deleteBtn" role="button">删除</a>
                        </th>
                    </tr>
                </c:forEach>
            </c:if>
            <c:if test="${empty requestScope.pageAgency}">
                <strong style="color: red">很遗憾没有记录</strong>
            </c:if>
        </table>
        <div class="text-right">
            <h3><strong style="color: red;">${requestScope.error}</strong></h3>
            <c:if test="${requestScope.pageMessage.sumPage > 1}">
                <a href="/agencyPageQuery?record=${requestScope.pageMessage.record}&sumPage=${requestScope.pageMessage.sumPage}
                &page=${requestScope.pageMessage.page == 1 ? 1 : requestScope.pageMessage.page - 1}" class="btn btn-primary btn-lg active" role="button">上一页</a>
                <a href="/agencyPageQuery?record=${requestScope.pageMessage.record}&sumPage=${requestScope.pageMessage.sumPage}
                &page=${requestScope.pageMessage.page == requestScope.pageMessage.sumPage ? requestScope.pageMessage.sumPage : requestScope.pageMessage.page + 1}" class="btn btn-primary btn-lg active" role="button">下一页</a>
            </c:if>
        </div>
    </div>
</div>
</c:if>
<c:if test="${sessionScope.loginUser.authority == 0 || sessionScope.loginUser.authority == 1}">
    <div id="page-wrapper">
        <h3><strong style="color: red">很遗憾你没有此权限</strong></h3>
    </div>
</c:if>
<div class="modal fade" id="agencyInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Modal title</h4>
            </div>
            <div class="modal-body">
                <form action="" method="post" class="form-horizontal" id="insertForm">
                    <div class="form-group">
                        <label for="id" class="control-label col-md-3">代理编号</label>
                        <div class="col-md-5">
                            <input type="text" class="form-control" name="id" id="id" placeholder="请输入代理编号" disabled>
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
                                <input type="radio" name="sex" value="1" id="check1">男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="sex" value="0" id="check2">女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="phone" class="control-label col-md-3">联系电话</label>
                        <div class="col-md-5">
                            <input type="text" class="form-control" name="phone" id="phone" placeholder="请输入代理联系人电话">
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
