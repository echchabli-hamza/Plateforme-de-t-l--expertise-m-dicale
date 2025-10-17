package org.example.controllers;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.entities.Creneau;
import org.example.entities.User;
import org.example.services.CreneauService;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/saveCreneau")
public class CreneauController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(CreneauController.class.getName());
    private EntityManagerFactory emf;
    private CreneauService creneauService;

    @Override
    public void init() throws ServletException {
        emf = (EntityManagerFactory) getServletContext().getAttribute("emf");
        creneauService = new CreneauService(emf);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String[] slots = request.getParameterValues("slots");
        String[] deleteSlots = request.getParameterValues("deleteSlots");
        User specialiste = (User) request.getSession().getAttribute("user");

        // Validation
        if (specialiste == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Check if at least one operation is requested
        if ((slots == null || slots.length == 0) && (deleteSlots == null || deleteSlots.length == 0)) {
            response.sendRedirect(request.getContextPath() + "/speDash?error=no_changes");
            return;
        }

        try {

            List<LocalDateTime> slotStarts = new ArrayList<>();
            if (slots != null) {
                DateTimeFormatter formatter = DateTimeFormatter.ISO_LOCAL_DATE_TIME;
                Set<String> processedSlots = new HashSet<>();

                for (String slot : slots) {
                    if (processedSlots.contains(slot)) {
                        continue;
                    }
                    processedSlots.add(slot);

                    try {
                        LocalDateTime debut = LocalDateTime.parse(slot, formatter);

                        if (debut.isBefore(LocalDateTime.now())) {
                            LOGGER.log(Level.WARNING, "Skipping past time slot: " + slot);
                            continue;
                        }

                        slotStarts.add(debut);

                    } catch (DateTimeParseException e) {
                        LOGGER.log(Level.WARNING, "Invalid date format for slot: " + slot, e);
                    }
                }
            }


            List<Long> deleteIds = new ArrayList<>();

            if (deleteSlots != null) {

                for (String deleteSlot : deleteSlots) {

                    try {

                        Long creneauId = Long.parseLong(deleteSlot);

                        deleteIds.add(creneauId);

                    } catch (NumberFormatException e) {

                        LOGGER.log(Level.WARNING, "Invalid creneau ID for deletion: " + deleteSlot, e);

                    }

                }

            }

            creneauService.updateCreneauxForWeek(specialiste, slotStarts, deleteIds);

            response.sendRedirect(request.getContextPath() + "/speDash?success=true");

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error updating creneaux", e);
            response.sendRedirect(request.getContextPath() + "/speDash?error=update_failed");
        }
    }



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/speDash");
    }
}