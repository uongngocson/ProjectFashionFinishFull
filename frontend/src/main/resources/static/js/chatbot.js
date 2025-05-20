/**
 * Chatbot helper functions
 */

// Format a date object to HH:MM format
function formatTime(date) {
    return `${date.getHours().toString().padStart(2, '0')}:${date.getMinutes().toString().padStart(2, '0')}`;
}

// Sanitize user input to prevent XSS
function sanitizeInput(input) {
    return input
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#039;");
}

// Toggle chatbot visibility
function toggleChatbot() {
    const chatbox = document.querySelector('.chatbot-container');
    if (chatbox) {
        chatbox.classList.toggle('hidden');
    }
} 