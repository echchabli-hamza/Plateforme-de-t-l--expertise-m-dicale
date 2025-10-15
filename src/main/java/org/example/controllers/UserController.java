package org.example.controllers;


import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.example.UserDTO;
import org.example.entities.SpecialistProfile;
import org.example.entities.User;
import org.example.services.UserService;
import com.google.gson.Gson;
import org.example.util.LL;

///

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;

import com.fasterxml.jackson.datatype.hibernate6.Hibernate6Module;

import com.fasterxml.jackson.databind.SerializationFeature;


///

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;


@WebServlet("/api/special")
public class UserController extends HttpServlet{


    private UserService es ;




    @Override
    public void init() throws  ServletException{
             es = new UserService(getServletContext());


    }


    @Override
    public void doGet(HttpServletRequest request , HttpServletResponse response )
         throws  IOException{


        String Nrole = request.getParameter("role");

        double tarif =Double.parseDouble( request.getParameter("tarif"));

        LocalDateTime t = LocalDateTime.now();
        LL.to(t.toString());
        LL.to(request.getParameter("tarif"));


        List<User> lu= es.getSp(Nrole , tarif);


        ObjectMapper mapper = new ObjectMapper();
        mapper.registerModule(new JavaTimeModule());
        mapper.registerModule(new Hibernate6Module());
        mapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);


        String json = mapper.writeValueAsString(lu);

        response.setContentType("application/json");
        response.getWriter().write(json);






    }




}
