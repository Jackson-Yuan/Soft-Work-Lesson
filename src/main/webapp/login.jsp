<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>首页</title>
    <link href="mycss/bootstrap.css" rel="stylesheet">
    <link href="js/metisMenu/metisMenu.min.css" rel="stylesheet">
    <link href="js/dist/css/sb-admin-2.css" rel="stylesheet">
    <link href="js/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-4 col-md-offset-4">
            <div class="login-panel panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">医药管理系统</h3>
                </div>
                <div class="panel-body">
                    <form role="form" action="/login" method="post" id="loginForm">
                        <fieldset>
                            <div class="form-group">
                                <input class="form-control" placeholder="账户名" name="id" type="text" >
                            </div>
                            <div class="form-group">
                                <input class="form-control" placeholder="密码" name="password" type="password" >
                            </div>
                            <div class="form-group">
                                <strong style="color: red">${requestScope.error}</strong>
                            </div>
                            <button type="submit" class="btn btn-success btn-block">登录</button>
                        </fieldset>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>



</body>

</html>
