
package org.example.services;


import jakarta.servlet.ServletContext;
import org.example.entities.SignesVitaux;
import org.example.repositories.SignesVitauxRepository;

import java.util.List;


public class SignesVitauxService {

    private final SignesVitauxRepository signesVitauxRepo;

    public SignesVitauxService(ServletContext context) {
        this.signesVitauxRepo = new SignesVitauxRepository(context);
    }

    public SignesVitaux finById(Long id){

       return signesVitauxRepo.findById(id);

    }


    public List<SignesVitaux> getUnusedSignesVitaux() {
        return signesVitauxRepo.findAll().stream()
                .filter(sv -> !sv.getUtilisePourConsultation())
                .toList();
    }
}