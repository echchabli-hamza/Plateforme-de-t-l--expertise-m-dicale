package org.example.entities;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.*;

@Entity
@Table(name = "specialist_profiles")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SpecialistProfile {

    @Id
    private Long id;

    @OneToOne
    @MapsId
    @JoinColumn(name = "user_id")
    @JsonBackReference
    private User user;

    private String specialite;
    private Double tarif;
    private Integer dureeConsultation = 30;
}
