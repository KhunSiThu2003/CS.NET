<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="JobFinder.User.ForgotPassword" %>

<!DOCTYPE html>

<html class="no-js" lang="zxx">
<head runat="server">
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>JobFinder - Forgot Password</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="manifest" href="site.webmanifest">
    <link rel="shortcut icon" type="image/x-icon" href="../assets/img/favicon.ico">

    <!-- CSS here -->
    <link rel="stylesheet" href="../assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="../assets/css/owl.carousel.min.css">
    <link rel="stylesheet" href="../assets/css/flaticon.css">
    <link rel="stylesheet" href="../assets/css/price_rangs.css">
    <link rel="stylesheet" href="../assets/css/slicknav.css">
    <link rel="stylesheet" href="../assets/css/animate.min.css">
    <link rel="stylesheet" href="../assets/css/magnific-popup.css">
    <link rel="stylesheet" href="../assets/css/fontawesome-all.min.css">
    <link rel="stylesheet" href="../assets/css/themify-icons.css">
    <link rel="stylesheet" href="../assets/css/slick.css">
    <link rel="stylesheet" href="../assets/css/nice-select.css">
    <link rel="stylesheet" href="../assets/css/style.css">

    <style>
        :root {
            --primary-color: #FB246A;
            --primary-hover: #E61E5D;
            --secondary-color: #FF7B9C;
            --error-color: #EF4444;
            --text-color: #1F2937;
            --light-gray: #F3F4F6;
            --medium-gray: #E5E7EB;
            --dark-gray: #6B7280;
            --success-color: #10B981;
        }

        body {
            background-color: #F9FAFB;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            color: var(--text-color);
        }

        .forgot-password-section {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            min-height: 100vh;
            width: 100vw;
            display: flex;
            align-items: center;
        }

        .forgot-password-card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
            padding: 3rem;
            margin: 2rem 0;
            position: relative;
            border: 1px solid var(--medium-gray);
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            width: 100%;
            max-width: 500px;
        }

        .forgot-password-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.1);
        }

        .forgot-password-title {
            color: var(--text-color);
            font-weight: 700;
            margin-bottom: 2rem;
            text-align: center;
            font-size: 2rem;
            position: relative;
            padding-bottom: 15px;
        }

        .forgot-password-title:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            border-radius: 2px;
        }

        .form-label {
            font-weight: 500;
            color: var(--text-color);
            margin-bottom: 0.5rem;
            display: block;
            font-size: 0.95rem;
        }

        .form-control {
            border-radius: 8px;
            padding: 0.75rem 1rem;
            border: 1px solid var(--medium-gray);
            transition: all 0.3s;
            width: 100%;
            font-size: 0.95rem;
            box-shadow: none;
            background-color: white;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(251, 36, 106, 0.1);
            outline: none;
        }

        .btn-reset {
            background: linear-gradient(135deg, var(--primary-color), var(--primary-hover));
            border: none;
            color: white;
            padding: 1rem 2rem;
            font-weight: 600;
            border-radius: 8px;
            width: 100%;
            margin-top: 1.5rem;
            transition: all 0.3s;
            cursor: pointer;
            font-size: 1rem;
            letter-spacing: 0.5px;
            box-shadow: 0 4px 6px rgba(251, 36, 106, 0.2);
            position: relative;
            overflow: hidden;
        }

        .btn-reset:hover {
            transform: translateY(-2px);
            box-shadow: 0 7px 14px rgba(251, 36, 106, 0.3);
            background: linear-gradient(135deg, var(--primary-hover), var(--primary-color));
        }

        .btn-reset:active {
            transform: translateY(0);
        }

        .btn-reset:after {
            content: "";
            position: absolute;
            top: 50%;
            left: 50%;
            width: 5px;
            height: 5px;
            background: rgba(255, 255, 255, 0.5);
            opacity: 0;
            border-radius: 100%;
            transform: scale(1, 1) translate(-50%);
            transform-origin: 50% 50%;
        }

        .btn-reset:focus:not(:active)::after {
            animation: ripple 1s ease-out;
        }

        @keyframes ripple {
            0% {
                transform: scale(0, 0);
                opacity: 0.5;
            }
            100% {
                transform: scale(20, 20);
                opacity: 0;
            }
        }

        .validation-error {
            color: var(--error-color);
            font-size: 0.85rem;
            margin-top: 0.25rem;
            display: block;
        }

        .form-group {
            margin-bottom: 1.5rem;
            position: relative;
            animation: fadeIn 0.4s ease-out forwards;
        }

        .alert-message {
            border-radius: 8px;
            padding: 1rem;
            margin-bottom: 1.5rem;
            border: none;
            font-weight: 500;
            background-color: var(--success-color);
            color: white;
            text-align: center;
        }

        .alert-message.error {
            background-color: var(--error-color);
        }

        .login-link {
            text-align: center;
            margin-top: 1.5rem;
            color: var(--dark-gray);
            font-size: 0.95rem;
        }

        .login-link a {
            color: var(--primary-color);
            font-weight: 600;
            text-decoration: none;
            transition: color 0.3s;
        }

        .login-link a:hover {
            color: var(--primary-hover);
            text-decoration: underline;
        }

        .back-button {
            position: absolute;
            top: 1.5rem;
            right: 1.5rem;
            background: white;
            border: 1px solid var(--medium-gray);
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            z-index: 1;
            color: var(--dark-gray);
        }

        .back-button:hover {
            background: var(--light-gray);
            transform: translateX(-3px);
            box-shadow: 0 3px 8px rgba(0,0,0,0.1);
            color: var(--primary-color);
            border-color: var(--primary-color);
        }

        @media (max-width: 768px) {
            .forgot-password-card {
                padding: 2rem;
                margin: 1rem;
            }

            .forgot-password-title {
                font-size: 1.75rem;
                margin-top: 1rem;
            }

            .back-button {
                top: 1rem;
                right: 1rem;
                width: 36px;
                height: 36px;
            }
        }

        @media (max-width: 576px) {
            .forgot-password-card {
                padding: 1.5rem;
                border-radius: 12px;
            }

            .forgot-password-title {
                font-size: 1.5rem;
                margin-bottom: 1.5rem;
            }
        }

        /* Animation for form elements */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .form-group:nth-child(1) { animation-delay: 0.1s; }
        .form-group:nth-child(2) { animation-delay: 0.2s; }
    </style>

    <!-- Add Font Awesome for the back button icon -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
