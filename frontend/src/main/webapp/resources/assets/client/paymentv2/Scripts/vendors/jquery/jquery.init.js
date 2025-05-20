// Block body scroll overlay
(function (name) {
    function BNS() {
        var settings = {
            prevScroll: 0, prevPosition: '', prevOverflow: '', prevClasses: '', on: false, classes: ''
        };

        var getPrev = function () {
            settings.prevScroll = (window.pageYOffset || document.documentElement.scrollTop) - (document.documentElement.clientTop || 0);
            settings.prevPosition = document.body.style.position;
            settings.prevOverflow = document.body.style.overflow;
            settings.prevClasses = document.body.className;
        };

        return {
            set: function (data) {
                settings.classes = data.classes;
            }, isOn: function () {
                return settings.on;
            }, on: function (additionalClasses) {
                if (typeof additionalClasses === 'undefined') additionalClasses = '';

                if (settings.on) return;
                settings.on = true;

                getPrev();

                document.body.className = document.body.className + ' ' + settings.classes + ' ' + additionalClasses;
                if (iOS()) {
                    if (settings.prevScroll == 0) {
                        settings.prevScroll = -1
                    }
                    document.body.style.top = -settings.prevScroll + 'px';
                    setTimeout(function () {
                        document.body.style.position = 'fixed';
                    }, 0); // WebKit/Blink bugfix
                }
                document.body.style.overflow = 'hidden';
            }, off: function () {
                if (!settings.on) return;
                settings.on = false;
                document.body.className = settings.prevClasses;
                if (iOS()) {
                    document.body.style.top = 0;
                }
                ; document.body.style.position = '';
                document.body.style.overflow = settings.prevOverflow;
                window.scrollTo(0, settings.prevScroll);
            }
        };
    }

    window[name] = new BNS();
})('BNS');
// Block body scroll overlay
//====================JQUERY BASIC INIT=================//

var deviceIsMobile = false; //At the beginning we set this flag as false. If we can detect the device is a mobile device in the next line, then we set it as true.
if (/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|ipad|iris|kindle|Android|Silk|lge |maemo|midp|mmp|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i.test(navigator.userAgent) || /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(navigator.userAgent.substr(0, 4))) {
    deviceIsMobile = true;
}

function iOS() {

    var iDevices = ['iPad Simulator', 'iPhone Simulator', 'iPod Simulator', 'iPad', 'iPhone', 'iPod'];

    if (!!navigator.platform) {
        while (iDevices.length) {
            if (navigator.platform === iDevices.pop()) {
                return true;
            }
        }
    }

    return false;
}

//====================END JQUERY BASIC INIT=================//
//====================JQUERY INPUT=================//
$(document).ready(function () {
    //input clear
    $('.input-ic-clear').on('mousedown', function () {
        //console.log("Clear");
        var input = $(this).closest('.input-inner-wrap').find('.input');
        input.val('');
        input.trigger('input');
        $(".domestic-bank").each(function (index) {
            $(this).removeClass('hidden');
        });
        $(".list-app-qr").each(function (index) {
            $(this).removeClass('hidden');
        });
    });
    $('.input-has-clear').on('paste keyup change', function () {
        //console.log("Remove");
        var inputClear = $(this).closest('.input-inner-wrap').find('.input-ic-clear');
        if ($(this).val()) {
            inputClear.addClass('show');
        } else {
            inputClear.removeClass('show');
            $(".domestic-bank").each(function (index) {
                $(this).removeClass('hidden');
            });
            $(".list-app-qr").each(function (index) {
                $(this).removeClass('hidden');
            });
        }
    });
    //end input clear
});

// Script to handle payment data from parent page
console.log('iframe-handler.js loaded and executing');

// Create debug overlay to visually display received data
function createDebugOverlay() {
    // Create a debug display container
    const debugDiv = document.createElement('div');
    debugDiv.id = 'debug-overlay';
    debugDiv.style.cssText = `
       
    `;
    document.body.appendChild(debugDiv);

    // Add content to the debug display


    return debugDiv;
}

