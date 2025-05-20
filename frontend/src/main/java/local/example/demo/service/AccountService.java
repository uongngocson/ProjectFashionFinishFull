package local.example.demo.service;

import java.security.SecureRandom;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import jakarta.transaction.Transactional;
import local.example.demo.model.dto.RegisterDTO;
import local.example.demo.model.entity.Account;
import local.example.demo.model.entity.Customer;
import local.example.demo.model.entity.Role;
import local.example.demo.repository.AccountRepository;
import local.example.demo.repository.CustomerRepository;

@Service
public class AccountService {
    // Add your service methods here
    // For example:
    private final CustomerRepository customerRepository;
    private final AccountRepository accountRepository;
    private final RoleService roleService;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public AccountService(CustomerRepository customerRepository,
                          AccountRepository accountRepository,
                          RoleService roleService,
                          PasswordEncoder passwordEncoder) {
        this.customerRepository = customerRepository;
        this.accountRepository = accountRepository;
        this.roleService = roleService;
        this.passwordEncoder = passwordEncoder;
    }

    // ✅ Thêm method đúng cho controller gọi
    public Account getAccountById(Integer id) {
        return accountRepository.findById(id).orElse(null);
    }
    public List<Account> getAllAccounts(){
        return accountRepository.findAll() ;
    }
    public void saveAccount(Account account) {
        accountRepository.save(account);
    }

    public void deleteAccountById(Integer id) {
        accountRepository.deleteById(id);
    }

    public boolean existsByLoginName(String loginName) {
        return accountRepository.existsByLoginName(loginName);
    }

    public Account getAccountByLoginName(String loginName) {
        return accountRepository.findByLoginName(loginName);
    }

    public Optional<Account> getAccountWithRoleByLoginName(String loginName) {
        return accountRepository.findByLoginNameWithRole(loginName);
    }

    public Customer mapOAuth2UserToCustomer(OAuth2User principal, String provider) {
        Customer customer = new Customer();

        // Full name
        String name = principal.getAttribute("name");
        if (name != null) {
            String[] nameParts = name.split(" ");
            if (nameParts.length >= 1) customer.setFirstName(nameParts[0]);
            if (nameParts.length >= 2) customer.setLastName(nameParts[nameParts.length - 1]);
        }

        // Nếu provider là Google
        if ("google".equalsIgnoreCase(provider)) {
            String email = principal.getAttribute("email");
            String firstName = principal.getAttribute("given_name");
            String lastName = principal.getAttribute("family_name");
            String picture = principal.getAttribute("picture");

            if (email != null) customer.setEmail(email);
            if (firstName != null) customer.setFirstName(firstName);
            if (lastName != null) customer.setLastName(lastName);
            if (picture != null) customer.setImageUrl(picture);
        }

        // Nếu provider là Facebook
        else if ("facebook".equalsIgnoreCase(provider)) {
            String email = principal.getAttribute("email");
            String firstName = principal.getAttribute("first_name");
            String lastName = principal.getAttribute("last_name");

            if (email != null) customer.setEmail(email);
            if (firstName != null) customer.setFirstName(firstName);
            if (lastName != null) customer.setLastName(lastName);

            // Lấy ảnh đại diện từ Facebook
            try {
                Map<String, Object> pictureData = (Map<String, Object>) ((Map<String, Object>) principal.getAttribute("picture")).get("data");
                String avatarUrl = (String) pictureData.get("url");
                if (avatarUrl != null) customer.setImageUrl(avatarUrl);
            } catch (Exception e) {
                // Trường hợp Facebook không trả ảnh
                System.out.println("Không lấy được ảnh đại diện từ Facebook.");
            }
        }

        customer.setRegistrationDate(LocalDate.now()); // Gán ngày đăng ký

        return customer;
    }

