package org.example.repositories;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletContext;
import org.example.entities.Consultation;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import java.util.List;

public class ConsultationRepository {
    private EntityManager em;

    public ConsultationRepository(ServletContext context) {

        EntityManagerFactory emf = (EntityManagerFactory) context.getAttribute("emf");
        this.em = emf.createEntityManager();
        em.clear();


    }
    public void save(Consultation c) {
        em.getTransaction().begin();
        em.persist(c);
        em.getTransaction().commit();
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
        em.clear();
        return em.createQuery("SELECT c FROM Consultation c ORDER BY c.dateConsultation", Consultation.class)
                 .getResultList();
    }

    public List<Consultation> findActiveConsultations() {
        em.clear();

        return em.createQuery(
                        "SELECT c FROM Consultation c WHERE c.status <> :status ORDER BY c.dateConsultation DESC",
                        Consultation.class
                )
                .setParameter("status", Consultation.TypeStatus.DONE)
                .getResultList();

    }

    public void refresh(Consultation c){
        em.clear();
        em.refresh(c);

    }
    public List<Consultation> findCompletedConsultations() {
        em.clear();
        return em.createQuery("SELECT c FROM Consultation c WHERE c.status = 'done' ORDER BY c.dateConsultation DESC", Consultation.class)
                .getResultList();
    }
}