// Update debug overlay with data
function updateDebugOverlay(type, data) {
    const debugDiv = document.getElementById('debug-overlay') || createDebugOverlay();

    switch (type) {
        case 'url':
            const urlDebug = document.getElementById('debug-url-params');
            if (urlDebug) {
                urlDebug.innerHTML = `<strong>URL Params:</strong><br>Amount: ${data.amount || 'None'}<br>Code: ${data.code || 'None'}`;
            }
            break;
        case 'localStorage':
            const lsDebug = document.getElementById('debug-localstorage');
            if (lsDebug) {
                lsDebug.innerHTML = `<strong>LocalStorage:</strong><br>Amount: ${data.amount || 'None'}<br>Code: ${data.code || 'None'}`;
            }
            break;
        case 'postMessage':
            const pmDebug = document.getElementById('debug-postmessage');
            if (pmDebug) {
                pmDebug.innerHTML = `<strong>PostMessage:</strong><br>Amount: ${data.amount || 'None'}<br>Code: ${data.code || 'None'}`;
            }
            break;
        case 'applied':
            const appliedDebug = document.getElementById('debug-applied');
            if (appliedDebug) {
                appliedDebug.innerHTML = `<strong>Applied to DOM:</strong><br>Amount: ${data.amount || 'None'}<br>Code: ${data.code || 'None'}`;
            }
            break;
    }
}

// Check if data exists in URL parameters
const urlParams = new URLSearchParams(window.location.search);
const urlAmount = urlParams.get('amount');
const urlCode = urlParams.get('code');
console.log('URL parameters:', { amount: urlAmount, code: urlCode });
updateDebugOverlay('url', { amount: urlAmount, code: urlCode });

// Check if data exists in localStorage
if (window.localStorage) {
    const localAmount = localStorage.getItem('paymentAmount');
    const localCode = localStorage.getItem('paymentTicketCode');
    console.log('localStorage data:', { amount: localAmount, code: localCode });
    updateDebugOverlay('localStorage', { amount: localAmount, code: localCode });
}

window.addEventListener('message', function (event) {
    // Check if message is payment data
    console.log('Message received in iframe:', event.data);

    if (event.data && event.data.type === 'paymentData') {
        try {
            const amount = event.data.amount;
            const code = event.data.code;

            console.log('Received payment data via postMessage:', { amount, code });
            updateDebugOverlay('postMessage', { amount, code });

            // Format the amount with proper formatting
            const formattedAmount = parseFloat(amount).toLocaleString('vi-VN');
            console.log('Formatted amount:', formattedAmount);

            // Update the total amount display on the page (mobile and desktop)
            const totalAmountDt = document.getElementById('totalAmountDt');
            if (totalAmountDt) {
                totalAmountDt.innerHTML = formattedAmount + '<sup>VND</sup>';
                console.log('Updated totalAmountDt:', totalAmountDt.innerHTML);
            } else {
                console.log('Element #totalAmountDt not found');
            }

            const totalAmountMb = document.getElementById('totalAmountMb');
            if (totalAmountMb) {
                totalAmountMb.innerHTML = formattedAmount + '<sup>VND</sup>';
                console.log('Updated totalAmountMb:', totalAmountMb.innerHTML);
            } else {
                console.log('Element #totalAmountMb not found');
            }

            // Update order value 
            const orderValueElements = document.querySelectorAll('.bills-list-item:nth-child(2) .title .h3');
            console.log('Order value elements found:', orderValueElements.length);
            orderValueElements.forEach((element, index) => {
                if (element) {
                    element.innerHTML = formattedAmount + '<sup>VND</sup>';
                    console.log(`Updated order value element ${index}:`, element.innerHTML);
                }
            });

            // Update order code - make sure to select the right element
            const orderCodeElements = document.querySelectorAll('.bills-list-item:nth-child(5) .title.text-left-md-right.h3');
            console.log('Order code elements found:', orderCodeElements.length);
            orderCodeElements.forEach((element, index) => {
                if (element) {
                    element.textContent = code;
                    console.log(`Updated order code element ${index}:`, element.textContent);
                }
            });

            // Direct update with exact HTML structure to ensure it works
            const allElements = document.querySelectorAll('.bills-list-item');
            console.log('Total bills-list-item elements found:', allElements.length);

            // Debug all bill list items
            allElements.forEach((item, index) => {
                const labelElement = item.querySelector('.sub-title');
                if (labelElement) {
                    console.log(`bills-list-item ${index} label:`, labelElement.textContent);
                }
            });

            let updatedAmount = false;
            let updatedCode = false;

            allElements.forEach((item, index) => {
                // Find the element containing "Mã đơn hàng" text
                const labelElement = item.querySelector('.sub-title');
                if (labelElement && labelElement.textContent.trim() === 'Mã đơn hàng') {
                    console.log('Found "Mã đơn hàng" element at index:', index);
                    const valueElement = item.querySelector('.title');
                    if (valueElement) {
                        valueElement.textContent = code;
                        console.log('Updated order code to:', code);
                        updatedCode = true;
                    } else {
                        console.log('Could not find .title element for order code');
                    }
                }

                // Find the element containing "Giá trị đơn hàng" text
                if (labelElement && labelElement.textContent.trim() === 'Giá trị đơn hàng') {
                    console.log('Found "Giá trị đơn hàng" element at index:', index);
                    const valueElement = item.querySelector('.title .h3');
                    if (valueElement) {
                        valueElement.innerHTML = formattedAmount + '<sup>VND</sup>';
                        console.log('Updated order value to:', formattedAmount);
                        updatedAmount = true;
                    } else {
                        console.log('Could not find .title .h3 element for order value');
                    }
                }
            });

            // Additional updates - try more general selectors
            if (!updatedCode) {
                const orderCodeLabels = document.querySelectorAll('.sub-title');
                orderCodeLabels.forEach(label => {
                    if (label.textContent.includes('Mã đơn hàng') ||
                        label.textContent.includes('Mã ĐH') ||
                        label.textContent.includes('đơn hàng')) {
                        const parent = label.closest('.bills-list-item');
                        if (parent) {
                            const valueElement = parent.querySelector('.title');
                            if (valueElement) {
                                valueElement.textContent = code;
                                console.log('Updated order code with alternative selector');
                                updatedCode = true;
                            }
                        }
                    }
                });
            }

            // Create a direct visible display if we couldn't update the existing elements
            if (!updatedAmount || !updatedCode) {
                // Create a visible display of the data on the page
                let dataDisplay = document.getElementById('payment-data-display');
                if (!dataDisplay) {
                    dataDisplay = document.createElement('div');
                    dataDisplay.id = 'payment-data-display';
                    dataDisplay.style.cssText = `
                        position: fixed;
                        bottom: 10px;
                        left: 10px;
                        background-color: #e4c590;
                        color: black;
                        padding: 15px;
                        border-radius: 5px;
                        z-index: 9999;
                        font-family: Arial, sans-serif;
                        font-size: 16px;
                    `;
                    document.body.appendChild(dataDisplay);
                }

                dataDisplay.innerHTML = `
                    <strong>Thông tin thanh toán:</strong><br>
                    Số tiền: ${formattedAmount} VND<br>
                    Mã đơn hàng: ${code}
                `;
            }

            updateDebugOverlay('applied', {
                amount: updatedAmount ? formattedAmount : 'Failed to update',
                code: updatedCode ? code : 'Failed to update'
            });

            // Send height to parent for iframe resizing
            sendHeightToParent();
        } catch (error) {
            console.error('Error processing payment data:', error);
        }
    }
});

