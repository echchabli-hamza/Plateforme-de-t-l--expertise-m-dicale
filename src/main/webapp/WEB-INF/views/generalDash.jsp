<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.entities.Patient" %>
<%@ page import="org.example.entities.Consultation" %>
<%@ page import="org.example.entities.SignesVitaux" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de bord - Généraliste</title>
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
            max-width: 1400px;
            margin: 0 auto;
        }

        .header {
            text-align: center;
            color: white;
            margin-bottom: 40px;
            animation: fadeIn 0.6s ease-out;
        }

        .header h1 {
            font-size: 36px;
            font-weight: 600;
            margin-bottom: 10px;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        }

        .welcome-text {
            font-size: 18px;
            opacity: 0.95;
            margin-top: 8px;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .logout-btn {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 12px 24px;
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(10px);
            color: white;
            text-decoration: none;
            border-radius: 10px;
            font-weight: 500;
            transition: all 0.3s ease;
            border: 1px solid rgba(255, 255, 255, 0.3);
            z-index: 1000;
        }

        .logout-btn:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .dashboard-card {
            background: white;
            border-radius: 20px;
            padding: 40px;
            margin-bottom: 30px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            animation: slideUp 0.6s ease-out;
        }

        .dashboard-card:nth-child(2) {
            animation-delay: 0.1s;
        }

        .dashboard-card:nth-child(3) {
            animation-delay: 0.2s;
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

        .card-header {
            display: flex;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #f0f0f0;
        }

        .card-header h2 {
            color: #333;
            font-size: 24px;
            font-weight: 600;
            margin-left: 12px;
        }

        .card-icon {
            font-size: 32px;
        }

        .table-wrapper {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
        }

        th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 16px;
            text-align: left;
            font-weight: 600;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        th:first-child {
            border-top-left-radius: 10px;
        }

        th:last-child {
            border-top-right-radius: 10px;
        }

        td {
            padding: 16px;
            border-bottom: 1px solid #e0e0e0;
            color: #333;
            font-size: 14px;
        }

        tr:hover td {
            background: #f8f9fa;
        }

        tr:last-child td:first-child {
            border-bottom-left-radius: 10px;
        }

        tr:last-child td:last-child {
            border-bottom-right-radius: 10px;
        }

        tr:last-child td {
            border-bottom: none;
        }

        .action-btn {
            padding: 10px 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 2px 8px rgba(102, 126, 234, 0.3);
        }

        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.5);
        }

        .action-btn:active {
            transform: translateY(0);
        }

        .link-btn {
            padding: 10px 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-block;
            box-shadow: 0 2px 8px rgba(102, 126, 234, 0.3);
        }

        .link-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.5);
        }

        .status-badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-active {
            background: #d4edda;
            color: #155724;
        }

        .status-pending {
            background: #fff3cd;
            color: #856404;
        }

        .status-completed {
            background: #d1ecf1;
            color: #0c5460;
        }

        .no-data {
            text-align: center;
            padding: 60px 20px;
            color: #999;
            font-size: 16px;
        }

        .no-data::before {
            content: "📋";
            display: block;
            font-size: 48px;
            margin-bottom: 16px;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 24px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            text-align: center;
            animation: slideUp 0.6s ease-out;
        }

        .stat-icon {
            font-size: 40px;
            margin-bottom: 12px;
        }

        .stat-number {
            font-size: 32px;
            font-weight: 700;
            color: #667eea;
            margin-bottom: 8px;
        }

        .stat-label {
            font-size: 14px;
            color: #666;
            font-weight: 500;
        }

        @media (max-width: 768px) {
            .header h1 {
                font-size: 28px;
            }

            .dashboard-card {
                padding: 24px;
                border-radius: 15px;
            }

            .card-header h2 {
                font-size: 20px;
            }

            .logout-btn {
                position: static;
                display: block;
                margin: 0 auto 20px;
                width: fit-content;
            }

            table {
                font-size: 12px;
            }

            th, td {
                padding: 10px 8px;
            }

            .action-btn, .link-btn {
                padding: 8px 16px;
                font-size: 12px;
            }
        }
    </style>
</head>
<body>
    <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Se déconnecter</a>

    <div class="container">
        <div class="header">
            <h1>Tableau de bord - Généraliste</h1>
            <p class="welcome-text">Bonjour, ${sessionScope.user.username} 👋</p>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon">⏳</div>
                <div class="stat-number">
                    <%
                        List<SignesVitaux> unusedSignes = (List<SignesVitaux>) request.getAttribute("unusedSignes");
                        int waitingCount = (unusedSignes != null) ? unusedSignes.size() : 0;
                    %>
                    <%= waitingCount %>
                </div>
                <div class="stat-label">En attente</div>
            </div>

            <div class="stat-card">
                <div class="stat-icon">📋</div>
                <div class="stat-number">
                    <%
                        List<Consultation> activeConsultations = (List<Consultation>) request.getAttribute("activeConsultations");
                        int activeCount = (activeConsultations != null) ? activeConsultations.size() : 0;
                    %>
                    <%= activeCount %>
                </div>
                <div class="stat-label">Consultations actives</div>
            </div>

            <div class="stat-card">
                <div class="stat-icon">✅</div>
                <div class="stat-number"><%= waitingCount + activeCount %></div>
                <div class="stat-label">Total aujourd'hui</div>
            </div>
        </div>

        <div class="dashboard-card">
            <div class="card-header">
                <span class="card-icon">⏳</span>
                <h2>Patients en attente de consultation</h2>
            </div>

            <div class="table-wrapper">
                <%
                    if (unusedSignes != null && !unusedSignes.isEmpty()) {
                %>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>CNE</th>
                            <th>Nom</th>
                            <th>Prénom</th>
                            <th>Date de naissance</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
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
                                <form method="get" action="${pageContext.request.contextPath}/createConsultation" style="display: inline;">
                                    <input type="hidden" name="signesVitauxId" value="<%= sv.getId() %>">
                                    <button type="submit" class="action-btn">Créer consultation</button>
                                </form>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <% } else { %>
                <div class="no-data">
                    Aucun patient en attente
                </div>
                <% } %>
            </div>
        </div>

        <div class="dashboard-card">
            <div class="card-header">
                <span class="card-icon">📋</span>
                <h2>Consultations en cours</h2>
            </div>

            <div class="table-wrapper">
                <%
                    if (activeConsultations != null && !activeConsultations.isEmpty()) {
                %>
                <table>
                    <thead>
                        <tr>
                            <th>ID Consultation</th>
                            <th>Patient CNE</th>
                            <th>Nom du Patient</th>
                            <th>Statut</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Consultation c : activeConsultations) { %>
                        <tr>
                            <td><%= c.getId() %></td>
                            <td><%= c.getSignesVitaux().getPatient().getCne() %></td>
                            <td><%= c.getSignesVitaux().getPatient().getNom() %> <%= c.getSignesVitaux().getPatient().getPrenom() %></td>
                            <td>
                                <span class="status-badge status-active"><%= c.getStatus() %></span>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/consultationPage?consultationId=<%= c.getId() %>" class="link-btn">
                                    Ouvrir
                                </a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <% } else { %>
                <div class="no-data">
                    Aucune consultation en cours
                </div>
                <% } %>
            </div>
        </div>
    </div>
</body>
</html>