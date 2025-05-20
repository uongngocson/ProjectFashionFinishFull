package local.example.demo.exception;

public class AccountInUseException extends RuntimeException {
    public AccountInUseException(String message) {
        super(message);
    }
}
