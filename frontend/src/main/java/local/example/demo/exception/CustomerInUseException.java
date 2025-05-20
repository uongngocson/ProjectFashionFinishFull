package local.example.demo.exception;

public class CustomerInUseException extends RuntimeException {
    public CustomerInUseException(String message) {
        super(message);
    }
}