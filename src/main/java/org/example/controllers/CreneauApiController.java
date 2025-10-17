package org.example.controllers;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.hibernate6.Hibernate6Module;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import com.fasterxml.jackson.databind.SerializationFeature;
import jakarta.persistence.EntityManagerFactory;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.entities.Creneau;
import org.example.entities.User;
import org.example.services.CreneauService;
import org.example.services.UserService;
import org.example.util.LL;

import java.io.IOException;
import java.util.List;

@WebServlet("/creneauApi")
public class CreneauApiController extends HttpServlet {

    private EntityManagerFactory emf;
    private UserService ur;

    @Override
    public void init() throws ServletException {

        ur = new UserService(getServletContext());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userIdParam = request.getParameter("userId");

        if (userIdParam == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing userId parameter");
            return;
        }

        try {
            Long userId = Long.parseLong(userIdParam);


            List<Creneau> res=ur.getUser(userId);



            LL.to("1 json");




            ObjectMapper mapper = new ObjectMapper();
            mapper.registerModule(new JavaTimeModule());
            mapper.registerModule(new Hibernate6Module());
            mapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);

            LL.to("2 json");

            String json = mapper.writeValueAsString(res);
            LL.to("3 json");

            LL.to(json);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            LL.to("4 json");

            response.getWriter().write(json);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid userId");
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error retrieving creneaux");
            e.printStackTrace();
        }
    }
}
