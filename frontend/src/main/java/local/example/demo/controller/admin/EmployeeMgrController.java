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

import jakarta.validation.Valid;
import local.example.demo.model.entity.Employee;

import local.example.demo.service.EmployeeService;
import local.example.demo.service.FileService;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("/admin/employee-mgr/")
public class EmployeeMgrController {
    private final EmployeeService employeeService;
    private final FileService fileService;

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
    public String deleteEmployee(@PathVariable("employeeId") Integer employeeId) {
        employeeService.deleteEmployee(employeeId);
        return "redirect:/admin/employee-mgr/list";
    }
}
