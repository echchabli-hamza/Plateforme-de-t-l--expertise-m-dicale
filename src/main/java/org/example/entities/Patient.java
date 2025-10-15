package org.example.entities;

import jakarta.persistence.*;
import lombok.*;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

@Entity
@Table(name = "patients")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Patient {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(unique = true)
    private String cne;
    private String nom;
    private String prenom;
    private LocalDate dateNaissance;
    private String numeroSS;
    private String telephone;
    private String adresse;
    private Date created_at;

    public Patient(String cne, String nom, String prenom, String numeroSS, LocalDate dateNaissance, String telephone, String adresse) {
        this.cne = cne;
        this.nom = nom;
        this.prenom = prenom;
        this.numeroSS = numeroSS;
        this.dateNaissance = dateNaissance;
        this.telephone = telephone;
        this.adresse = adresse;
    }


    @OneToMany(mappedBy = "patient", cascade = CascadeType.ALL)
    private List<SignesVitaux> signesVitauxList;

    @OneToMany(mappedBy = "patient", cascade = CascadeType.ALL)
    @org.hibernate.annotations.SQLRestriction("utilisepourconsultation = false")
    private List<SignesVitaux> activeSignesVitaux;

}
