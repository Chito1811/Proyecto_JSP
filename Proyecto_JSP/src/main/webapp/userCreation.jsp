<%-- index.jsp (proyecto Incrementa5) --%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<%@page import="modules.connectionpool.ConnectionPool"%>
<%@page import="modules.usuarios.UsuarioService"%>
<%@page import="modules.usuarios.Usuario"%>
<%@page import="java.util.ArrayList"%>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");

    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String username = request.getParameter("username");
    
    String user = "Ignacio"; 
    String pass = "1234";
    
    ConnectionPool pool = new ConnectionPool("jdbc:mysql://localhost:3306/Proyecto_jsp_2", user, pass);

    UsuarioService userv = new UsuarioService(pool.getConnection());

    ArrayList<Usuario> lista = userv.requestAll("");

    if (session != null) {
            String uname = (String) session.getAttribute("user");
            if (uname == null) {
                response.sendRedirect("signIn.jsp");
            } 
        } else {
            response.sendRedirect("signIn.jsp");
        }
        

    boolean exists = false;

    for (Usuario usuario: lista){
        if (usuario.getUsername().equals(username)){
            exists = true;
            break;
        }
    }

    if (exists){
        response.sendRedirect("createUser.jsp?exists=true"); 
    } else {
        Usuario x = new Usuario(0,username, email, password);
        userv.create(x);
        response.sendRedirect("usersList.jsp");
    }
%>

