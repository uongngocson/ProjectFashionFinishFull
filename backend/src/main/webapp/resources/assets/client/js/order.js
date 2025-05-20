// Toggle billing address fields
document.getElementById('sameAsShipping').addEventListener('change', function () {
    const billingFields = document.getElementById('billingFields');
    if (this.checked) {
        billingFields.classList.add('hidden');
    } else {
        billingFields.classList.remove('hidden');
    }
});

// Payment method selection
const paymentMethods = document.querySelectorAll('.payment-method');
paymentMethods.forEach(method => {
    method.addEventListener('click', function () {
        // Remove selected class from all methods
        paymentMethods.forEach(m => {
            m.classList.remove('selected');
            m.querySelector('.w-4.h-4').classList.remove('bg-black');
            m.querySelector('.w-4.h-4').classList.add('bg-transparent');
        });

        // Add selected class to clicked method
        this.classList.add('selected');
        this.querySelector('.w-4.h-4').classList.remove('bg-transparent');
        this.querySelector('.w-4.h-4').classList.add('bg-black');
    });
});

// Format credit card input
document.getElementById('cardNumber').addEventListener('input', function (e) {
    let value = this.value.replace(/\s+/g, '').replace(/[^0-9]/gi, '');
    let matches = value.match(/\d{4,16}/g);
    let match = matches && matches[0] || '';
    let parts = [];

    for (let i = 0, len = match.length; i < len; i += 4) {
        parts.push(match.substring(i, i + 4));
    }

    if (parts.length) {
        this.value = parts.join(' ');
    }
});

// Format expiry date input
document.getElementById('expiry').addEventListener('input', function (e) {
    let value = this.value.replace(/\s+/g, '').replace(/[^0-9]/gi, '');
    if (value.length > 2) {
        this.value = value.substring(0, 2) + '/' + value.substring(2, 4);
    }
});