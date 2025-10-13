<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.entities.Patient" %>
<html>
<head>
    <title>Gestion des patients</title>
    <style>
        body { font-family: Arial; background-color: #f7f7f7; margin: 40px; }
        h2 { color: #333; text-align:center; }
        form { background: #fff; padding: 20px; border-radius: 8px; max-width: 400px; margin: 20px auto; box-shadow:0 0 10px rgba(0,0,0,0.1);}
        input, select, button { display:block; width:100%; padding:8px; margin-bottom:12px; border:1px solid #ccc; border-radius:5px; font-size:14px; }
        button { background-color:#4CAF50; color:white; cursor:pointer; }
        button:hover { background-color:#45a049; }
        table { width:90%; margin:30px auto; border-collapse:collapse; background:#fff; }
        th, td { padding:10px; border:1px solid #ccc; text-align:center; }
        th { background-color:#4CAF50; color:white; }
        .msg { text-align:center; color:green; }
    </style>
</head>
<body>

<h2>Ajouter un nouveau patient avec signes vitaux</h2>

<form action="${pageContext.request.contextPath}/patient" method="post">
    <!-- Patient info -->
    <input type="text" name="cne" placeholder="cne" required>

    <input type="text" name="prenom" placeholder="Prénom" required>
    <input type="text" name="nom" placeholder="Nom" required>
    <input type="date" name="dateNaissance" required>
    <input type="text" name="numeroSS" placeholder="Numéro Sécurité Sociale" required>
    <input type="text" name="telephone" placeholder="Téléphone" required>
    <input type="text" name="adresse" placeholder="Adresse" required>

   <input type="number" step="0.1" name="tension" placeholder="Tension (mmHg)" required>
   <input type="number" name="frequenceCardiaque" placeholder="Fréquence cardiaque (bpm)" required>
   <input type="number" name="frequenceRespiratoire" placeholder="Fréquence respiratoire" required>
   <input type="number" step="0.1" name="temperature" placeholder="Température (°C)" required>
   <input type="number" step="0.1" name="poids" placeholder="Poids (kg)">
   <input type="number" step="0.1" name="taille" placeholder="Taille (cm)">


    <button type="submit">Ajouter Patient + Signes Vitaux</button>
</form>

<p class="msg">${message}</p>

<h2>Liste des patients</h2>
<%
    List<Patient> patients = (List<Patient>) request.getAttribute("patients");
    if (patients != null && !patients.isEmpty()) {
%>
<table>
    <tr>
        <th>ID</th>
        <th>Prénom</th>
        <th>Nom</th>
        <th>Date de naissance</th>
        <th>Téléphone</th>
        <th>Adresse</th>
    </tr>
    <% for (Patient p : patients) { %>
    <tr>
        <td><%= p.getId() %></td>
        <td><%= p.getPrenom() %></td>
        <td><%= p.getNom() %></td>
        <td><%= p.getDateNaissance() %></td>
        <td><%= p.getTelephone() %></td>
        <td><%= p.getAdresse() %></td>
    </tr>
    <% } %>
</table>
<% } else { %>
<p style="text-align:center;">Aucun patient trouvé.</p>
<% } %>

    <a href="${pageContext.request.contextPath}/logout">Se déconnecter</a>


</body>
</html>
