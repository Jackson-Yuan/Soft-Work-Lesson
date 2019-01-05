<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <base href="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/">
    <title>客户信息添加</title>
    <script type="text/javascript" src="../../../myjs/jquery-3.2.1.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
           $("#add").click(function () {
               var pattern = /^[0-9]*$/;
               var id = $("#id").val();
               var name = $("#name").val();
               var sex = $('input[name="sex"]:checked').val();
               var address = $("#address").val();
               var age = $("#age").val();
               var condition = $("#condition").val();
               var remark = $("#remark").val();
               var phone = $("#phone").val();
               if (!pattern.test(age).valueOf()){
                   alert("数字格式错误");
                   return;
               }
               if(condition == "" || address == "" || age == "" || name == ""){
                   alert("请补全相关");
                   return;
               }

               $.ajax({
                   url:"/addClient",
                   type:"POST",
                   data:{
                       id:id,
                       name:name,
                       sex:sex,
                       address:address,
                       age:age,
                       condition:condition,
                       remark:remark,
                       phone:phone,
                       date:new Date(),
                       handled:false
                   },
                   success:function (data) {
                       console.log(data);
                       alert(data.data);
                       if(data.flag == true){
                           var name = $("#name").val("");
                           var address = $("#address").val("");
                           var age = $("#age").val("");
                           var medicineId = $("#medicineId").val("");
                           var condition = $("#condition").val("");
                           var remark = $("#remark").val("");
                       }
                   },
                   fail:function () {
                       alert("请检查网络连接");
                   }
               });
           });

           $("#id").change(function () {
               var id = $("#id").val();

               $.ajax({
                   url:"/getPersonMessage",
                   type:"GET",
                   data:{
                       id:id
                   },
                   success:function (data) {
                      if(data.flag == true){
                          $("#name").val(data.data.name);
                          $("#age").val(data.data.age);
                          $("#address").val(data.data.address);
                          $("#phone").val(data.data.phone);
                      }
                   }
               })
           });

        });
    </script>
</head>
<body>
<jsp:include page="/pages/header.jsp"/>
<!--主体内容编写-->
<c:if test="${sessionScope.loginUser.authority == 1}" >
    <div id="page-wrapper">
        <div class="col-md-12">
            <h2 class="h2" style="text-align: center">添加客户</h2>
        </div>
        <form action="" method="post" class="form-horizontal" id="insertForm">
            <div class="form-group">
                <label for="id" class="control-label col-md-3">身份证号码</label>
                <div class="col-md-5">
                    <input type="text" class="form-control" name="id" id="id" placeholder="请输入身份证号码">
                </div>
            </div>
            <div class="form-group">
                <label for="name" class="control-label col-md-3">客户姓名</label>
                <div class="col-md-5">
                    <input type="text" class="form-control" name="name" id="name" placeholder="请输入姓名">
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
                <label for="age" class="control-label col-md-3">年龄</label>
                <div class="col-md-5">
                    <input type="text" class="form-control" name="age" id="age" placeholder="请输入年龄">
                </div>
            </div>
            <div class="form-group">
                <label for="address" class="control-label col-md-3">地址</label>
                <div class="col-md-5">
                    <input type="text" class="form-control" name="address" id="address" placeholder="请输入地址">
                </div>
            </div>
            <div class="form-group">
                <label for="condition" class="control-label col-md-3">病况</label>
                <div class="col-md-5">
                    <input type="text" class="form-control" name="condition" id="condition" placeholder="请输入病况">
                </div>
            </div>
            <div class="form-group">
                <label for="remark" class="control-label  col-md-3">备注</label>
                <div class="col-md-5">
                    <input type="text" class="form-control" name="remark" id="remark" placeholder="请输入备注">
                </div>
            </div>
            <div class="form-group">
                <label for="phone" class="control-label  col-md-3">联系电话</label>
                <div class="col-md-5">
                    <input type="text" class="form-control" name="phone" id="phone" placeholder="请输入联系电话">
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
<c:if test="${sessionScope.loginUser.authority == 0 || sessionScope.loginUser.authority == 2}">
    <div id="page-wrapper">
        <h3><strong style="color: red">很遗憾你没有此权限</strong></h3>
    </div>
</c:if>


<jsp:include page="/pages/footer.jsp"/>
</body>
</html>
