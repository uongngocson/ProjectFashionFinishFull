const products = [
    { id: 1, name: "Laptop", category: "Electronics", technology: "Intel i7", description: "High-performance laptop", price: "$1200", discount: "10%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 3, name: "Headphones", category: "Accessories", technology: "Bluetooth", description: "Noise-cancelling headphones", price: "$200", discount: "15%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },
    { id: 2, name: "Smartphone", category: "Electronics", technology: "5G", description: "Latest model with 5G", price: "$800", discount: "5%" },


];

function renderProducts() {
    const tbody = document.querySelector("tbody");
    tbody.innerHTML = ""; // Xóa dữ liệu cũ


    products.forEach(product => {
        const row = document.createElement("tr");
        row.className = "table-hover align-middle";

        row.innerHTML = `
        <td class="p-3 text-center">
            <div class="form-check">
                <input id="checkbox-${product.id}" type="checkbox" class="form-check-input">
                <label for="checkbox-${product.id}" class="form-check-label sr-only">Checkbox</label>
            </div>
        </td>
        <td class="p-3 fw-medium text-center">#${product.id}</td>
        <td class="p-3 text-center">
            <div class="fw-bold">${product.name}</div>
            <div class="text-muted">${product.category}</div>
        </td>
        <td class="p-3 fw-medium text-center">${product.technology}</td>
        <td class="p-3 text-truncate text-center" style="max-width: 250px;">${product.description}</td>
        <td class="p-3 fw-medium text-center">${product.price}</td>
        <td class="p-3 fw-medium text-center">${product.discount}</td>
        <td class="p-3 text-center">
            <div class="d-flex flex-wrap gap-1 justify-content-center">
                <button class="btn btn-primary w-50 d-flex align-items-center justify-content-center" type="button"
                    data-bs-toggle="offcanvas" data-bs-target="#drawerUpdateProduct" aria-controls="drawerUpdateProduct">
                    <i class="bi bi-pencil-square"></i> Update
                </button>
                <button class="btn btn-primary w-50 d-flex align-items-center justify-content-center" type="button"
                    data-bs-toggle="offcanvas" data-bs-target="#drawerDetailProduct" aria-controls="drawerDetailProduct">
                    <i class="bi bi-pencil-square"></i> Detail
                </button>
                <button class="btn btn-danger w-50 d-flex align-items-center justify-content-center" type="button"
                    data-bs-toggle="offcanvas" data-bs-target="#drawerDeleteProduct" aria-controls="drawerDeleteProduct">
                    <i class="bi bi-trash"></i> Delete
                </button>
            </div>
        </td>
    `;


        tbody.appendChild(row);
    });
}

document.addEventListener("DOMContentLoaded", renderProducts);


// lưa trạng thái show 

document.addEventListener("DOMContentLoaded", function () {
    const collapseItems = ["sub", "subnav1"]; // Danh sách các ID collapse

    collapseItems.forEach(id => {
        let element = document.getElementById(id);
        if (element) {
            // Xóa class "show" mặc định
            element.classList.remove("show");

            // Nếu trong localStorage có lưu trạng thái mở => thêm class "show"
            if (localStorage.getItem(id) === "open") {
                element.classList.add("show");
            }
        }
    });
});

function toggleCollapse(id) {
    let element = document.getElementById(id);
    if (!element) return;

    let isCollapsed = element.classList.contains("show");

    if (isCollapsed) {
        localStorage.removeItem(id); // Nếu đang mở, khi nhấn sẽ đóng
        element.classList.remove("show");
    } else {
        localStorage.setItem(id, "open"); // Nếu đang đóng, khi nhấn sẽ mở
        element.classList.add("show");
    }
}
//

