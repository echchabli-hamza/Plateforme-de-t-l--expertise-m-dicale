package org.example.repositories;

import org.example.entities.Consultation;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import java.util.List;

@Transactional
public class ConsultationRepository {

    @PersistenceContext(unitName = "TeleExpertisePU")
    private EntityManager em;

    public void save(Consultation c) {
        em.persist(c);
    }

    public Consultation update(Consultation c) {
        return em.merge(c);
    }

    public void delete(Consultation c) {
        em.remove(em.contains(c) ? c : em.merge(c));
    }

    public Consultation findById(Long id) {
        return em.find(Consultation.class, id);
    }

    public List<Consultation> findAll() {
        return em.createQuery("SELECT c FROM Consultation c ORDER BY c.dateConsultation", Consultation.class)
                 .getResultList();
    }
}
