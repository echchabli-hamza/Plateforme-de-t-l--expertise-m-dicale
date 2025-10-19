package org.example.controllers;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.entities.Creneau;
import org.example.entities.SpecialistProfile;
import org.example.entities.TeleExpertise;
import org.example.entities.User;
import org.example.services.CreneauService;
import org.hibernate.Session;

import java.io.IOException;
import java.util.List;


@WebServlet("/speDash")
public class SpecialisteDash extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }




        User user = (User) session.getAttribute("user");
        EntityManagerFactory emf = (EntityManagerFactory) getServletContext().getAttribute("emf");






        String view = request.getParameter("view");

        if ("main".equals(view)) {

            List<TeleExpertise> teleExpertises = user.getTeleExpertises();
            request.setAttribute("teleExpertises", teleExpertises);
            request.getRequestDispatcher("/WEB-INF/views/speMain.jsp").forward(request, response);

        } else {
            CreneauService creneauService = new CreneauService(emf);

            List<Creneau> ss = creneauService.getCreneauxForNextWeek(user.getId());
             request.setAttribute("listC" , ss );
            request.getRequestDispatcher("/WEB-INF/views/specialisteDash.jsp").forward(request, response);
        }
    }
}
