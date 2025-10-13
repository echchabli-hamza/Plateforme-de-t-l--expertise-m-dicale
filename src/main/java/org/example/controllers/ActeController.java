package org.example.controllers;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.example.entities.ActeTechnique;
import org.example.entities.Consultation;
import org.example.repositories.ActeTechniqueRepository;
import org.example.repositories.ConsultationRepository;

@WebServlet("/addActeTechnique")
public class ActeController extends HttpServlet {

    private ActeTechniqueRepository acteRepo;
    private ConsultationRepository consultationRepo;

    @Override
    public void init() throws ServletException {
        ServletContext context = getServletContext();
        acteRepo = new ActeTechniqueRepository(context);
        consultationRepo = new ConsultationRepository(context);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, java.io.IOException {

        try {
            Long consultationId = Long.parseLong(request.getParameter("consultationId"));
            String acteName = request.getParameter("acte");

            if (acteName == null || acteName.trim().isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Nom de l’acte manquant.");
                return;
            }

            Consultation consultation = consultationRepo.findById(consultationId);
            if (consultation == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Consultation non trouvée.");
                return;
            }

            ActeTechnique acte = new ActeTechnique();
            acte.setNom(acteName);
            acte.setConsultation(consultation);
            acte.setCout(100.0);
            acteRepo.save(acte);


            response.sendRedirect(request.getContextPath() + "/consultationPage?consultationId=" + consultationId);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Erreur lors de l’ajout de l’acte technique.");
        }
    }
}
