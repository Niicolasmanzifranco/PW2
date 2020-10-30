<%-- 
    Document   : usuarios
    Created on : 21/09/2020, 12:15:58
    Author     : Nicolas Manzi
--%>

<%@page import="config.Conexao"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pg restrita</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">

    </head>
    <body>
        <%
                String nome = (String) session.getAttribute("nomeUsuario");
                
                
                if(nome == null){
                    response.sendRedirect("index.jsp");
                }
            %>
            <nav class="navbar navbar-light bg-light">
                <span class="navbar-brand mb-0 h1"><%out.println(nome);%></span>
                <a href="logout.jsp" class="btn btn-outline-warning">Sair</a>
            </nav>
                
                <div class="container">
                    
                    <div class="row mt-4 mb-4">
                        <button class="btn-warning" data-toggle="modal" data-target="#exampleModal">Novo Usuário</button>
                        <form class="form-inline my-2 my-lg-0">
                            <input class="form-control mr-sm-2" type="search" name="txtbuscar" placeholder="Digite um nome" aria-label="Search">
                            <button class="btn btn-outline-warning my-2 my-sm-0" type="submit">Buscar</button>
                        </form>
                    </div>
                    
                    
                    <table class="table table-bordered">
                        <thead>
                          <tr>
                            <th scope="col">Cod</th>
                            <th scope="col">Nome</th>
                            <th scope="col">Email</th>
                            <th scope="col">Senha</th>
                            <th scope="col">Conta</th>
                          </tr>
                        </thead>
                        <tbody>
                            
                            <%
                        Statement st = null;
                        ResultSet rs = null;
                        String id_usuario = "";
                        String nome_usuario = "";
                        String email_usuario = "";
                        String senha_usuario = "";
                        String nivel_usuario = "";
                        
                        try{
                            st = new Conexao().conectar().createStatement();
                            rs = st.executeQuery("SELECT * FROM usuarios");
                            while(rs.next()){
                    %>
                        
                            <tr>
                              <th scope="row"><%= rs.getString(1) %></th>
                              <td><%= rs.getString(2) %></td>
                              <td><%= rs.getString(3) %></td>
                              <td><%= rs.getString(4) %></td>
                              <td><%= rs.getString(5) %></td>
                            </tr>
                      
                       <%
                                
                            }
                        }catch(Exception e){
                            out.println(e);
                        }
                        
                    %>

                        </tbody>
                    </table>
                    
                    
                </div>
            
            
            
            
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js" integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s" crossorigin="anonymous"></script>
    </body>
</html>



<div class="modal fade" id="exampleModal" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
        <form action="usuarios.jsp" method="post">
              <div class="modal-body">
                    <div class="form-group">
                    <label for="exampleInputPassword1">Nome</label>
                    <input type="text" class="form-control" name="nome" id="nome">
                  </div>
                  <div class="form-group">
                    <label for="exampleInputPassword1">Email</label>
                    <input type="text" class="form-control" name="email" id="email">
                  </div>
                  <div class="form-group">
                    <label for="exampleInputPassword1">Senha</label>
                    <input type="password" class="form-control" name="senha" id="senha">
                  </div>
                  <label for="inputState">Conta</label>
                  <select id="conta" name="conta" class="form-control">
                      <option value="Comum" selected>Comum</option>
                      <option value="Admin">Admin</option>
                   </select>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Sair</button>
                <button type="submit" name="btn-salvar" class="btn btn-warning">Finalizar cadastro</button>
              </div>
        </form>
    </div>
  </div>
</div>


<%
    
    if (request.getParameter("btn-salvar") != null) {
            String nomee = request.getParameter("nome");
            String email = request.getParameter("email");
            String senha = request.getParameter("senha");
            String nivel = request.getParameter("conta");
            
            try{
                
                st = new Conexao().conectar().createStatement();
                
                rs = st.executeQuery("SELECT * FROM usuarios WHERE email = '"+ email +"'");
                while(rs.next()){
                    rs.getRow();
                    if (rs.getRow() > 0) {
                        out.print("<script>alert('ERRO: Este usuario ja foi cadastrado')</script>");
                            return;
                        }
                }
                
                st.executeUpdate("INSERT INTO usuarios (nome, email, senha, nivel) VALUES ('"+nomee+"','"+email+"','"+senha+"','"+nivel+"')");
                response.sendRedirect("usuarios.jsp");
            }catch(Exception e){
                out.println(e);
            }
            
        }

%>