<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Connexion</title>
</head>
<body>
<h2>Connexion</h2>

<c:if test="${not empty error}">
    <p style="color:red">${error}</p>
</c:if>

<form method="post" action="${pageContext.request.contextPath}/login">
    <label>Nom d'utilisateur:</label>
    <input type="text" name="username" required /><br/><br/>

    <label>Mot de passe:</label>
    <input type="password" name="password" required /><br/><br/>

    <button type="submit">Se connecter</button>
</form>
</body>
</html>
