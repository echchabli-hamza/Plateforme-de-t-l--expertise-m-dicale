package org.example.entities;

import com.fasterxml.jackson.annotation.JsonBackReference;
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
    @JsonBackReference
    private User specialist;









    @Override
    public String toString() {
        return "Creneau{" +
                "id=" + id +
                ", debut=" + debut +
                ", fin=" + fin +
                ", disponible=" + disponible +

                '}';
    }
}