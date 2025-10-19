<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.entities.Patient" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des patients</title>
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

        .header p {
            font-size: 16px;
            opacity: 0.95;
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

        .form-card {
            background: white;
            border-radius: 20px;
            padding: 40px;
            margin-bottom: 40px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            animation: slideUp 0.6s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
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

        .form-card h2 {
            color: #333;
            font-size: 24px;
            margin-bottom: 30px;
            text-align: center;
            font-weight: 600;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group label {
            font-size: 13px;
            font-weight: 500;
            color: #555;
            margin-bottom: 6px;
        }

        input, select {
            padding: 12px 16px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 15px;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }

        input:focus, select:focus {
            outline: none;
            border-color: #667eea;
            background: white;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
        }

        input:hover, select:hover {
            border-color: #c0c0c0;
        }

        .section-title {
            grid-column: 1 / -1;
            font-size: 16px;
            font-weight: 600;
            color: #667eea;
            margin-top: 10px;
            padding-bottom: 10px;
            border-bottom: 2px solid #e0e0e0;
        }

        button[type="submit"] {
            width: 100%;
            padding: 16px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
            margin-top: 10px;
        }

        button[type="submit"]:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.6);
        }

        button[type="submit"]:active {
            transform: translateY(0);
        }

        .success-message {
            background: #d4edda;
            border-left: 4px solid #28a745;
            color: #155724;
            padding: 16px 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            font-size: 15px;
            text-align: center;
            animation: slideDown 0.5s ease-out;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .table-card {
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            animation: slideUp 0.8s ease-out;
            overflow-x: auto;
        }

        .table-card h2 {
            color: #333;
            font-size: 24px;
            margin-bottom: 30px;
            text-align: center;
            font-weight: 600;
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
            font-size: 14px;
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

        @media (max-width: 768px) {
            .header h1 {
                font-size: 28px;
            }

            .form-card, .table-card {
                padding: 24px;
                border-radius: 15px;
            }

            .form-grid {
                grid-template-columns: 1fr;
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
        }
    </style>
</head>
<body>
    <a href="${pageContext.request.contextPath}/logout" class="logout-btn">Se déconnecter</a>

    <div class="container">
        <div class="header">
            <h1>Gestion des Patients</h1>
            <p>Système de gestion des dossiers médicaux</p>
        </div>

        <div class="form-card">
            <h2>➕ Ajouter un nouveau patient</h2>

            <% if (request.getAttribute("message") != null) { %>
                <div class="success-message">
                    <%= request.getAttribute("message") %>
                </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/patient" method="post">
                <div class="form-grid">
                    <div class="section-title">Informations personnelles</div>

                    <div class="form-group">
                        <label for="cne">CNE</label>
                        <input type="text" id="cne" name="cne" placeholder="Code National Étudiant" required>
                    </div>

                    <div class="form-group">
                        <label for="prenom">Prénom</label>
                        <input type="text" id="prenom" name="prenom" placeholder="Prénom du patient" required>
                    </div>

                    <div class="form-group">
                        <label for="nom">Nom</label>
                        <input type="text" id="nom" name="nom" placeholder="Nom de famille" required>
                    </div>

                    <div class="form-group">
                        <label for="dateNaissance">Date de naissance</label>
                        <input type="date" id="dateNaissance" name="dateNaissance" required>
                    </div>

                    <div class="form-group">
                        <label for="numeroSS">Numéro de Sécurité Sociale</label>
                        <input type="text" id="numeroSS" name="numeroSS" placeholder="N° Sécurité Sociale" required>
                    </div>

                    <div class="form-group">
                        <label for="telephone">Téléphone</label>
                        <input type="text" id="telephone" name="telephone" placeholder="06 XX XX XX XX" required>
                    </div>

                    <div class="form-group" style="grid-column: 1 / -1;">
                        <label for="adresse">Adresse</label>
                        <input type="text" id="adresse" name="adresse" placeholder="Adresse complète" required>
                    </div>

                    <div class="section-title">Signes vitaux</div>

                    <div class="form-group">
                        <label for="tension">Tension artérielle (mmHg)</label>
                        <input type="number" id="tension" name="tension" step="0.1" placeholder="120/80" required>
                    </div>

                    <div class="form-group">
                        <label for="frequenceCardiaque">Fréquence cardiaque (bpm)</label>
                        <input type="number" id="frequenceCardiaque" name="frequenceCardiaque" placeholder="70" required>
                    </div>

                    <div class="form-group">
                        <label for="frequenceRespiratoire">Fréquence respiratoire</label>
                        <input type="number" id="frequenceRespiratoire" name="frequenceRespiratoire" placeholder="16" required>
                    </div>

                    <div class="form-group">
                        <label for="temperature">Température (°C)</label>
                        <input type="number" id="temperature" name="temperature" step="0.1" placeholder="37.0" required>
                    </div>

                    <div class="form-group">
                        <label for="poids">Poids (kg)</label>
                        <input type="number" id="poids" name="poids" step="0.1" placeholder="70.5">
                    </div>

                    <div class="form-group">
                        <label for="taille">Taille (cm)</label>
                        <input type="number" id="taille" name="taille" step="0.1" placeholder="175">
                    </div>
                </div>

                <button type="submit">Ajouter le patient</button>
            </form>
        </div>

        <div class="table-card">
            <h2>📋 Liste des patients</h2>

            <%
                List<Patient> patients = (List<Patient>) request.getAttribute("patients");
                if (patients != null && !patients.isEmpty()) {
            %>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Prénom</th>
                        <th>Nom</th>
                        <th>Date de naissance</th>
                        <th>Téléphone</th>
                        <th>Adresse</th>
                    </tr>
                </thead>
                <tbody>
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
                </tbody>
            </table>
            <% } else { %>
            <div class="no-data">
                Aucun patient trouvé dans la base de données
            </div>
            <% } %>
        </div>
    </div>
</body>
</html>