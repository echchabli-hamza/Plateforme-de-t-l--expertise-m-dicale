<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="org.example.entities.TeleExpertise" %>
<%@ page import="org.example.entities.Consultation" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Workspace - Télé-Expertises</title>
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
            padding: 40px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            animation: slideUp 0.8s ease-out;
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #f0f0f0;
            flex-wrap: wrap;
            gap: 15px;
        }

        .card-header h2 {
            color: #333;
            font-size: 24px;
            font-weight: 600;
        }

        .expertise-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 20px;
        }

        .expertise-card {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 24px;
            border-left: 4px solid #667eea;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .expertise-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
            border-left-color: #764ba2;
        }

        .expertise-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 16px;
        }

        .expertise-id {
            font-size: 14px;
            font-weight: 600;
            color: #667eea;
        }

        .status-badge {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-en-attente {
            background: #fff3cd;
            color: #856404;
        }

        .status-terminee {
            background: #d1ecf1;
            color: #0c5460;
        }

        .expertise-info {
            margin-bottom: 12px;
        }

        .info-label {
            font-size: 12px;
            color: #666;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 4px;
        }

        .info-value {
            font-size: 14px;
            color: #333;
            line-height: 1.5;
        }

        .question-text {
            background: white;
            padding: 12px;
            border-radius: 8px;
            font-size: 14px;
            color: #555;
            margin-top: 8px;
            border-left: 3px solid #667eea;
        }

        .expertise-actions {
            display: flex;
            gap: 10px;
            margin-top: 16px;
            padding-top: 16px;
            border-top: 1px solid #e0e0e0;
        }

        .btn {
            flex: 1;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
            text-decoration: none;
            display: inline-block;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            box-shadow: 0 2px 8px rgba(102, 126, 234, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.5);
        }

        .btn-secondary {
            background: #f0f0f0;
            color: #333;
        }

        .btn-secondary:hover {
            background: #e0e0e0;
        }

        .no-data {
            text-align: center;
            padding: 60px 20px;
            color: #999;
            font-size: 16px;
        }

        .no-data::before {
            content: "🔍";
            display: block;
            font-size: 48px;
            margin-bottom: 16px;
        }

        .date-info {
            font-size: 13px;
            color: #888;
            margin-top: 8px;
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

            .expertise-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="header-left">
                <h1>🏥 Workspace - Télé-Expertises</h1>
                <p class="welcome-text">Bonjour, <strong>${sessionScope.user.username}</strong> 👋</p>
            </div>
            <div style="display: flex; align-items: center; gap: 15px; flex-wrap: wrap;">
                <nav class="navbar">
                    <a href="${pageContext.request.contextPath}/speDash">Créneaux</a>
                    <a href="${pageContext.request.contextPath}/speDash?view=main">Workspace</a>
                </nav>
                <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Se déconnecter</a>
            </div>
        </div>

        <%
            java.util.List<org.example.entities.TeleExpertise> teleExpertises =
                (java.util.List<org.example.entities.TeleExpertise>) request.getAttribute("teleExpertises");

            int totalCount = 0;
            int pendingCount = 0;
            int completedCount = 0;

            if (teleExpertises != null) {
                totalCount = teleExpertises.size();
                for (org.example.entities.TeleExpertise te : teleExpertises) {
                    if ("EN_ATTENTE".equals(te.getStatut())) {
                        pendingCount++;
                    } else if ("TERMINEE".equals(te.getStatut())) {
                        completedCount++;
                    }
                }
            }
        %>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon">📋</div>
                <div class="stat-number"><%= totalCount %></div>
                <div class="stat-label">Total Télé-Expertises</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">⏳</div>
                <div class="stat-number"><%= pendingCount %></div>
                <div class="stat-label">En Attente</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">✅</div>
                <div class="stat-number"><%= completedCount %></div>
                <div class="stat-label">Terminées</div>
            </div>
        </div>

        <div class="main-card">
            <div class="card-header">
                <h2>Mes Télé-Expertises Assignées</h2>
            </div>

            <%
                if (teleExpertises != null && !teleExpertises.isEmpty()) {
            %>
                <div class="expertise-grid">
                    <% for (org.example.entities.TeleExpertise te : teleExpertises) { %>
                        <div class="expertise-card">
                            <div class="expertise-header">
                                <span class="expertise-id">#TE-<%= te.getId() %></span>
                                <span class="status-badge <%= "EN_ATTENTE".equals(te.getStatut()) ? "status-en-attente" : "status-terminee" %>">
                                    <%= te.getStatut() %>
                                </span>
                            </div>

                            <div class="expertise-info">
                                <div class="info-label">Consultation</div>
                                <div class="info-value">
                                    <% if (te.getConsultation() != null) { %>
                                        Consultation #<%= te.getConsultation().getId() %>
                                        <% if (te.getConsultation().getSignesVitaux() != null &&
                                               te.getConsultation().getSignesVitaux().getPatient() != null) { %>
                                            - <%= te.getConsultation().getSignesVitaux().getPatient().getNom() %>
                                            <%= te.getConsultation().getSignesVitaux().getPatient().getPrenom() %>
                                        <% } %>
                                    <% } else { %>
                                        Non spécifiée
                                    <% } %>
                                </div>
                            </div>

                            <div class="expertise-info">
                                <div class="info-label">Question</div>
                                <div class="question-text">
                                    <%= te.getQuestion() != null ? te.getQuestion() : "Aucune question" %>
                                </div>
                            </div>

                            <% if (te.getDateDemande() != null) { %>
                                <div class="date-info">
                                    📅 Demandée le <%= te.getDateDemande() %>
                                </div>
                            <% } %>

                            <div class="expertise-actions">
                                <% if ("EN_ATTENTE".equals(te.getStatut())) { %>
                                    <a href="${pageContext.request.contextPath}/consultationPage?consultationId=<%= te.getConsultation().getId() %>" class="btn btn-primary">
                                        Répondre
                                    </a>
                                <% } else { %>
                                    <a href="${pageContext.request.contextPath}/consultationPage?consultationId=<%= te.getConsultation().getId() %>" class="btn btn-secondary">
                                        Voir détails
                                    </a>
                                <% } %>
                            </div>
                        </div>
                    <% } %>
                </div>
            <% } else { %>
                <div class="no-data">
                    Aucune télé-expertise assignée
                </div>
            <% } %>
        </div>
    </div>
</body>
</html>