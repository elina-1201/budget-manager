package org.artso.budget_manager.auth;

import lombok.AllArgsConstructor;
import org.artso.budget_manager.auth.dto.RegisterRequest;
import org.artso.budget_manager.security.userdetails.AppUserAdapter;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Service;

import org.springframework.web.server.ResponseStatusException;

import java.util.Locale;

@Service
@AllArgsConstructor
public class AppUserService implements UserDetailsService {
    final AppUserRepo repository;
    final PasswordEncoder passwordEncoder;

    public boolean userExistsByEmail(String email) {
        return repository.existsByEmail(normalizeEmail(email));
    }

    public AppUser requireUserByEmail(String email) {
        return repository.findByEmail(normalizeEmail(email))
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found"));
    }

    public void addUser(RegisterRequest request){
        if(userExistsByEmail(request.email())) {
            throw new ResponseStatusException(HttpStatus.CONFLICT);
        }

        String encodedPassword = passwordEncoder.encode(request.password());

        AppUser user = new AppUser();
        user.setName(request.name());
        user.setEmail(request.email());
        user.setPassword(encodedPassword);

        repository.save(user);
    }

    @Override
    @SuppressWarnings("deprecation")
    public @NonNull UserDetails loadUserByUsername(@NonNull String username) throws UsernameNotFoundException {
        AppUser user = requireUserByEmail(username);
        return new AppUserAdapter(user);
    }

    private String normalizeEmail(String email) {
        return email.toLowerCase(Locale.ROOT);
    }
}
