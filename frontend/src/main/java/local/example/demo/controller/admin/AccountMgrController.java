package local.example.demo.controller.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;
import local.example.demo.model.entity.Account;
import local.example.demo.service.AccountService;
import local.example.demo.service.RoleService;

@Controller
@RequestMapping("/admin/account-mgr/")
public class AccountMgrController {

    // Injecting the AccountService to handle account-related operations
    @Autowired
    private final AccountService accountService;
    private final RoleService roleService;

    public AccountMgrController(AccountService accountService, RoleService roleService) {
        this.accountService = accountService;
        this.roleService = roleService;
    }

    @GetMapping("list")
    public String listAccounts(Model model) {
        List<Account> accounts = accountService.getAllAccounts();
        model.addAttribute("accounts", accounts);
        return "admin/account-mgr/all-account";
    }

    @GetMapping("create")
    public String createAccount(Model model) {
        model.addAttribute("roles", roleService.getAllRoles());
        model.addAttribute("account", new Account());
        return "admin/account-mgr/form-account";
    }

    @GetMapping("update/{accountId}")
    public String updateAccount(@PathVariable("accountId") Integer accountId, Model model) {
        Account account = accountService.getAccountById(accountId);
        model.addAttribute("roles", roleService.getAllRoles());
        if (account == null) {
            return "redirect:/account-mgr/list";
        }
        model.addAttribute("account", account);
        return "admin/account-mgr/form-account";
    }

    @PostMapping("save")
    public String saveAccount(@ModelAttribute("account") @Valid Account account, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "admin/account-mgr/form-account";
        }
        accountService.saveAccount(account);
        return "redirect:/account-mgr/list";
    }

    @RequestMapping("delete/{accountId}")
    public String deleteAccount(@PathVariable("accountId") Integer accountId) {
        accountService.deleteAccountById(accountId);
        return "redirect:/account-mgr/list";
    }
}