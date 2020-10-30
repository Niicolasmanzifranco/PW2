<%-- 
    Document   : logout
    Created on : 21/09/2020, 12:11:50
    Author     : Nicolas Manzi
--%>

<%
    session.invalidate();
    response.sendRedirect("index.jsp");
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Logout</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
