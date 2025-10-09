package org.example.services;

import org.example.entities.User;
import org.example.repositories.UserRepository;
import jakarta.transaction.Transactional;
import org.mindrot.jbcrypt.BCrypt;

@Transactional
public class AuthenticationService {

    private final UserRepository userRepository = new UserRepository();

    public User login(String username, String password) {
        User user = userRepository.findByUsername(username);
        if (user == null) {
            return null; // Utilisateur non trouvé
        }

        // Vérifier le mot de passe avec bcrypt
        if (BCrypt.checkpw(password, user.getPassword())) {
            return user;
        }

        return null; // Mot de passe incorrect
    }

    public void register(User user, String plainPassword) {
        // Hasher le mot de passe avant de sauvegarder
        String hashed = BCrypt.hashpw(plainPassword, BCrypt.gensalt());
        user.setPassword(hashed);
        userRepository.save(user);
    }
}
