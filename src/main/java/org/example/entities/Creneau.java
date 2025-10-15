package org.example.entities;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "creneaux",
        uniqueConstraints = @UniqueConstraint(columnNames = {"debut", "fin"}))

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Creneau {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private LocalDateTime debut;

    @Column(nullable = false)
    private LocalDateTime fin;

    @Column(nullable = false)
    @Builder.Default
    private Boolean disponible = true;

    @ManyToOne
    @JoinColumn(name = "specialist_id", nullable = false)
    private User specialist;

    @ManyToOne
    @JoinColumn(name = "patient_id")
    private User patient;

    // Add the missing business logic methods
    public boolean isAvailableForBooking() {
        return disponible && debut.isAfter(LocalDateTime.now()) && patient == null;
    }

    public void bookFor(User patient) {
        if (!isAvailableForBooking()) {
            throw new IllegalStateException("Cannot book an unavailable slot");
        }
        this.patient = patient;
        this.disponible = false;
    }

    public void cancel() {
        this.patient = null;
        this.disponible = true;
    }


}