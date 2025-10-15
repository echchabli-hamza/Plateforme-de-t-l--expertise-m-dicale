package org.example.repositories;

import jakarta.persistence.EntityManagerFactory;
import jakarta.servlet.ServletContext;
import org.example.entities.ActeTechnique;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import org.example.entities.Consultation;

import java.util.List;

@Transactional
public class ActeTechniqueRepository {


    EntityManager em ;

    public ActeTechniqueRepository(ServletContext context) {

        EntityManagerFactory emf = (EntityManagerFactory) context.getAttribute("emf");
        this.em = emf.createEntityManager();


    }
    public void save(ActeTechnique a) {
        em.getTransaction().begin();
        em.persist(a);
        em.getTransaction().commit();
    }



    public ActeTechnique update(ActeTechnique a) {
        return em.merge(a);
    }

    public void delete(ActeTechnique a) {
        em.remove(em.contains(a) ? a : em.merge(a));
    }


    public ActeTechnique findById(Long id) {
        em.clear();
        return em.find(ActeTechnique.class, id);
    }

    public List<ActeTechnique> findAll(Long consultationId) {

        return em.createQuery(
                        "SELECT a FROM ActeTechnique a WHERE a.consultation.id = " + consultationId,
                        ActeTechnique.class
                )
                 .getResultList();
    }


}
