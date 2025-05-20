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
import local.example.demo.model.entity.Product;
import local.example.demo.model.entity.Supplier;
import local.example.demo.service.FileService;
import local.example.demo.service.ProductService;
import local.example.demo.service.SupplierService;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Controller
@RequestMapping("admin/supplier-mgr/")
public class SupplierMgrController {
    private final SupplierService supplierService;
    private final ProductService productService;
    private final FileService fileService;

    // Example method to get the list of Suppliers
    @GetMapping("list")
    public String getSupplierList() {
        return "admin/supplier-mgr/all-suppliers";
    }

    // Example method to get the list of Suppliers
    @ModelAttribute("suppliers")
    public List<Supplier> populateSuppliers() {
        return supplierService.findAllSuppliers();
    }

    // Example method to get the details of a specific Supplier
    @GetMapping("detail/{supplierId}")
    public String getSupplierDetail(@PathVariable("supplierId") Integer supplierId, Model model) {
        Supplier supplier = supplierService.findSupplierById(supplierId);
        List<Product> products = productService.findProductsBySupplierId(supplierId);
        if (supplier == null) {
            return "redirect:/admin/supplier-mgr/list";
        }
        model.addAttribute("products", products);
        model.addAttribute("supplier", supplier);
        return "admin/supplier-mgr/detail-supplier";
    }

    // Example method to create a new supplier
    @GetMapping("create")
    public String createSupplier(Model model) {
        model.addAttribute("supplier", new Supplier());
        return "admin/supplier-mgr/form-supplier";
    }

    // update the supplier
    @GetMapping("update/{supplierId}")
    public String updateSupplier(Model model, @PathVariable("supplierId") Integer supplierId) {
        Supplier supplier = supplierService.findSupplierById(supplierId);
        if (supplier == null) {
            return "redirect:/admin/supplier-mgr/list";
        }
        model.addAttribute("supplier", supplier);
        return "admin/supplier-mgr/form-supplier";
    }

    // Example method to handle the creation of a new supplier
    @PostMapping("save")
    public String saveSupplier(@ModelAttribute("supplier") @Valid Supplier supplier, BindingResult bindingResult,
            @RequestParam("logoFile") MultipartFile logoFile) {
        if (bindingResult.hasErrors()) {
            return "admin/supplier-mgr/form-supplier";
        }
        if (fileService.isValidFile(logoFile)) {
            String fileName = fileService.handleSaveUploadFile(logoFile, "supplier");
            supplier.setLogoUrl("/resources/images-upload/supplier/" + fileName);
        }
        // Save the supplier to the database
        supplierService.saveSupplier(supplier);
        return "redirect:/admin/supplier-mgr/list";
    }

    // delete the supplier
    @PostMapping("delete/{supplierId}")
    public String deleteSupplier(@PathVariable("supplierId") Integer supplierId) {
        supplierService.deleteSupplierById(supplierId);
        return "redirect:/admin/supplier-mgr/list";
    }

}
