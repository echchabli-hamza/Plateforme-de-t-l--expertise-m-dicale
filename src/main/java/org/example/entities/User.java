package org.example.entities;

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

    // Si user est SPECIALISTE, il a un profil
    @OneToOne(mappedBy = "user", cascade = CascadeType.ALL)
    private SpecialistProfile specialistProfile;

    // Si user est SPECIALISTE, il a des créneaux
    @OneToMany(mappedBy = "specialist", cascade = CascadeType.ALL)
    private List<Creneau> creneaux;

    // Si user est GENERALISTE, il a des consultations
    @OneToMany(mappedBy = "generaliste", cascade = CascadeType.ALL)
    private List<Consultation> consultations;

    // Si user est SPECIALISTE, il a des télé-expertises
    @OneToMany(mappedBy = "specialist", cascade = CascadeType.ALL)
    private List<TeleExpertise> teleExpertises;

    public void setFullname(String administrator) {
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public enum Role {
        INFIRMIER,
        GENERALISTE,
        SPECIALISTE
    }
}
