package org.example.repositories;

import org.example.entities.ActeTechnique;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import java.util.List;

@Transactional
public class ActeTechniqueRepository {

    @PersistenceContext(unitName = "TeleExpertisePU")
    private EntityManager em;

    public void save(ActeTechnique a) {
        em.persist(a);
    }

    public ActeTechnique update(ActeTechnique a) {
        return em.merge(a);
    }

    public void delete(ActeTechnique a) {
        em.remove(em.contains(a) ? a : em.merge(a));
    }

    public ActeTechnique findById(Long id) {
        return em.find(ActeTechnique.class, id);
    }

    public List<ActeTechnique> findAll() {
        return em.createQuery("SELECT a FROM ActeTechnique a", ActeTechnique.class).getResultList();
    }
}
