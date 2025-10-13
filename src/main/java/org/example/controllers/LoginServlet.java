package org.example.controllers;

import org.example.entities.User;
import org.example.repositories.UserRepository;
import org.example.services.AuthenticationService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private  AuthenticationService authService ;

    @Override
    public void init() throws ServletException {

        UserRepository userRepo = new UserRepository(getServletContext());
        authService = new AuthenticationService(userRepo);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            resp.sendRedirect(req.getContextPath() + session.getAttribute("dash"));
            return;
        }


        req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String password = req.getParameter("password");
        String username = req.getParameter("username");


        User user = authService.login(username, password);



        if (user == null) {

            req.setAttribute("error", "Nom d'utilisateur ou mot de passe incorrect");
            req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);

        } else if(user.getRole().name().equals("INFIRMIER")) {
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            session.setAttribute("dash", "/infermierDash");





            resp.sendRedirect(req.getContextPath() + "/infermierDash");
        }
        else if(user.getRole().name().equals("SPECIALISTE")) {
            HttpSession session = req.getSession();session.setAttribute("dash", "/speDash");
            session.setAttribute("user", user);
            resp.sendRedirect(req.getContextPath() + "/speDash"); // Redirection après login
        }
        else if(user.getRole().name().equals("GENERALISTE")) {
            HttpSession session = req.getSession(); session.setAttribute("dash", "/geneDash");
            session.setAttribute("user", user);
            resp.sendRedirect(req.getContextPath() + "/geneDash"); // Redirection après login
        }


    }
}
