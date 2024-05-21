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
<link rel="stylesheet" href="assets/css/signIn.css">
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
    %>
    <div class="container">
        <div class="forms-container" onsubmit="return redireccionarSignInUser()">
            <div class="signin-signup">
                <form class="sign-in-form">
                    <h2 class="title">SIGN IN</h2>
                    <div class="input-field">
                        <input id="inputUsername" type="text" placeholder="Username" />
                    </div>
                    <div class="input-field">
                        
                        <input style="flex-grow: 1;padding-right: 30px;" onchange="checkField('password','passwordHelp')" id="inputPassword" type="password" name="password" placeholder="Password" /> 
                        <span style="cursor: pointer;" class="toggle-button" onclick="togglePassword()">🙈</span>
                    </div>
                    <br>
                    <a id="contact-button" href="signUp.jsp">Dont have an account yet? Sign up here.</a> <br>
                    <input type="submit" value="Login" class="btn solid" />
                </form>
            </div>
        </div>
    </div>
<script>

    function redireccionarSignInUser() {
        var username = document.getElementById('inputUsername').value;
        var password = document.getElementById('inputPassword').value;
        var user = username;
        var pass = password;
        window.location.href = "signInUser.jsp?user=" + encodeURIComponent(user) + "&pass=" + encodeURIComponent(pass)
        return false;            
    }   

    
function togglePassword() {
            var passwordField = document.getElementById('inputPassword');
            var toggleButton = document.querySelector('.toggle-button');
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                toggleButton.textContent = '👁️'; // Cambia el icono al de "ocultar"
            } else {
                passwordField.type = 'password';
                toggleButton.textContent = '🙈'; // Cambia el icono al de "mostrar"
            }
        }

</script>

</body>
</html>