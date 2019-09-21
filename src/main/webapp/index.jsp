<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

  <%-- 參考部分--%>
   <%-- $.each(list, function (num) {
    alert(list[num].zhname);
    })--%>
    <meta charset="utf-8">
    <title>首頁</title>
    <script src="https://cdn.bootcss.com/jquery/3.4.1/jquery.js"></script>
    <script src="js/timeFormat.js"></script>
    <script>
        $(function(){
            $('#yi').on('click',function(){

                var tbody = document.getElementById("tbodyTwo");
                var i=0;
                $.ajax({
                    url:'http://localhost:8080/stand2/xxx',
                    type:'POST',
                    dataType:'json',
                    success: function (result) {
                            var list = result.page.list;

                            var num = 1;
                            $.each(list, function (num) {
                                alert(list[num].zhname);
                            })


                            for (var key in list) {
                            i++;
                            var item = list[key];
                            var tr = tbody.insertRow(-1);                   // FireFox必须使用-1这个参数

                                var id           = tr.insertCell(-1);      // Table 有多少列就添加多少个这个
                                var std_num      = tr.insertCell(-1);
                                var zhname       = tr.insertCell(-1);
                                var version      = tr.insertCell(-1);
                                var ralease_date = tr.insertCell(-1);
                                var impl_date    = tr.insertCell(-1);
                                id.innerHTML           = item.id;
                                std_num.innerHTML      = item.stdnum;
                                zhname.innerHTML       = item.zhname;
                                version.innerHTML      = item.version;
                                ralease_date.innerHTML = getLocalTime(item.raleasedate);
                                /*impl_date.innerHTML    = getLocalTime(item.impl_date);*/
                        }
                        if(i==0){
                            alert("很抱歉！没有查找到你要找的数据");
                        }
                    },
                    error:function(){
                        alert('error');
                    }
                });
            });
        });
    </script>




</head>


<body>


<button id="yi">前端跨域显示</button>

          <table  id="tableid">
              <thead >
              <tr>
                  <th rowspan="2">id</th>
                  <th rowspan="2">标准号</th>
                  <th rowspan="2">版本</th>
                  <th rowspan="2">发布日期</th>
                  <th rowspan="2">实施日期</th>
                <%--  <th rowspan="2">操作</th>--%>
              </tr>
              </thead>


              <tbody id="tbodyTwo">

              </tbody>


          </table>




</body>
</html>