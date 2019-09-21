<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>

    <meta charset="utf-8">
    <title>首頁4</title>

    <link rel="stylesheet" href="${ctx}/bootstrap/css/bootstrap.css" type="text/css"></link>
    <link   href= "${ctx}/bootstrap/css/bootstrap-responsive.css" rel="stylesheet">  <!-- start 响应式布局要添加的 -->
    <script src=  "${ctx}/bootstrap/js/jquery-3.1.1.min.js"></script>
    <script src=  "${ctx}/bootstrap/js/bootstrap.js"></script>

    <script type="text/javascript">
    </script>

    <script>

        var pageNow = 0;  //定义的页面
        var condition;    //定义的条件


        //初始化
        $(function(){
            var tbody = document.getElementById("tbodyTwo");
            var i=0;
            $("#tbodyTwo").empty();                                 //刪除所有的行
            $.ajax({
                url:'http://localhost:8080/ssmgrogshop2/Commodity/tolist2.do',
                type:'POST',
                scriptCharset: 'utf-8',
                dataType:'json',
                success: function (result) {
                    pageNow = result.list.currentPage;   //定义的当前页面
                    var list = result.list.result;
                    var listOne = result.listOne;

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


                        id.innerHTML                      = "<input type='checkbox' name='id' value='"+item.id+"'>";  //这时一个复选框
                        commodityName.innerHTML           = item.commodityName;             //商品名称
                        commodityTypeName.innerHTML       = item.commodityTypeName;         //商品类型
                        uOMName.innerHTML                 = item.uOMName;                   //计量单位
                        salePrice.innerHTML               = item.salePrice;                 //销售价格
                        huiyuanjia.innerHTML              = item.huiyuanjia;                //会员价格
                    }
                    //显示类别
                    var num = 1;
                    var html = "";
                    $.each(listOne, function (num) {
                        var leixing = listOne[num].attributeDetailsName;
                        var   id    = listOne[num].far_id;
                        html = html + "<option value='" + id + "'>" + leixing + "</option>";
                    })

                    $("[name='commodityTypeID']").append(html);
                    if(i==0){
                        alert("很抱歉！没有查找到你要找的数据");
                    }
                },
                error:function(){
                    alert('出现错误');
                }
            });


        });

        //分页模糊
        function selectFunction(page,condition,commodityTypeID) {
            if(page==null){
                page =pageNow
            }
            var tbody = document.getElementById("tbodyTwo");


            var txtname = document.getElementById("txtnameid").value;//关键字条件
            //condition = txtname.value;

            var leixing = document.getElementById("selectCboId").value;   //取到商品的分類
            //commodityTypeID = txtname.value;

            var i=0;
            $("#tbodyTwo").empty();//刪除所有的行
            $.ajax({
                url:'http://localhost:8080/ssmgrogshop2/Commodity/tolist2.do',
                data:"currentPage="+page+"&txtname="+txtname+"&commodityTypeID="+leixing,
                type:'POST',
                scriptCharset: 'utf-8',
                dataType:'json',
                success: function (result) {
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

                        id.innerHTML                      = "<input type='radio' name='id' value='"+item.id+"'>";  //这时一个复选框
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
        //加载出2个新增要用的属性
        function xz() {
            window.location.href="${ctx}/add2.jsp";
        }

        //修改的时候只能选择一条修改（不可以一次性修改多条）
        function updatefunction(){
            var chk_value=[];
            $("input[name='id']:checked").each(function(){
                chk_value.push($(this).val());
            });
            if(chk_value!=""){
                if(chk_value.toString().indexOf(",")>0){
                    alert("修改只能选择一条");
                }else{
                    updatefunction2(chk_value);
                }
            }else{
                alert("请选择一条数据进行修改");
            }
        }

         //删除
        function deletefunction(){
            var chk_value=[];
            $("input[name='id']:checked").each(function(){
                chk_value.push($(this).val());
            });
            if(chk_value!=""){
                var flag=window.confirm("注意：您确定要永久删除该信息吗?");
                if(flag){
                    deletefunction2(chk_value);
                }
            }else{
                alert("请选择一条或多条数据进行删除");
            }

        }


        //修改2 （得到数据然后跳转到修改页面）
        function updatefunction2(id) {
            window.location.href="${ctx}/update.jsp?id="+id;
        }

        //删除2 （得到数据然后跳转到修改页面）
        function deletefunction2(id) {
                alert("得到的id为"+id)
               number = parseInt(id);
            $.ajax({
                url:'http://localhost:8080/ssmgrogshop2/Commodity/delete2.do',
                type:'POST',
                data:{"id":number},
                scriptCharset: 'utf-8',
                dataType:'json',
                success: function (result) {
                    if(result=="200"){
                        window.location.href="${ctx}/si.jsp"
                    }else{
                        alert("删除失败");
                    }
                },
                error:function() {
                    alert('点击删除出现错误');
                 }
                });
        }

    </script>
</head>


<body>


<!-- 根据條件查询的一个div-->
<div class="row-fluid">
    <form action="" method="post" style="float: left;">
        <input id="txtnameid" name="txtname"   type="text" placeholder="请输入关键字" value="${txtname}">
        <button type="button" onclick="selectFunction()">搜索</button>
    </form>
</div>


<!-- 根据商品分類模糊查询的一个div-->
<div class="span5">
    <select id="selectCboId" name="commodityTypeID"  onchange="selectFunction()">
    </select>
</div>



<button class="" type="button" class="btn btn-primary" onclick="xz()">新增</button>
<button class="" type="button" onclick="updatefunction()">修改1</button>
<button class="" type="button" onclick="deletefunction()">删除</button>





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

</table>


<a href="javascript:selectFunction(pageNow=1,condition)">首页</a><br />
<a href="javascript:selectFunction(pageNow-1,condition)">上一页</a><br />
<a href="javascript:selectFunction(pageNow+1,condition)">下一页</a><br />
<%--<a href="javascript:toggle(pageNow+1,condition)">末页</a><br />--%>


<%-- 取消按钮--%>
<div class="span4" style="text-align:center;">
    <div class="row-fluid">
        <button class="btn btn-warning" type="button" onclick="deletefunction()">取消</button>
    </div>
</div>


</body>
</html>