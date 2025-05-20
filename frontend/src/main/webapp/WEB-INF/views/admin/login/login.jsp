<%@page contentType="text/html" pageEncoding="UTF-8" %>


    <!doctype html>
    <html lang="en">

    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="icon" type="image/png" href="./assets/img/favicon.png">
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/bootstrap.min.css">
        <!-- FontAwesome CSS -->
        <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/all.min.css">
        <link rel="stylesheet" href="../../../../resources/assets/dashboard/css/logindashboard.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    </head>

    <body>
        <div class="uf-form-signin">
            <div class="text-center">
                <a href=""><img src="../../../../resources/assets/dashboard/img/logo-fb.png" alt="" width="100"
                        height="100"></a>
                <h1 class="text-white h3">Account Login</h1>
            </div>
            <form class="mt-4">
                <div class="input-group uf-input-group input-group-lg mb-3">
                    <span class="input-group-text fa fa-user"></span>
                    <input type="text" class="form-control" placeholder="Username or Email address">
                </div>
                <div class="input-group uf-input-group input-group-lg mb-3">
                    <span class="input-group-text fa fa-lock"></span>
                    <input type="password" class="form-control" placeholder="Password">
                </div>
                <div class="d-flex mb-3 justify-content-between">
                    <div class="form-check">
                        <input type="checkbox" class="form-check-input uf-form-check-input" id="exampleCheck1">
                        <label class="form-check-label text-white" for="exampleCheck1">Remember Me</label>
                    </div>
                    <a class="cus-color" href="#">Forgot password?</a>
                </div>

                <div class="d-grid mb-4">

                    <button type="submit" class="btn uf-btn-primary btn-lg">Login</button>
                </div>
                <div class="d-flex mb-3">
                    <div class="dropdown-divider m-auto w-25"></div>
                    <small class="text-nowrap text-white">Or login with</small>
                    <div class="dropdown-divider m-auto w-25"></div>
                </div>
                <div class="uf-social-login d-flex justify-content-center">
                    <a href="#" class="uf-social-ic" title="Login with Facebook"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="uf-social-ic" title="Login with Twitter"><i class="fab fa-twitter"></i></a>
                    <a href="#" class="uf-social-ic" title="Login with Google"><i class="fab fa-google"></i></a>
                </div>
                <div class="mt-4 text-center">
                    <span class="text-white">Don't have an account?</span>
                    <a class="cus-color" href="/admin/register">Sign Up</a>
                </div>
            </form>
        </div>

        <!-- JavaScript -->

        <!-- Separate Popper and Bootstrap JS -->
        <script src="../../../../resources/assets/dashboard/js/popper.min.js"></script>
        <script src="../../../../resources/assets/dashboard/js/bootstrap.min.js"></script>
    </body>

    </html>