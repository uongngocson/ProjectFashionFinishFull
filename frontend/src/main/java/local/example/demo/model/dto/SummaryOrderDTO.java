package local.example.demo.model.dto;

import java.util.List;

public class SummaryOrderDTO {
    private String customerId;
    private CustomerInfo customerInfo;
    private ShippingAddress shippingAddress;
    private Payment payment;
    private Shipping shipping;
    private String note;
    private TaxInfo taxInfo;
    private List<OrderItem> orderItems;
    private OrderCalculation orderCalculation;

    public static class CustomerInfo {
        private String fullName;
        private String email;
        private String phone;

        public String getFullName() {
            return fullName;
        }

        public void setFullName(String fullName) {
            this.fullName = fullName;
        }

        public String getEmail() {
            return email;
        }

        public void setEmail(String email) {
            this.email = email;
        }

        public String getPhone() {
            return phone;
        }

        public void setPhone(String phone) {
            this.phone = phone;
        }
    }

    public static class ShippingAddress {
        private String id;
        private String recipientName;
        private String recipientPhone;
        private String provinceId;
        private String districtId;
        private String districtName;
        private String wardCode;
        private String wardName;
        private String fullAddress;

        public String getId() {
            return id;
        }

        public void setId(String id) {
            this.id = id;
        }

        public String getRecipientName() {
            return recipientName;
        }

        public void setRecipientName(String recipientName) {
            this.recipientName = recipientName;
        }

        public String getRecipientPhone() {
            return recipientPhone;
        }

        public void setRecipientPhone(String recipientPhone) {
            this.recipientPhone = recipientPhone;
        }

        public String getProvinceId() {
            return provinceId;
        }

        public void setProvinceId(String provinceId) {
            this.provinceId = provinceId;
        }

        public String getDistrictId() {
            return districtId;
        }

        public void setDistrictId(String districtId) {
            this.districtId = districtId;
        }

        public String getDistrictName() {
            return districtName;
        }

        public void setDistrictName(String districtName) {
            this.districtName = districtName;
        }

        public String getWardCode() {
            return wardCode;
        }

        public void setWardCode(String wardCode) {
            this.wardCode = wardCode;
        }

        public String getWardName() {
            return wardName;
        }

        public void setWardName(String wardName) {
            this.wardName = wardName;
        }

        public String getFullAddress() {
            return fullAddress;
        }

        public void setFullAddress(String fullAddress) {
            this.fullAddress = fullAddress;
        }
    }

    public static class Payment {
        private String method;

        public String getMethod() {
            return method;
        }

        public void setMethod(String method) {
            this.method = method;
        }
    }

    public static class Shipping {
        private int fee;
        private int serviceId;
        private String estimatedDeliveryTime;

        public int getFee() {
            return fee;
        }

        public void setFee(int fee) {
            this.fee = fee;
        }

        public int getServiceId() {
            return serviceId;
        }

        public void setServiceId(int serviceId) {
            this.serviceId = serviceId;
        }

        public String getEstimatedDeliveryTime() {
            return estimatedDeliveryTime;
        }

        public void setEstimatedDeliveryTime(String estimatedDeliveryTime) {
            this.estimatedDeliveryTime = estimatedDeliveryTime;
        }
    }

    public static class TaxInfo {
        private boolean includeVat;
        private double vatRate;
        private int vatAmount;

        public boolean isIncludeVat() {
            return includeVat;
        }

        public void setIncludeVat(boolean includeVat) {
            this.includeVat = includeVat;
        }

        public double getVatRate() {
            return vatRate;
        }

        public void setVatRate(double vatRate) {
            this.vatRate = vatRate;
        }

        public int getVatAmount() {
            return vatAmount;
        }

        public void setVatAmount(int vatAmount) {
            this.vatAmount = vatAmount;
        }
    }

    public static class OrderItem {
        private int product_variant_id;
        private int quantity;
        private int price;
        private List<Object> applied_discounts;

        public int getProduct_variant_id() {
            return product_variant_id;
        }

        public void setProduct_variant_id(int product_variant_id) {
            this.product_variant_id = product_variant_id;
        }

        public int getQuantity() {
            return quantity;
        }

        public void setQuantity(int quantity) {
            this.quantity = quantity;
        }

        public int getPrice() {
            return price;
        }

        public void setPrice(int price) {
            this.price = price;
        }

        public List<Object> getApplied_discounts() {
            return applied_discounts;
        }

        public void setApplied_discounts(List<Object> applied_discounts) {
            this.applied_discounts = applied_discounts;
        }
    }

    public static class OrderCalculation {
        private int subtotal;
        private int totalDiscountAmount;
        private int shippingFee;
        private int taxAmount;
        private int totalAfterDiscount;
        private int finalTotal;
        private List<Object> appliedDiscounts;

        public int getSubtotal() {
            return subtotal;
        }

        public void setSubtotal(int subtotal) {
            this.subtotal = subtotal;
        }

        public int getTotalDiscountAmount() {
            return totalDiscountAmount;
        }

        public void setTotalDiscountAmount(int totalDiscountAmount) {
            this.totalDiscountAmount = totalDiscountAmount;
        }

        public int getShippingFee() {
            return shippingFee;
        }

        public void setShippingFee(int shippingFee) {
            this.shippingFee = shippingFee;
        }

        public int getTaxAmount() {
            return taxAmount;
        }

        public void setTaxAmount(int taxAmount) {
            this.taxAmount = taxAmount;
        }

        public int getTotalAfterDiscount() {
            return totalAfterDiscount;
        }

        public void setTotalAfterDiscount(int totalAfterDiscount) {
            this.totalAfterDiscount = totalAfterDiscount;
        }

        public int getFinalTotal() {
            return finalTotal;
        }

        public void setFinalTotal(int finalTotal) {
            this.finalTotal = finalTotal;
        }

        public List<Object> getAppliedDiscounts() {
            return appliedDiscounts;
        }

        public void setAppliedDiscounts(List<Object> appliedDiscounts) {
            this.appliedDiscounts = appliedDiscounts;
        }
    }

    // Getters and Setters for the main class
    public String getCustomerId() {
        return customerId;
    }

    public void setCustomerId(String customerId) {
        this.customerId = customerId;
    }

    public CustomerInfo getCustomerInfo() {
        return customerInfo;
    }

    public void setCustomerInfo(CustomerInfo customerInfo) {
        this.customerInfo = customerInfo;
    }

    public ShippingAddress getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(ShippingAddress shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    public Payment getPayment() {
        return payment;
    }

    public void setPayment(Payment payment) {
        this.payment = payment;
    }

    public Shipping getShipping() {
        return shipping;
    }

    public void setShipping(Shipping shipping) {
        this.shipping = shipping;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public TaxInfo getTaxInfo() {
        return taxInfo;
    }

    public void setTaxInfo(TaxInfo taxInfo) {
        this.taxInfo = taxInfo;
    }

    public List<OrderItem> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }

    public OrderCalculation getOrderCalculation() {
        return orderCalculation;
    }

    public void setOrderCalculation(OrderCalculation orderCalculation) {
        this.orderCalculation = orderCalculation;
    }
}
