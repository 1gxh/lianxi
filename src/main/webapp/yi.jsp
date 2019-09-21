<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>首頁</title>
    <script src="https://cdn.bootcss.com/jquery/3.4.1/jquery.js"></script>
    <script src="webjars/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="webjars/bootstrap/3.3.7/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="css/buyaode.css"><!-- 新增窗口样式引用 -->
    <script src="js/timeFormat.js"></script>

    <%--自动加载--%>
    <script type="text/javascript">

        var pageNow = 0;  //定义的页面
        var condition;    //定义的条件

        $(function(){
            alert("自动加载");
            var tbody = document.getElementById("tbodyTwo");
            var txtnameid=document.getElementById("txtnameid").value;
            var i=0;
            $("#tbodyTwo").empty();//刪除所有的行
            $.ajax({
                url:'http://localhost:8080/ssmgrogshop2/Commodity/tolist2.do',
                data:"txtname="+txtnameid,
                type:'POST',
                scriptCharset: 'utf-8',
                dataType:'json',
                success: function (result) {
                    var list = result.list.result;

                  /*  pageNow = result.list.currentPage;
                    condition = result.list.condition;
                    alert(pageNow);
                    alert(condition);*/
                    var num = 1;
                    for (var key in list) {
                        i++;
                        var item = list[key];
                        var tr = tbody.insertRow(-1);            // FireFox必须使用-1这个参数

                        var id                  = tr.insertCell(-1);      // Table 有多少列就添加多少个这个
                        var commodityName       = tr.insertCell(-1);
                        var commodityTypeName   = tr.insertCell(-1);
                        var uOMName             = tr.insertCell(-1);
                        var salePrice           = tr.insertCell(-1);
                        var huiyuanjia          = tr.insertCell(-1);


                        id.innerHTML                      = "<input type='radio' name='idTwo1' value='"+item.id+"'>";  //这时一个复选框
                        commodityName.innerHTML           = item.commodityName;             //商品名称
                        commodityTypeName.innerHTML       = item.commodityTypeName;         //商品类型
                        uOMName.innerHTML                 = item.uOMName;                   //计量单位
                        salePrice.innerHTML               = item.salePrice;                 //销售价格
                        huiyuanjia.innerHTML              = item.huiyuanjia;                //会员价格
                    }
                    if(i==0){
                        alert("很抱歉！没有查找到你要找的数据");
                    }
                },
                error:function(){
                    alert('出现错误');
                }
            });



        });


        function toggle(id,condition) {
            alert(id);
            alert(condition);
            var tbody = document.getElementById("tbodyTwo");
            var i=0;
            $("#tbodyTwo").empty();//刪除所有的行
            $.ajax({
                url:'http://localhost:8080/ssmgrogshop2/Commodity/tolist2.do?currentPage='+id+"&txtname="+condition,
                type:'GET',
                scriptCharset: 'utf-8',
                dataType:'json',
                success: function (result) {
                    pageNow = result.list.currentPage;
                    condition = result.list.condition;

                    var list = result.list.result;
                    var num = 1;
                    for (var key in list) {
                        i++;
                        var item = list[key];
                        var tr = tbody.insertRow(-1);            // FireFox必须使用-1这个参数

                        var id                  = tr.insertCell(-1);      // Table 有多少列就添加多少个这个
                        var commodityName       = tr.insertCell(-1);
                        var commodityTypeName   = tr.insertCell(-1);
                        var uOMName             = tr.insertCell(-1);
                        var salePrice           = tr.insertCell(-1);
                        var huiyuanjia          = tr.insertCell(-1);


                        id.innerHTML                      = "<input type='radio' name='idTwo1' value='"+item.id+"'>";  //这时一个复选框
                        commodityName.innerHTML           = item.commodityName;             //商品名称
                        commodityTypeName.innerHTML       = item.commodityTypeName;         //商品类型
                        uOMName.innerHTML                 = item.uOMName;                   //计量单位
                        salePrice.innerHTML               = item.salePrice;                 //销售价格
                        huiyuanjia.innerHTML              = item.huiyuanjia;                //会员价格
                    }
                    if(i==0){
                        alert("很抱歉！没有查找到你要找的数据");
                    }
                },
                error:function(){
                    alert('出现错误');
                }
            });

        }
    </script>
</head>


<body>


<div ><!-- 根据商品模糊查询的一个div-->
    <div >
        <label class="">房间号：</label>
        <form action="" method="post" style="float: left;">
            <input id="txtnameid" name="txtname" class="" style="" type="text" placeholder="商品名1" value="${commodityName}">
            <div class="input-append">
                <button type="button" onclick="" class="" style=""><li class=""></li>搜索1</button>
            </div>
        </form>

    </div>
</div>



<button class="" type="button" onclick="addfunction()"><li class=""></li>新增</button>
<button  type="button"   class="btn btn-info">修改</button>
<button  type="button"   class="btn btn-info">删除</button>





<table  id="tableid" class="table table-bordered">
    <thead >
    <tr>
        <th rowspan="2">选择</th>
        <th rowspan="2">商品名称</th>
        <th rowspan="2">商品类别</th>
        <th rowspan="2">计量单位</th>
        <th rowspan="2">销售价格</th>
        <th rowspan="2">会员价格</th>
    </tr>
    </thead>


    <tbody id="tbodyTwo">

    </tbody>



    <!--  点击新增时弹出的 新增页面窗口 -->
    <div class="theme-popover">
        <div class="theme-poptit">
            <a href="javascript:;" title="关闭" class="close">×</a>
            <h3>新增窗口</h3>
        </div>


        <div class="theme-popbod dform">
            <form id="formid" action="add" method="post">
                <ol>
                    <li><strong>商品名称： </strong>  <input type="text" name="name1" id="bzh1" ></li>
                    <li><strong>商品类别： </strong>  <select class="form-control" name="typeid" id="kuang"></select></li>

                    <li><strong>销售价格： </strong>  <input type="text" name="name2" id="bzh" ></li>
                    <li><strong>会员价格 ：</strong>  <input type="text" name="name3"></li>
                    <li><strong>计量单位： </strong>  <select class="form-control" name="typeid2" id="kuang2"></select></li>
                    <li><input class="btn btn-primary" type="submit" value="提交 " /></li>
                </ol>
            </form>
        </div>

    </div>

</table>

<
<a href="javascript:toggle(1,condition)">首页</a><br />
<a href="javascript:toggle(pageNow-1,condition)">上一页</a><br />
<a href="javascript:toggle(pageNow+1,condition)">下一页</a><br />
<%--<a href="javascript:toggle(pageNow+1,condition)">末页</a><br />--%>




</body>
</html>