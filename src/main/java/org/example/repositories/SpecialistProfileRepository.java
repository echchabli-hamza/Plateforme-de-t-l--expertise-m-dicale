package org.example.repositories;

import org.example.entities.SpecialistProfile;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import java.util.List;

@Transactional
public class SpecialistProfileRepository {

    @PersistenceContext(unitName = "TeleExpertisePU")
    private EntityManager em;

    public void save(SpecialistProfile sp) {
        em.persist(sp);
    }

    public SpecialistProfile update(SpecialistProfile sp) {
        return em.merge(sp);
    }

    public void delete(SpecialistProfile sp) {
        em.remove(em.contains(sp) ? sp : em.merge(sp));
    }

    public SpecialistProfile findById(Long id) {
        return em.find(SpecialistProfile.class, id);
    }

    public List<SpecialistProfile> findAll() {
        return em.createQuery("SELECT s FROM SpecialistProfile s", SpecialistProfile.class).getResultList();
    }
}
