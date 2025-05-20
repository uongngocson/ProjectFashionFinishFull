package local.example.demo.controller.client;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ErrorController implements org.springframework.boot.web.servlet.error.ErrorController {

    @RequestMapping("/error")
    public String handleError(HttpServletRequest request, Model model) {
        Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);

        if (status != null) {
            Integer statusCode = Integer.valueOf(status.toString());

            if (statusCode == HttpStatus.NOT_FOUND.value()) {
                model.addAttribute("errorCode", statusCode);
                model.addAttribute("errorMessage", "Trang bạn đang tìm kiếm không tồn tại");
                return "error/404";
            } else if (statusCode == HttpStatus.INTERNAL_SERVER_ERROR.value()) {
                model.addAttribute("errorCode", statusCode);
                model.addAttribute("errorMessage", "Đã xảy ra lỗi hệ thống");
                return "error/500";
            } else if (statusCode == HttpStatus.FORBIDDEN.value()) {
                model.addAttribute("errorCode", statusCode);
                model.addAttribute("errorMessage", "Bạn không có quyền truy cập trang này");
                return "error/403";
            }
        }

        model.addAttribute("errorCode", "Lỗi");
        model.addAttribute("errorMessage", "Đã xảy ra lỗi không xác định");
        return "error/error";
    }

    public String getErrorPath() {
        return "/error";
    }
}