package org.example.entities;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.*;
import java.util.List;

@Entity
@Table(name = "users")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String username;
    private String password;
    private String fullName;

    @Enumerated(EnumType.STRING)
    private Role role;


    @OneToOne(mappedBy = "user", cascade = CascadeType.ALL)
    @JsonManagedReference
    private SpecialistProfile specialistProfile;


    @OneToMany(mappedBy = "specialist", cascade = CascadeType.ALL)
    @JsonManagedReference
    private List<Creneau> creneaux;

    @OneToMany(mappedBy = "generaliste", cascade = CascadeType.ALL)
    private List<Consultation> consultations;

    @OneToMany(mappedBy = "specialist", cascade = CascadeType.ALL)
    private List<TeleExpertise> teleExpertises;






    public enum Role {
        INFIRMIER,
        GENERALISTE,
        SPECIALISTE
    }



}
