package server.Models;

import jakarta.validation.constraints.Min;

public class Role {
    @Min(value = 5, message = "Username must be at least 5 characters")
    private String username;

    @Min(value = 5, message = "Role must be at least 5 characters")
    private String role;

    public Role(String username, String role) {
        this.username = username;
        this.role = role;
    }

    public Role() {
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}
