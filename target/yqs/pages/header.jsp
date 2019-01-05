<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html lang="zh">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>主页</title>

    <link href="../js/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="../js/metisMenu/metisMenu.min.css" rel="stylesheet">
    <link href="../js/dist/css/sb-admin-2.css" rel="stylesheet">
    <link href="../js/morrisjs/morris.css" rel="stylesheet">
    <link href="../js/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
</head>
<body>

<div id="wrapper">
    <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="index.html">医药管理系统</a>
        </div>
        </li>
        <ul class="nav navbar-top-links navbar-right">
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                    <i class="fa fa-user fa-fw"></i> <i class="fa fa-caret-down"></i>
                </a>
                <ul class="dropdown-menu dropdown-user">
                    <li><a href="#"><i class="fa fa-user fa-fw"></i> 用户信息</a>
                    </li>
                    <li><a href="#"><i class="fa fa-gear fa-fw"></i> 设置</a>
                    </li>
                    <li class="divider"></li>
                    <li><a href="/loginOut"><i class="fa fa-sign-out fa-fw"></i>注销</a>
                    </li>
                </ul>
            </li>
        </ul>
        <div class="navbar-default sidebar" role="navigation">
            <div class="sidebar-nav navbar-collapse">
                <ul class="nav" id="side-menu">
                    <li>
                        <a href="/pages/back/index.jsp"><i class="fa fa-dashboard fa-fw"></i></a>
                    </li>
                    <li>
                        <a href="#"><i class="fa fa-bar-chart-o fa-fw"></i>代理管理<span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level">
                            <li>
                                <a href="/pages/back/agency/agency_insert.jsp">增加代理</a>
                            </li>
                            <li>
                                <a href="/agencyPageQuery">代理列表</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="#"><i class="fa fa-edit fa-fw"></i> 药品列表<span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level">
                            <li>
                                <a href="/pages/back/medicine/medicine_insert.jsp">增加药品</a>
                            </li>
                            <li>
                                <a href="/medicinePageQuery">药品列表</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="#"><i class="fa fa-edit fa-fw"></i> 人员信息<span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level">
                            <li>
                                <a href="/pages/back/people/people_insert.jsp">增加人员</a>
                            </li>
                            <li>
                                <a href="/pageQuery">人员列表</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="#"><i class="fa fa-edit fa-fw"></i>记录信息<span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level">
                            <li>
                                <a href="/pages/back/client/client_insert.jsp">增加记录</a>
                            </li>
                            <li>
                                <a href="/pages/back/client/client_approval.jsp">记录审核</a>
                            </li>
                        </ul>
                    </li>
                    <li>
                        <a href="#"><i class="fa fa-edit fa-fw"></i>检索<span class="fa arrow"></span></a>
                        <ul class="nav nav-second-level">
                            <li>
                                <a data-toggle="modal" data-target="#myModal">记录检索</a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Modal title</h4>
            </div>
            <div class="modal-body">
                <form action="/clientPageQuery" method="post" class="form-horizontal" id="insertForm">
                    <div class="form-group">
                        <label for="recordId" class="control-label col-md-3">单号</label>
                        <div class="col-md-5">
                            <input type="text" class="form-control" name="recordId" id="recordId" placeholder="请输入单号">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="userId" class="control-label col-md-3">操作员工号</label>
                        <div class="col-md-5">
                            <input type="text" class="form-control" name="userId" id="userId" placeholder="请输入操作员工号">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="handled" class="control-label col-md-3">审核</label>
                        <div class="col-md-5">
                            <select name="handled" id="handled" class="form-control">
                                <option value="true">审核</option>
                                <option value="false">未审核</option>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary">查询</button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>
</body>