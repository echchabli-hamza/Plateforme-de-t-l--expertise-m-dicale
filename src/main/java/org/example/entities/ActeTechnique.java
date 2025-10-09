package org.example.entities;

import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "actes_techniques")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ActeTechnique {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nom;
    private Double cout;

    @ManyToOne
    @JoinColumn(name = "consultation_id")
    private Consultation consultation;
}
