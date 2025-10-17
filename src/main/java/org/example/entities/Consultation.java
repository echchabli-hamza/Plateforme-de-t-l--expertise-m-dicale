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

    private Double cout = 150.0;

    private TypeStatus status ;

    @ManyToOne
    @JoinColumn(name = "signes_vitaux_id")
    private SignesVitaux signesVitaux;

    @ManyToOne
    @JoinColumn(name = "generaliste_id")
    private User generaliste;

    @OneToMany(mappedBy = "consultation", cascade = CascadeType.ALL)
    private List<ActeTechnique> actes;

    @OneToOne(mappedBy = "consultation", cascade = CascadeType.ALL)
    private TeleExpertise expertise;


    public enum TypeStatus {
        IN_PROGRESS,
        DONE,
        AWAITING_TELE_EXPERTISE
    }

}

