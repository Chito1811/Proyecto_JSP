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
<link rel="stylesheet" href="assets/css/createUser.css">
</head>
</head>
<body>
<%
if (session != null) {
            String username = (String) session.getAttribute("user");
            if (username == null) {
                response.sendRedirect("signIn.jsp");
            } 
        } else {
            response.sendRedirect("signIn.jsp");
        }
%>
<header id="nav">
<a id="userListNav" href="usersList.jsp">Users list</a><br><br><br>
</header>

<div class="container">
    <div class="forms-container">
        <div class="signin-signup">
            <form action="userCreation.jsp" class="sign-in-form" id="miFormulario">
                <h2 class="title">NEW USER</h2>
                <div class="input-field">
                    <input onchange="checkField('email','emailhelp')" id="email" type="text" name="email" placeholder="Email" />
                </div>
                <div id="emailhelp" style="visibility: hidden; color: red;">Invalid email.</div> 
                <div class="input-field">
                    <input style="flex-grow: 1;padding-right: 30px;" onchange="checkField('password','passwordHelp')" id="password" type="password" name="password" placeholder="Password" /> 
                    <span style="cursor: pointer;" class="toggle-button" onclick="togglePassword()">🙈</span>
                </div>
                <div id="passwordHelp" style="visibility: hidden; color: red;">Invalid password. <br>
                </div> 
                <div class="input-field">
                    <input onchange="checkField('username','usernamehelp')" type="text" name="username" id="username" placeholder="Username" />
                </div>
                <div id="usernamehelp" style="visibility: hidden; color: red;">Invalid username. <br>
                </div>
                <button class="btn solid">Create</button>
            </form>
        </div>
    </div>
</div>


<script>
document.getElementById("miFormulario").addEventListener("submit", function(event) {
    var usernameInput = document.getElementById("username");
    var usernameHelp = document.getElementById("usernamehelp");
    var username = usernameInput.value.trim();

    if (username === '' || username.length < 8 || username.length > 12) {
        usernameInput.style.borderColor="red";
        usernameHelp.style.visibility = "visible";
        event.preventDefault();
        alert("- Usename length: 8-12 characters.");
    } else {
        usernameInput.style.borderColor="#ccc";
        usernameHelp.style.visibility = "hidden";
    }
});

document.getElementById("miFormulario").addEventListener("submit", function(event) {
    var passwordInput = document.getElementById("password");
    var passwordHelp = document.getElementById("passwordHelp");
    var password = passwordInput.value.trim();

    var regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,15}$/;

    if (!regex.test(password)) {
        document.getElementById('password').style.borderColor="red"
        passwordHelp.style.visibility = "visible";
        event.preventDefault();
        alert("- Password length: 8-15 characters \n- Must contain one number.\n- Must contain one upper and lower case letter.");
    } else {
        document.getElementById('password').style.borderColor="#ccc"
        passwordHelp.style.visibility = "hidden";
    }
});

document.getElementById("miFormulario").addEventListener("submit", function(event) {
    var emailInput = document.getElementById("email");
    var emailHelp = document.getElementById("emailhelp");
    var email = emailInput.value.trim();
    var emailRegex = /^\w+([.-_+]?\w+)*@\w+([.-]?\w+)*(\.\w{2,10})+$/;

    if (!emailRegex.test(email)) {
        document.getElementById('email').style.borderColor="red"
        emailHelp.style.visibility = "visible";
        event.preventDefault();
    } else {
        emailHelp.style.visibility = "hidden";
        document.getElementById('email').style.borderColor="white"
    }
});

function checkField(inputId, helpId) {
    var input = document.getElementById(inputId);
    var help = document.getElementById(helpId);

    if (input.value === "") {
        help.style.visibility = "visible";
        input.style.borderColor = "red"
    } else {
        help.style.visibility = "hidden";
        input.style.borderColor = "white"
    }
}


function togglePassword() {
            var passwordField = document.getElementById('password');
            var toggleButton = document.querySelector('.toggle-button');
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                toggleButton.textContent = '👁️'; // Cambia el icono al de "ocultar"
            } else {
                passwordField.type = 'password';
                toggleButton.textContent = '🙈'; // Cambia el icono al de "mostrar"
            }
        }

document.addEventListener("DOMContentLoaded", function() {
    
    var exists = (new URLSearchParams(window.location.search)).get('exists');
    exists = (exists === 'true');

    if (exists) {
        alert("That username is already in use.");
    }
});

</script>
</body>
</html>