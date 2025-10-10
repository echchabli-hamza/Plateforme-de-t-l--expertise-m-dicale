<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Tableau de bord</title>
</head>
<body>
<h2>Specialiste dash</h2>

<p>Bonjour, ${sessionScope.user.username} !</p>

<form method="post" action="${pageContext.request.contextPath}/logout">
   <a href="${pageContext.request.contextPath}/logout">Se déconnecter</a>

</form>
</body>
</html>
