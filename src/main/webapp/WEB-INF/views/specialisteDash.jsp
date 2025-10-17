<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="org.example.entities.Creneau" %>
<%@ page import="org.example.entities.Patient" %>

<!DOCTYPE html>
<html>
<head>
    <title>Tableau de bord Spécialiste</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f5f7fa;
            padding: 20px;
        }
        .container {
            max-width: 1400px;
            margin: 0 auto;
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            padding: 30px;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #e0e0e0;
        }
        .header h2 {
            color: #2c3e50;
            font-size: 28px;
        }
        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        .logout-btn {
            background: #e74c3c;
            color: white;
            padding: 10px 20px;
            border-radius: 6px;
            text-decoration: none;
            transition: background 0.3s;
        }
        .logout-btn:hover {
            background: #c0392b;
        }
        .controls {
            margin-bottom: 20px;
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.3s;
        }
        .btn-primary {
            background: #3498db;
            color: white;
        }
        .btn-primary:hover {
            background: #2980b9;
        }
        .btn-success {
            background: #27ae60;
            color: white;
        }
        .btn-success:hover {
            background: #229954;
        }
        .btn-warning {
            background: #f39c12;
            color: white;
        }
        .btn-warning:hover {
            background: #e67e22;
        }
        .calendar-wrapper {
            overflow-x: auto;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            min-width: 800px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px 8px;
            text-align: center;
        }
        th {
            background: #34495e;
            color: white;
            font-weight: 600;
            position: sticky;
            top: 0;
            z-index: 10;
        }
        th:first-child {
            background: #2c3e50;
        }
        td:first-child {
            background: #ecf0f1;
            font-weight: 600;
            color: #2c3e50;
        }
        .slot-cell {
            position: relative;
            padding: 5px;
            height: 60px;
            vertical-align: middle;
        }
        .slot-checkbox {
            width: 24px;
            height: 24px;
            cursor: pointer;
            accent-color: #27ae60;
        }
        .slot-cell.selected {
            background: #d5f4e6;
        }
        .slot-cell.booked {
            background: #f8d7da;
            color: #721c24;
        }
        .slot-cell.existing {
            background: #a9dfbf;
        }
        .slot-cell.to-delete {
            background: #fff3cd;
        }
        .day-header {
            font-size: 14px;
        }
        .date {
            font-size: 12px;
            color: #7f8c8d;
        }
        .legend {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 6px;
            flex-wrap: wrap;
        }
        .legend-item {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .legend-box {
            width: 20px;
            height: 20px;
            border: 1px solid #ddd;
            border-radius: 3px;
        }
        .success-msg, .error-msg {
            padding: 15px;
            border-radius: 6px;
            margin-bottom: 20px;
        }
        .success-msg {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .error-msg {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .stats {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }
        .stat-card {
            flex: 1;
            padding: 15px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 8px;
            text-align: center;
        }
        .stat-number {
            font-size: 32px;
            font-weight: bold;
        }
        .stat-label {
            font-size: 14px;
            opacity: 0.9;
        }
        .booked-text {
            color: #721c24;
            font-size: 12px;
            font-weight: bold;
        }
        .delete-text {
            color: #856404;
            font-size: 11px;
            margin-top: 5px;
        }
    </style>
</head>
<body>



<div class="container">
<nav class="navbar">
                           <ul>
                               <li><a href="http://localhost:8080/medic-1/speDash">Creneaux</a></li>
                               <li><a href="#assignedConsultations">Workspace</a></li>
                           </ul>
       </nav>
    <div class="header">
        <div>
            <h2>Tableau de bord Spécialiste</h2>
            <p style="color: #7f8c8d; margin-top: 5px;">Bonjour, <strong>${sessionScope.user.username}</strong></p>
        </div>
        <div class="user-info">
            <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Se déconnecter</a>
        </div>
    </div>

    <c:if test="${param.success}">
        <div class="success-msg">✓ Créneaux enregistrés avec succès !</div>
    </c:if>

    <c:if test="${param.error}">
        <div class="error-msg">✗ Une erreur s'est produite lors de l'enregistrement.</div>
    </c:if>

    <div class="stats">
        <div class="stat-card">
            <div class="stat-number" id="selected-count">0</div>
            <div class="stat-label">Nouveaux créneaux sélectionnés</div>
        </div>
    </div>



    <div class="controls">
        <button type="button" class="btn btn-primary" onclick="selectAllNew()">Sélectionner tous les nouveaux créneaux</button>
       </div>

    <h3 style="margin-bottom: 15px; color: #2c3e50;">Gestion des créneaux - Semaine à venir</h3>

    <form method="post" action="${pageContext.request.contextPath}/saveCreneau" id="creneauForm">
        <div class="calendar-wrapper">
            <table id="calendar">
                <thead>
                    <tr>
                        <th style="width: 150px;">Heure</th>
                        <%
                        java.time.format.DateTimeFormatter dayFormatter = java.time.format.DateTimeFormatter.ofPattern("EEEE", java.util.Locale.FRENCH);
                        java.time.format.DateTimeFormatter dateFormatter = java.time.format.DateTimeFormatter.ofPattern("dd/MM");
                        for (int d = 0; d < 7; d++) {
                            java.time.LocalDate date = java.time.LocalDate.now().plusDays(d);
                        %>
                            <th>
                                <div class="day-header"><%= date.format(dayFormatter) %></div>
                                <div class="date"><%= date.format(dateFormatter) %></div>
                            </th>
                        <% } %>
                    </tr>
                </thead>
                <tbody>
                <%

                    java.util.List<org.example.entities.Creneau> existingCreneaux =
                        (java.util.List<org.example.entities.Creneau>) request.getAttribute("listC");

                    java.time.LocalTime start = java.time.LocalTime.of(8,0);
                    java.time.LocalTime end = java.time.LocalTime.of(18,0);
                    java.time.LocalTime time = start;
                    java.time.format.DateTimeFormatter timeFormatter = java.time.format.DateTimeFormatter.ofPattern("HH:mm");

                    while(time.isBefore(end)) {
                %>
                    <tr>
                        <td><%= time.format(timeFormatter) %> - <%= time.plusMinutes(30).format(timeFormatter) %></td>
                        <%
                        for (int d = 0; d < 7; d++) {
                            java.time.LocalDate date = java.time.LocalDate.now().plusDays(d);
                            java.time.LocalDateTime slotDateTime = java.time.LocalDateTime.of(date, time);
                            String value = date + "T" + time;

                            // Check if this slot exists in database
                            boolean slotExists = false;
                            boolean isBooked = false;
                            boolean isAvailable = false;
                            Long existingCreneauId = null;

                            if (existingCreneaux != null) {
                                for (org.example.entities.Creneau creneau : existingCreneaux) {
                                    if (creneau.getDebut().equals(slotDateTime)) {
                                        slotExists = true;
                                        existingCreneauId = creneau.getId();
                                        if (!creneau.getDisponible()) {
                                            isBooked = true;
                                        } else {
                                            isAvailable = true;
                                        }
                                        break;
                                    }
                                }
                            }
                        %>
                            <td class="slot-cell
                                <%= slotExists && isBooked ? "booked" : "" %>
                                <%= slotExists && isAvailable ? "existing" : "" %>
                                <%= !slotExists ? "available" : "" %>"
                                data-slot="<%=value%>">

                                <% if (slotExists && isBooked) { %>
                                    <!-- Session Booked - No checkbox -->
                                    <div class="booked-text">📅 Session réservée</div>
                                <% } else if (slotExists && isAvailable) { %>
                                    <!-- Existing available slot - Checkbox to delete -->
                                    <input type="checkbox"
                                           class="slot-checkbox delete-checkbox"
                                           name="deleteSlots"
                                           value="<%=existingCreneauId%>"
                                           onchange="updateSlotUI(this)">
                                    <div class="delete-text">Supprimer</div>
                                <% } else { %>
                                    <!-- New slot - Checkbox to add -->
                                    <input type="checkbox"
                                           class="slot-checkbox new-slot-checkbox"
                                           name="slots"
                                           value="<%=value%>"
                                           onchange="updateSlotUI(this)">
                                <% } %>
                            </td>
                        <% } %>
                    </tr>
                <%
                        time = time.plusMinutes(30);
                    }
                %>
                </tbody>
            </table>
        </div>
        <br>
        <button type="submit" class="btn btn-success" style="width: 100%; padding: 15px; font-size: 16px;">
            💾 Mettre à jour les créneaux
        </button>
    </form>
</div>

<script>
    function updateSlotUI(checkbox) {
        const cell = checkbox.closest('.slot-cell');
        if (checkbox.checked) {
            cell.classList.add('selected');
        } else {
            cell.classList.remove('selected');
        }
        updateCount();
    }

    function updateCount() {
        const count = document.querySelectorAll('.new-slot-checkbox:checked').length;
        document.getElementById('selected-count').textContent = count;
    }

    function selectAllNew() {
        document.querySelectorAll('.new-slot-checkbox').forEach(cb => {
            cb.checked = true;
            updateSlotUI(cb);
        });
    }

    function deselectAll() {
        document.querySelectorAll('.slot-checkbox').forEach(cb => {
            cb.checked = false;
            updateSlotUI(cb);
        });
    }

    function submitForm() {
        const newCount = document.querySelectorAll('.new-slot-checkbox:checked').length;
        const deleteCount = document.querySelectorAll('.delete-checkbox:checked').length;

        if (newCount === 0 && deleteCount === 0) {
            alert('Aucun changement sélectionné.');
            return;
        }

        let message = '';
        if (newCount > 0) {
            message += `${newCount} nouveau(x) créneau(x) à ajouter\n`;
        }
        if (deleteCount > 0) {
            message += `${deleteCount} créneau(x) à supprimer\n`;
        }

        if (confirm(`Confirmer les modifications ?\n\n${message}`)) {
            document.getElementById('creneauForm').submit();
        }
    }

    // Initialize on load
    document.addEventListener('DOMContentLoaded', function() {
        updateCount();
    });
</script>
</body>
</html>