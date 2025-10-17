package org.example.services;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.PersistenceException;
import org.example.entities.Creneau;
import org.example.entities.User;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CreneauService {

    private static final Logger LOGGER = Logger.getLogger(CreneauService.class.getName());
    private final EntityManagerFactory emf;

    public CreneauService(EntityManagerFactory emf) {
        this.emf = emf;
    }


    public void updateCreneauxForWeek(User specialist, List<LocalDateTime> newSlotStarts, List<Long> deleteSlotIds) {
        EntityManager em = emf.createEntityManager();

        try {
            em.getTransaction().begin();

            // Delete slots that are marked for deletion
            if (deleteSlotIds != null && !deleteSlotIds.isEmpty()) {
                for (Long creneauId : deleteSlotIds) {
                    Creneau creneau = em.find(Creneau.class, creneauId);
                    if (creneau != null &&
                            creneau.getSpecialist().getId().equals(specialist.getId()) &&
                            creneau.getDisponible()) {
                        em.remove(creneau);
                        LOGGER.log(Level.INFO, "Deleted creneau: {0}", creneauId);
                    }
                }
            }

            // Add new slots
            if (newSlotStarts != null && !newSlotStarts.isEmpty()) {
                LocalDateTime weekStart = LocalDateTime.now().toLocalDate().atStartOfDay();
                LocalDateTime weekEnd = weekStart.plusDays(7);

                for (LocalDateTime debut : newSlotStarts) {
                    if (debut.isBefore(LocalDateTime.now())) {
                        continue;
                    }

                    // Check if slot already exists for this specialist in the current week
                    boolean slotExists = em.createQuery(
                                    "SELECT COUNT(c) FROM Creneau c WHERE c.specialist.id = :specialistId " +
                                            "AND c.debut = :debut AND c.debut >= :weekStart AND c.debut < :weekEnd",
                                    Long.class)
                            .setParameter("specialistId", specialist.getId())
                            .setParameter("debut", debut)
                            .setParameter("weekStart", weekStart)
                            .setParameter("weekEnd", weekEnd)
                            .getSingleResult() > 0;

                    if (!slotExists) {
                        try {
                            Creneau creneau = Creneau.builder()
                                    .debut(debut)
                                    .fin(debut.plusMinutes(30))
                                    .disponible(true)
                                    .specialist(specialist)
                                    .build();

                            em.persist(creneau);
                            LOGGER.log(Level.INFO, "Created new creneau: {0}", debut);

                        } catch (PersistenceException e) {
                            LOGGER.log(Level.INFO, "Duplicate time slot skipped: {0}", debut);
                        }
                    }
                }
            }

            em.getTransaction().commit();

        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            LOGGER.log(Level.SEVERE, "Error updating creneaux", e);
            throw new RuntimeException("Failed to update time slots", e);
        } finally {
            em.close();
        }
    }

    /**
     * Get all creneaux for specialist in the next 7 days
     */
    public List<Creneau> getCreneauxForNextWeek(Long specialistId) {
        EntityManager em = emf.createEntityManager();
        try {
            LocalDateTime weekStart = LocalDateTime.now().toLocalDate().atStartOfDay();
            LocalDateTime weekEnd = weekStart.plusDays(7);

            return em.createQuery(
                            "SELECT c FROM Creneau c WHERE c.specialist.id = :specialistId " +
                                    "AND c.debut >= :weekStart AND c.debut < :weekEnd " +
                                    "ORDER BY c.debut", Creneau.class)
                    .setParameter("specialistId", specialistId)
                    .setParameter("weekStart", weekStart)
                    .setParameter("weekEnd", weekEnd)
                    .getResultList();
        } finally {
            em.close();
        }
    }


    public boolean saveCreneauSafely(Creneau creneau) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(creneau);
            em.getTransaction().commit();
            return true;
        } catch (PersistenceException e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            LOGGER.log(Level.INFO, "Duplicate creneau not saved: {0} to {1}",
                    new Object[]{creneau.getDebut(), creneau.getFin()});
            return false;
        } finally {
            em.close();
        }
    }


    public void save(Creneau c) {
        EntityManager em = emf.createEntityManager();
        em.persist(c);
    }

    public Creneau update(Creneau c) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            Creneau merged = em.merge(c);
            em.getTransaction().commit();
            return merged;
        } catch (RuntimeException e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }


    public void delete(Creneau c) {
        EntityManager em = emf.createEntityManager();
        em.remove(em.contains(c) ? c : em.merge(c));
    }

    public Creneau findById(Long id) {
        EntityManager em = emf.createEntityManager();

        return em.find(Creneau.class, id);
    }

    public List<Creneau> findAll() {
        EntityManager em = emf.createEntityManager();
        return em.createQuery("SELECT c FROM Creneau c ORDER BY c.debut", Creneau.class).getResultList();
    }
}