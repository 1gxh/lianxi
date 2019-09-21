<%--
  Created by IntelliJ IDEA.
  User: GXH
  Date: 2019/7/23
  Time: 12:53
  To change this template use File | Settings | File Templates.
--%>
<%--小張--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="${ctx}/bootstrap/css/bootstrap.css" type="text/css"></link>
<link   href= "${ctx}/bootstrap/css/bootstrap-responsive.css" rel="stylesheet">  <!-- start 响应式布局要添加的 -->
<script src=  "${ctx}/bootstrap/js/jquery-3.1.1.min.js"></script>
<script src=  "${ctx}/bootstrap/js/bootstrap.js"></script>

<html>

<%--样式--%>
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

<%--标题--%>
<head>
    <title>新增页面</title>
</head>

<%--事件--%>
<script type="text/javascript">
    //初始化
    $(function () {
        $.ajax({
            url:'http://localhost:8080/ssmgrogshop2/Commodity/toadd2.do',   //去查
            type:'POST',
            scriptCharset: 'utf-8',
            dataType:'json',
            success: function (result) {
                var listTwo = result.listTwo;  //商品类别
                var listOne = result.listOne;  //计量单位

                //商品类别
                var num1 = 1;
                var html1 = "";
                $.each(listTwo, function (num1) {
                    var leibie = listTwo[num1].attributeDetailsName;                      //商品类别
                    var   id   = listTwo[num1].far_id;                                    //商品类别对应的id//alert("初始化获得到的商品类别为"+leibie+"对应的id为"+id);
                    html1 = html1 + "<option value='"+id+"'>"+leibie+"</option>";         //定义格式
                })
                $("[name='commodityTypeID']").append(html1);

                //计量单位
                var num = 1;
                var html = "";
                $.each(listOne, function (num) {
                    var danwei = listOne[num].attributeDetailsName;
                    var id = listOne[num].far_id;
                    html = html + "<option value='"+id+"'>"+danwei+"</option>";
                })
                $("[name='uOMID']").append(html);
            },
            error:function(){
                alert('点击新增出现错误');
            }
        });



        //保存
        $("#baochun").click(function () {
            if(verify()){

                var commodityNameId = $("#commodityNameId").val();                //商品名称
                var commodityTypeID = $("[name='commodityTypeID']").val();        //商品类别
                var salePrice       = $("#salePriceId").val();                    //价格
                var salePriceId2    = $("#salePriceId2").val();                   //会员价格
                var     uOMID       = $("[name='uOMID']").val();                  //计量单位

                //alert("保存时获取商品类别id为"+commodityTypeID+"计量单位id为"+uOMID);

                $.ajax({
                    url:'http://localhost:8080/ssmgrogshop2/Commodity/add2.do',   //去查
                    type:'POST',
                    data:{"commodityName":commodityNameId,
                          "commodityTypeID":commodityTypeID,
                          "salePrice":salePrice,
                          "huiyuanjia":salePriceId2,
                          "uOMID":uOMID},
                    scriptCharset: 'utf-8',
                    dataType:'json',
                    success: function (result) {
                        if(result=="200"){
                            window.location.href="${ctx}/si.jsp"
                        }else{
                            window.location.href="${ctx}/update.jsp"
                        }
                    },
                    error:function(){
                        alert('点击新增出现错误');
                    }
                });
            }
        });


    });

    //判断非空
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

    //删除
    function deletefunction(){
        parent.document.getElementById('Mainid').src='${ctx}/Commodity/tolist.do';
    }

    //控制销售价格
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

<body >

<div class="span11" style=" border: solid; border-color: #DDDDDD;">

            <div class="span12">
                <div class="row-fluid">

                    <div class="span5">
                        <label class="labelroomnumber">商品名称：</label>
                        <input id="commodityNameId" name="commodityName" type="text" onchange="onchangeOne()" onblur="YZ(this.value)">
                    </div>

                    <div class="span5 ">
                        <label class="labelroomnumber">商品类别：</label>
                        <select name="commodityTypeID" class="cboone inputone">
                         </select>
                    </div>


                </div>
            </div>


            <div class="span12">
                <div class="row-fluid">


                    <div class="span5">
                        <label class="labelroomnumber">销售价格：</label>
                        <input id="salePriceId" name="salePrice"  style="float:left; height:26px;" type="text">
                      <%--  <input id="salePriceId" name="salePrice"  onchange="onchangeOne()" style="float:left; height:26px;" type="text">--%>
                    </div>

                    <div class="span5">
                        <label class="labelroomnumber">会员价格：</label>
                        <input id="salePriceId2" name="huiyuanjia" style="float:left;border-radius:0px; height:26px;" type="text">
                    </div>

                    <div class="span5">
                        <label class="labelroomnumber">计量单位：</label>
                        <select name="uOMID" >
                        </select>
                    </div>


                </div>
            </div>

            <div class="span6">
                <button class="btn btn-primary" id="baochun" type="button">保存</button>
            </div>

        <%--</form>--%>



   <%-- 取消按钮--%>
        <div class="span4" style="text-align:center;">
            <div class="row-fluid">
                    <button class="btn btn-warning" type="button" onclick="deletefunction()">取消</button>
            </div>
        </div>


</div>





</body>
</html>
