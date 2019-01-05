<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <base href="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/">
    <title>病历审核</title>
    <script type="text/javascript" src="../../../myjs/jquery-3.2.1.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#recordId").change(function () {
                var recordId = $("#recordId").val();

                $.ajax({
                    url:"/getComprehensiveMedicine",
                    type:"GET",
                    data:{
                        recordId:recordId
                    },
                    success:function (data) {
                        if (data.flag == true){
                            $("#name").val(data.data.name);
                            $("#age").val(data.data.age);
                            $("#condition").val(data.data.condition);
                            $("#remark").val(data.data.remark)
                        }else {
                            alert("病单号有误")
                        }
                    }
                });
            });

            $("#add").click(function () {
                var recordId = $("#recordId").val();
                var medicineId = $("#medicineId").val();
                var phone = $("#phone").val();
                $.ajax({
                    url:"/approval",
                    data:{
                        editClient:recordId,
                        medicineId:medicineId,
                        handled:true
                    },
                    success:function (data) {
                        alert(data.data);
                    }
                });
            });
        });
    </script>
</head>
<body>
<jsp:include page="/pages/header.jsp"/>
<c:if test="${sessionScope.loginUser.authority == 0}">
<div id="page-wrapper">
    <div class="col-md-12">
        <h2 class="h2" style="text-align: center">病历审核</h2>
    </div>
    <form action="" method="post" class="form-horizontal" id="insertForm">
        <div class="form-group">
            <label for="recordId" class="control-label col-md-3">看病记录号</label>
            <div class="col-md-5">
                <input type="text" class="form-control" name="recordId" id="recordId" placeholder="请输入记录号">
            </div>
        </div>
        <div class="form-group">
            <label for="name" class="control-label col-md-3">客户姓名</label>
            <div class="col-md-5">
                <input type="text" class="form-control" name="name" id="name" placeholder="等待信息拉取" disabled>
            </div>
        </div>
        <div class="form-group">
            <label for="age" class="control-label col-md-3">年龄</label>
            <div class="col-md-5">
                <input type="text" class="form-control" name="age" id="age" placeholder="等待信息拉取" disabled>
            </div>
        </div>
        <div class="form-group">
            <label for="condition" class="control-label col-md-3">病况</label>
            <div class="col-md-5">
                <textarea class="form-control" name="condition" id="condition" placeholder="等待信息拉取" disabled></textarea>
            </div>
        </div>
        <div class="form-group">
            <label for="remark" class="control-label  col-md-3">备注</label>
            <div class="col-md-5">
                <textarea class="form-control" name="remark" id="remark" placeholder="等待信息拉取" disabled></textarea>
            </div>
        </div>
        <div class="form-group">
            <label for="medicineId" class="control-label  col-md-3">所开药品编号</label>
            <div class="col-md-5">
                <input type="text" class="form-control" name="medicineId" id="medicineId" placeholder="请输入药品编号">
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
<c:if test="${sessionScope.loginUser.authority == 1 || sessionScope.loginUser.authority == 2}">
    <div id="page-wrapper">
        <h3><strong style="color: red">很遗憾你没有此权限</strong></h3>
    </div>
</c:if>
<jsp:include page="/pages/footer.jsp"/>
</body>
</html>