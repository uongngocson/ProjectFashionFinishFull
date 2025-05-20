package local.example.demo.service;

import java.time.LocalDate;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import local.example.demo.model.entity.Account;
import local.example.demo.model.entity.Customer;

import local.example.demo.repository.AccountRepository;
import local.example.demo.repository.CustomerRepository;

@Service
public class RegisterService {
    @Autowired
    private AccountRepository accountRepository;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private JavaMailSender mailSender;

    // public void sendVerificationCode(String toEmail, String code) {
    //     SimpleMailMessage message = new SimpleMailMessage();
    //     message.setTo(toEmail);
    //     message.setSubject("Verification Code for Registration");
    //     message.setText("Your verification code is: " + code + "\n\n" +
    //                    "Please enter this code to complete your registration.\n" +
    //                    "This code will expire in 10 minutes.");
    //     mailSender.send(message);
    // }
    public void sendVerificationCode(String toEmail, String code) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setTo(toEmail);
            helper.setSubject("🔐 Verification Code for Registration");

            String htmlContent = "<!DOCTYPE html>" +
                    "<html><head><style>" +
                    "body { font-family: 'Segoe UI', Tahoma, sans-serif; background-color: #f8f8f8; padding: 20px; }" +
                    ".container { background: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1); max-width: 600px; margin: auto; }" +
                    ".code-box { font-size: 24px; font-weight: bold; color: #fff; background-color: #4CAF50; padding: 15px; border-radius: 6px; text-align: center; letter-spacing: 3px; margin: 20px 0; }" +
                    ".footer { font-size: 12px; color: #999; margin-top: 30px; text-align: center; }" +
                    "</style></head><body>" +
                    "<div class='container'>" +
                    "<h2>🔐 Verification Code</h2>" +
                    "<p>Hello,</p>" +
                    "<p>Thank you for registering. Please use the verification code below to complete your registration:</p>" +
                    "<div class='code-box'>" + code + "</div>" +
                    "<p>This code will expire in <strong>10 minutes</strong>.</p>" +
                    "<p>If you did not request this code, please ignore this email.</p>" +
                    "<div class='footer'>&copy; 2025 AlphaMart</div>" +
                    "</div></body></html>";

            helper.setText(htmlContent, true); // Enable HTML

            mailSender.send(message);

        } catch (MessagingException e) {
            throw new RuntimeException("Failed to send verification email", e);
        }
    }

    public String generateVerificationCode() {
        return String.format("%06d", new Random().nextInt(999999));
    }

    public Account saveAccount(Account account) {
        return accountRepository.save(account);
    }

    public Customer saveCustomer(String email, Account account) {
        Customer customer = new Customer();
        customer.setAccount(account);
        customer.setEmail(email);
        customer.setRegistrationDate(LocalDate.now());
        return customerRepository.save(customer);
    }
}
