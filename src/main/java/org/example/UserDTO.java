package org.example;

import org.example.entities.User;

public record UserDTO(Long id, String username, String fullName, User.Role role) {}
