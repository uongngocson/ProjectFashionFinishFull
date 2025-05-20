package local.example.demo.controller.admin;

import java.time.LocalDate;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.Valid;
import local.example.demo.model.entity.Customer;
import local.example.demo.model.entity.Order;
import local.example.demo.service.CustomerService;
import local.example.demo.service.FileService;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/admin/customer-mgr/")
public class CustomerMgrController {

    private final CustomerService customerService;
    private final FileService fileService;

    @GetMapping("list")
    public String getCustomersList() {
        return "admin/customer-mgr/all-customers";
    }

    // get all customers
    @ModelAttribute("customers")
    public List<Customer> getAllCustomers() {
        return customerService.findAllCustomers();
    }

    @GetMapping("detail/{customerId}")
    public String getCustomerDetail(Model model, @PathVariable("customerId") Integer customerId) {
        Customer customer = customerService.findCustomerById(customerId);
        if (customer == null) {
            return "redirect:/admin/customer-mgr/list";
        }

        List<Order> orders = customerService.findOrdersByCustomerId(customerId);
        model.addAttribute("orders", orders);
        model.addAttribute("customer", customer);
        return "admin/customer-mgr/detail-customer";
    }

    @GetMapping("create")
    public String createCustomer(Model model) {
        model.addAttribute("customer", new Customer());
        return "admin/customer-mgr/form-customer";
    }

    @GetMapping("update/{customerId}")
    public String updateCustomer(Model model, @PathVariable("customerId") Integer customerId) {
        Customer customer = customerService.findCustomerById(customerId);
        if (customer == null) {
            return "redirect:/admin/customer-mgr/list";
        }
        model.addAttribute("customer", customer);
        return "admin/customer-mgr/form-customer";
    }

    @PostMapping("save")
    public String saveCustomer(@ModelAttribute("customer") @Valid Customer customer, BindingResult bindingResult,
            @RequestParam("imageFile") MultipartFile imageFile) {

        if (bindingResult.hasErrors()) {
            return "admin/customer-mgr/form-customer";
        }
        if (fileService.isValidFile(imageFile)) {
            String nameImageFile = fileService.handleSaveUploadFile(imageFile, "customer");
            customer.setImageUrl("/resources/images-upload/customer/" + nameImageFile);
        }
        if (customer.getCustomerId() == null) {
            customer.setRegistrationDate(LocalDate.now());
        }
        customerService.saveCustomer(customer);
        return "redirect:/admin/customer-mgr/list";
    }

    @GetMapping("delete/{customerId}")
    public String deleteCustomer(@PathVariable("customerId") Integer customerId) {
        customerService.deleteCustomerById(customerId);
        return "redirect:/admin/customer-mgr/list";
    }
}
