package org.example.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.entities.ActeTechnique;
import org.example.entities.Consultation;
import org.example.repositories.ActeTechniqueRepository;
import org.example.repositories.ConsultationRepository;

import java.io.IOException;

@WebServlet("/consultationPage")
public class ConsultationController extends HttpServlet {

    private ConsultationRepository consultationRepo;

    @Override
    public void init() throws ServletException {
        consultationRepo = new ConsultationRepository(getServletContext());

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("consultationId");
        if (idParam == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing consultationId");
            return;
        }

        try {
            Long consultationId = Long.parseLong(idParam);
            Consultation consultation = consultationRepo.findById(consultationId);
            if (consultation == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Consultation not found");
                return;
            }



            request.setAttribute("consultation", consultation);
            request.getRequestDispatcher("/WEB-INF/views/consultation.jsp")
                    .forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid consultationId");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String consultationIdParam = request.getParameter("consultationId");
        String action = request.getParameter("action");

        if (consultationIdParam == null || action == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing parameters");
            return;
        }

        try {
            Long consultationId = Long.parseLong(consultationIdParam);
            Consultation consultation = consultationRepo.findById(consultationId);

            if (consultation == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Consultation not found");
                return;
            }

            if ("done".equals(action)) {
                double total = consultation.getCout() != null ? consultation.getCout() : 0.0;
                if (consultation.getActes() != null) {
                    for (ActeTechnique acte : consultation.getActes()) {
                        total += acte.getCout() != null ? acte.getCout() : 0.0;
                    }
                }
                consultation.setCout(total);
                consultation.setStatus(Consultation.TypeStatus.DONE);

            } else if ("extend".equals(action)) {
                consultation.setStatus(Consultation.TypeStatus.AWAITING_TELE_EXPERTISE);
            }

            consultationRepo.save(consultation);
            response.sendRedirect(request.getContextPath() + "/consultationPage?consultationId=" + consultation.getId());

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid consultationId");
        }
    }
}
