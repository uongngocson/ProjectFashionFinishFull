package local.example.demo.service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;
import local.example.demo.model.dto.RegisterDTO;
import local.example.demo.exception.AccountInUseException;
import local.example.demo.model.entity.Account;
import local.example.demo.model.entity.Customer;
import local.example.demo.model.entity.Employee;
import local.example.demo.repository.AccountRepository;
import local.example.demo.repository.CustomerRepository;
import local.example.demo.repository.EmployeeRepository;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AccountService {

    private final AccountRepository accountRepository;
    private final RoleService roleService;
    private final CustomerRepository customerRepository; // Inject CustomerRepository
    private final EmployeeRepository employeeRepository; // Inject EmployeeRepository

    public List<Account> getAllAccounts() {
        return accountRepository.findAll();
    }

    public Account getAccountById(Integer id) {
        return accountRepository.findById(id).orElse(null);
    }

    public void saveAccount(Account account) {
        accountRepository.save(account);
    }

    @Transactional // Thêm @Transactional để đảm bảo tính nhất quán
    public void deleteAccountById(Integer id) {
        Account account = accountRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Account not found with ID: " + id));

        // Kiểm tra liên kết với Customer
        Customer customer = customerRepository.findByAccount(account);
        if (customer != null) {
            throw new AccountInUseException("Cannot delete account: It is associated with customer "
                    + customer.getFirstName() + " " + customer.getLastName());
        }

        // Kiểm tra liên kết với Employee
        Employee employee = employeeRepository.findByAccount(account);
        if (employee != null) {
            throw new AccountInUseException("Cannot delete account: It is associated with employee "
                    + employee.getFirstName() + " " + employee.getLastName());
        }

        accountRepository.deleteById(id);
    }

    public boolean existsByLoginName(String loginName) {
        return accountRepository.existsByLoginName(loginName);
    }

    public Account getAccountByLoginName(String loginName) {
        return accountRepository.findByLoginName(loginName);
    }

    public Optional<Account> getAccountWithRoleByLoginName(String loginName) {
        return accountRepository.findByLoginNameWithRole(loginName);
    }

    @Transactional
    public Account findOrCreateAccount(String googleId, String email, String name) {
        Account account = accountRepository.findByLoginName(email);
        if (account != null)
            return account;

        // Tạo account mới
        Account newAccount = new Account();
        newAccount.setLoginName(email);
        newAccount.setPassword("oauth2_" + googleId);
        newAccount.setRole(roleService.getRoleById(1)); // default role is 1-CUSTOMER

        Account savedAccount = accountRepository.save(newAccount);

        // Tạo customer
        Customer customer = new Customer();
        customer.setAccount(savedAccount);
        customer.setEmail(email);
        customer.setRegistrationDate(LocalDate.now());
        customerRepository.save(customer);

        return savedAccount;
    }

    public List<Account> findAccountsNotLinkedToEmployee() {
        return accountRepository.findAccountsNotLinkedToEmployee();
    }

    // mapper registerDTO to account
    public Account mapRegisterDTOToAccount(RegisterDTO registerDTO) {
        Account account = new Account();
        account.setLoginName(registerDTO.getLoginName());
        account.setPassword(registerDTO.getPassword());
        return account;
    }

}
