<%@ page import="java.util.Date" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>药品列表</title>
    <base href="${pageContext.request.scheme}://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/">
    <script type="text/javascript" src="../../../myjs/jquery-3.2.1.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".update").click(function () {
                var obj = this;

                $.ajax({
                    url:"/getMedicineInfo",
                    type:"GET",
                    data:{
                        id:obj.value
                    },
                    success:function (data) {
                        if (data.flag == false){
                            alert("系统异常，请稍后再试");
                        }else{
                             $("#id").val(data.data.id);
                             $("#specification").val(data.data.specification);
                             $("#name").val(data.data.name);
                             if(data.data.method === "外服"){
                                 $("#check1").attr("checked","checked");
                             }else{
                                 $("#check2").attr("checked","checked");
                             }
                            if(data.data.type === true){
                                $("#typeCheck1").attr("checked","checked");
                            }else{
                                $("#typeCheck2").attr("checked","checked");
                            }
                             $("#introduction").val(data.data.introduction);
                             $("#quantity").val(data.data.quantity);
                             $("#medicineInfo").modal();
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
                var specification = $("#specification").val();
                var name = $("#name").val();
                var introduction = $("#introduction").val();
                var method = $('input[name="method"]:checked').val();
                var type = $('input[name="specification"]:checked').val();
                var quantity = $("#quantity").val();

                if (!pattern.test(id).valueOf() || !pattern.test(quantity).valueOf()){
                    alert("编号,数量格式不正确");
                    return ;
                }
                if(specification == "" || introduction == "" || method == "" || name == ""){
                    alert("请补全相关项");
                    return;
                }

                $.ajax({
                    url:"/updateMedicine",
                    type:"POST",
                    data:{
                        editMedicine:id,
                        name:name,
                        specification:specification,
                        introduction:introduction,
                        method:method,
                        quantity:quantity,
                        type:type
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
<c:if test="${sessionScope.loginUser.authority == 2 || sessionScope.loginUser.authority == 1}">
<div id="page-wrapper">
    <div class="col-md-12">
        <table class="table table-bordered table-hover" id="studentTable">
            <tr>
                <th class="text-center">药品批号</th>
                <th class="text-center">药品编号</th>
                <th class="text-center">药品名称</th>
                <th class="text-center">是否过期</th>
                <th class="text-center">代理厂商</th>
                <th class="text-center">数量</th>
                <th class="text-center">单价</th>
                <th class="text-center">修改</th>
                <th class="text-center">删除</th>
            </tr>
            <c:if test="${!empty requestScope.pageMedicine}">
                <c:forEach var="medicine" items="${requestScope.pageMedicine}">
                    <tr>
                        <th class="text-center">${medicine.batchId}</th>
                        <th class="text-center">${medicine.id}</th>
                        <th class="text-center">${medicine.name}</th>
                        <th class="text-center">
                            <c:set var="endDate">
                                <fmt:formatDate value="${medicine.endTime}"  pattern="yyyy-MM-dd " type="date"/>
                            </c:set>
                            <c:set var="nowDate">
                                <fmt:formatDate value="<%=new Date()%>"  pattern="yyyy-MM-dd" type="date"/>
                            </c:set>
                            <c:if test="${endDate >= nowDate}">
                                未过期
                            </c:if>
                            <c:if test="${endDate < nowDate}">
                                已过期
                            </c:if>
                        </th>
                        <th class="text-center">${medicine.resource}</th>
                        <th class="text-center">${medicine.quantity}</th>
                        <th class="text-center">${medicine.price}</th>
                        <th class="text-center">
                            <button class="btn btn-success btn-sm update" type="button" value="${medicine.id}">修改</button>
                        </th>
                        <th class="text-center">
                            <c:if test="${sessionScope.loginUser.authority == 2}">
                                <a href="/deleteMedicine?deleteId=${medicine.id}" class="btn btn-danger btn-sm " id="deleteBtn" role="button">删除</a>
                            </c:if>
                            <c:if test="${sessionScope.loginUser.authority == 1}">
                                <a href="/deleteMedicine?deleteId=${medicine.id}" class="btn btn-danger btn-sm " id="deleteBtn" role="button" disabled="disabled">删除</a>
                            </c:if>
                        </th>
                    </tr>
                </c:forEach>
            </c:if>
            <c:if test="${empty requestScope.pageMedicine}">
                <strong style="color: red">很遗憾没有记录</strong>
            </c:if>
        </table>

        <div class="text-right">
            <h3><strong style="color: red;">${requestScope.error}</strong></h3>
            <c:if test="${requestScope.pageMessage.sumPage > 1}">
                <a href="/medicinePageQuery?record=${requestScope.pageMessage.record}&sumPage=${requestScope.pageMessage.sumPage}
                &page=${requestScope.pageMessage.page == 1 ? 1 : requestScope.pageMessage.page - 1}" class="btn btn-primary btn-lg active" role="button">上一页</a>
                <a href="/medicinePageQuery?record=${requestScope.pageMessage.record}&sumPage=${requestScope.pageMessage.sumPage}
                &page=${requestScope.pageMessage.page == requestScope.pageMessage.sumPage ? requestScope.pageMessage.sumPage : requestScope.pageMessage.page + 1}" class="btn btn-primary btn-lg active" role="button">下一页</a>
            </c:if>
        </div>
    </div>
</div>
</c:if>
<c:if test="${sessionScope.loginUser.authority == 0}">
    <div id="page-wrapper">
        <h3><strong style="color: red">很遗憾你没有此权限</strong></h3>
    </div>
</c:if>
<div class="modal fade" id="medicineInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">修改药品信息</h4>
            </div>
            <div class="modal-body">
                <form action="" method="post" class="form-horizontal" id="insertForm">
                    <div class="form-group">
                        <label for="id" class="control-label col-md-3">药品编号</label>
                        <div class="col-md-5">
                            <input type="text" class="form-control" name="id" id="id" placeholder="请输入药品编号" disabled>
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
                           <textarea class="form-control" name="introduction" id="introduction"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-3" for="specification">药品规格</label>
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
                        <label  class="control-label col-md-3">药品服用方法</label>
                        <div class="col-md-5">
                            <label class="radio-inline">
                                <input type="radio" name="method" value="内服" id="check1">外服
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="method" value="外服" id="check2">内服
                            </label>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="quantity" class="control-label  col-md-3">数量</label>
                        <div class="col-md-5">
                            <input type="text" class="form-control" name="quantity" id="quantity" placeholder="请输入数量">
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
<script src="jquery/jquery.validate.min.js"></script>
<script src="jquery/additional-methods.min.js"></script>
<script src="jquery/jquery.metadata.js"></script>
<script src="jquery/Message_zh_CN.js"></script>
<script src="jquery/util.js"></script>
<script src="jquery/student_list.js"></script>
</body>
</html>
