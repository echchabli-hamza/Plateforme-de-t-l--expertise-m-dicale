package org.example.entities;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "signes_vitaux")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SignesVitaux {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Double tension;
    private Integer frequenceCardiaque;
    private Integer frequenceRespiratoire;
    private Double temperature;
    private Double poids;
    private Double taille;
    private LocalDateTime dateMesure;

    private Boolean utilisePourConsultation = false;

    @ManyToOne
    @JoinColumn(name = "patient_id")
    private Patient patient;
}
