package local.example.demo.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.hibernate.TransientObjectException;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.security.crypto.password.PasswordEncoder;

import local.example.demo.model.dto.RegisterDTO;
import local.example.demo.model.entity.Account;
import local.example.demo.model.entity.Address;
import local.example.demo.model.entity.Cart;
import local.example.demo.model.entity.Customer;
import local.example.demo.model.entity.Order;
import local.example.demo.exception.CustomerInUseException;
import local.example.demo.repository.AccountDiscountCodeRepository;
import local.example.demo.repository.AccountRepository;
import local.example.demo.repository.AddressRepository;
import local.example.demo.repository.CartDetailRepository;
import local.example.demo.repository.CartRepository;
import local.example.demo.repository.CustomerRepository;
import local.example.demo.repository.OrderRepository;
import local.example.demo.repository.ReviewRepository;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CustomerService {

    private final CustomerRepository customerRepository;
    private final OrderRepository orderRepository;
    private final CartDetailRepository cartDetailRepository;
    private final CartRepository cartRepository;
    private final AccountRepository accountRepository;
    private final AddressRepository addressRepository;
    private final PasswordEncoder passwordEncoder;
    private final ReviewRepository reviewRepository;
    private final AccountDiscountCodeRepository accountDiscountCodeRepository;

    @Transactional(readOnly = true)
    public List<Customer> findAllCustomers() {
        return customerRepository.findAll();
    }

    @Transactional(readOnly = true)
    public Customer findCustomerById(Integer customerId) {
        return customerRepository.findById(customerId).orElse(null);
    }

    @Transactional
    public void saveCustomer(Customer customer) {
        customerRepository.save(customer);
    }

    @Transactional
    public void deleteCustomerById(Integer customerId) {
        Customer customer = customerRepository.findById(customerId)
                .orElseThrow(() -> new IllegalArgumentException("Không tìm thấy khách hàng có ID: " + customerId));

        // Kiểm tra ràng buộc với Order
        if (orderRepository.existsByCustomer_CustomerId(customerId)) {
            throw new CustomerInUseException("Không thể xóa khách hàng này vì có đơn hàng liên quan.");
        }

        // Kiểm tra ràng buộc với Review
        if (reviewRepository.existsByCustomer_CustomerId(customerId)) {
            throw new CustomerInUseException("Không thể xóa khách hàng này vì có đánh giá liên quan.");
        }
        // kiểm tra địa chỉ có được sử dụng trong Order không
        List<Address> addresses = customer.getAddresses();
        for (Address address : addresses) {
            // Đảm bảo rằng tên phương thức ở đây khớp với tên đã sửa trong OrderRepository
            if (orderRepository.existsByShippingAddress_AddressId(address.getAddressId())) {
                throw new CustomerInUseException("Không thể xóa khách hàng này vì có địa chỉ liên quan đến đơn hàng.");
            }
        }
        addressRepository.deleteByCustomer_CustomerId(customerId);
        addressRepository.deleteByCustomerId(customerId);
        cartRepository.deleteByCustomer_CustomerId(customerId);
        accountDiscountCodeRepository.deleteByCustomer_CustomerId(customerId);

        // Optional: Xóa Account nếu nó không còn được sử dụng bởi bất kỳ Customer nào
        // khác
        Account account = customer.getAccount();
        if (account != null && !customerRepository.existsByAccount(account)) {
            accountRepository.delete(account);
        }

        customerRepository.delete(customer);
    }

    @Transactional(readOnly = true)
    public List<Order> findOrdersByCustomerId(Integer customerId) {
        return orderRepository.findByCustomerId(customerId);
    }

    public boolean existsByEmail(String email) {
        return customerRepository.existsByEmail(email);
    }

    // find customer by account
    public Customer getCustomerByAccount(Account account) {
        return customerRepository.findByAccount(account);
    }

    // get cart detail count by cart
    public int getCartDetailCountByCart(Customer customer) {
        return cartDetailRepository.countByCart(customer.getCart());
    }

    // get cart by customer
    public Cart getCartByCustomer(Customer customer) {
        return cartRepository.findByCustomer(customer);
    }

    // mapper registerDTO to customer
    public Customer mapRegisterDTOToCustomer(RegisterDTO registerDTO) {
        Customer customer = new Customer();
        customer.setFirstName(registerDTO.getFirstName());
        customer.setLastName(registerDTO.getLastName());
        customer.setEmail(registerDTO.getEmail());
        customer.setPhone(registerDTO.getPhoneNumber());
        return customer;
    }

    @Transactional(readOnly = true)
    public Customer findByUsername(String username) {
        Account account = accountRepository.findByLoginName(username);
        if (account == null) {
            return null;
        }
        return customerRepository.findByAccount(account);
    }

    @Transactional(readOnly = true)
    public Customer findById(Integer customerId) {
        return customerRepository.findById(customerId).orElse(null);
    }

    @Transactional(readOnly = true)
    public Customer getCurrentLoggedInCustomer() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated()) {
            return null;
        }

        String username = authentication.getName();
        return findByUsername(username);
    }

    @Transactional(readOnly = true)
    public List<Address> findAddressesByCustomerId(Integer customerId) {
        // Method 1: Using direct repository method
        return addressRepository.findByCustomerCustomerId(customerId);
    }

    @Transactional(readOnly = true)
    public List<Address> findAddressesByCustomer(Customer customer) {
        if (customer == null) {
            return List.of();
        }
        return addressRepository.findByCustomer(customer);
    }

    @Transactional
    public Customer updateCustomerProfile(Customer updatedCustomer, MultipartFile image) throws IOException {
        Customer currentCustomer = getCurrentLoggedInCustomer();
        if (currentCustomer == null || !currentCustomer.getCustomerId().equals(updatedCustomer.getCustomerId())) {
            throw new IllegalStateException("Không có quyền chỉnh sửa hồ sơ này");
        }

        if (!currentCustomer.getEmail().equals(updatedCustomer.getEmail())
                && existsByEmail(updatedCustomer.getEmail())) {
            throw new IllegalArgumentException("Email đã được sử dụng: " + updatedCustomer.getEmail());
        }

        currentCustomer.setFirstName(updatedCustomer.getFirstName());
        currentCustomer.setLastName(updatedCustomer.getLastName());
        currentCustomer.setEmail(updatedCustomer.getEmail());
        currentCustomer.setPhone(updatedCustomer.getPhone());
        currentCustomer.setDateOfBirth(updatedCustomer.getDateOfBirth());
        currentCustomer.setGender(updatedCustomer.isGender());

        if (image != null && !image.isEmpty()) {
            String uploadDir = "src/main/resources/static/resources/images-upload/customer/";
            String fileName = UUID.randomUUID().toString() + "_" + image.getOriginalFilename();
            Path filePath = Paths.get(uploadDir, fileName);

            Files.createDirectories(filePath.getParent());

            Files.write(filePath, image.getBytes());

            currentCustomer.setImageUrl("/resources/images-upload/customer/" + fileName);
        }

        return customerRepository.save(currentCustomer);
    }

    @Transactional
    public void changePassword(String oldPassword, String newPassword, String confirmPassword) {
        Customer customer = getCurrentLoggedInCustomer();
        if (customer == null) {
            throw new IllegalStateException("Không có quyền thực hiện hành động này");
        }

        // Lấy Account liên kết với Customer
        Account account = customer.getAccount();
        if (account == null) {
            throw new IllegalStateException("Không tìm thấy tài khoản liên kết");
        }

        // Kiểm tra mật khẩu cũ
        if (!passwordEncoder.matches(oldPassword, account.getPassword())) {
            throw new IllegalArgumentException("Mật khẩu cũ không đúng");
        }

        // Kiểm tra mật khẩu mới và xác nhận mật khẩu
        if (!newPassword.equals(confirmPassword)) {
            throw new IllegalArgumentException("Mật khẩu mới và xác nhận mật khẩu không khớp");
        }

        // Kiểm tra độ dài mật khẩu mới (tùy chọn)
        if (newPassword.length() < 8) {
            throw new IllegalArgumentException("Mật khẩu mới phải có ít nhất 8 ký tự");
        }

        // Mã hóa và cập nhật mật khẩu mới
        String encodedNewPassword = passwordEncoder.encode(newPassword);
        account.setPassword(encodedNewPassword);
        accountRepository.save(account);
    }

    public Customer fetchCurrentLoggedInCustomer() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication == null || !authentication.isAuthenticated()
                || authentication instanceof AnonymousAuthenticationToken) {
            System.out.println("No authenticated user found");
            return null;
        }

        String username = authentication.getName();
        System.out.println("Authenticated username: " + username);

        // Tìm Customer trực tiếp dựa trên loginName
        Customer customer = customerRepository.findByAccountLoginName(username);
        if (customer == null) {
            System.out.println("Customer not found for loginName: " + username);
            throw new IllegalStateException("Customer not found for loginName: " + username);
        }
        System.out.println("Found customer ID: " + customer.getCustomerId());

        return customer;
    }

}
