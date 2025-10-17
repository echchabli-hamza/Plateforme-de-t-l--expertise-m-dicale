package org.example.repositories;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.TypedQuery;
import jakarta.servlet.ServletContext;
import org.example.entities.TeleExpertise;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import java.util.List;

@Transactional
public class TeleExpertiseRepository {


    @PersistenceContext(unitName = "TeleExpertisePU")
    private EntityManager em;

    public TeleExpertiseRepository(ServletContext context) {

        EntityManagerFactory emf = (EntityManagerFactory) context.getAttribute("emf");
        this.em = emf.createEntityManager();
        em.clear();


    }
    public void saveIfNotExists(TeleExpertise te) {
        em.getTransaction().begin();

        TypedQuery<Long> query = em.createQuery(
                "SELECT COUNT(t) FROM TeleExpertise t WHERE t.consultation.id = :cid",
                Long.class
        );
        query.setParameter("cid", te.getConsultation().getId());

        Long exists = query.getSingleResult();

        if (exists == 0) {
            em.persist(te);
        } else {
            System.out.println(" TeleExpertise already exists for this consultation.");
        }

        em.getTransaction().commit();
    }



    public void save(TeleExpertise te) {
        em.getTransaction().begin();
        em.merge(te);
        em.getTransaction().commit();
    }

    public TeleExpertise update(TeleExpertise te) {
        try {
            em.getTransaction().begin();
            TeleExpertise merged = em.merge(te);
            em.getTransaction().commit();
            return merged;
        } catch (RuntimeException e) {
            if (em.getTransaction().isActive()) em.getTransaction().rollback();
            throw e;
        }
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
