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

    boolean exists = false;

    for (Usuario usuario: lista){
        if (usuario.getUsername().equals(username)){
            exists = true;
            break;
        }
    }

    if (exists){
        response.sendRedirect("signUp.jsp?exists=true"); 
    } else {
        Usuario x = new Usuario(0,username, email, password);
        userv.create(x);
        response.sendRedirect("signIn.jsp");
    }
    
%>

<script>


</script>