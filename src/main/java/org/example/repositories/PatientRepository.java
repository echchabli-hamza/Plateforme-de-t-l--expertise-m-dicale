package org.example.repositories;

import jakarta.persistence.EntityManagerFactory;
import jakarta.servlet.ServletContext;
import org.example.entities.Patient;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

import java.time.LocalDate;
import java.util.List;

@Transactional
public class PatientRepository {

    @PersistenceContext(unitName = "TeleExpertisePU")
    private EntityManager em;

    public PatientRepository(ServletContext context) {
        EntityManagerFactory emf = (EntityManagerFactory) context.getAttribute("emf");
        this.em = emf.createEntityManager();
    }

//    public void save(Patient patient) {
//        em.persist(patient);
//    }

    public Patient save(Patient patient) {
        try {
            em.getTransaction().begin();
            em.persist(patient);
            em.getTransaction().commit();
            return patient;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
        }
        return null ;
    }


    public Patient update(Patient patient) {
        return em.merge(patient);
    }

    public void delete(Patient patient) {
        em.remove(em.contains(patient) ? patient : em.merge(patient));
    }

    public Patient findById(Long id) {
        return em.find(Patient.class, id);
    }

    public List<Patient> findAll() {
        em.clear();

        return em.createQuery("SELECT p FROM Patient p ORDER BY p.id", Patient.class).getResultList();
    }


}
