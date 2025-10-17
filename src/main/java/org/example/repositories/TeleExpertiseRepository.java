package org.example.repositories;

import jakarta.persistence.EntityManagerFactory;
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



    public void save(TeleExpertise te) {
        em.getTransaction().begin();
        em.persist(te);
        em.getTransaction().commit();
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
