<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<%@page import="modules.connectionpool.ConnectionPool"%>
<%@page import="modules.usuarios.UsuarioService"%>
<%@page import="modules.usuarios.Usuario"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="javax.servlet.annotation.WebServlet" %>
<%@ page import="javax.servlet.http.HttpServlet" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ page import="javax.servlet.http.HttpServletResponse" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");


    String user = "Ignacio"; 
    String pass = "1234";
    
    ConnectionPool pool = new ConnectionPool("jdbc:mysql://localhost:3306/Proyecto_jsp_2", user, pass);

    UsuarioService userv = new UsuarioService(pool.getConnection());
    ArrayList<Usuario> lista = userv.requestAll("");

    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String username = request.getParameter("username");



    if (session != null) {
            String uname = (String) session.getAttribute("user");
            if (uname == null) {
                response.sendRedirect("signIn.jsp");
            } else {
                for (Usuario usuario: lista){
                    if (usuario.getUsername().equals(username)){
                        long id = usuario.getId();
                        Usuario updatedUser = new Usuario(id, username, email, password);
                        userv.update(updatedUser);
                        response.sendRedirect("usersList.jsp");
                    }
                }
            }
        } else {
            response.sendRedirect("signIn.jsp");
        }

%>