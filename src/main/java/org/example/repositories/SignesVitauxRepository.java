package org.example.repositories;

import jakarta.persistence.EntityManagerFactory;
import jakarta.servlet.ServletContext;
import org.example.entities.SignesVitaux;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import java.util.List;

@Transactional
public class SignesVitauxRepository {

    @PersistenceContext(unitName = "TeleExpertisePU")
    private EntityManager em;

    public SignesVitauxRepository(ServletContext context) {
        EntityManagerFactory emf = (EntityManagerFactory) context.getAttribute("emf");
        this.em = emf.createEntityManager();
        em.clear();
    }

    public void save(SignesVitaux sv) {
        em.getTransaction().begin();
        em.persist(sv);
        em.getTransaction().commit();
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
        em.clear();
        return em.createQuery("SELECT s FROM SignesVitaux s ORDER BY s.dateMesure", SignesVitaux.class)
                 .getResultList();
    }
}