// Function to send iframe height to parent
function sendHeightToParent() {
    if (window.parent) {
        const height = document.body.scrollHeight;
        console.log('Sending iframe height to parent:', height);
        window.parent.postMessage({
            type: 'iframeResize',
            height: height
        }, '*');
    }
}

// Send height on load and when window resizes
window.addEventListener('load', function () {
    console.log('iframe window loaded');
    sendHeightToParent();

    // Create initial debug overlay
    createDebugOverlay();
});

window.addEventListener('resize', sendHeightToParent);

// Add a global function to check data
window.checkPaymentData = function () {
    const totalAmountDt = document.getElementById('totalAmountDt');
    const orderCodeElement = document.querySelector('.bills-list-item:nth-child(5) .title');

    alert(`Current displayed values:\n
    Total amount: ${totalAmountDt ? totalAmountDt.innerText : 'Not found'}\n
    Order code: ${orderCodeElement ? orderCodeElement.innerText : 'Not found'}`);

    return {
        totalAmount: totalAmountDt ? totalAmountDt.innerText : null,
        orderCode: orderCodeElement ? orderCodeElement.innerText : null
    };
};

// Ensure the script is properly executed when the DOM is fully loaded
document.addEventListener('DOMContentLoaded', function () {
    console.log('DOM fully loaded in iframe');

    // Debug HTML structure
    console.log('Document body children:', document.body.children.length);

    // Check for important elements
    const billsItems = document.querySelectorAll('.bills-list-item');
    console.log('Bills list items found:', billsItems.length);

    // If there are URL parameters with payment data, process them
    const urlParams = new URLSearchParams(window.location.search);
    const amount = urlParams.get('amount');
    const code = urlParams.get('code');

    console.log('URL parameters detected in DOMContentLoaded:', { amount, code });

    if (amount && code) {
        processPaymentData(amount, code);
    }

    // Check for data in localStorage as a fallback
    if (window.localStorage) {
        const storedAmount = localStorage.getItem('paymentAmount');
        const storedCode = localStorage.getItem('paymentTicketCode');

        console.log('localStorage data detected in DOMContentLoaded:', { amount: storedAmount, code: storedCode });

        if (storedAmount && storedCode) {
            processPaymentData(storedAmount, storedCode);
        }
    }

    // Add a button to manually check for data

});

