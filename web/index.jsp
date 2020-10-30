<%-- 
    Document   : index
    Created on : 21/09/2020, 11:52:50
    Author     : Nicolas Manzi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="config.Conexao"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <title>JSP Page</title>
    </head>
    <%
        Statement st = null;
        ResultSet rs = null;             
    %>
    <body>
        <div class="container">
            <br>
            <form action="index.jsp" method="Post">
                <label>Email:</label>
                <input type="text" name="email" class="form-control" required>
                <label>Senha:</label>
                <input type="password" name="senha" class="form-control" required>
                <center>
                    <br>
                    <input type="submit" class="btn btn-outline-warning" value="Fazer login">
                </center>
            </form>
            <br>
            <center>
            <%
                String email = request.getParameter("email");
                String senha = request.getParameter("senha");
                
                String nomeUsuario = "";
                
                String em = "";
                String se = "";
                
                int i = 0;
                
                try{
                    st = new Conexao().conectar().createStatement() ;
                    rs = st.executeQuery("select * from usuarios where email = '" + email + "' and senha = '" + senha + "'");
                    while(rs.next()){
                        nomeUsuario = rs.getString(2);
                        em = rs.getString(3);
                        se = rs.getString(4);                        
                        rs.last();
                        i = rs.getRow();
                    }
                    
                }catch(Exception e){
                    out.println(e);
                }
                
                if(email == null || senha == null){
                    out.println("Preencha os dados");
                } else{
                    if(i>0){
                        session.setAttribute("nomeUsuario", nomeUsuario);
                        response.sendRedirect("usuarios.jsp");
                    }
                }
            %>
            </center>
        </div>
    </body>
</html>
