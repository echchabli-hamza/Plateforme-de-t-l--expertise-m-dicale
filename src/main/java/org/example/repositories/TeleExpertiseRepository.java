package org.example.repositories;

import org.example.entities.TeleExpertise;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import java.util.List;

@Transactional
public class TeleExpertiseRepository {

    @PersistenceContext(unitName = "TeleExpertisePU")
    private EntityManager em;

    public void save(TeleExpertise te) {
        em.persist(te);
    }

    public TeleExpertise update(TeleExpertise te) {
        return em.merge(te);
    }

    public void delete(TeleExpertise te) {
        em.remove(em.contains(te) ? te : em.merge(te));
    }

    public TeleExpertise findById(Long id) {
        return em.find(TeleExpertise.class, id);
    }

    public List<TeleExpertise> findAll() {
        return em.createQuery("SELECT t FROM TeleExpertise t ORDER BY t.dateDemande", TeleExpertise.class)
                .getResultList();
    }
}
