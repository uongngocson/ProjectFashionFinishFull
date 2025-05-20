package local.example.demo.validator;

import org.springframework.stereotype.Service;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;
import local.example.demo.model.dto.RegisterDTO;
import local.example.demo.service.AccountService;
import local.example.demo.service.CustomerService;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class RegisterValidator implements ConstraintValidator<RegisterCheck, RegisterDTO> {
    private final AccountService accountService;
    private final CustomerService customerService;

    @Override
    public boolean isValid(RegisterDTO registerDTO, ConstraintValidatorContext context) {
        // compare password and confirm password -> print error message if they are not
        // the same
        boolean isValid = true;
        if (!registerDTO.getPassword().equals(registerDTO.getConfirmPassword())) {
            context.disableDefaultConstraintViolation();
            context.buildConstraintViolationWithTemplate("Password and confirm password must be the same")
                    .addPropertyNode("confirmPassword")
                    .addConstraintViolation();
            isValid = false;
        }

        // check if login name is already taken
        if (accountService.existsByLoginName(registerDTO.getLoginName())) {
            context.disableDefaultConstraintViolation();
            context.buildConstraintViolationWithTemplate("Login name is already taken")
                    .addPropertyNode("loginName")
                    .addConstraintViolation();
            isValid = false;
        }

        // check if email is already taken
        if (customerService.existsByEmail(registerDTO.getEmail())) {
            context.disableDefaultConstraintViolation();
            context.buildConstraintViolationWithTemplate("Email is already taken")
                    .addPropertyNode("email")
                    .addConstraintViolation();
            isValid = false;
        }
        return isValid;
    }

}
