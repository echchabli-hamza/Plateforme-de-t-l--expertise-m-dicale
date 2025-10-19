<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="org.example.entities.Creneau" %>
<%@ page import="org.example.entities.Patient" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de bord Spécialiste</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1600px;
            margin: 0 auto;
        }

        .header {
            background: white;
            border-radius: 20px;
            padding: 30px 40px;
            margin-bottom: 30px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            animation: slideDown 0.6s ease-out;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .header-left h1 {
            color: #333;
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .welcome-text {
            color: #666;
            font-size: 16px;
        }

        .navbar {
            display: flex;
            gap: 10px;
        }

        .navbar a {
            padding: 10px 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 10px;
            font-weight: 500;
            transition: all 0.3s ease;
            box-shadow: 0 2px 8px rgba(102, 126, 234, 0.3);
        }

        .navbar a:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.5);
        }

        .logout-btn {
            padding: 12px 24px;
            background: rgba(231, 76, 60, 0.9);
            color: white;
            text-decoration: none;
            border-radius: 10px;
            font-weight: 500;
            transition: all 0.3s ease;
            box-shadow: 0 2px 8px rgba(231, 76, 60, 0.3);
        }

        .logout-btn:hover {
            background: rgba(192, 57, 43, 1);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(231, 76, 60, 0.5);
        }

        .alert {
            padding: 16px 20px;
            border-radius: 15px;
            margin-bottom: 30px;
            font-size: 15px;
            animation: slideIn 0.5s ease-out;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateX(-30px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .alert-success {
            background: #d4edda;
            color: #155724;
            border-left: 4px solid #28a745;
        }

        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border-left: 4px solid #dc3545;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 24px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            text-align: center;
            animation: slideUp 0.6s ease-out;
            transition: transform 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .stat-icon {
            font-size: 40px;
            margin-bottom: 12px;
        }

        .stat-number {
            font-size: 36px;
            font-weight: 700;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 8px;
        }

        .stat-label {
            font-size: 14px;
            color: #666;
            font-weight: 500;
        }

        .main-card {
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            animation: slideUp 0.8s ease-out;
            max-height: 85vh;
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
            flex-wrap: wrap;
            gap: 15px;
            flex-shrink: 0;
        }

        .card-header h2 {
            color: #333;
            font-size: 20px;
            font-weight: 600;
        }

        .controls {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.25);
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-success {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
            font-size: 16px;
        }

        .btn-submit {
            width: 100%;
            padding: 15px;
            margin-top: 20px;
            flex-shrink: 0;
        }

        .legend {
            display: flex;
            gap: 20px;
            margin-bottom: 15px;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 15px;
            flex-wrap: wrap;
            flex-shrink: 0;
        }

        .legend-item {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 13px;
            color: #666;
        }

        .legend-box {
            width: 20px;
            height: 20px;
            border-radius: 6px;
            border: 2px solid #ddd;
        }

        .legend-box.available {
            background: white;
        }

        .legend-box.existing {
            background: #a9dfbf;
        }

        .legend-box.booked {
            background: #f8d7da;
        }

        .legend-box.selected {
            background: #d5f4e6;
            border-color: #27ae60;
        }

        .calendar-wrapper {
            overflow: auto;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            flex: 1;
            min-height: 0;
        }

        table {
            width: 100%;
            min-width: 1200px;
            border-collapse: separate;
            border-spacing: 0;
            font-size: 12px;
        }

        th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 10px 8px;
            font-weight: 600;
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: 0.3px;
            position: sticky;
            top: 0;
            z-index: 10;
        }

        th:first-child {
            border-top-left-radius: 10px;
            width: 140px;
        }

        th:last-child {
            border-top-right-radius: 10px;
        }

        .day-header {
            font-size: 12px;
            margin-bottom: 2px;
        }

        .date {
            font-size: 9px;
            opacity: 0.9;
            font-weight: 400;
        }

        td {
            border: 1px solid #e0e0e0;
            text-align: center;
        }

        td:first-child {
            background: #f8f9fa;
            font-weight: 600;
            color: #333;
            padding: 12px 8px;
            font-size: 11px;
            text-align: left;
        }

        .slot-cell {
            padding: 4px;
            width: 50px;
            height: 50px;
            vertical-align: middle;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .slot-cell:hover:not(.booked) {
            background: #f0f4ff;
        }

        .slot-cell.selected {
            background: #d5f4e6 !important;
            border: 2px solid #27ae60;
        }

        .slot-cell.booked {
            background: #f8d7da;
            cursor: not-allowed;
        }

        .slot-cell.existing {
            background: #a9dfbf;
        }

        .slot-checkbox {
            width: 18px;
            height: 18px;
            cursor: pointer;
            accent-color: #27ae60;
        }

        .booked-text {
            color: #721c24;
            font-size: 10px;
            font-weight: 600;
        }

        .delete-text {
            color: #856404;
            font-size: 9px;
            margin-top: 2px;
            font-weight: 500;
        }

        @media (max-width: 768px) {
            .header {
                padding: 20px;
            }

            .header-left h1 {
                font-size: 22px;
            }

            .main-card {
                padding: 24px;
            }

            .controls {
                width: 100%;
            }

            .btn {
                flex: 1;
                min-width: 150px;
            }

            .legend {
                flex-direction: column;
                gap: 12px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="header-left">
                <h1>📅 Tableau de bord Spécialiste</h1>
                <p class="welcome-text">Bonjour, <strong>${sessionScope.user.username}</strong> 👋</p>
            </div>
            <div style="display: flex; align-items: center; gap: 15px; flex-wrap: wrap;">
                <nav class="navbar">
                    <a href="http://localhost:8080/medic-1/speDash">Créneaux</a>
                    <a href="http://localhost:8080/medic-1/speDash?view=main">Workspace</a>
                </nav>
                <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Se déconnecter</a>
            </div>
        </div>

        <c:if test="${param.success}">
            <div class="alert alert-success">
                ✓ Créneaux enregistrés avec succès !
            </div>
        </c:if>

        <c:if test="${param.error}">
            <div class="alert alert-error">
                ✗ Une erreur s'est produite lors de l'enregistrement.
            </div>
        </c:if>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon">➕</div>
                <div class="stat-number" id="selected-count">0</div>
                <div class="stat-label">Nouveaux créneaux sélectionnés</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">✅</div>
                <div class="stat-number" id="existing-count">0</div>
                <div class="stat-label">Créneaux disponibles</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">📅</div>
                <div class="stat-number" id="booked-count">0</div>
                <div class="stat-label">Sessions réservées</div>
            </div>
        </div>

        <div class="main-card">
            <div class="card-header">
                <h2>Gestion des créneaux - Semaine à venir</h2>
                <div class="controls">
                    <button type="button" class="btn btn-primary" onclick="selectAllNew()">
                        Sélectionner tous les nouveaux
                    </button>
                </div>
            </div>

            <div class="legend">
                <div class="legend-item">
                    <div class="legend-box available"></div>
                    <span>Nouveau créneau</span>
                </div>
                <div class="legend-item">
                    <div class="legend-box existing"></div>
                    <span>Créneau disponible</span>
                </div>
                <div class="legend-item">
                    <div class="legend-box booked"></div>
                    <span>Session réservée</span>
                </div>
                <div class="legend-item">
                    <div class="legend-box selected"></div>
                    <span>Sélectionné</span>
                </div>
            </div>

            <form method="post" action="${pageContext.request.contextPath}/saveCreneau" id="creneauForm">
                <div class="calendar-wrapper">
                    <table id="calendar">
                        <thead>
                            <tr>
                                <th>Jour</th>
                                <%
                                java.time.LocalTime start = java.time.LocalTime.of(8,0);
                                java.time.LocalTime end = java.time.LocalTime.of(18,0);
                                java.time.LocalTime time = start;
                                java.time.format.DateTimeFormatter timeFormatter = java.time.format.DateTimeFormatter.ofPattern("HH:mm");

                                while(time.isBefore(end)) {
                                %>
                                    <th>
                                        <div class="day-header"><%= time.format(timeFormatter) %></div>
                                    </th>
                                <%
                                    time = time.plusMinutes(30);
                                }
                                %>
                            </tr>
                        </thead>
                        <tbody>
                        <%
                            java.util.List<org.example.entities.Creneau> existingCreneaux =
                                (java.util.List<org.example.entities.Creneau>) request.getAttribute("listC");

                            java.time.format.DateTimeFormatter dayFormatter = java.time.format.DateTimeFormatter.ofPattern("EEEE", java.util.Locale.FRENCH);
                            java.time.format.DateTimeFormatter dateFormatter = java.time.format.DateTimeFormatter.ofPattern("dd/MM");

                            for (int d = 0; d < 7; d++) {
                                java.time.LocalDate date = java.time.LocalDate.now().plusDays(d);
                        %>
                            <tr>
                                <td>
                                    <div class="day-header"><%= date.format(dayFormatter) %></div>
                                    <div class="date"><%= date.format(dateFormatter) %></div>
                                </td>
                                <%
                                time = java.time.LocalTime.of(8,0);
                                while(time.isBefore(end)) {
                                    java.time.LocalDateTime slotDateTime = java.time.LocalDateTime.of(date, time);
                                    String value = date + "T" + time;

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
                                    <td class="slot-cell <%= slotExists && isBooked ? "booked" : "" %> <%= slotExists && isAvailable ? "existing" : "" %>"
                                        data-slot="<%=value%>"
                                        data-type="<%= slotExists && isBooked ? "booked" : (slotExists && isAvailable ? "existing" : "new") %>">

                                        <% if (slotExists && isBooked) { %>
                                            <div class="booked-text">📅</div>
                                        <% } else if (slotExists && isAvailable) { %>
                                            <input type="checkbox"
                                                   class="slot-checkbox delete-checkbox"
                                                   name="deleteSlots"
                                                   value="<%=existingCreneauId%>"
                                                   onchange="updateSlotUI(this)">
                                        <% } else { %>
                                            <input type="checkbox"
                                                   class="slot-checkbox new-slot-checkbox"
                                                   name="slots"
                                                   value="<%=value%>"
                                                   onchange="updateSlotUI(this)">
                                        <% } %>
                                    </td>
                                <%
                                    time = time.plusMinutes(30);
                                }
                                %>
                            </tr>
                        <%
                            }
                        %>
                        </tbody>
                    </table>
                </div>
                <button type="submit" class="btn btn-success btn-submit">
                    💾 Mettre à jour les créneaux
                </button>
            </form>
        </div>
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
            const newCount = document.querySelectorAll('.new-slot-checkbox:checked').length;
            const existingCount = document.querySelectorAll('.slot-cell.existing').length;
            const bookedCount = document.querySelectorAll('.slot-cell.booked').length;

            document.getElementById('selected-count').textContent = newCount;
            document.getElementById('existing-count').textContent = existingCount;
            document.getElementById('booked-count').textContent = bookedCount;
        }

        function selectAllNew() {
            document.querySelectorAll('.new-slot-checkbox').forEach(cb => {
                cb.checked = true;
                updateSlotUI(cb);
            });
        }

        document.addEventListener('DOMContentLoaded', function() {
            updateCount();
        });
    </script>
</body>
</html>