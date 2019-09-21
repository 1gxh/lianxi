<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set  value="${pageContext.request.contextPath}" scope="page" var="ctx"></c:set>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

    <title></title>

    <link rel="stylesheet" href="${ctx}/bootstrap/css/bootstrap.css" type="text/css"></link>
    <link  href="${ctx}/bootstrap/css/bootstrap-responsive.css" rel="stylesheet">  <!-- start 响应式布局要添加的 -->
    <script src="${ctx}/bootstrap/js/jquery-3.1.1.min.js"></script>
    <script src="${ctx}/bootstrap/js/bootstrap.js"></script>

    <style>

        .container{
            margin-top: 10px;
        }


        .labelroomnumber{
            position: relative;
            font-size: 17px;
            float: left;
            margin-top: 15px;
        }

        .marginrightone{
            margin-right: 33px;
        }

        .marginrighttwo{
            margin-right: 16.5px;
        }

        .marginrightthree{
            margin-right: 43px;
        }

        .textone{
            margin-top:12px;
        }

        .inputone{
            width:54.2%;
            float:left;
        }

        .inputtwo{
            width:46.8%;
        }

        .inputthree{
            width:47.8%;
        }

        .cboone{
            margin-top:10px;
            height: 27px;
        }

        .margin-top-one{
            margin-top: -10px;
        }

        .margin-top-two{
            margin-top: -20px;
        }

        .textwidth{
            width: 138px;
        }

        .radiusone{
            margin-left: -4px;
        }

        @media(min-width:731px) and (max-width:767px){
            .inputthree{
                width: 50.5%;
            }
        }

        @media(min-width:550px) and (max-width:730px){
            .inputtwo{
                width: 46.2%;
            }
            .inputthree{
                width: 49.2%;
            }
        }


        @media(min-width:431px) and (max-width:550px){
            .inputtwo{
                width: 43.2%;
            }
            .inputthree{
                width: 47.5%;
            }
        }

        @media(min-width:366px) and (max-width:430px){
            .inputtwo{
                width: 40.2%;
            }
            .inputthree{
                width: 46%;
            }
        }

        @media(min-width:285px) and (max-width:366px){
            .inputtwo{
                width: 37.2%;
            }
            .inputthree{
                width: 44%;
            }
        }

        @media(min-width:237px) and (max-width:285px){
            .inputtwo{
                width: 30%;
            }
            .inputthree{
                width: 40%;
            }
        }

        .yansered{
            color:red;
        }

    </style>

    <script type="text/javascript">

        var id = '<%=request.getParameter("id") %>';   /*获得到si.jsp页面传过来的id值*/
        number = parseInt(id);

        //初始化
        $(function () {
            $.ajax({
                url:'http://localhost:8080/ssmgrogshop2/Commodity/toupdate2.do',
                data:"id="+number,
                type:'POST',
                scriptCharset: 'utf-8',
                dataType:'json',
                success: function (result) {
                    var  listTwo = result.listTwo;  //商品类别
                    var  listOne = result.listOne;  //计量单位
                    var  listPo  = result.listPo;

                    var  id   = listPo.id;  //id
                    $("#id").val(id);

                    var   commodityName   = listPo.commodityName;  //商品名
                    $("#commodityNameId").val(commodityName);


                    var   salePrice   = listPo.salePrice; //销售价格
                    $("#salePriceId").val(salePrice);


                    var   huiyuanjia   = listPo.huiyuanjia; //会员价格
                    $("#huiyuanjia").val(huiyuanjia);


                    //商品类别
                    var num1 = 1;
                    var html1 = "";
                    $.each(listTwo, function (num1) {
                        var   commodityTypeID   = listPo.commodityTypeID;  //商品对应的类型
                        var     leibie          = listTwo[num1].attributeDetailsName;                     //商品类别
                        var        id           = listTwo[num1].far_id;                                   //商品类别对应的id，alert("初始化获得到的商品类别为"+leibie+"对应的id为"+id);
                          html1 = html1 +"<option value='"+id+"' ";
                            if(id==commodityTypeID){
                                html1 = html1 +" selected='selected' ";
                            }
                            html1 = html1+">"+leibie+"</option>";
                    })
                    $("[name='commodityTypeID']").append(html1);

                    //计量单位
                    var num = 1;
                    var html2 = "";
                    $.each(listOne, function (num) {
                        var uOMID    = listPo.uOMID;                                //商品对应的计量单位
                        var danwei   = listOne[num].attributeDetailsName;           //計量單位類別
                        var id       = listOne[num].far_id;                         //計量單位對應的Id

                        html2 = html2 +"<option value='"+id+"' ";
                        if(id==uOMID){
                            html2 = html2 +" selected='selected' ";
                        }
                        html2 = html2+">"+danwei+"</option>";
                    })
                    $("[name='uOMID']").append(html2);
                },
                error:function(){
                    alert('点击修改出现错误');
                }

               });

              //保存修改
             $("#baochun").click(function () {



                var commodityName   = $("#commodityNameId").val();                //商品名称
                var commodityTypeID = $("[name='commodityTypeID']").val();        //商品类别
                var salePrice       = $("#salePriceId").val();                    //价格
                var huiyuanjia      = $("#huiyuanjia").val();                   //会员价格
                var     uOMID       = $("[name='uOMID']").val();                  //计量单位

                $.ajax({
                    url:'http://localhost:8080/ssmgrogshop2/Commodity/update2.do',   //去查
                    type:'POST',

                    data:{"commodityName"  :commodityName,
                          "id"  :id,
                          "commodityTypeID":commodityTypeID,
                          "salePrice"      :salePrice,
                          "huiyuanjia"     :huiyuanjia,
                          "uOMID"          :uOMID},
                    scriptCharset: 'utf-8',
                    dataType:'json',
                    success: function (result) {
                        if(result=="200"){
                            window.location.href="${ctx}/si.jsp"   //正确的情况
                        }else{
                            window.location.href="${ctx}/add.jsp"
                        }
                    },
                    error:function(){
                        alert('点击新增出现错误');
                    }
                });
            });

        });

        //检查非空
        function verify(){
            if(document.getElementById("commodityNameId").value==""){
                alert("商品名称  是必填项，不能为空哦！");
                document.getElementById("commodityNameId").focus();
                return false;
            }else if(document.getElementById("salePriceId").value==""){
                alert("销售价格  是必填项，不能为空哦！");
                document.getElementById("salePriceId").focus();
                return false;
            }else if(document.getElementById("commodityNameId").value.length>25){
                alert("你输入的   商品名称  太过长了  请不要超出  25 位长度");
                document.getElementById("commodityNameId").focus();
                return false;
            }else if(document.getElementById("salePriceId").value.length>8){
                alert("你输入的   销售价格   太过长了  请不要超出  8 位长度");
                document.getElementById("salePriceId").focus();
                return false;
            }else{
                return true;
            }
        }
        //取消按钮
        function deletefunction(){
            parent.document.getElementById('Mainid').src='${ctx}/Commodity/tolist.do';
        }
        //检查商品名称和销售价格的格式
        function onchangeOne(){
            //商品名称
            if(document.getElementById("commodityNameId").value!=""){
                document.getElementById("divOne").style.display="none";
            }else{
                document.getElementById("divOne").style.display="block"; //显示
            }
            //销售价格
            if(document.getElementById("salePriceId").value!=""){
                document.getElementById("divTwo").style.display="none";
                if(!document.getElementById("salePriceId").value.trim().match("^[0-9]+(\\.[0-9]+)?$"))
                {
                    document.getElementById("salePriceId").focus();
                    document.getElementById("salePriceId").value="";
                    document.getElementById("divTwo").style.display="block"; //显示
                    alert("销售价格:请输入正数");
                }
            }else{
                document.getElementById("divTwo").style.display="block"; //显示
            }
        }

        //異步查询商品名称
        function YZ(value){
            if(value!=""){
                $.ajax({
                    cache:false,                                                     //是否使用缓存提交 如果为TRUE 会调用浏览器的缓存 而不会提交
                    type: "POST",                                                    //上面3行都是必须要的
                    url:'http://localhost:8080/ssmgrogshop2/Commodity/YZ2.do',       //去查                            //地址 type 带参数
                    data:"commodityName="+value,                                     // IDCardValue 自定义的。相当于name把值赋予给 他可以在servlet 获取
                    success: function (result) {                                     // 不出现异常 进行立面方
                        if(result>=1){
                            alert("已存在此商品名称，请另取商品名称！");                   //提示框
                            document.getElementById("commodityNameId").value="";     //这个id的文本框的值 将会清空
                            document.getElementById("commodityNameId").focus();      // 给这个id的文本框提供焦点
                            document.getElementById("divOne").style.display="block"; //显示
                        }else{
                            alert("可以使用名称！");
                        }
                    },
                    error: function(data) { }
                });
            }
        }





    </script>

