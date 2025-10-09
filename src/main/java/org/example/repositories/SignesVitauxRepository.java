package org.example.repositories;

import org.example.entities.SignesVitaux;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import java.util.List;

@Transactional
public class SignesVitauxRepository {

    @PersistenceContext(unitName = "TeleExpertisePU")
    private EntityManager em;

    public void save(SignesVitaux sv) {
        em.persist(sv);
    }

    public SignesVitaux update(SignesVitaux sv) {
        return em.merge(sv);
    }

    public void delete(SignesVitaux sv) {
        em.remove(em.contains(sv) ? sv : em.merge(sv));
    }

    public SignesVitaux findById(Long id) {
        return em.find(SignesVitaux.class, id);
    }

    public List<SignesVitaux> findAll() {
        return em.createQuery("SELECT s FROM SignesVitaux s ORDER BY s.datemesure", SignesVitaux.class)
                 .getResultList();
    }
}
