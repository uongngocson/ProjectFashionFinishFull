package local.example.demo.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.session.security.web.authentication.SpringSessionRememberMeServices;

import jakarta.servlet.DispatcherType;
import local.example.demo.service.AccountService;
import local.example.demo.service.CustomUserDetailService;

@Configuration
@EnableMethodSecurity(securedEnabled = true)
public class SecurityConfig {

        @Bean
        public UserDetailsService userDetailsService(AccountService accountService) {
                return new CustomUserDetailService(accountService);
        }

        @Bean
        public AuthenticationSuccessHandler authenticationSuccess() {
                return new CustomSuccessHandler();
        }

        @Bean
        public PasswordEncoder passwordEncoder() {
                return new BCryptPasswordEncoder();
        }

        @Bean
        public DaoAuthenticationProvider authProvider(
                        PasswordEncoder passwordEncoder,
                        UserDetailsService userDetailsService) {
                DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
                authProvider.setUserDetailsService(userDetailsService);
                authProvider.setPasswordEncoder(passwordEncoder);
                // authProvider.setHideUserNotFoundExceptions(false);
                return authProvider;
        }

        @Bean
        public LogoutSuccessHandler logoutSuccessHandler() {
                return new CustomLogoutSuccessHandler();
        }

        @Bean
        public SpringSessionRememberMeServices rememberMeServices() {
        SpringSessionRememberMeServices rememberMeServices = new
        SpringSessionRememberMeServices();
        // optionally customize
        rememberMeServices.setAlwaysRemember(true);

        return rememberMeServices;
        }

        // Ensure this method is present and correctly configured
        @Bean
        public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
                http
                                .authorizeHttpRequests(authorize -> authorize
                                                .dispatcherTypeMatchers(DispatcherType.FORWARD,
                                                                DispatcherType.INCLUDE)
                                                .permitAll()

                                                .requestMatchers("/", "/about", "/login", "/oauth2/**", "/register",
                                                                "/register-auth",
                                                                "/resend-verification", "/product/**",
                                                                "/resources/**", "/product/category", "/api/**",
                                                                "/chatbot/**", "/chatbot/send", "/chatbot/demo", "/forwardPassword")
                                                .permitAll()
                                                .requestMatchers("/admin/**").hasRole("ADMIN") // Ensure role is
                                                                                               // correctly defined
                                                .requestMatchers("/management/**").authenticated()
                                                .anyRequest().authenticated())

                                .sessionManagement((sessionManagement) -> sessionManagement
                                                .sessionCreationPolicy(SessionCreationPolicy.ALWAYS)
                                                .invalidSessionUrl("/logout?expired")
                                                .maximumSessions(1)
                                                .maxSessionsPreventsLogin(false))

                                .logout(logout -> logout
                                                .logoutSuccessHandler(logoutSuccessHandler())
                                                .deleteCookies("JSESSIONID")
                                                .invalidateHttpSession(true))

                                .rememberMe(r -> r.rememberMeServices(rememberMeServices()))

                                
                          
                                 .oauth2Login(oauth -> oauth
                                 .loginPage("/login")
                                 .defaultSuccessUrl("/oauth2-login", true))
                                 

                                .formLogin(form -> form
                                                .loginPage("/login")// Ensure redirect to the correct home page
                                                .failureUrl("/login?error")
                                                .successHandler(authenticationSuccess())
                                                .permitAll())
                                .exceptionHandling(ex -> ex.accessDeniedPage("/page-not-found"))
                                .csrf(csrf -> csrf.disable());

                return http.build();
        }

}
