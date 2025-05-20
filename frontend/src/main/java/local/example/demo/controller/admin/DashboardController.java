package local.example.demo.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("admin/dashboard/")
public class DashboardController {

    // admin navigation to home
    @GetMapping("index")
    public String getDashboardPage(Model model) {
        return "admin/dashboard/index";
    }

    // admin navigation to home login
    @GetMapping("login")
    public String getDashboardPageLogin(Model model) {
        return "admin/login/login";
    }

    // admin navigation to home register
    @GetMapping("register")
    public String getDashboardPageRegister(Model model) {
        return "admin/login/register";
    }

}
