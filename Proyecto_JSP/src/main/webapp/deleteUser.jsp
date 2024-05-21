<%-- index.jsp (proyecto Incrementa5) --%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<%@page import="modules.connectionpool.ConnectionPool"%>
<%@page import="modules.usuarios.UsuarioService"%>
<%@page import="modules.usuarios.Usuario"%>
<%@page import="java.util.ArrayList"%>

<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");


    String user = "Ignacio"; 
    String pass = "1234";
    
    ConnectionPool pool = new ConnectionPool("jdbc:mysql://localhost:3306/Proyecto_jsp_2", user, pass);

    UsuarioService userv = new UsuarioService(pool.getConnection());
    ArrayList<Usuario> lista = userv.requestAll("");

    if (session != null) {
            String username = (String) session.getAttribute("user");
            if (username == null) {
                response.sendRedirect("signIn.jsp");
            } else {
                String dato = request.getParameter("dato");
                long id = Long.parseLong(dato);
                userv.delete(id);
                response.sendRedirect("usersList.jsp");
            }
        } else {
            response.sendRedirect("signIn.jsp");
        }

%>