</head>
<body>
    <form id="form1" runat="server">
        <section class="forgot-password-section">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-6">
                        <div class="forgot-password-card">
                            <!-- Back Button -->
                            <button type="button" class="back-button" onclick="window.history.back();">
                                <i class="fas fa-arrow-left"></i>
                            </button>

                            <h1 class="forgot-password-title">Reset Password</h1>

                            <!-- Message Panel -->
                            <asp:Panel ID="messagePanel" runat="server" Visible="false" CssClass="alert-message">
                                <asp:Literal ID="litMessage" runat="server"></asp:Literal>
                            </asp:Panel>

                            <div class="forgot-password-form">
                                <div class="form-group">
                                    <label for="txtEmail" class="form-label">Email Address</label>
                                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"
                                        placeholder="Enter your email address" TextMode="Email"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                                        ControlToValidate="txtEmail" ErrorMessage="Email is required"
                                        CssClass="validation-error" Display="Dynamic" SetFocusOnError="true">
                                    </asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revEmail" runat="server"
                                        ErrorMessage="Please enter a valid email address"
                                        CssClass="validation-error" Display="Dynamic" SetFocusOnError="true"
                                        ControlToValidate="txtEmail"
                                        ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$">
                                    </asp:RegularExpressionValidator>
                                </div>

                                <div class="form-group">
                                    <asp:Button ID="btnResetPassword" runat="server" Text="Send Reset Link"
                                        CssClass="btn-reset" OnClick="btnResetPassword_Click" />
                                </div>

                                <div class="login-link">
                                    Remember your password? <a href="Login.aspx">Sign in</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </form>

    <script>
        // Add animation to form elements
        const formGroups = document.querySelectorAll('.form-group');
        formGroups.forEach((group, index) => {
            group.style.opacity = '0';
            group.style.transform = 'translateY(10px)';
            group.style.animationDelay = `${index * 0.1}s`;
        });
    </script>
</body>
</html>