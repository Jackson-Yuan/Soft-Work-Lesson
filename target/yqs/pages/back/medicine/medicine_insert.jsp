<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <base href="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/">
    <title>药品添加</title>
    <meta charset="utf-8">
    <script type="text/javascript" src="../../../myjs/jquery-3.2.1.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#add").click(function () {
                var pattern = /^[0-9]*$/;
                var id = $("#id").val();
                var batchId = $("#batchId").val();
                var resource = $("#resource").val();
                var name = $("#name").val();
                var introduction = $("#introduction").val();
                var method = $('input[name="method"]:checked').val();
                var type = $('input[name="type"]:checked').val();
                var quantity = $("#quantity").val();
                var startTime = $("#startTime").val();
                var endTime = $("#endTime").val();
                var price = $("#price").val();
                var specification = $("#specification").val();

                if (!pattern.test(id).valueOf() || !pattern.test(quantity).valueOf() || !pattern.test(resource).valueOf()){
                    alert("编号,数量格式不正确");
                    return ;
                }
                if(resource == "" || introduction == "" || method == "" || name == ""){
                    alert("请补全相关项");
                    return;
                }

                $.ajax({
                    url:"/addMedicine",
                    type:"POST",
                    data:{
                        id:id,
                        batchId:batchId,
                        name:name,
                        resource:resource,
                        introduction:introduction,
                        method:method,
                        quantity:quantity,
                        type:type,
                        specification:specification,
                        startTime:startTime,
                        endTime:endTime,
                        price:price
                    },

                    success:function (data) {
                        console.log(data);
                        alert(data.data);
                        if(data.flag == true){
                            $("#id").val("");
                            $("#resource").val("");
                            $("#name").val("");
                            $("#introduction").val("");
                            $("#quantity").val("");
                        }
                    },
                    fail:function () {
                        alert("请检查网络连接");
                    }
                });
            })
        });
    </script>
</head>
<body>
<jsp:include page="/pages/header.jsp"/>
<!--主体内容编写-->
<c:if test="${sessionScope.loginUser.authority == 2}">
    <div id="page-wrapper">
        <div class="col-md-12">
            <h2 class="h2" style="text-align: center">增加药品</h2>
        </div>
        <form action="" method="post" class="form-horizontal" id="insertForm">
            <div class="form-group">
                <label for="batchId" class="control-label col-md-3">药品进货批号</label>
                <div class="col-md-5">
                    <input type="text" class="form-control" name="batchId" id="batchId" placeholder="请输入药品进货批号">
                </div>
            </div>
            <div class="form-group">
                <label for="id" class="control-label col-md-3">药品编号</label>
                <div class="col-md-5">
                    <input type="text" class="form-control" name="id" id="id" placeholder="请输入药品编号">
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-md-3">代理编号</label>
                <div class="col-md-5">
                    <input type="text" class="form-control" name="resource" id="resource" placeholder="请输入代理编号">
                </div>
            </div>
            <div class="form-group">
                <label for="name" class="control-label col-md-3">药品名称</label>
                <div class="col-md-5">
                    <input type="text" class="form-control" name="name" id="name" placeholder="请输入药品名称">
                </div>
            </div>
            <div class="form-group">
                <label for="introduction" class="control-label col-md-3">药品介绍</label>
                <div class="col-md-5">
                    <textarea class="form-control" name="introduction" id="introduction" placeholder="请输入药品介绍"></textarea>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-md-3">药品服用方法</label>
                <div class="col-md-5">
                    <label class="radio-inline">
                        <input type="radio" name="method" value="内服" checked="checked">外服
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="method" value="外服">内服
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label for="specification" class="control-label  col-md-3">药品规格</label>
                <div class="col-md-5">
                    <input type="text" class="form-control" name="specification" id="specification" placeholder="请输入药品规格">
                </div>
            </div>
            <div class="form-group">
                <label  class="control-label col-md-3">药品类型</label>
                <div class="col-md-5">
                    <label class="radio-inline">
                        <input type="radio" name="type" value="true" id="typeCheck1">处方药
                    </label>
                    <label class="radio-inline">
                        <input type="radio" name="type" value="false" id="typeCheck2">非处方药
                    </label>
                </div>
            </div>
            <div class="form-group">
                <label for="quantity" class="control-label  col-md-3">数量</label>
                <div class="col-md-5">
                    <input type="text" class="form-control" name="quantity" id="quantity" placeholder="请输入数量">
                </div>
            </div>
            <div class="form-group">
                <label for="price" class="control-label  col-md-3">单价</label>
                <div class="col-md-5">
                    <input type="text" class="form-control" name="price" id="price" placeholder="请输入单价">
                </div>
            </div>
            <div class="form-group">
                <label for="startTime" class="control-label  col-md-3">出厂日期</label>
                <div class="col-md-5">
                    <input type="date" class="form-control" name="startTime" id="startTime" placeholder="请输入出厂日期">
                </div>
            </div>
            <div class="form-group">
                <label for="endTime" class="control-label  col-md-3">截止日期</label>
                <div class="col-md-5">
                    <input type="date" class="form-control" name="endTime" id="endTime" placeholder="请输入截止日期">
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
