<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <base href="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/">
    <title>历史列表</title>
    <script type="text/javascript" src="../../../myjs/jquery-3.2.1.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".update").click(function () {
                var obj = this;
                $.ajax({
                    url:"/getClientInfo",
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
                            if (data.data.sex === 1) {
                                $("#check1").attr("checked", "checked");
                            } else {
                                $("#check2").attr("checked", "checked");
                            }
                            $("#age").val(data.data.age);
                            $("#address").val(data.data.address);
                            $("#medicineId").val(data.data.medicineId);
                            $("#condition").val(data.data.condition);
                            $("#remark").val(data.data.remark);
                            $("#clientInfo").modal();
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
                var sex = $('input[name="sex"]:checked').val();
                var address = $("#address").val();
                var age = $("#age").val();
                var medicineId = $("#medicineId").val();
                var condition = $("#condition").val();
                var remark = $("#remark").val();

                if (!pattern.test(medicineId).valueOf() || !pattern.test(age).valueOf()){
                    alert("数字格式错误");
                    return;
                }
                if(condition == "" || address == "" || age == "" || name == ""){
                    alert("请补全相关");
                    return;
                }

                $.ajax({
                    url:"/updateClient",
                    type:"POST",
                    data:{
                        editClient:id,
                        name:name,
                        sex:sex,
                        address:address,
                        age:age,
                        medicineId:medicineId,
                        condition:condition,
                        remark:remark
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
<div id="page-wrapper">
    <div class="col-md-12">
        <table class="table table-bordered table-hover" id="studentTable">
            <tr>
                <th class="text-center">客户姓名</th>
                <th class="text-center">客户地址</th>
                <th class="text-center">客户年龄</th>
                <th class="text-center">购买药物</th>
                <th class="text-center">购买日期</th>
                <th class="text-center">详情</th>
                <th class="text-center">删除</th>
            </tr>
            <c:if test="${!empty requestScope.pageClient}">
            <c:forEach var="client" items="${requestScope.pageClient}">
                <tr>
                    <th class="text-center">${client.name}</th>
                    <th class="text-center">${client.address}</th>
                    <th class="text-center">${client.age}</th>
                    <th class="text-center">${client.medicineId}</th>
                    <th class="text-center">${client.date}</th>
                    <th class="text-center">
                        <c:if test="${sessionScope.loinUser.authority == 0 || sessionScope.loginUser.authority == 1}">
                            <button class="btn btn-success btn-sm update" type="button" value="${client.recordId}">详情</button>
                        </c:if>
                        <c:if test="${sessionScope.loginUser.authority == 2}">
                            <button class="btn btn-success btn-sm update" type="button" value="${client.recordId}" disabled="disabled">详情</button>
                        </c:if>
                    </th>
                    <th class="text-center">
                        <c:if test="${sessionScope.loginUser.authority == 2}">
                        <a href="/deleteClient?deleteId=${client.recordId}" class="btn btn-danger btn-sm " id="deleteBtn" role="button" disabled="">删除</a>
                        </c:if>
                        <c:if test="${sessionScope.loginUser.authority == 1 || sessionScope.loginUser.authority == 0}">
                            <a href="/deleteClient?deleteId=${client.recordId}" class="btn btn-danger btn-sm " id="deleteBtn" role="button">删除</a>
                        </c:if>
                    </th>
                </tr>
            </c:forEach>
            </c:if>
            <c:if test="${empty requestScope.pageClient}">
                <strong style="color: red">很遗憾没有记录</strong>
            </c:if>
        </table>

        <div class="text-right">
            <h3><strong style="color: red;">${requestScope.error}</strong></h3>
            <c:if test="${requestScope.pageMessage.sumPage > 1}">
                <a href="/clientPageQuery?record=${requestScope.pageMessage.record}&sumPage=${requestScope.pageMessage.sumPage}
                &page=${requestScope.pageMessage.page == 1 ? 1 : requestScope.pageMessage.page - 1}&recordId=${requestScope.record}&userId=${requestScope.user}&handled=${requestScope.handled}" class="btn btn-primary btn-lg active" role="button">上一页</a>
                <a href="/clientPageQuery?record=${requestScope.pageMessage.record}&sumPage=${requestScope.pageMessage.sumPage}
                &page=${requestScope.pageMessage.page == requestScope.pageMessage.sumPage ? requestScope.pageMessage.sumPage : requestScope.pageMessage.page + 1}&recordId=${requestScope.record}&userId=${requestScope.user}&handled=${requestScope.handled}" class="btn btn-primary btn-lg active" role="button">下一页</a>
            </c:if>
        </div>

    </div>
</div>

<div class="modal fade" id="clientInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">修改客户信息</h4>
            </div>
            <div class="modal-body">
                <form action="" method="post" class="form-horizontal" id="insertForm">
                    <div class="form-group">
                        <label for="name" class="control-label col-md-3">客户姓名</label>
                        <div class="col-md-5">
                            <input type="text" class="form-control" name="name" id="name" placeholder="请输入姓名">
                            <input type="hidden" name="id" id="id">
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
                        <label for="age" class="control-label col-md-3">年龄</label>
                        <div class="col-md-5">
                            <input type="text" class="form-control" name="age" id="age" placeholder="请输入年龄">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="address" class="control-label col-md-3">地址</label>
                        <div class="col-md-5">
                            <input type="text" class="form-control" name="address" id="address" placeholder="请输入药品介绍">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="medicineId" class="control-label col-md-3">药品编号</label>
                        <div class="col-md-5">
                            <input type="text" class="form-control" name="medicineId" id="medicineId" placeholder="请输入药品编号">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="condition" class="control-label col-md-3">病况</label>
                        <div class="col-md-5">
                           <textarea class="form-control" name="condition" id="condition"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="remark" class="control-label  col-md-3">备注</label>
                        <div class="col-md-5">
                            <textarea class="form-control" id="remark" name="remark"></textarea>
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
