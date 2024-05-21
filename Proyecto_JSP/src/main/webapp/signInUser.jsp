<%-- index.jsp (proyecto Incrementa5) --%>
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

    String username = request.getParameter("user");
    String password = request.getParameter("pass");


    boolean signIn = false;

    for (Usuario usuario: lista){
        if (usuario.getUsername().equals(username) && usuario.getPassword().equals(password)) {
            signIn = true;
            break;
        }
    }

    if (signIn){
        session.setAttribute("user", username);
        if (username.equals("JuanArrow")){
            response.sendRedirect("usersList.jsp");
        } else {
            response.sendRedirect("usersListNoAdmin.jsp");
        }
        
    } else {
        response.sendRedirect("signIn.jsp");
    }
%>
