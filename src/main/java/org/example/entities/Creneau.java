package org.example.entities;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "creneaux")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Creneau {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private LocalDateTime debut;
    private LocalDateTime fin;
    private Boolean disponible = true;

    @ManyToOne
    @JoinColumn(name = "specialist_id")
    private User specialist;
}
