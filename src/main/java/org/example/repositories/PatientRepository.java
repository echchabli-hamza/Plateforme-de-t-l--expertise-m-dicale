package org.example.repositories;

import org.example.entities.Patient;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import java.util.List;

@Transactional
public class PatientRepository {

    @PersistenceContext(unitName = "TeleExpertisePU")
    private EntityManager em;

    public void save(Patient patient) {
        em.persist(patient);
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
        return em.createQuery("SELECT p FROM Patient p ORDER BY p.id", Patient.class).getResultList();
    }
}
