<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.entities.TeleExpertise" %>
<%@ page import="org.example.entities.SignesVitaux" %>
<%@ page import="org.example.entities.Consultation" %>
<%@ page import="org.example.entities.Patient" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.entities.ActeTechnique" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Télé-Expertise</title>
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
            background: white;
            border-radius: 20px;
            padding: 30px 40px;
            margin-bottom: 30px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            animation: slideDown 0.6s ease-out;
            display: flex;
            justify-content: space-between;
            align-items: center;
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

        .header h1 {
            color: #333;
            font-size: 28px;
            font-weight: 600;
        }

        .status-badge {
            padding: 10px 20px;
            border-radius: 20px;
            font-size: 13px;
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

        .main-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
            margin-bottom: 30px;
        }

        .card {
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            animation: slideUp 0.6s ease-out;
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

        .card:nth-child(2) {
            animation-delay: 0.1s;
        }

        .card h2 {
            color: #333;
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #f0f0f0;
            display: flex;
            align-items: center;
        }

        .info-row {
            display: flex;
            padding: 12px 0;
            border-bottom: 1px solid #f0f0f0;
        }

        .info-row:last-child {
            border-bottom: none;
        }

        .info-label {
            font-weight: 600;
            color: #666;
            min-width: 180px;
        }

        .info-value {
            color: #333;
            flex: 1;
        }

        .full-width-card {
            grid-column: 1 / -1;
        }

        .table-wrapper {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin: 20px 0;
        }

        th {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 14px;
            text-align: left;
            font-weight: 600;
            font-size: 13px;
            text-transform: uppercase;
        }

        th:first-child {
            border-top-left-radius: 10px;
        }

        th:last-child {
            border-top-right-radius: 10px;
        }

        td {
            padding: 14px;
            border-bottom: 1px solid #e0e0e0;
            color: #333;
            font-size: 14px;
        }

        tr:hover td {
            background: #f8f9fa;
        }

        tr:last-child td {
            border-bottom: none;
        }

        .question-section {
            background: #fff3cd;
            padding: 25px;
            border-radius: 15px;
            margin: 20px 0;
            border-left: 4px solid #ffc107;
        }

        .question-section h3 {
            color: #856404;
            font-size: 18px;
            margin-bottom: 15px;
            font-weight: 600;
        }

        .question-text {
            color: #333;
            font-size: 15px;
            line-height: 1.6;
        }

        .response-section {
            background: #f8f9fa;
            padding: 25px;
            border-radius: 15px;
            margin: 20px 0;
        }

        .response-section h3 {
            color: #333;
            font-size: 18px;
            margin-bottom: 20px;
            font-weight: 600;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-size: 14px;
            font-weight: 600;
            color: #555;
            margin-bottom: 8px;
        }

        textarea, input {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 15px;
            transition: all 0.3s ease;
            background: white;
            font-family: inherit;
        }

        textarea {
            min-height: 120px;
            resize: vertical;
        }

        textarea:focus, input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
        }

        .btn {
            padding: 14px 28px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.6);
        }

        .btn:active {
            transform: translateY(0);
        }

        .btn-success {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
        }

        .btn-block {
            width: 100%;
            margin-top: 10px;
        }

        .back-link {
            display: inline-block;
            padding: 12px 24px;
            background: #f0f0f0;
            color: #333;
            text-decoration: none;
            border-radius: 10px;
            font-weight: 500;
            transition: all 0.3s ease;
            margin-bottom: 20px;
        }

        .back-link:hover {
            background: #e0e0e0;
            transform: translateY(-2px);
        }

        .existing-response {
            background: #d4edda;
            padding: 20px;
            border-radius: 10px;
            border-left: 4px solid #28a745;
            margin: 20px 0;
        }

        .existing-response h4 {
            color: #155724;
            font-size: 16px;
            margin-bottom: 10px;
        }

        .existing-response p {
            color: #333;
            line-height: 1.6;
            margin-bottom: 10px;
        }

        .readonly-section {
            background: #e9ecef;
            padding: 20px;
            border-radius: 10px;
            margin: 20px 0;
        }

        @media (max-width: 1024px) {
            .main-grid {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .header {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }

            .card {
                padding: 20px;
            }

            .info-row {
                flex-direction: column;
            }

            .info-label {
                margin-bottom: 5px;
            }
        }
    </style>
</head>
<body>
    <%
        TeleExpertise teleExpertise = (TeleExpertise) request.getAttribute("teleExpertise");
        Consultation consultation = teleExpertise != null ? teleExpertise.getConsultation() : null;
        SignesVitaux sv = consultation != null ? consultation.getSignesVitaux() : null;
        Patient patient = sv != null ? sv.getPatient() : null;
        boolean isCompleted = "TERMINEE".equals(teleExpertise.getStatut().name());
    %>

    <div class="container">
        <a href="${pageContext.request.contextPath}/speDash?view=main" class="back-link">← Retour au workspace</a>

        <div class="header">
            <h1>🌐 Télé-Expertise #<%= teleExpertise.getId() %></h1>
            <span class="status-badge <%= isCompleted ? "status-terminee" : "status-en-attente" %>">
                <%= teleExpertise.getStatut() %>
            </span>
        </div>

        <div class="main-grid">
            <div class="card">
                <h2>👨‍⚕️ Généraliste demandeur</h2>
                <% if (consultation != null && consultation.getGeneraliste() != null) { %>
                    <div class="info-row">
                        <span class="info-label">Username:</span>
                        <span class="info-value"><%= consultation.getGeneraliste().getUsername() %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Consultation:</span>
                        <span class="info-value">#<%= consultation.getId() %></span>
                    </div>
                <% } %>
            </div>

            <div class="card">
                <h2>👤 Patient</h2>
                <% if (patient != null) { %>
                    <div class="info-row">
                        <span class="info-label">Nom:</span>
                        <span class="info-value"><%= patient.getNom() %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Prénom:</span>
                        <span class="info-value"><%= patient.getPrenom() %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">CNE:</span>
                        <span class="info-value"><%= patient.getCne() %></span>
                    </div>
                    <div class="info-row">
                        <span class="info-label">Date de naissance:</span>
                        <span class="info-value"><%= patient.getDateNaissance() %></span>
                    </div>
                <% } %>
            </div>

            <div class="card full-width-card">
                <h2>💓 Signes Vitaux</h2>
                <% if (sv != null) { %>
                <div class="table-wrapper">
                    <table>
                        <thead>
                            <tr>
                                <th>Tension</th>
                                <th>Fréq. Cardiaque</th>
                                <th>Fréq. Respiratoire</th>
                                <th>Température</th>
                                <th>Poids</th>
                                <th>Taille</th>
                                <th>Date Mesure</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><%= sv.getTension() %> mmHg</td>
                                <td><%= sv.getFrequenceCardiaque() %> bpm</td>
                                <td><%= sv.getFrequenceRespiratoire() %></td>
                                <td><%= sv.getTemperature() %> °C</td>
                                <td><%= sv.getPoids() != null ? sv.getPoids() + " kg" : "N/A" %></td>
                                <td><%= sv.getTaille() != null ? sv.getTaille() + " cm" : "N/A" %></td>
                                <td><%= sv.getDateMesure() %></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <% } %>
            </div>

            <%
                List<ActeTechnique> actes = consultation != null ? consultation.getActes() : null;
                if (actes != null && !actes.isEmpty()) {
            %>
            <div class="card full-width-card">
                <h2>🔬 Actes Techniques Réalisés</h2>
                <div class="table-wrapper">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nom de l'acte</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (ActeTechnique acte : actes) { %>
                            <tr>
                                <td><%= acte.getId() %></td>
                                <td><%= acte.getNom() %></td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
            <% } %>

            <div class="card full-width-card">
                <h2>❓ Question du Généraliste</h2>
                <div class="question-section">
                    <h3>Question posée:</h3>
                    <p class="question-text">
                        <%= teleExpertise.getQuestion() != null ? teleExpertise.getQuestion() : "Aucune question spécifiée" %>
                    </p>
                </div>
                <% if (teleExpertise.getDateDemande() != null) { %>
                    <p style="color: #888; font-size: 13px; margin-top: 10px;">
                        📅 Demande créée le: <%= teleExpertise.getDateDemande() %>
                    </p>
                <% } %>
            </div>


            <div class="card full-width-card">
                <h2>📝 Réponse du Spécialiste</h2>

                <% if (isCompleted) { %>
                    <div class="existing-response">
                        <h4>✅ Avis médical fourni:</h4>

                        <% if (teleExpertise.getRecommandations() != null && !teleExpertise.getRecommandations().isEmpty()) { %>
                            <p><strong>Recommandations:</strong><br><%= teleExpertise.getRecommandations() %></p>
                        <% } %>
                    </div>
                    <p style="color: #28a745; font-weight: 600; text-align: center; margin-top: 20px;">
                        Cette télé-expertise a été complétée avec succès.
                    </p>
                <% } else { %>
                    <div class="response-section">
                        <h3>Fournir votre expertise médicale</h3>
                        <form method="post" action="${pageContext.request.contextPath}/teleExpertise?_method=PUT">
                            <input type="hidden" name="teleExpertiseId" value="<%= teleExpertise.getId() %>">

                              <input type="hidden" name="_method" value="PUT">

                            <div class="form-group">
                                <label for="recommandations">Recommandations</label>
                                <textarea id="recommandations" name="recommandations" placeholder="Recommandations et plan de traitement suggérés..."></textarea>
                            </div>

                            <button type="submit" class="btn btn-success btn-block">
                                ✓ Soumettre l'expertise
                            </button>
                        </form>
                    </div>
                <% } %>
            </div>
        </div>
    </div>
</body>
</html>