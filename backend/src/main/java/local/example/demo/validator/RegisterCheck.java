package local.example.demo.validator;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;

import java.lang.annotation.*;

@Documented
@Constraint(validatedBy = RegisterValidator.class)
@Target({ ElementType.TYPE })
@Retention(RetentionPolicy.RUNTIME)
public @interface RegisterCheck {
    String message() default "Password and confirm password are not the same";

    Class<?>[] groups() default {};

    Class<? extends Payload>[] payload() default {};

}
