package org.example.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.entities.Consultation;
import org.example.entities.SignesVitaux;
import org.example.entities.User;
import org.example.repositories.ConsultationRepository;
import org.example.repositories.SignesVitauxRepository;

import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet("/createConsultation")
public class HandleConsultationController extends HttpServlet {

    private ConsultationRepository consultationRepo;
    private SignesVitauxRepository signesVitauxRepo;

    @Override
    public void init() throws ServletException {
        consultationRepo = new ConsultationRepository(getServletContext());
        signesVitauxRepo = new SignesVitauxRepository(getServletContext());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String signesVitauxIdParam = request.getParameter("signesVitauxId");
        if (signesVitauxIdParam == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing signesVitauxId");
            return;
        }

        try {
            Long signesVitauxId = Long.parseLong(signesVitauxIdParam);
            SignesVitaux signesVitaux = signesVitauxRepo.findById(signesVitauxId);

            SignesVitaux s = signesVitauxRepo.findById(signesVitauxId);
            s.setUtilisePourConsultation(true);
            signesVitauxRepo.save(s);

            if (signesVitaux == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Signes vitaux not found");
                return;
            }
            HttpSession session = request.getSession(false);

            User generaliste = (User) session.getAttribute("user");

            Consultation consultation = new Consultation();
            consultation.setSignesVitaux(signesVitaux);
            consultation.setGeneraliste(generaliste);
            consultation.setDateConsultation(LocalDateTime.now());
            consultation.setStatus(Consultation.TypeStatus.IN_PROGRESS);

            consultationRepo.save(consultation);

            response.sendRedirect(request.getContextPath() + "/consultationPage?consultationId=" + consultation.getId());

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid signesVitauxId");
        }
    }
}
