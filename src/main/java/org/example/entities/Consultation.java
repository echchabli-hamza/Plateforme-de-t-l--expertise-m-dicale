package org.example.entities;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "consultations")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Consultation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private LocalDateTime dateConsultation;
    private String motif;
    private String observations;
    private Double cout = 150.0; // fixed

    @ManyToOne
    @JoinColumn(name = "patient_id")
    private Patient patient;

    @ManyToOne
    @JoinColumn(name = "generaliste_id")
    private User generaliste;

    @OneToMany(mappedBy = "consultation", cascade = CascadeType.ALL)
    private List<ActeTechnique> actes;

    @OneToMany(mappedBy = "consultation", cascade = CascadeType.ALL)
    private List<TeleExpertise> expertises;
}
