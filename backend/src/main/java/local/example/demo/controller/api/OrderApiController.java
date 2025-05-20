package local.example.demo.controller.api;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import local.example.demo.model.dto.CreateOrderRequest;
import local.example.demo.model.dto.CreateOrderResponse;
import local.example.demo.service.OrderService;
import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/orders")
@RequiredArgsConstructor
public class OrderApiController {

    private final OrderService orderService;

    @PostMapping("/create")
    public ResponseEntity<CreateOrderResponse> createOrder(@RequestBody CreateOrderRequest request) {
        try {
            CreateOrderResponse response = orderService.createOrderWithStoredProcedure(
                    request.getCustomer_id(),
                    request.getPayment_id(),
                    request.getOrder_items());

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            CreateOrderResponse errorResponse = new CreateOrderResponse();
            errorResponse.setErrorCode(-1);
            errorResponse.setErrorMessage("Error creating order: " + e.getMessage());
            return ResponseEntity.status(500).body(errorResponse);
        }
    }
}