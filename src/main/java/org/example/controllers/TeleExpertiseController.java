package org.example.controllers;


import jakarta.persistence.EntityManagerFactory;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.entities.*;
import org.example.repositories.ConsultationRepository;
import org.example.repositories.TeleExpertiseRepository;
import org.example.services.CreneauService;
import org.example.util.LL;

import java.io.IOException;
import java.time.LocalDateTime;

@WebServlet("/teleExpertise")
public class TeleExpertiseController extends HttpServlet {
    ConsultationRepository cr ;
    TeleExpertiseRepository te ;
    CreneauService creneau;


    @Override
    public void init() throws ServletException {
        cr = new ConsultationRepository(getServletContext());
        te = new TeleExpertiseRepository(getServletContext());
        creneau = new CreneauService((EntityManagerFactory) getServletContext().getAttribute("emf"));
    }



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {




    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String consultationIdParam = request.getParameter("consultationId");
        String creneauIdParam = request.getParameter("creneauId");

        Long c= Long.parseLong(consultationIdParam);
        Long r= Long.parseLong(creneauIdParam);

        LL.to(consultationIdParam + "\n");

        LL.to(creneauIdParam + "\n");

        Consultation cRes = cr.findById(c);

        cRes.setStatus(Consultation.TypeStatus.AWAITING_TELE_EXPERTISE);

        cr.update(cRes);

        Creneau cc =  creneau.findById(r);

        LL.to(cc.toString());

        LL.to(cc.getDisponible().toString());
        cc.setDisponible(false);
        LL.to(cc.getDisponible().toString());

        creneau.update(cc);



        TeleExpertise tt = new TeleExpertise(null,"efaerfer" , null , TeleExpertise.Statut.EN_ATTENTE , LocalDateTime.now() , cRes , cc.getSpecialist());


        te.saveIfNotExists(tt);




        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        String jsonResponse = "{\"status\":\"ok\",\"consultationId\":\"" + consultationIdParam + "\",\"creneauId\":\"" + creneauIdParam + "\"}";
        response.getWriter().write(jsonResponse);
    }




    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
}
