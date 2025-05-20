package local.example.demo.exception;

public class OrderInUseException extends RuntimeException{
    public OrderInUseException(String message){
        super(message);
    }  
}
