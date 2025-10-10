<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Tableau de bord - Infirmier</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            margin: 40px;
        }
        h2 { color: #333; }
        form {
            background: #fff;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 10px;
            box-shadow: 0 0 5px rgba(0,0,0,0.1);
            width: 400px;
        }
        input, select {
            width: 100%;
            padding: 8px;
            margin-top: 6px;
            margin-bottom: 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
        }
        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px;
            border-radius: 6px;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
        .logout {
            margin-top: 20px;
        }
    </style>
</head>
<body>

<h2>Bienvenue Infirmier ${sessionScope.user.fullname}</h2>
<p>Connecté en tant que: ${sessionScope.user.role}</p>

<!-- ✅ Formulaire pour ajouter un patient -->
<form action="${pageContext.request.contextPath}/patients/add" method="post">
    <h3>Ajouter un patient</h3>
    <label>Nom complet :</label>
    <input type="text" name="fullname" required>

    <label>Date de naissance :</label>
    <input type="date" name="birthdate" required>

    <label>Genre :</label>
    <select name="gender">
        <option value="M">Homme</option>
        <option value="F">Femme</option>
    </select>

    <button type="submit">Ajouter</button>
</form>

<!-- ✅ Formulaire pour ajouter les signes vitaux -->
<form action="${pageContext.request.contextPath}/signvitals/add" method="post">
    <h3>Ajouter des signes vitaux</h3>

    <label>ID du patient :</label>
    <input type="number" name="patient_id" required>

    <label>Température (°C):</label>
    <input type="text" name="temperature" required>

    <label>Tension artérielle (mmHg):</label>
    <input type="text" name="blood_pressure" required>

    <label>Fréquence cardiaque (bpm):</label>
    <input type="text" name="heart_rate" required>

    <label>Utilisé pour consultation :</label>
    <select name="utilisePourConsultation">
        <option value="true">Oui</option>
        <option value="false">Non</option>
    </select>

    <button type="submit">Enregistrer</button>
</form>

<!-- ✅ Bouton de déconnexion -->
<div class="logout">
    <a href="${pageContext.request.contextPath}/logout">Se déconnecter</a>
</div>

</body>
</html>
