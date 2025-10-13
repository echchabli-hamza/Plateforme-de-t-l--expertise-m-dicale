package org.example.controllers;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.entities.Patient;
import org.example.services.PatientService;

import java.io.IOException;
import java.util.List;

@WebServlet("/infermierDash")
public class InfermierDash extends HttpServlet {
    private PatientService patientService;


    @Override
    public void init() throws ServletException {
        patientService = new PatientService(getServletContext());
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        List<Patient> pl = patientService.findToday();
        request.setAttribute("patients", pl);
        request.getRequestDispatcher("/WEB-INF/views/infDash.jsp").forward(request, response);
    }
}
