<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="modules.connectionpool.ConnectionPool"%>
<%@page import="modules.usuarios.UsuarioService"%>
<%@page import="modules.usuarios.Usuario"%>
<%@page import="java.util.ArrayList"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="assets/css/usersList.css">
</head>
</head>
<body>



<%
    //Usuario de la base de datos
    String user = "Ignacio";
    //Contraseña de la base de datos
    String password = "1234";
    //Pool de conexiones a la base de datos
    ConnectionPool pool = new ConnectionPool("jdbc:mysql://localhost:3306/Proyecto_jsp_2", user, password);

    UsuarioService userv = new UsuarioService(pool.getConnection());
    ArrayList<Usuario> list = userv.requestAll("");

        if (session != null) {
            String username = (String) session.getAttribute("user");
            if (username == null) {
                response.sendRedirect("signIn.jsp");
            } 
        } else {
            response.sendRedirect("signIn.jsp");
        }
    
    String username = (String) session.getAttribute("user");

        out.println("<div class='container'>");
        out.println("<div class='title d-flex'>");
        out.println("<h1>Users list</h1>");
        out.println(String.format("<button onclick='redireccionarProfile()'>%s</button>", username));
        out.println("</div>");
        out.println("<div id='container'>");

        // Fila de encabezados
        out.println("<div class='user header-row'>");
        out.println("<div><b>Username</b></div>");
        out.println("<div><b>Password</b></div>");
        out.println("<div><b>Email</b></div>");
        out.println("<div id='actions' style='color: white;'>------------</div>");
        out.println("</div>");

        // Filas de datos
        for (Usuario usuario : list) {
            out.println("<div class='user'>");

            out.println("<div class='column-tittles'><b>Username:&nbsp</b></div>");
            out.println(String.format("<div>%s</div>", usuario.getUsername()));
            out.println("<div class='column-tittles'><b>Password:&nbsp</b></div>");
            out.println(String.format("<div>%s</div>", usuario.getPassword()));
            out.println("<div class='column-tittles'><b>Email:&nbsp</b></div>");
            out.println(String.format("<div>%s</div>", usuario.getEmail()));
            if (!usuario.getUsername().equals("JuanArrow")){
            out.println("<div id='actions'>");
            out.println("<div id='edit'>");
            out.println(String.format("<button onclick='redireccionarEditView(\"%s\")' class='bg-primary p-1 ml-5'>Edit</button>",usuario.getId()));
            out.println("</div>");
            out.println("<div id='delete'>");
            out.println(String.format("<button onclick='redireccionarDeleteUser(\"%s\")' class='bg-danger p-1'>Delete</button>", usuario.getId()));
            out.println("</div>");
            out.println("</div>");
            } else {
                out.println("<div id='actions'>");
            out.println("<div style='color:white;' id='relleno'>");
            out.println("------------");
            out.println("</div>");
            out.println("</div>");
            }
            out.println("</div>");
        }

        out.println("</div>");
        out.println("<button onclick='redireccionarCreateUser()' id='addUserBtn'>+</button>");
        out.println("</div>");
        out.println("</body>");
        out.println("</html>");

    %>

<script>

    function redireccionarDeleteUser(id) { 
            var confirmacion = confirm("Are you sure you want to delete the user?");
            var dato = id;

            if (confirmacion) {
                window.location.href = "deleteUser.jsp?dato=" + encodeURIComponent(dato);
            }
        }

    function redireccionarEditView(id) { 
            var dato = id;
            window.location.href = "editView.jsp?dato=" + encodeURIComponent(dato);
        }


    function redireccionarProfile() { 
                window.location.href = "profile.jsp";            
        }


    function redireccionarCreateUser() { 
                window.location.href = "createUser.jsp";            
        }

</script>



</body>
</html>