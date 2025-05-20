package local.example.demo.controller.client;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import jakarta.validation.Valid;
import local.example.demo.model.dto.RegisterDTO;
import local.example.demo.model.entity.Account;
import local.example.demo.model.entity.Customer;
import local.example.demo.repository.AccountRepository;
import local.example.demo.service.AccountService;
import local.example.demo.service.CustomerService;
import local.example.demo.service.RegisterService;
import local.example.demo.service.RoleService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.servlet.http.HttpSession;

@RequiredArgsConstructor
@Controller
@RequestMapping("/")
public class AuthenticationController {

    private final AccountService accountService;
    private final CustomerService customerService;
    private final RoleService roleService;
    private final PasswordEncoder passwordEncoder;
    private final RegisterService registerService;

    @GetMapping("login")
    public String getLoginPage() {
        return "client/auth/login";
    }

    @GetMapping("page-not-found")
    public String getPageNotFoundPage() {
        return "client/auth/page-not-found";
    }

    @GetMapping("register")
    public String getRegisterPage(Model model) {
        model.addAttribute("registerDTO", new RegisterDTO());
        return "client/auth/register";
    }

    @PostMapping("register")
    public String register(Model model, @Valid @ModelAttribute("registerDTO") RegisterDTO registerDTO,
            BindingResult bindingResult, HttpSession session) {
        if (bindingResult.hasErrors()) {
            model.addAttribute("message", "REGISTRATION FAILED!");
            return "client/auth/register";
        }
        
        // Store individual fields in session
        session.setAttribute("pending_email", registerDTO.getEmail());
        session.setAttribute("pending_password", registerDTO.getPassword());
        session.setAttribute("pending_username", registerDTO.getLoginName());
        session.setAttribute("pending_firstName", registerDTO.getFirstName());
        session.setAttribute("pending_lastName", registerDTO.getLastName());
        session.setAttribute("pending_phoneNumber", registerDTO.getPhoneNumber());
    
        // Generate and send verification code
        String verificationCode = registerService.generateVerificationCode();
        session.setAttribute("verificationCode", verificationCode);
        registerService.sendVerificationCode(registerDTO.getEmail(), verificationCode);
        
        return "client/auth/register-auth";
    }

    @PostMapping("/register-auth")
    public String verifyRegistration(@RequestParam("verificationCode") String submittedCode,
            HttpSession session,
            RedirectAttributes redirectAttributes,
            Model model) {
        
        // Add debug logging
        System.out.println("Submitted Code: " + submittedCode);
        System.out.println("Stored Code: " + session.getAttribute("verificationCode"));
        System.out.println("Stored Email: " + session.getAttribute("pending_email"));
        
        String storedCode = (String) session.getAttribute("verificationCode");
        String email = (String) session.getAttribute("pending_email");
        String password = (String) session.getAttribute("pending_password");
        String username = (String) session.getAttribute("pending_username");
        String phone = (String) session.getAttribute("pending_phoneNumber");
        String firstName = (String) session.getAttribute("pending_firstName");
        String lastName = (String) session.getAttribute("pending_lastName");
        if (storedCode == null || email == null) {
            redirectAttributes.addFlashAttribute("verificationError", "Session expired. Please register again.");
            return "redirect:/register";
        }
        
        if (!storedCode.equals(submittedCode)) {
            // Change to use Model instead of RedirectAttributes for direct return
            model.addAttribute("verificationError", "Invalid verification code");
            return "client/auth/register-auth";
        }
        
        // Recreate RegisterDTO from session data
        RegisterDTO registerDTO = new RegisterDTO();
        registerDTO.setEmail(email);
        registerDTO.setPassword(password);
        registerDTO.setLoginName(username);
        registerDTO.setFirstName(firstName);
        registerDTO.setLastName(lastName);
        registerDTO.setPhoneNumber(phone);
        
        // Process registration
        registerDTO.setPassword(passwordEncoder.encode(registerDTO.getPassword()));
        Account account = accountService.mapRegisterDTOToAccount(registerDTO);
        Customer customer = customerService.mapRegisterDTOToCustomer(registerDTO);
        
        account.setRole(roleService.getRoleById(1));
        accountService.saveAccount(account);
        customer.setAccount(account);
        customerService.saveCustomer(customer);
        
        // Clear session
        session.removeAttribute("verificationCode");
        session.removeAttribute("pending_email");
        session.removeAttribute("pending_password");
        session.removeAttribute("pending_username");
        session.removeAttribute("pending_phoneNumber");
        session.removeAttribute("pending_firstName");
        session.removeAttribute("pending_lastName");
        
        redirectAttributes.addFlashAttribute("message", "Registration successful! Please login.");
        return "redirect:/login";
    }

    @GetMapping("/resend-verification")
    public String resendVerification(HttpSession session, RedirectAttributes redirectAttributes, Model model) {
        String email = (String) session.getAttribute("pending_email");
        if (email == null) {
            redirectAttributes.addFlashAttribute("verificationError", "Session expired. Please register again.");
            return "redirect:/register";
        }
        
        String newCode = registerService.generateVerificationCode();
        session.setAttribute("verificationCode", newCode);
        registerService.sendVerificationCode(email, newCode);
        
        model.addAttribute("message", "New verification code sent!");
        return "client/auth/register-auth";  // Return directly to the view instead of redirect
    }


    @GetMapping("/oauth2-login")
    public String oauth2Login(Model model, @AuthenticationPrincipal OAuth2User principal, OAuth2AuthenticationToken authentication) {
        if (principal != null) {
            Account account = accountService.findOrCreateAccount(principal ,authentication.getAuthorizedClientRegistrationId());
        }

        return "redirect:/";
    }
    @GetMapping("forwardPassword")
    public String forwardPassword() {
        return "client/auth/forwardPassword";
    }
    @Autowired
    private AccountRepository accountRepository;
   @PostMapping("forwardPassword")
    public String postForwardPassword(@RequestParam("emailForward") String email,
                                    @RequestParam("username") String username,
                                    Model model) {

        Account account = accountRepository.findByLoginName(username);
        
        if (account != null) {
            // 1. Tạo mật khẩu mới
            String newPassword = AccountService.generateRandomPassword();

            // 2. Mã hóa và cập nhật mật khẩu mới
            String encodedPassword = passwordEncoder.encode(newPassword);
            account.setPassword(encodedPassword);
            accountRepository.save(account);

            // 3. Gửi email
            accountService.sendNewPassword(email, newPassword);
            System.out.println("Sending new password to: " + email);
            System.out.println("New password is: " + newPassword);

            model.addAttribute("message", "✅ Mật khẩu mới đã được gửi đến email của bạn.");
            return "client/auth/login";
        } else {
            model.addAttribute("error", "❌ Không tìm thấy tài khoản với thông tin đã cung cấp.");
            return "client/auth/forwardPassword";
        }
    }

}