// Function to process payment data and update the UI
function processPaymentData(amount, code) {
    console.log('Processing payment data:', { amount, code });

    // Format the amount with proper formatting
    const formattedAmount = parseFloat(amount).toLocaleString('vi-VN');
    console.log('Formatted amount:', formattedAmount);

    // Update the total amount display on the page (mobile and desktop)
    const totalAmountDt = document.getElementById('totalAmountDt');
    if (totalAmountDt) {
        totalAmountDt.innerHTML = formattedAmount + '<sup>VND</sup>';
        console.log('Updated totalAmountDt:', totalAmountDt.innerHTML);
    } else {
        console.log('Element #totalAmountDt not found');
    }

    const totalAmountMb = document.getElementById('totalAmountMb');
    if (totalAmountMb) {
        totalAmountMb.innerHTML = formattedAmount + '<sup>VND</sup>';
        console.log('Updated totalAmountMb:', totalAmountMb.innerHTML);
    } else {
        console.log('Element #totalAmountMb not found');
    }

    // Update order value 
    const orderValueElements = document.querySelectorAll('.bills-list-item:nth-child(2) .title .h3');
    console.log('Order value elements found:', orderValueElements.length);
    orderValueElements.forEach((element, index) => {
        if (element) {
            element.innerHTML = formattedAmount + '<sup>VND</sup>';
            console.log(`Updated order value element ${index}:`, element.innerHTML);
        }
    });

    let updatedAmount = false;
    let updatedCode = false;

    // Direct update with exact HTML structure to ensure it works
    const allElements = document.querySelectorAll('.bills-list-item');
    console.log('Total bills-list-item elements found:', allElements.length);

    // Debug all bill list items
    allElements.forEach((item, index) => {
        const labelElement = item.querySelector('.sub-title');
        if (labelElement) {
            console.log(`bills-list-item ${index} label:`, labelElement.textContent);
        }
    });

    allElements.forEach((item) => {
        // Find the element containing "Mã đơn hàng" text
        const labelElement = item.querySelector('.sub-title');
        if (labelElement && labelElement.textContent.trim() === 'Mã đơn hàng') {
            const valueElement = item.querySelector('.title');
            if (valueElement) {
                valueElement.textContent = code;
                console.log('Updated order code to:', code);
                updatedCode = true;
            } else {
                console.log('Could not find .title element for order code');
            }
        }

        // Find the element containing "Giá trị đơn hàng" text
        if (labelElement && labelElement.textContent.trim() === 'Giá trị đơn hàng') {
            const valueElement = item.querySelector('.title .h3');
            if (valueElement) {
                valueElement.innerHTML = formattedAmount + '<sup>VND</sup>';
                console.log('Updated order value to:', formattedAmount);
                updatedAmount = true;
            } else {
                console.log('Could not find .title .h3 element for order value');
            }
        }
    });

    // Additional updates - try more general selectors
    if (!updatedCode) {
        const orderCodeLabels = document.querySelectorAll('.sub-title');
        orderCodeLabels.forEach(label => {
            if (label.textContent.includes('Mã đơn hàng') ||
                label.textContent.includes('Mã ĐH') ||
                label.textContent.includes('đơn hàng')) {
                const parent = label.closest('.bills-list-item');
                if (parent) {
                    const valueElement = parent.querySelector('.title');
                    if (valueElement) {
                        valueElement.textContent = code;
                        console.log('Updated order code with alternative selector');
                        updatedCode = true;
                    }
                }
            }
        });
    }

    // Create a direct visible display if we couldn't update the existing elements
    if (!updatedAmount || !updatedCode) {
        // Create a visible display of the data on the page
        let dataDisplay = document.getElementById('payment-data-display');
        if (!dataDisplay) {
            dataDisplay = document.createElement('div');
            dataDisplay.id = 'payment-data-display';
            dataDisplay.style.cssText = `
                position: fixed;
                bottom: 10px;
                left: 10px;
                background-color: #e4c590;
                color: black;
                padding: 15px;
                border-radius: 5px;
                z-index: 9999;
                font-family: Arial, sans-serif;
                font-size: 16px;
            `;
            document.body.appendChild(dataDisplay);
        }

        dataDisplay.innerHTML = `
            <strong>Thông tin thanh toán:</strong><br>
            Số tiền: ${formattedAmount} VND<br>
            Mã đơn hàng: ${code}
        `;
    }

    updateDebugOverlay('applied', {
        amount: updatedAmount ? formattedAmount : 'Failed to update',
        code: updatedCode ? code : 'Failed to update'
    });
}
//====================END JQUERY INPUT=================//