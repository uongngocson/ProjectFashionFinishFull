package local.example.demo.controller.admin;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import local.example.demo.model.entity.Account;
import local.example.demo.model.entity.Employee;
import local.example.demo.service.AccountService;
import local.example.demo.service.EmployeeService;
import local.example.demo.service.FileService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/admin/employee-mgr/")
public class EmployeeMgrController {
    private final EmployeeService employeeService;
    private final FileService fileService;
    private final AccountService accountService;

    @GetMapping("list")
    public String getEmployeesList() {
        return "admin/employee-mgr/all-employees";
    }

    // get all employees
    @ModelAttribute("employees")
    public List<Employee> getAllEmployees() {
        return employeeService.getAllEmployees();
    }

    // get maneger
    @ModelAttribute("managers")
    public List<Employee> getManager() {
        return employeeService.getAllEmployees();
    }

    @ModelAttribute("accounts")
    public List<Account> getAccountsNotLinkedToEmployee() {
        return accountService.findAccountsNotLinkedToEmployee();
    }

    @GetMapping("detail/{employeeId}")
    public String detailEmployee(@PathVariable("employeeId") Integer employeeId, Model model) {
        Employee employee = employeeService.getEmployeeById(employeeId);
        model.addAttribute("employee", employee);
        return "admin/employee-mgr/detail-employee";
    }

    @GetMapping("create")
    public String createEmployee(Model model) {
        model.addAttribute("employee", new Employee());
        return "admin/employee-mgr/form-employee";
    }

    @GetMapping("update/{employeeId}")
    public String updateEmployee(@PathVariable("employeeId") Integer employeeId, Model model) {
        Employee employee = employeeService.getEmployeeById(employeeId);
        model.addAttribute("employee", employee);

        // Lấy danh sách các tài khoản chưa được liên kết
        List<Account> availableAccounts = accountService.findAccountsNotLinkedToEmployee();

        // Nếu nhân viên hiện tại đã có tài khoản, và tài khoản đó không có trong danh
        // sách availableAccounts,
        // thì thêm nó vào để nó có thể được chọn trên form.
        if (employee.getAccount() != null) {
            boolean accountExistsInList = availableAccounts.stream()
                    .anyMatch(acc -> acc.getAccountId().equals(employee.getAccount().getAccountId()));
            if (!accountExistsInList) {
                availableAccounts.add(employee.getAccount());
            }
        }
        model.addAttribute("accounts", availableAccounts);

        return "admin/employee-mgr/form-employee";
    }

    // save employee
    @PostMapping("save")
    public String saveEmployee(@ModelAttribute("employee") @Valid Employee employee, BindingResult bindingResult,
            @RequestParam("imageFile") MultipartFile imageFile, Model model) {
        if (bindingResult.hasErrors()) {
            return "admin/employee-mgr/form-employee";
        }

        if (fileService.isValidFile(imageFile)) {
            String imageUrl = fileService.handleSaveUploadFile(imageFile, "employee");
            employee.setImageUrl("/resources/images-upload/employee/" + imageUrl);
        }

        employeeService.saveEmployee(employee);
        return "redirect:/admin/employee-mgr/list";
    }

    // delete employee
    @PostMapping("delete/{employeeId}")
    public String deleteEmployee(HttpServletRequest request, @PathVariable("employeeId") Integer employeeId,
            RedirectAttributes redirectAttributes) {
        HttpSession session = request.getSession();
        try {
            // Lấy ID của nhân viên đang đăng nhập từ session
            Integer loggedInEmployeeId = (Integer) session.getAttribute("employeeId");

            // Kiểm tra nếu nhân viên đang cố gắng xóa chính mình
            if (loggedInEmployeeId != null && loggedInEmployeeId.equals(employeeId)) {
                redirectAttributes.addFlashAttribute("errorMessage", "Bạn không thể xóa chính mình.");
                return "redirect:/admin/employee-mgr/list";
            }

            // Kiểm tra xem nhân viên có đang quản lý nhân viên khác không
            // Hoặc có ràng buộc nào khác không cho phép xóa (ví dụ: đang có task
            // active,...)
            // Ví dụ đơn giản: nếu nhân viên có status là active thì không cho xóa
            Employee employee = employeeService.getEmployeeById(employeeId);
            if (employee != null && employee.isStatus()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Không thể xóa nhân viên đang hoạt động.");
                return "redirect:/admin/employee-mgr/list";
            }

            employeeService.deleteEmployee(employeeId);
            redirectAttributes.addFlashAttribute("successMessage", "Xóa nhân viên thành công!");
        } catch (Exception e) {
            // Log lỗi ở đây nếu cần thiết
            redirectAttributes.addFlashAttribute("errorMessage", "Đã xảy ra lỗi khi xóa nhân viên: " + e.getMessage());
        }
        return "redirect:/admin/employee-mgr/list";
    }
}
