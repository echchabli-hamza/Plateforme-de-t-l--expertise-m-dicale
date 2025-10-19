<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.entities.SignesVitaux" %>
<%@ page import="org.example.entities.Consultation" %>
<%@ page import="org.example.entities.User" %>
<%@ page import="org.example.entities.Patient" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.entities.ActeTechnique" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consultation</title>
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

        .status-active {
            background: #d4edda;
            color: #155724;
        }

        .status-done {
            background: #d1ecf1;
            color: #0c5460;
        }

        .status-awaiting {
            background: #fff3cd;
            color: #856404;
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

        .card h2::before {
            margin-right: 10px;
            font-size: 24px;
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

        .form-section {
            background: #f8f9fa;
            padding: 25px;
            border-radius: 15px;
            margin: 20px 0;
        }

        .form-section h3 {
            color: #333;
            font-size: 18px;
            margin-bottom: 20px;
            font-weight: 600;
        }

        .form-group {
            display: flex;
            gap: 15px;
            align-items: flex-end;
        }

        select, input {
            flex: 1;
            padding: 12px 16px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 15px;
            transition: all 0.3s ease;
            background: white;
        }

        select:focus, input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
        }

        .btn {
            padding: 12px 24px;
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

        .btn-warning {
            background: linear-gradient(135deg, #ffc107 0%, #ff9800 100%);
        }

        .actions-section {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .actions-section .btn {
            flex: 1;
        }

        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            backdrop-filter: blur(5px);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 1000;
            animation: fadeIn 0.3s ease-out;
        }

        .modal-content {
            background: white;
            padding: 40px;
            border-radius: 20px;
            text-align: center;
            max-width: 500px;
            box-shadow: 0 30px 80px rgba(0, 0, 0, 0.4);
            animation: scaleIn 0.3s ease-out;
        }

        @keyframes scaleIn {
            from {
                opacity: 0;
                transform: scale(0.9);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        .modal-content h2 {
            color: #333;
            font-size: 26px;
            margin-bottom: 20px;
        }

        .modal-content p {
            color: #666;
            font-size: 18px;
            margin-bottom: 30px;
        }

        .modal-content .total {
            font-size: 32px;
            color: #667eea;
            font-weight: 700;
            margin: 20px 0;
        }

        .tele-expertise-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            backdrop-filter: blur(5px);
            z-index: 1000;
            overflow-y: auto;
            padding: 20px;
        }

        .tele-expertise-modal.active {
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .tele-modal-content {
            background: white;
            border-radius: 20px;
            padding: 40px;
            max-width: 1200px;
            width: 100%;
            max-height: 90vh;
            overflow-y: auto;
            position: relative;
            box-shadow: 0 30px 80px rgba(0, 0, 0, 0.4);
        }

        .close-modal {
            position: absolute;
            top: 20px;
            right: 20px;
            background: #f0f0f0;
            border: none;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            font-size: 24px;
            cursor: pointer;
            transition: all 0.3s ease;
            color: #666;
        }

        .close-modal:hover {
            background: #e0e0e0;
            transform: rotate(90deg);
        }

        .search-container {
            display: flex;
            gap: 15px;
            margin: 30px 0;
        }

        .search-container select,
        .search-container input {
            flex: 1;
        }

        .results-container {
            margin-top: 30px;
        }

        .calendar-wrapper {
            overflow-x: auto;
            margin: 30px 0;
        }

        #calendar {
            min-width: 800px;
        }

        #calendar th {
            padding: 12px 8px;
            font-size: 12px;
        }

        #calendar td {
            padding: 8px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        #calendar td:hover {
            background: #e8edff;
        }

        #calendar td.selected {
            background: #667eea;
            color: white;
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

            .form-group {
                flex-direction: column;
                align-items: stretch;
            }

            .actions-section {
                flex-direction: column;
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
        Consultation consultation = (Consultation) request.getAttribute("consultation");
        User generaliste = consultation.getGeneraliste();
        SignesVitaux sv = consultation.getSignesVitaux();
        Patient patient = sv != null ? sv.getPatient() : null;
        boolean isDone = consultation.getStatus() != null && consultation.getStatus() == Consultation.TypeStatus.DONE;
    %>

    <div class="container">
        <div class="header">
            <h1>🏥 Consultation #<%= consultation.getId() %></h1>
            <span class="status-badge <%= isDone ? "status-done" : (consultation.getStatus() == Consultation.TypeStatus.AWAITING_TELE_EXPERTISE ? "status-awaiting" : "status-active") %>">
                <%= consultation.getStatus() %>
            </span>
        </div>

        <div class="main-grid">
            <div class="card">
                <h2 style="content: '👨‍⚕️';">👨‍⚕️ Généraliste</h2>
                <div class="info-row">
                    <span class="info-label">Username:</span>
                    <span class="info-value">HH</span>
                </div>
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
                <% } %>
            </div>

            <div class="card full-width-card">
                <h2>💓 Signes Vitaux</h2>
                <% if (sv != null) { %>
                <div class="table-wrapper">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
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
                                <td><%= sv.getId() %></td>
                                <td><%= sv.getTension() %> mmHg</td>
                                <td><%= sv.getFrequenceCardiaque() %> bpm</td>
                                <td><%= sv.getFrequenceRespiratoire() %></td>
                                <td><%= sv.getTemperature() %> °C</td>
                                <td><%= sv.getPoids() %> kg</td>
                                <td><%= sv.getTaille() %> cm</td>
                                <td><%= sv.getDateMesure() %></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <% } %>
            </div>

            <div class="card full-width-card">
                <h2>🔬 Actes Techniques</h2>

                <div class="form-section">
                    <h3>Ajouter un acte technique</h3>
                    <form method="post" action="${pageContext.request.contextPath}/addActeTechnique">
                        <input type="hidden" name="consultationId" value="<%= consultation.getId() %>">
                        <div class="form-group">
                            <select name="acte" required>
                                <option value="">-- Sélectionner un acte --</option>
                                <option value="Radiographie">Radiographie</option>
                                <option value="Échographie">Échographie</option>
                                <option value="IRM">IRM</option>
                                <option value="Électrocardiogramme">Électrocardiogramme</option>
                                <option value="Dermatologiques (Laser)">Dermatologiques (Laser)</option>
                                <option value="Fond d'œil">Fond d'œil</option>
                                <option value="Analyse de sang">Analyse de sang</option>
                                <option value="Analyse d'urine">Analyse d'urine</option>
                            </select>
                            <button type="submit" class="btn">Ajouter</button>
                        </div>
                    </form>
                </div>

                <%
                    List<ActeTechnique> actes = consultation.getActes();
                    if (actes != null && !actes.isEmpty()) {
                %>
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
                <% } %>
            </div>

            <div class="card full-width-card">
                <h2>⚙️ Actions</h2>
                <div class="actions-section">
                    <form method="post" action="${pageContext.request.contextPath}/consultationPage" style="flex: 1;">
                        <input type="hidden" name="consultationId" value="<%= consultation.getId() %>">
                        <button type="submit" name="action" value="done" class="btn btn-success">
                            ✓ Terminer la consultation
                        </button>
                    </form>

                    <% if (consultation.getStatus() != Consultation.TypeStatus.AWAITING_TELE_EXPERTISE) { %>
                        <button id="expert" type="button" class="btn btn-warning">
                            🌐 Étendre à Télé-Expertise
                        </button>
                    <% } %>
                </div>
            </div>
        </div>
    </div>

    <% if (isDone) { %>
    <div class="modal-overlay">
        <div class="modal-content">
            <h2>✅ Consultation terminée</h2>
            <div class="total"><%= consultation.getCout() %> DH</div>
            <p>Total à payer</p>
            <form method="get" action="<%= request.getContextPath() %>/geneDash">
                <button type="submit" class="btn">Retour au tableau de bord</button>
            </form>
        </div>
    </div>
    <% } %>

    <div id="tele" class="tele-expertise-modal">
        <div class="tele-modal-content">
            <button id="closeModal" class="close-modal">×</button>
            <h2>🔍 Recherche de Spécialistes</h2>

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
                <input type="number" id="amount" placeholder="Montant maximum" />
                <button id="filter-btn" class="btn">Filtrer</button>
            </div>

            <div id="specialistsResults" class="results-container"></div>

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
                    <button type="button" id="confirmButton" class="btn">Confirmer le rendez-vous</button>
                </form>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/consultation.js"></script>
    <script>
        // Modal toggle
        const expertBtn = document.getElementById('expert');
        const teleModal = document.getElementById('tele');
        const closeModalBtn = document.getElementById('closeModal');

        if (expertBtn) {
            expertBtn.addEventListener('click', () => {
                teleModal.classList.add('active');
            });
        }

        if (closeModalBtn) {
            closeModalBtn.addEventListener('click', () => {
                teleModal.classList.remove('active');
            });
        }

        // Close on outside click
        teleModal.addEventListener('click', (e) => {
            if (e.target === teleModal) {
                teleModal.classList.remove('active');
            }
        });
    </script>
</body>
</html>