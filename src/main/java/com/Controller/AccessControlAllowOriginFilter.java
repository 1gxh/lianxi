package com.Controller;

import javax.servlet.*;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
//在被请求资源中添加响应头信息"Access-Control-Allow-Origin：*
//@CrossOrigin
//解决跨域问题的过滤器

public class AccessControlAllowOriginFilter implements Filter {

    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        HttpServletResponse response = (HttpServletResponse) res;
        response.setHeader("Access-Control-Allow-Origin", "*");//允许任何域名
        response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE");//是允许的请求方式
        response.setHeader("Access-Control-Allow-Credentials", "true"); //跨域允许包含的头。
        chain.doFilter(req, response);
    }
    public void init(FilterConfig filterConfig) {

    }
    public void destroy() {

    }

}

