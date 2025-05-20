package local.example.demo.model;

/**
 * Centralized error code definitions for the application.
 * 
 * Error codes are organized by category:
 * - 1000-1999: Validation errors
 * - 2000-2999: Resource not found errors
 * - 3000-3999: Authentication/Authorization errors
 * - 4000-4999: Business logic errors
 * - 5000-5999: System/Technical errors
 */
public final class ErrorCodes {

    // Validation errors (1000-1999)
    public static final int VALIDATION_ERROR = 1000;
    public static final int PRODUCT_OUT_OF_STOCK = 1001;
    public static final int PAYMENT_METHOD_NOT_SUPPORTED = 1002;
    public static final int SHIPPING_ADDRESS_INVALID = 1003;
    public static final int INVALID_DISCOUNT_CODE = 1004;
    public static final int INVALID_PHONE_NUMBER = 1005;
    public static final int INVALID_EMAIL_FORMAT = 1006;
    public static final int MISSING_REQUIRED_FIELD = 1007;

    // Resource not found errors (2000-2999)
    public static final int CUSTOMER_NOT_FOUND = 2001;
    public static final int PRODUCT_NOT_FOUND = 2002;
    public static final int ORDER_NOT_FOUND = 2003;
    public static final int ADDRESS_NOT_FOUND = 2004;
    public static final int DISCOUNT_NOT_FOUND = 2005;

    // Authentication/Authorization errors (3000-3999)
    public static final int UNAUTHORIZED_ACCESS = 3001;
    public static final int INSUFFICIENT_PERMISSIONS = 3002;
    public static final int AUTHENTICATION_FAILED = 3003;
    public static final int SESSION_EXPIRED = 3004;

    // Business logic errors (4000-4999)
    public static final int PAYMENT_PROCESSING_ERROR = 4001;
    public static final int ORDER_ALREADY_PROCESSED = 4002;
    public static final int INSUFFICIENT_INVENTORY = 4003;
    public static final int MAX_QUANTITY_EXCEEDED = 4004;
    public static final int SHIPPING_CALCULATION_ERROR = 4005;
    public static final int DISCOUNT_EXPIRED = 4006;
    public static final int DISCOUNT_USAGE_LIMIT_REACHED = 4007;
    public static final int MINIMUM_ORDER_AMOUNT_NOT_MET = 4008;

    // System/Technical errors (5000-5999)
    public static final int GENERAL_ERROR = 5000;
    public static final int DATABASE_ERROR = 5001;
    public static final int EXTERNAL_SERVICE_ERROR = 5002;
    public static final int PAYMENT_GATEWAY_ERROR = 5003;
    public static final int SHIPPING_API_ERROR = 5004;
    public static final int TIMEOUT_ERROR = 5005;

    // Prevent instantiation
    private ErrorCodes() {
        throw new AssertionError("ErrorCodes class should not be instantiated");
    }

    /**
     * Gets a human-readable error message for a given error code
     * 
     * @param errorCode The error code to get a message for
     * @return A human-readable error message
     */
    public static String getErrorMessage(int errorCode) {
        switch (errorCode) {
            // Validation errors
            case VALIDATION_ERROR:
                return "Validation error occurred";
            case PRODUCT_OUT_OF_STOCK:
                return "Sản phẩm đã hết hàng";
            case PAYMENT_METHOD_NOT_SUPPORTED:
                return "Phương thức thanh toán không được hỗ trợ";
            case SHIPPING_ADDRESS_INVALID:
                return "Địa chỉ giao hàng không hợp lệ";
            case INVALID_DISCOUNT_CODE:
                return "Mã giảm giá không hợp lệ hoặc đã hết hạn";
            case INVALID_PHONE_NUMBER:
                return "Số điện thoại không hợp lệ";
            case INVALID_EMAIL_FORMAT:
                return "Định dạng email không hợp lệ";
            case MISSING_REQUIRED_FIELD:
                return "Thiếu trường thông tin bắt buộc";

            // Resource not found errors
            case CUSTOMER_NOT_FOUND:
                return "Không tìm thấy thông tin khách hàng";
            case PRODUCT_NOT_FOUND:
                return "Không tìm thấy sản phẩm";
            case ORDER_NOT_FOUND:
                return "Không tìm thấy đơn hàng";
            case ADDRESS_NOT_FOUND:
                return "Không tìm thấy địa chỉ";
            case DISCOUNT_NOT_FOUND:
                return "Không tìm thấy mã giảm giá";

            // Authentication/Authorization errors
            case UNAUTHORIZED_ACCESS:
                return "Bạn không có quyền truy cập";
            case INSUFFICIENT_PERMISSIONS:
                return "Bạn không có đủ quyền để thực hiện thao tác này";
            case AUTHENTICATION_FAILED:
                return "Xác thực thất bại";
            case SESSION_EXPIRED:
                return "Phiên đăng nhập đã hết hạn";

            // Business logic errors
            case PAYMENT_PROCESSING_ERROR:
                return "Lỗi xử lý thanh toán";
            case ORDER_ALREADY_PROCESSED:
                return "Đơn hàng đã được xử lý trước đó";
            case INSUFFICIENT_INVENTORY:
                return "Không đủ hàng trong kho";
            case MAX_QUANTITY_EXCEEDED:
                return "Vượt quá số lượng tối đa cho phép";
            case SHIPPING_CALCULATION_ERROR:
                return "Lỗi tính phí vận chuyển";
            case DISCOUNT_EXPIRED:
                return "Mã giảm giá đã hết hạn";
            case DISCOUNT_USAGE_LIMIT_REACHED:
                return "Đã đạt giới hạn sử dụng mã giảm giá";
            case MINIMUM_ORDER_AMOUNT_NOT_MET:
                return "Chưa đạt giá trị đơn hàng tối thiểu";

            // System/Technical errors
            case GENERAL_ERROR:
                return "Đã xảy ra lỗi";
            case DATABASE_ERROR:
                return "Lỗi cơ sở dữ liệu";
            case EXTERNAL_SERVICE_ERROR:
                return "Lỗi dịch vụ bên ngoài";
            case PAYMENT_GATEWAY_ERROR:
                return "Lỗi cổng thanh toán";
            case SHIPPING_API_ERROR:
                return "Lỗi API vận chuyển";
            case TIMEOUT_ERROR:
                return "Quá thời gian xử lý";

            default:
                return "Lỗi không xác định (Mã lỗi: " + errorCode + ")";
        }
    }
}