    @Transactional
    public Account findOrCreateAccount(OAuth2User principal, String provider) {
        String email = principal.getAttribute("email");
        String id = null;
        boolean isFacebook = false;

        if ("google".equalsIgnoreCase(provider)) {
            id = principal.getAttribute("sub");
        } else if ("facebook".equalsIgnoreCase(provider)) {
            id = principal.getAttribute("id");
            isFacebook = true;
        }

        // Tìm account theo email (nếu có), nếu không thì fallback qua id
        Account account = (email != null && !email.isBlank())
                ? accountRepository.findByLoginName(email)
                : null;

        if (account == null) {
            account = accountRepository.findByLoginName(id);
        }

        if (account != null) return account;

        // Nếu không có thì tạo mới
        String loginName = (email != null && !email.isBlank()) ? email : id;
        String rawPassword = (isFacebook ? "oauthFB" : "oauthGG") + id;
        String encodedPassword = passwordEncoder.encode(rawPassword);

        Account newAccount = new Account();
        newAccount.setLoginName(loginName);
        newAccount.setPassword(encodedPassword);
        newAccount.setRole(roleService.getRoleById(1)); // CUSTOMER mặc định

        Account savedAccount = accountRepository.save(newAccount);

        // Tạo và lưu Customer
        Customer customer = mapOAuth2UserToCustomer(principal, provider);
        customer.setAccount(savedAccount);
        customerRepository.save(customer);

        return savedAccount;
    }





    // mapper registerDTO to account
    public Account mapRegisterDTOToAccount(RegisterDTO registerDTO) {
        Account account = new Account();
        account.setLoginName(registerDTO.getLoginName());
        account.setPassword(registerDTO.getPassword());
        return account;
    }

    @Autowired
    private JavaMailSender mailSender;

    public void sendNewPassword(String toEmail, String code) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setTo(toEmail);
            helper.setSubject("New Password");

            String htmlContent = "<!DOCTYPE html>" +
                "<html><head><style>" +
                "body { font-family: 'Segoe UI', Tahoma, sans-serif; background-color: #f4f4f4; padding: 20px; }" +
                ".container { background-color: #ffffff; max-width: 600px; margin: auto; padding: 30px; border-radius: 10px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); }" +
                ".title { font-size: 24px; font-weight: bold; color: #333; margin-bottom: 20px; }" +
                ".text { font-size: 16px; color: #555; line-height: 1.5; }" +
                ".password-box { margin: 30px 0; padding: 15px; background-color: #007BFF; color: white; font-size: 20px; font-weight: bold; border-radius: 8px; text-align: center; letter-spacing: 2px; }" +
                ".footer { font-size: 12px; color: #aaa; text-align: center; margin-top: 30px; }" +
                "</style></head><body>" +
                "<div class='container'>" +
                "<div class='title'>🔐 Mật khẩu mới của bạn</div>" +
                "<div class='text'>Chào bạn,<br><br>Mật khẩu mới đã được tạo cho tài khoản của bạn. Vui lòng sử dụng mật khẩu dưới đây để đăng nhập:</div>" +
                "<div class='password-box'>" + code + "</div>" +
                "<div class='text'>Sau khi đăng nhập, bạn nên đổi mật khẩu này để đảm bảo an toàn.<br><br>Nếu bạn không yêu cầu cấp lại mật khẩu, hãy bỏ qua email này.</div>" +
                "<div class='footer'>&copy; 2025 AlphaMart - Bảo mật là ưu tiên hàng đầu của chúng tôi.</div>" +
                "</div></body></html>";

            helper.setText(htmlContent, true); // Enable HTML

            mailSender.send(message);

        } catch (MessagingException e) {
            throw new RuntimeException("Failed to send new password", e);
        }
    }

    private static final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    private static final int PASSWORD_LENGTH = 10;

    public static String generateRandomPassword() {
        SecureRandom random = new SecureRandom();
        StringBuilder password = new StringBuilder(PASSWORD_LENGTH);
        for (int i = 0; i < PASSWORD_LENGTH; i++) {
            int index = random.nextInt(CHARACTERS.length());
            password.append(CHARACTERS.charAt(index));
        }
        return password.toString();
    }
}
