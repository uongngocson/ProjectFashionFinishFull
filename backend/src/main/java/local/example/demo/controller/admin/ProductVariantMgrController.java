package local.example.demo.controller.admin;

import local.example.demo.model.entity.Product;
import local.example.demo.model.entity.ProductVariant;
import local.example.demo.service.ProductVariantService;
import local.example.demo.service.ProductService;
import local.example.demo.service.ColorService;
import local.example.demo.service.FileService;
import local.example.demo.service.SizeService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.validation.Valid;

import org.springframework.web.multipart.MultipartFile;

@Controller
@RequestMapping("/admin/product-variant-mgr")
@RequiredArgsConstructor
public class ProductVariantMgrController {

    private final ProductVariantService productVariantService;
    private final ProductService productService;
    private final ColorService colorService;
    private final SizeService sizeService;
    private final FileService fileService;

    // Method to show the form for adding a new variant
    @GetMapping("/add/{productId}")
    public String showAddVariantForm(@PathVariable("productId") Integer productId, Model model) {
        Product product = productService.findProductById(productId);
        if (product == null) {
            // Handle product not found
            return "redirect:/admin/product-mgr/list";
        }
        ProductVariant variant = new ProductVariant();
        variant.setProduct(product); // Pre-assign the product
        model.addAttribute("productVariant", variant);
        model.addAttribute("product", product);
        model.addAttribute("colors", colorService.getAllColors()); // Fetch all colors
        model.addAttribute("sizes", sizeService.getAllSizes()); // Fetch all sizes
        model.addAttribute("formAction", "/admin/product-variant-mgr/add");
        return "admin/product-mgr/form-variant"; // You'll need to create this JSP
    }

    // Method to process the form for adding a new variant
    @PostMapping("/add")
    public String addVariant(@Valid @ModelAttribute("productVariant") ProductVariant productVariant,
            BindingResult result,
            @RequestParam("imageFile") MultipartFile imageFile, // Add MultipartFile parameter
            Model model,
            RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            model.addAttribute("product", productService.findProductById(productVariant.getProduct().getProductId()));
            model.addAttribute("colors", colorService.getAllColors());
            model.addAttribute("sizes", sizeService.getAllSizes());
            model.addAttribute("formAction", "/admin/product-variant-mgr/add");
            return "admin/product-mgr/form-variant";
        }

        if (imageFile != null && !imageFile.isEmpty()) {
            String fileName = fileService.handleSaveUploadFile(imageFile, "product-variants");
            if (!fileName.isEmpty()) {
                productVariant.setImageUrl("resources/images-upload/product-variants/" + fileName); // Set the path to
                                                                                                    // be stored in DB
            } else {
                // Handle file save error, perhaps add a binding error or flash message
                model.addAttribute("product",
                        productService.findProductById(productVariant.getProduct().getProductId()));
                model.addAttribute("colors", colorService.getAllColors());
                model.addAttribute("sizes", sizeService.getAllSizes());
                model.addAttribute("formAction", "/admin/product-variant-mgr/add");
                model.addAttribute("imageUploadError", "Could not save image file.");
                return "admin/product-mgr/form-variant";
            }
        }

        productVariantService.save(productVariant);
        redirectAttributes.addFlashAttribute("successMessage", "Variant added successfully!");
        return "redirect:/admin/product-mgr/detail/" + productVariant.getProduct().getProductId();
    }

    // Method to show the form for editing an existing variant
    @GetMapping("/edit/{variantId}")
    public String showEditVariantForm(@PathVariable("variantId") Integer variantId, Model model) {
        ProductVariant variant = productVariantService.findById(variantId);
        if (variant == null) {
            // Handle variant not found
            return "redirect:/admin/product-mgr/list"; // Or back to product detail
        }
        model.addAttribute("productVariant", variant);
        model.addAttribute("product", variant.getProduct());
        model.addAttribute("colors", colorService.getAllColors());
        model.addAttribute("sizes", sizeService.getAllSizes());
        model.addAttribute("formAction", "/admin/product-variant-mgr/edit");
        return "admin/product-mgr/form-variant"; // Reuse the same form JSP
    }

    // Method to process the form for editing an existing variant
    @PostMapping("/edit")
    public String editVariant(@Valid @ModelAttribute("productVariant") ProductVariant productVariant,
            BindingResult result,
            @RequestParam("imageFile") MultipartFile imageFile, // Add MultipartFile parameter
            Model model,
            RedirectAttributes redirectAttributes) {
        if (result.hasErrors()) {
            model.addAttribute("product",
                    productService.findProductById(productVariant.getProduct().getProductId()));
            model.addAttribute("colors", colorService.getAllColors());
            model.addAttribute("sizes", sizeService.getAllSizes());
            model.addAttribute("formAction", "/admin/product-variant-mgr/edit");
            return "admin/product-mgr/form-variant";
        }

        // Handle file upload for edit
        if (imageFile != null && !imageFile.isEmpty()) {
            String fileName = fileService.handleSaveUploadFile(imageFile, "product-variants");
            if (!fileName.isEmpty()) {
                // Optionally, delete the old image if it exists and is different
                // ProductVariant existingVariant =
                // productVariantService.findById(productVariant.getProductVariantId());
                // if (existingVariant != null && existingVariant.getImageUrl() != null &&
                // !existingVariant.getImageUrl().isEmpty()) {
                // fileService.deleteFile(existingVariant.getImageUrl()); // You'll need to
                // implement deleteFile in FileService
                // }
                productVariant.setImageUrl("resources/images-upload/product-variants/" + fileName);
            } else {
                // Handle file save error
                model.addAttribute("product",
                        productService.findProductById(productVariant.getProduct().getProductId()));
                model.addAttribute("colors", colorService.getAllColors());
                model.addAttribute("sizes", sizeService.getAllSizes());
                model.addAttribute("formAction", "/admin/product-variant-mgr/edit");
                model.addAttribute("imageUploadError", "Could not save image file.");
                return "admin/product-mgr/form-variant";
            }
        } else {
            // If no new file is uploaded, keep the existing imageUrl
            ProductVariant existingVariant = productVariantService.findById(productVariant.getProductVariantId());
            if (existingVariant != null) {
                productVariant.setImageUrl(existingVariant.getImageUrl());
            }
        }

        productVariantService.save(productVariant); // save acts as update if ID exists
        redirectAttributes.addFlashAttribute("successMessage", "Variant updated successfully!");
        return "redirect:/admin/product-mgr/detail/" + productVariant.getProduct().getProductId();
    }

    // Method to delete a variant
    @GetMapping("/delete/{variantId}")
    public String deleteVariant(@PathVariable("variantId") Integer variantId, RedirectAttributes redirectAttributes) {
        ProductVariant variant = productVariantService.findById(variantId);
        if (variant == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "Variant not found!");
            return "redirect:/admin/product-mgr/list"; // Or a more appropriate page
        }
        Integer productId = variant.getProduct().getProductId();
        // Add checks here: e.g., if variant is in active orders, prevent deletion or
        // handle accordingly
        try {
            productVariantService.deleteById(variantId);
            redirectAttributes.addFlashAttribute("successMessage", "Variant deleted successfully!");
        } catch (Exception e) {
            // Log the exception
            redirectAttributes.addFlashAttribute("errorMessage", "Error deleting variant: " + e.getMessage());
        }
        return "redirect:/admin/product-mgr/detail/" + productId;
    }
}
