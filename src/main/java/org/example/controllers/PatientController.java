package org.example.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.entities.Patient;
import org.example.services.PatientService;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@WebServlet("/patient")
public class PatientController extends HttpServlet {

    private PatientService patientService;

    @Override
    public void init() throws ServletException {
        patientService = new PatientService(getServletContext());
    }

//    @Override
//    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
//            throws ServletException, IOException {
//        List<Patient> pl = patientService.getPatientsWaiting();
//        req.setAttribute("patients", pl);
//
//        req.getRequestDispatcher("/WEB-INF/views/infDash.jsp").forward(req, resp);
//    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            String prenom = req.getParameter("prenom");
            String nom = req.getParameter("nom");
            LocalDate dateNaissance = LocalDate.parse(req.getParameter("dateNaissance"));
            String numeroSS = req.getParameter("numeroSS");
            String telephone = req.getParameter("telephone");
            String adresse = req.getParameter("adresse");
            String cne = req.getParameter("cne");;

           Optional<Patient> patientRes = patientService.findByCne(cne);

            Patient patient ;
            if (patientRes.isPresent()) {

                patient = patientRes.get();

                if (!patient.getActiveSignesVitaux().isEmpty()){
                    req.getSession().setAttribute("message", "Ce patient est déjà dans la file d'attente !");
                    resp.sendRedirect(req.getContextPath() + "/infermierDash");
                    return;
                }


            }
            else {
                patient = patientService.addPatient(prenom, nom, dateNaissance, numeroSS, telephone, adresse , cne);
            }






            Long patientId = patient.getId();
            Double tension = Double.parseDouble(req.getParameter("tension"));
            Integer frequenceCardiaque = Integer.parseInt(req.getParameter("frequenceCardiaque"));
            Integer frequenceRespiratoire = Integer.parseInt(req.getParameter("frequenceRespiratoire"));
            Double temperature = Double.parseDouble(req.getParameter("temperature"));
            Double poids = req.getParameter("poids").isEmpty() ? null : Double.parseDouble(req.getParameter("poids"));
            Double taille = req.getParameter("taille").isEmpty() ? null : Double.parseDouble(req.getParameter("taille"));

            patientService.addSignesVitaux(patientId, tension, frequenceCardiaque,
                    frequenceRespiratoire, temperature, poids,
                    taille , false);

            req.setAttribute("message", " Patient et signes vitaux ajoutés avec succès !");

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("message", " Erreur : " + e.getMessage());
        }

        resp.sendRedirect(req.getContextPath() + "/infermierDash");

    }



}
