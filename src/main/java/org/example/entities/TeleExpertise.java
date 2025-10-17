package org.example.entities;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(
        name = "tele_expertises",
        uniqueConstraints = @UniqueConstraint(columnNames = {"consultation_id"})
)
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TeleExpertise {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String question;

    private String recommandations;

    @Enumerated(EnumType.STRING)
    private Statut statut = Statut.EN_ATTENTE;

    private LocalDateTime dateDemande;

    @OneToOne
    @JoinColumn(name = "consultation_id")
    private Consultation consultation;

    @ManyToOne
    @JoinColumn(name = "specialist_id")
    private User specialist;

    public enum Statut {
        EN_ATTENTE,
        TERMINEE
    }
}
