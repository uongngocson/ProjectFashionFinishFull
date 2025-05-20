package local.example.demo.controller.employee;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.validation.Valid;
import local.example.demo.exception.ProductInUseException;
import local.example.demo.model.entity.Brand;
import local.example.demo.model.entity.Category;
import local.example.demo.model.entity.Product;
import local.example.demo.model.entity.Supplier;
import local.example.demo.service.BrandService;
import local.example.demo.service.CategoryService;
import local.example.demo.service.ProductService;
import local.example.demo.service.SupplierService;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller("employeeProductMgrController")
@RequestMapping("/employee/product-mgr/")
public class ProductMgrController {

    private final ProductService productService;
    private final CategoryService categoryService;
    private final BrandService brandService;
    private final SupplierService supplierService;

    // employee navigation to product list
    @GetMapping("list")
    public String getProductList() {
        return "employee/product-mgr/all-products";
    }

    // get all product
    @ModelAttribute("products")
    public List<Product> populateProducts() {
        return productService.findAllProducts();
    }

    // get all category
    @ModelAttribute("categories")
    public List<Category> populateCategories() {
        return categoryService.findAllCategories();
    }

    // get all brand
    @ModelAttribute("brands")
    public List<Brand> populateBrands() {
        return brandService.findAllBrands();
    }

    // get all supplier
    @ModelAttribute("suppliers")
    public List<Supplier> populateSuppliers() {
        return supplierService.findAllSuppliers();
    }

    // Show product details
    @GetMapping("detail/{productId}")
    public String viewProduct(Model model, @PathVariable("productId") Integer productId) {
        Product product = productService.findProductById(productId);
        if (product == null) {
            return "redirect:/employee/product-mgr/list";
        }
        model.addAttribute("totalQuantity", productService.getTotalStock(productId));
        model.addAttribute("product", product);
        return "employee/product-mgr/detail-product";
    }

    @GetMapping("create")
    public String createProduct(Model model) {
        model.addAttribute("product", new Product());
        return "employee/product-mgr/form-product";
    }

    @GetMapping("update/{productId}")
    public String updateProduct(Model model, @PathVariable("productId") Integer productId) {
        Product product = productService.findProductById(productId);
        model.addAttribute("product", product);
        return "employee/product-mgr/form-product";
    }

    // Process save product
    @PostMapping("save")
    public String saveProduct(Model model, @Valid @ModelAttribute("product") Product product,
            BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return "employee/product-mgr/form-product";
        }
        productService.saveProduct(product);
        return "redirect:/employee/product-mgr/list";
    }

    @PostMapping("delete/{productId}")
    public String deleteProduct(Model model, @PathVariable("productId") Integer productId,
            RedirectAttributes redirectAttributes) {
        try {
            productService.deleteProductById(productId);
            redirectAttributes.addFlashAttribute("successMessage", "Product deleted successfully.");
        } catch (ProductInUseException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage",
                    "Failed to delete product. An unexpected error occurred.");
        }
        return "redirect:/employee/product-mgr/list";
    }
}