package org.example.services;

import jakarta.servlet.ServletContext;
import org.example.entities.Patient;
import org.example.entities.SignesVitaux;
import org.example.repositories.PatientRepository;
import org.example.repositories.SignesVitauxRepository;
import org.example.repositories.UserRepository;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public class PatientService {

    private final PatientRepository patientRepo;
    private final SignesVitauxRepository signesVitauxRepo;
    private final UserRepository userRepo;

    public PatientService(ServletContext context) {
        this.patientRepo = new PatientRepository(context);
        this.signesVitauxRepo = new SignesVitauxRepository(context);
        this.userRepo = new UserRepository(context);
    }


    public Patient addPatient(String prenom, String nom, LocalDate dateNaissance,
                           String numeroSS, String telephone, String adresse ,String cne) {

        Patient patient = Patient.builder()
                .prenom(prenom)
                .nom(nom)
                .dateNaissance(dateNaissance)
                .numeroSS(numeroSS)
                .telephone(telephone)
                .adresse(adresse)
                .cne(cne)
                .build();

       return patientRepo.save(patient);
    }


    public void addSignesVitaux(Long patientId, Double tension, Integer frequenceCardiaque,
                                Integer frequenceRespiratoire, Double temperature, Double poids,
                                Double taille, Boolean utilisePourConsultation) {

        Patient patient = patientRepo.findById(patientId);
        if (patient == null) throw new IllegalArgumentException("Patient introuvable");

        SignesVitaux sv = SignesVitaux.builder()
                .tension(tension)
                .frequenceCardiaque(frequenceCardiaque)
                .frequenceRespiratoire(frequenceRespiratoire)
                .temperature(temperature)
                .poids(poids)
                .taille(taille)
                .dateMesure(LocalDateTime.now())
                .utilisePourConsultation(utilisePourConsultation)
                .patient(patient)
                .build();

        signesVitauxRepo.save(sv);
    }


    public List<Patient> getAllPatients() {
        return patientRepo.findAll();
    }

    public List<Patient> findToday() {
        LocalDate today = LocalDate.now();

        return patientRepo.findAll().stream()
                .filter(p -> !p.getActiveSignesVitaux().isEmpty() &&
                        p.getActiveSignesVitaux().getFirst().getDateMesure() != null &&
                        p.getActiveSignesVitaux().getFirst().getDateMesure().toLocalDate().equals(today))
                .toList();
    }




    public List<Patient> getPatientsWaiting() {
        return patientRepo.findAll().stream()
                .filter(p -> p.getSignesVitauxList() != null &&
                        p.getSignesVitauxList().stream()
                                .anyMatch(sv -> !sv.getUtilisePourConsultation()))
                .toList();
    }

    public Optional<Patient> findByCne(String cne){

        return patientRepo.findAll().stream()
                .filter(p -> p.getCne().equals(cne))
                .findFirst();


    }
}
