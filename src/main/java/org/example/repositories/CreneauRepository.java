package org.example.repositories;

import org.example.entities.Creneau;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import java.util.List;

@Transactional
public class CreneauRepository {

    @PersistenceContext(unitName = "TeleExpertisePU")
    private EntityManager em;

    public void save(Creneau c) {
        em.persist(c);
    }

    public Creneau update(Creneau c) {
        return em.merge(c);
    }

    public void delete(Creneau c) {
        em.remove(em.contains(c) ? c : em.merge(c));
    }

    public Creneau findById(Long id) {
        em.clear();
        return em.find(Creneau.class, id);
    }

    public List<Creneau> findAll() {
        return em.createQuery("SELECT c FROM Creneau c ORDER BY c.debut", Creneau.class).getResultList();
    }
}
