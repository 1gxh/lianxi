package com.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

//@RestController //返回文字
@Controller   //返回视图
public class controller {

    @RequestMapping("/hello")
    public String hello(){
        return "我是最666666666666666";
    }

    //返回到啦text.html页面
    @RequestMapping("/html")
    public String test(){
        return "text";
    }


    @RequestMapping(value = "/index")
    public String index(){
        return "index";
    }

    @RequestMapping(value = "/list")
    public String list(){
        return "si";
    }

}