</head>


<body >


<div class="container">

    <div class="span11" style=" border: solid; border-color: #DDDDDD;">

                <h3 style="text-align: center;">商品修改</h3>

        <form action="" method="post" onsubmit="return verify()">

            <input type="hidden" name="id" value="">


            <div class="span5">
                <label class="labelroomnumber">商品名称：</label>
                <input id="commodityNameId" type="text" name="commodityName" value=""  onchange="" onblur="YZ(this.value)">
            </div>

            <div class="span5 ">
                <label class="labelroomnumber">商品类别：</label>
                <select name="commodityTypeID" class="cboone inputone">
                </select>
            </div>

            <div class="span5">
                <label class="labelroomnumber">销售价格：</label>
                <input id="salePriceId" name="salePrice" type="text" onchange="" value="">
            </div>


            <div class="span5">
                <label class="labelroomnumber">会员价格：</label>
                <input id="huiyuanjia" name="huiyuanjia" type="text"  value="">
            </div>



            <div class="span5">
                <label class="labelroomnumber">计量单位：</label>
                <select name="uOMID" >
                </select>
            </div>

            <div class="span12" style="margin-top: 10px;margin-bottom: 8px;">
                <button class="btn btn-primary" id="baochun" type="button">确定修改</button>
            </div>


        </form>


        <div class="span4"  style="margin-top: 10px;margin-bottom: 8px;">
            <button class="btn btn-warning" type="button" onclick="deletefunction()">取消</button>
        </div>


    </div>
    </div>


</body>
</html>
