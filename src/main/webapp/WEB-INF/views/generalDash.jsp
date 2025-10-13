<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.entities.Patient" %>
<%@ page import="org.example.entities.Consultation" %>
<%@ page import="org.example.entities.SignesVitaux" %>

<html>
<head>
    <title>Tableau de bord - Généraliste</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background-color: #f7f7f7;
        }
        h2, h3 {
            color: #333;
            text-align: center;
        }
        table {
            width: 90%;
            margin: 20px auto;
            border-collapse: collapse;
            background: #fff;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: center;
        }
        th {
            background-color: #4CAF50;
            color: white;
        }
        form {
            display: inline-block;
        }
        input, select, button {
            padding: 8px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
        .section {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            margin: 30px auto;
            width: 90%;
        }
        .logout {
            text-align: center;
            margin-top: 20px;
        }
        a.logout-link {
            color: #4CAF50;
            text-decoration: none;
            font-weight: bold;
        }
        a.logout-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<h2>Tableau de bord - Généraliste</h2>
<p style="text-align: center;">Bonjour, ${sessionScope.user.username} 👋</p>

<div class="section">
    <h3>Patients en attente de consultation</h3>
    <%
        List<SignesVitaux> unusedSignes = (List<SignesVitaux>) request.getAttribute("unusedSignes");
        if (unusedSignes != null && !unusedSignes.isEmpty()) {
    %>
    <table>
        <tr>
            <th>ID</th>
            <th>CNE</th>
            <th>Nom</th>
            <th>Prénom</th>
            <th>Date de naissance</th>
            <th>Action</th>
        </tr>
        <% for (SignesVitaux sv : unusedSignes) {
            Patient p = sv.getPatient();
        %>
        <tr>
            <td><%= sv.getId() %></td>
            <td><%= p.getCne() %></td>
            <td><%= p.getNom() %></td>
            <td><%= p.getPrenom() %></td>
            <td><%= p.getDateNaissance() %></td>
            <td>
                <form method="get" action="${pageContext.request.contextPath}/createConsultation">
                    <input type="hidden" name="signesVitauxId" value="<%= sv.getId() %>">
                    <button type="submit">Créer consultation</button>
                </form>
            </td>
        </tr>
        <% } %>
    </table>
    <% } else { %>
    <p style="text-align:center;">Aucun patient en attente.</p>
    <% } %>

</div>

<div class="section">
    <h3>Consultations en cours</h3>
    <%
        List<Consultation> activeConsultations = (List<Consultation>) request.getAttribute("activeConsultations");
        if (activeConsultations != null && !activeConsultations.isEmpty()) {
    %>
    <table>
        <tr>
            <th>ID Consultation</th>
            <th>Patient CNE</th>
            <th>Nom du Patient</th>
            <th>Statut</th>
            <th>Action</th>
        </tr>
        <% for (Consultation c : activeConsultations) { %>
        <tr>
            <td><%= c.getId() %></td>
            <td><%= c.getSignesVitaux().getPatient().getCne() %></td>
            <td><%= c.getSignesVitaux().getPatient().getNom() %> <%= c.getSignesVitaux().getPatient().getPrenom() %></td>
            <td><%= c.getStatus() %></td>
            <td>
               <a href="${pageContext.request.contextPath}/consultationPage?consultationId=<%= c.getId() %>">Ouvrir</a>



            </td>
        </tr>
        <% } %>
    </table>
    <% } else { %>
    <p style="text-align:center;">Aucune consultation en cours.</p>
    <% } %>
</div>



<div class="logout">
    <a href="${pageContext.request.contextPath}/logout" class="logout-link">Se déconnecter</a>
</div>

</body>
</html>
