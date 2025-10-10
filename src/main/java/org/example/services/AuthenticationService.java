package org.example.services;

import org.example.entities.User;
import org.example.repositories.UserRepository;
import jakarta.transaction.Transactional;
import org.mindrot.jbcrypt.BCrypt;

@Transactional
public class AuthenticationService {

    private final UserRepository userRepository ;

    public AuthenticationService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public User login(String username, String password) {
        User user = userRepository.findByUsername(username);
        if (user == null) {
            return null;
        }

        String testP = password ;

        if (password.equals(user.getPassword())) {
            return user;
        }

        return null;
    }

    public void register(User user, String plainPassword) {

        String hashed = BCrypt.hashpw(plainPassword, BCrypt.gensalt());
        user.setPassword(hashed);
        userRepository.save(user);
    }
}
