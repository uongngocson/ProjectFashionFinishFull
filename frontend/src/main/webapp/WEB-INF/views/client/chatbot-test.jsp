<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Chatbot API Test</title>
            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        </head>

        <body>
            <h1>Chatbot API Testtt</h1>

            <div>
                <input type="text" id="messageInput" value="Hello, how are you?">
                <button id="sendButton">Send Test Message</button>
            </div>

            <h2>Response:</h2>
            <pre id="response"></pre>

            <script>
                $(document).ready(function () {
                    $("#sendButton").click(function () {
                        const message = $("#messageInput").val();

                        // Log to console
                        console.log("Sending message:", message);

                        // Clear previous response
                        $("#response").text("Sending request...");

                        // Send Ajax request
                        $.ajax({
                            url: "/chatbot/send",
                            type: "POST",
                            data: { message: message },
                            success: function (response) {
                                console.log("Response received:", response);
                                $("#response").text(JSON.stringify(response, null, 2));
                            },
                            error: function (xhr, status, error) {
                                console.error("Error:", error);
                                console.error("Status:", status);
                                console.error("Response:", xhr.responseText);
                                $("#response").text("Error: " + error + "\nStatus: " + status + "\nDetails: " + xhr.responseText);
                            }
                        });
                    });
                });
            </script>
        </body>

        </html>