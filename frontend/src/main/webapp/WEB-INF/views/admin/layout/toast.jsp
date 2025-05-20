<%@page contentType="text/html" pageEncoding="UTF-8" %>

    <div class="fixed z-9999 right-0 bottom-0 p-4">
        <div id="toast-success"
            class="flex items-center w-full max-w-xs p-4 mb-4 text-gray-500 bg-white rounded-lg shadow hidden"
            role="alert">
            <div
                class="inline-flex items-center justify-center flex-shrink-0 w-8 h-8 text-green-500 bg-green-100 rounded-lg">
                <i class="fas fa-check"></i>
                <span class="sr-only">Success icon</span>
            </div>
            <div class="ml-3 text-sm font-normal">Login successful!</div>
            <button type="button"
                class="ml-auto -mx-1.5 -my-1.5 bg-white text-gray-400 hover:text-gray-900 rounded-lg focus:ring-2 focus:ring-gray-300 p-1.5 hover:bg-gray-100 inline-flex h-8 w-8"
                data-dismiss-target="#toast-success" aria-label="Close">
                <span class="sr-only">Close</span>
                <i class="fas fa-times"></i>
            </button>
        </div>

        <div id="toast-danger"
            class="flex items-center w-full max-w-xs p-4 mb-4 text-gray-500 bg-white rounded-lg shadow hidden"
            role="alert">
            <div
                class="inline-flex items-center justify-center flex-shrink-0 w-8 h-8 text-red-500 bg-red-100 rounded-lg">
                <i class="fas fa-times"></i>
                <span class="sr-only">Error icon</span>
            </div>
            <div class="ml-3 text-sm font-normal">Error occurred.</div>
            <button type="button"
                class="ml-auto -mx-1.5 -my-1.5 bg-white text-gray-400 hover:text-gray-900 rounded-lg focus:ring-2 focus:ring-gray-300 p-1.5 hover:bg-gray-100 inline-flex h-8 w-8"
                data-dismiss-target="#toast-danger" aria-label="Close">
                <span class="sr-only">Close</span>
                <i class="fas fa-times"></i>
            </button>
        </div>

        <div id="toast-warning"
            class="flex items-center w-full max-w-xs p-4 text-gray-500 bg-white rounded-lg shadow hidden" role="alert">
            <div
                class="inline-flex items-center justify-center flex-shrink-0 w-8 h-8 text-orange-500 bg-orange-100 rounded-lg">
                <i class="fas fa-exclamation-triangle"></i>
                <span class="sr-only">Warning icon</span>
            </div>
            <div class="ml-3 text-sm font-normal">Warning notification.</div>
            <button type="button"
                class="ml-auto -mx-1.5 -my-1.5 bg-white text-gray-400 hover:text-gray-900 rounded-lg focus:ring-2 focus:ring-gray-300 p-1.5 hover:bg-gray-100 inline-flex h-8 w-8"
                data-dismiss-target="#toast-warning" aria-label="Close">
                <span class="sr-only">Close</span>
                <i class="fas fa-times"></i>
            </button>
        </div>
    </div>

    <style>
        .fixed {
            position: fixed;
        }

        .z-9999 {
            z-index: 9999;
        }

        .hidden {
            display: none;
        }

        .flex {
            display: flex;
        }

        .items-center {
            align-items: center;
        }

        .rounded-lg {
            border-radius: 0.5rem;
        }

        .shadow {
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06);
        }

        .p-4 {
            padding: 1rem;
        }

        .mb-4 {
            margin-bottom: 1rem;
        }

        .ml-3 {
            margin-left: 0.75rem;
        }

        .ml-auto {
            margin-left: auto;
        }

        .text-sm {
            font-size: 0.875rem;
        }

        .font-normal {
            font-weight: 400;
        }

        .text-gray-500 {
            color: #6b7280;
        }

        .text-gray-400 {
            color: #9ca3af;
        }

        .bg-white {
            background-color: #ffffff;
        }

        .text-green-500 {
            color: #10b981;
        }

        .bg-green-100 {
            background-color: #d1fae5;
        }

        .text-red-500 {
            color: #ef4444;
        }

        .bg-red-100 {
            background-color: #fee2e2;
        }

        .text-orange-500 {
            color: #f97316;
        }

        .bg-orange-100 {
            background-color: #ffedd5;
        }

        .w-full {
            width: 100%;
        }

        .max-w-xs {
            max-width: 20rem;
        }

        .w-8 {
            width: 2rem;
        }

        .h-8 {
            height: 2rem;
        }

        .inline-flex {
            display: inline-flex;
        }

        .justify-center {
            justify-content: center;
        }

        .flex-shrink-0 {
            flex-shrink: 0;
        }

        .sr-only {
            position: absolute;
            width: 1px;
            height: 1px;
            padding: 0;
            margin: -1px;
            overflow: hidden;
            clip: rect(0, 0, 0, 0);
            white-space: nowrap;
            border-width: 0;
        }

        .hover\:text-gray-900:hover {
            color: #111827;
        }

        .hover\:bg-gray-100:hover {
            background-color: #f3f4f6;
        }
    </style>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            // Check for login or logout success parameter
            const urlParams = new URLSearchParams(window.location.search);

            // Handle login success
            if (urlParams.get('login') === 'success') {
                showToast('toast-success', 'Login successful!');
            }

            // Handle logout success
            if (urlParams.get('logout') === 'success') {
                showToast('toast-success', 'Logout successful!');
            }

            // Function to show a toast with the given message
            function showToast(toastId, message) {
                const toast = document.getElementById(toastId);
                if (toast) {
                    // Update toast message if needed
                    const toastMessage = toast.querySelector('.ml-3.text-sm.font-normal');
                    if (toastMessage) {
                        toastMessage.textContent = message;
                    }

                    // Show the toast
                    toast.classList.remove('hidden');

                    // Set timeout to hide toast after 3 seconds
                    setTimeout(function () {
                        toast.classList.add('hidden');
                    }, 3000);

                    // Clean URL by removing the parameter
                    const url = new URL(window.location);
                    url.searchParams.delete('login');
                    url.searchParams.delete('logout');
                    window.history.replaceState({}, '', url);
                }
            }

            // Set up click handlers for toast close buttons
            document.querySelectorAll('[data-dismiss-target]').forEach(button => {
                button.addEventListener('click', function () {
                    const target = this.getAttribute('data-dismiss-target');
                    document.querySelector(target).classList.add('hidden');
                });
            });
        });
    </script>