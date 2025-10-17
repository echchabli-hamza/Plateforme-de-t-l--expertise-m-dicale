<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.entities.SignesVitaux" %>
<%@ page import="org.example.entities.Consultation" %>
<%@ page import="org.example.entities.User" %>
<%@ page import="org.example.entities.Patient" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.entities.ActeTechnique" %>

<html>
<head>
    <title>Consultation</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/consultation.css">
</head>
<body>

<%
    Consultation consultation = (Consultation) request.getAttribute("consultation");
    User generaliste = consultation.getGeneraliste();
    SignesVitaux sv = consultation.getSignesVitaux();
    Patient patient = sv != null ? sv.getPatient() : null;
%>

<h2>Consultation #<%= consultation.getId() %></h2>

<h3>Généraliste</h3>

<p>Username: HH</p>

<h3>Patient</h3>
<% if (patient != null) { %>
    <p>Nom: <%= patient.getNom() %></p>
    <p>Prénom: <%= patient.getPrenom() %></p>
    <p>CNE: <%= patient.getCne() %></p>
<% } %>

<h3>Signes Vitaux</h3>
<% if (sv != null) { %>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Tension</th>
        <th>Fréquence Cardiaque</th>
        <th>Fréquence Respiratoire</th>
        <th>Température</th>
        <th>Poids</th>
        <th>Taille</th>
        <th>Date Mesure</th>
    </tr>
    <tr>
        <td><%= sv.getId() %></td>
        <td><%= sv.getTension() %></td>
        <td><%= sv.getFrequenceCardiaque() %></td>
        <td><%= sv.getFrequenceRespiratoire() %></td>
        <td><%= sv.getTemperature() %></td>
        <td><%= sv.getPoids() %></td>
        <td><%= sv.getTaille() %></td>
        <td><%= sv.getDateMesure() %></td>
    </tr>
</table>
<% } %>

<h3>Ajouter un Acte Technique</h3>
<h3>Ajouter un Acte Technique</h3>
<form method="post" action="${pageContext.request.contextPath}/addActeTechnique">
    <input type="hidden" name="consultationId" value="<%= consultation.getId() %>">

    <select name="acte" required>
        <option value="">-- Sélectionner un acte technique --</option>
        <option value="Radiographie">Radiographie</option>
        <option value="Échographie">Échographie</option>
        <option value="IRM">IRM</option>
        <option value="Électrocardiogramme">Électrocardiogramme (activité électrique du cœur)</option>
        <option value="Dermatologiques (Laser)">Dermatologiques (Laser)</option>
        <option value="Fond d'œil">Fond d'œil (examen de la rétine)</option>
        <option value="Analyse de sang">Analyse de sang</option>
        <option value="Analyse d’urine">Analyse d’urine</option>
    </select>

    <button type="submit">Ajouter</button>
</form>

<%
    List<ActeTechnique> actes = consultation.getActes();
    if (actes != null && !actes.isEmpty()) {
%>
    <h3>Actes Techniques associés</h3>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Nom de l’acte</th>
        </tr>
        <% for (ActeTechnique acte : actes) { %>
        <tr>
            <td><%= acte.getId() %></td>
            <td><%= acte.getNom() %></td>
        </tr>
        <% } %>
    </table>
<% } %>


<h3>Actions</h3>
<form method="post" action="${pageContext.request.contextPath}/consultationPage">
    <input type="hidden" name="consultationId" value="<%= consultation.getId() %>">
    <button type="submit" name="action" value="done">Terminer la consultation</button>

</form>
 <button id="expert" type="submit" name="action" value="extend">Étendre à Télé-Expertise</button>
<%

    boolean isDone = consultation.getStatus() != null
                     && consultation.getStatus() == Consultation.TypeStatus.DONE;


%>
<div>
    Status: <%= consultation.getStatus() %>
</div>


<% if (isDone) { %>
    <div style="position: fixed; top: 0; left: 0; width: 100%; height: 100%;
                background: rgba(0,0,0,0.5); display: flex; justify-content: center;
                align-items: center;">
        <div style="background: #fff; padding: 30px; border-radius: 10px; text-align: center;">
            <h2>Consultation terminée</h2>
            <p>Total à payer : <%= consultation.getCout() %> DH</p>
            <form method="get" action="<%= request.getContextPath() %>/geneDash">
                <button type="submit">Retour au tableau de bord</button>
            </form>
        </div>
    </div>
<% } %>


<div id="tele" class="absolut">
 <button id="expert">Open Modal</button>
  <div class="dimentions">

   <button id="closeModal">×</button>
    <h2 class="h2Css">Recherche de Spécialistes</h2>

    <div class="search-container">
      <select id="specialtyFilter">
        <option value="">Toutes les spécialités</option>
        <option value="Cardiologie">Cardiologie</option>
        <option value="Pneumologie">Pneumologie</option>
        <option value="Neurologie">Neurologie</option>

                <option value="Gastro-entérologie">Gastro-entérologie</option>
                <option value="Endocrinologie">Endocrinologie</option>
                <option value="Dermatologie">Dermatologie</option>
                 <option value="Rhumatologie">Rhumatologie</option>
        <option value="Psychiatrie">Psychiatrie</option>
        <option value="Néphrologie">Néphrologie</option>
         <option value="Orthopédie">Orthopédie</option>


      </select>

      <input  type="number" id="amount" placeholder="Montant" />
      <button id="filter-btn">Filtrer</button>
    </div>

    <div id="specialistsResults" class="results-container">



    </div>

    <div id="creneau" class="results-container">
    <form id="creneauForm">
        <div class="calendar-wrapper">
            <table id="calendar">
                <thead>
                    <tr>
                        <th>Heure</th>
                        <th>mercredi<br>15/10</th>
                        <th>jeudi<br>16/10</th>
                        <th>vendredi<br>17/10</th>
                        <th>samedi<br>18/10</th>
                        <th>dimanche<br>19/10</th>
                        <th>lundi<br>20/10</th>
                        <th>mardi<br>21/10</th>
                    </tr>
                </thead>
                <tbody id="calendarBody">
                    <!-- Rows generated by JS -->
                </tbody>
            </table>
        </div>

 <button type="button" id="confirmButton">Confirm</button>
    </form>

    </div>

  </div>
</div>



  <script src="${pageContext.request.contextPath}/js/consultation.js"></script>
</body>
</html>
