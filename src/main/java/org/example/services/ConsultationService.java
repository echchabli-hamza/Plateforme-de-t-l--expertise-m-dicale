package org.example.services;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import org.example.entities.Consultation;
import org.example.repositories.ConsultationRepository;
import jakarta.inject.Inject;
import java.util.List;

public class ConsultationService {


    private final ConsultationRepository consultationRepository;


    public ConsultationService(ServletContext context) {
        System.out.println(">>> ConsultationService constructor - Instance: " + System.identityHashCode(this));
        this.consultationRepository = new ConsultationRepository(context);
        System.out.println(">>> consultationRepository assigned: " + this.consultationRepository);
        System.out.println(">>> consultationRepository field: " + System.identityHashCode(this.consultationRepository));
    }

    public List<Consultation> getActiveC() {


        return this.consultationRepository.findActiveConsultations();
    }

    public void createConsultation(Consultation c) {
        consultationRepository.save(c);
    }



    public List<Consultation> getCompletedConsultations() {
        return consultationRepository.findCompletedConsultations();
    }

    public void closeConsultation(Long id) {
        Consultation c = consultationRepository.findById(id);
        if (c != null) {
            c.setStatus(Consultation.TypeStatus.DONE);
            consultationRepository.update(c);
        }
    }

    public void requestTeleExpertise(Long consultationId) {
        Consultation c = consultationRepository.findById(consultationId);
        if (c != null) {
            c.setStatus(Consultation.TypeStatus.IN_PROGRESS);
            consultationRepository.update(c);
        }
    }
}
