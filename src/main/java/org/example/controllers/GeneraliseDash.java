package org.example.controllers;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.entities.SignesVitaux;
import org.example.entities.User;
import org.example.services.ConsultationService;
import org.example.services.PatientService;
import org.example.services.SignesVitauxService;

import java.io.IOException;

@WebServlet("/geneDash")
public class GeneraliseDash extends HttpServlet {

    private PatientService patientService;
    private ConsultationService cs ;
    private SignesVitauxService ss ;

    @Override
    public void init() throws ServletException {
        patientService = new PatientService(getServletContext());
        cs =  new ConsultationService(getServletContext());
        ss = new SignesVitauxService(getServletContext());


    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

//        HttpSession session = request.getSession(false);
//        if (session == null || session.getAttribute("user") == null) {
//            response.sendRedirect(request.getContextPath() + "/login");
//            return;
//        }



        request.setAttribute("unusedSignes", ss.getUnusedSignesVitaux());
        request.setAttribute("activeConsultations", cs.getActiveC());


        request.getRequestDispatcher("/WEB-INF/views/generalDash.jsp").forward(request, response);
    }
}
