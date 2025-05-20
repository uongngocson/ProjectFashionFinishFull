// package local.example.demo.controller.client;

// import local.example.demo.model.dto.SummaryOrderDTO;
// import local.example.demo.service.SummaryService;
// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.stereotype.Controller;
// import org.springframework.ui.Model;
// import org.springframework.web.bind.annotation.GetMapping;
// import org.springframework.web.bind.annotation.ModelAttribute;
// import org.springframework.web.bind.annotation.PostMapping;
// import org.springframework.web.bind.annotation.RequestMapping;
// import org.springframework.web.bind.annotation.RequestParam;
// import org.springframework.web.servlet.mvc.support.RedirectAttributes;

// @Controller
// @RequestMapping("/order")
// public class SummaryOrderController {

// @Autowired
// private SummaryService summaryService;

// /**
// * Handle the order summary submission
// *
// * @param orderDTO The order data from form submission
// * @param redirectAttributes For flash attributes in redirection
// * @return View name for redirection
// */
// @PostMapping("/submit")
// public String submitOrder(@ModelAttribute SummaryOrderDTO orderDTO,
// RedirectAttributes redirectAttributes) {
// try {
// // Print the received data to the terminal/console
// System.out.println("===== RECEIVED ORDER DATA =====");
// System.out.println("Customer ID: " + orderDTO.getCustomerId());

// // Print customer info
// if (orderDTO.getCustomerInfo() != null) {
// System.out.println("Customer Name: " +
// orderDTO.getCustomerInfo().getFullName());
// System.out.println("Customer Email: " +
// orderDTO.getCustomerInfo().getEmail());
// System.out.println("Customer Phone: " +
// orderDTO.getCustomerInfo().getPhone());
// }

// // Print shipping address
// if (orderDTO.getShippingAddress() != null) {
// System.out.println("Shipping To: " +
// orderDTO.getShippingAddress().getRecipientName());
// System.out.println("Recipient Phone: " +
// orderDTO.getShippingAddress().getRecipientPhone());
// System.out.println("Province ID: " +
// orderDTO.getShippingAddress().getProvinceId());
// System.out.println("District: " +
// orderDTO.getShippingAddress().getDistrictName() + " (ID: "
// + orderDTO.getShippingAddress().getDistrictId() + ")");
// System.out.println("Ward: " + orderDTO.getShippingAddress().getWardName() + "
// (Code: "
// + orderDTO.getShippingAddress().getWardCode() + ")");
// }

// // Print payment info
// if (orderDTO.getPayment() != null) {
// System.out.println("Payment Method: " + orderDTO.getPayment().getMethod());
// }

// // Print shipping info
// if (orderDTO.getShipping() != null) {
// System.out.println("Shipping Fee: " + orderDTO.getShipping().getFee());
// System.out.println("Service ID: " + orderDTO.getShipping().getServiceId());
// System.out.println("Estimated Delivery: " +
// orderDTO.getShipping().getEstimatedDeliveryTime());
// }

// // Print note
// System.out.println("Order Note: " + orderDTO.getNote());

// // Print tax info
// if (orderDTO.getTaxInfo() != null) {
// System.out.println("Include VAT: " + orderDTO.getTaxInfo().isIncludeVat());
// System.out.println("VAT Rate: " + orderDTO.getTaxInfo().getVatRate());
// System.out.println("VAT Amount: " + orderDTO.getTaxInfo().getVatAmount());
// }

// // Print calculation summary
// if (orderDTO.getOrderCalculation() != null) {
// System.out.println("Subtotal: " +
// orderDTO.getOrderCalculation().getSubtotal());
// System.out.println("Discount: " +
// orderDTO.getOrderCalculation().getTotalDiscountAmount());
// System.out.println("Shipping: " +
// orderDTO.getOrderCalculation().getShippingFee());
// System.out.println("Tax: " + orderDTO.getOrderCalculation().getTaxAmount());
// System.out.println("Total After Discount: " +
// orderDTO.getOrderCalculation().getTotalAfterDiscount());
// System.out.println("Final Total: " +
// orderDTO.getOrderCalculation().getFinalTotal());
// }
// System.out.println("================================");

// // Process the order through the service
// String orderId = summaryService.processOrderSummary(orderDTO);

// // Add success message and order ID for the confirmation page
// redirectAttributes.addFlashAttribute("success", true);
// redirectAttributes.addFlashAttribute("orderId", orderId);
// redirectAttributes.addFlashAttribute("orderData", orderDTO);

// // Redirect to confirmation page
// return "redirect:/order/confirmation";

// } catch (Exception e) {
// // Log the error (in a real application)
// e.printStackTrace();

// // Add error message
// redirectAttributes.addFlashAttribute("error", true);
// redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());

// // Redirect back to order page
// return "redirect:/order";
// }
// }

// /**
// * Display order confirmation page
// *
// * @param model The view model
// * @return View name
// */
// @GetMapping("/confirmation")
// public String showConfirmation(Model model, @RequestParam(required = false)
// String orderId) {
// // Check if we have orderId either from request param or flash attributes
// if (orderId != null) {
// // If coming from API flow with orderId as request param
// model.addAttribute("orderId", orderId);
// return "client/user/order-confirmation";
// } else if (model.containsAttribute("orderId")) {
// // If coming from traditional form post with flash attributes
// return "client/user/order-confirmation";
// } else {
// // If no order data at all, redirect to home
// return "redirect:/";
// }
// }
// }
