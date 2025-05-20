package local.example.demo.service;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import jakarta.transaction.Transactional;
import local.example.demo.model.dto.RegisterDTO;
import local.example.demo.model.entity.Account;
import local.example.demo.model.entity.Customer;
import local.example.demo.repository.AccountRepository;
import local.example.demo.repository.CustomerRepository;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class AccountService {
    // Add your service methods here
    // For example:
    private final AccountRepository accountRepository;
    private final RoleService roleService;
    private final CustomerRepository customerRepository;

    public List<Account> getAllAccounts() {
        return accountRepository.findAll();
    }

    public Account getAccountById(Integer id) {
        return accountRepository.findById(id).orElse(null);
    }

    public void saveAccount(Account account) {
        accountRepository.save(account);
    }

    public void deleteAccountById(Integer id) {
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
        if (account != null) return account;

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



    // mapper registerDTO to account
    public Account mapRegisterDTOToAccount(RegisterDTO registerDTO) {
        Account account = new Account();
        account.setLoginName(registerDTO.getLoginName());
        account.setPassword(registerDTO.getPassword());
        return account;
    }

}
