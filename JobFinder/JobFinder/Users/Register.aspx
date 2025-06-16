<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="JobFinder.User.Register" %>

<!DOCTYPE html>

<html class="no-js" lang="zxx">
<head runat="server">
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>JobFinder - Create Account</title>
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
            --primary-color: #FB246A; /* Updated to your preferred color */
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

        .register-section {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            padding: 2rem 0;
            min-height: 100vh;
            display: flex;
            align-items: center;
        }

        .register-card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
            padding: 3rem;
            margin: 2rem 0;
            position: relative;
            border: 1px solid var(--medium-gray);
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

            .register-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 15px 30px rgba(0,0,0,0.1);
            }

        .register-title {
            color: var(--text-color);
            font-weight: 700;
            margin-bottom: 2rem;
            text-align: center;
            font-size: 2rem;
            position: relative;
            padding-bottom: 15px;
        }

            .register-title:after {
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

        .section-title {
            color: var(--primary-color);
            font-weight: 600;
            margin: 2rem 0 1.5rem;
            padding-bottom: 0.75rem;
            border-bottom: 1px solid var(--medium-gray);
            font-size: 1.25rem;
            letter-spacing: -0.2px;
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

        .drop-down {
            border-radius: 8px;
            padding: 0.75rem 1rem;
            border: 1px solid var(--medium-gray);
            transition: all 0.3s;
            width: 100%;
            font-size: 0.95rem;
            box-shadow: none;
            background-color: white;
            appearance: none;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='%236B7280'%3e%3cpath d='M7 10l5 5 5-5z'/%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 1rem center;
            background-size: 1rem;
        }

            .drop-down:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 3px rgba(251, 36, 106, 0.1);
                outline: none;
            }

        .btn-register {
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

            .btn-register:hover {
                transform: translateY(-2px);
                box-shadow: 0 7px 14px rgba(251, 36, 106, 0.3);
                background: linear-gradient(135deg, var(--primary-hover), var(--primary-color));
            }

            .btn-register:active {
                transform: translateY(0);
            }

            .btn-register:after {
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

            .btn-register:focus:not(:active)::after {
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

        .password-strength {
            height: 6px;
            background: var(--light-gray);
            margin-top: 0.5rem;
            border-radius: 3px;
            overflow: hidden;
        }

        .password-strength-bar {
            height: 100%;
            width: 0;
            transition: width 0.3s, background-color 0.3s;
            border-radius: 3px;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
        }

        .back-button {
            position: absolute;
            top: 1.5rem;
            left: 1.5rem;
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

        .form-text {
            font-size: 0.85rem;
            color: var(--dark-gray);
            margin-top: 0.25rem;
        }

        /* Input group styles */
        .input-group {
            position: relative;
            display: flex;
            flex-wrap: wrap;
            align-items: stretch;
            width: 100%;
        }

        .input-group-append {
            margin-left: -1px;
            display: flex;
        }

            .input-group-append .btn {
                position: relative;
                z-index: 2;
                border-top-left-radius: 0;
                border-bottom-left-radius: 0;
                border-left: 0;
                background-color: white;
                border: 1px solid var(--medium-gray);
                color: var(--dark-gray);
                transition: all 0.3s;
                padding: 0 15px;
                display: flex;
                align-items: center;
                justify-content: center;
            }

                .input-group-append .btn:hover {
                    background-color: var(--light-gray);
                    color: var(--primary-color);
                    border-color: var(--medium-gray);
                }

        .input-group .form-control {
            position: relative;
            flex: 1 1 auto;
            width: 1%;
            min-width: 0;
            margin-bottom: 0;
            border-top-right-radius: 0;
            border-bottom-right-radius: 0;
        }

        /* Checkbox for terms */
        .terms-check {
            display: flex;
            align-items: flex-start;
            margin-top: 1.5rem;
        }

            .terms-check input {
                margin-right: 10px;
                margin-top: 3px;
            }

            .terms-check label {
                font-size: 0.9rem;
                color: var(--dark-gray);
                line-height: 1.5;
            }

            .terms-check a {
                color: var(--primary-color);
                text-decoration: none;
                font-weight: 500;
            }

                .terms-check a:hover {
                    text-decoration: underline;
                }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .register-card {
                padding: 2rem;
                margin: 1rem 0;
            }

            .register-title {
                font-size: 1.75rem;
                margin-top: 1rem;
            }

            .back-button {
                top: 1rem;
                left: 1rem;
                width: 36px;
                height: 36px;
            }
        }

        @media (max-width: 576px) {
            .register-card {
                padding: 1.5rem;
                border-radius: 12px;
            }

            .register-title {
                font-size: 1.5rem;
                margin-bottom: 1.5rem;
            }

            .section-title {
                font-size: 1.1rem;
                margin: 1.5rem 0 1rem;
            }
        }

        /* Animation for form elements */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(10px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .form-group {
            animation: fadeIn 0.4s ease-out forwards;
        }

            .form-group:nth-child(1) {
                animation-delay: 0.1s;
            }

            .form-group:nth-child(2) {
                animation-delay: 0.2s;
            }

            .form-group:nth-child(3) {
                animation-delay: 0.3s;
            }

            .form-group:nth-child(4) {
                animation-delay: 0.4s;
            }

            .form-group:nth-child(5) {
                animation-delay: 0.5s;
            }

            .form-group:nth-child(6) {
                animation-delay: 0.6s;
            }

        /* Password toggle button */
        .toggle-password {
            background: transparent;
            border: none;
            cursor: pointer;
            padding: 0 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--dark-gray);
        }

            .toggle-password:hover {
                color: var(--primary-color);
            }

        /* Custom checkbox */
        .custom-checkbox {
            position: relative;
            padding-left: 30px;
            cursor: pointer;
            user-select: none;
        }

            .custom-checkbox input {
                position: absolute;
                opacity: 0;
                cursor: pointer;
                height: 0;
                width: 0;
            }

        .checkmark {
            position: absolute;
            top: 0;
            left: 0;
            height: 20px;
            width: 20px;
            background-color: white;
            border: 1px solid var(--medium-gray);
            border-radius: 4px;
            transition: all 0.2s;
        }

        .custom-checkbox:hover input ~ .checkmark {
            border-color: var(--primary-color);
        }

        .custom-checkbox input:checked ~ .checkmark {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .checkmark:after {
            content: "";
            position: absolute;
            display: none;
            left: 7px;
            top: 3px;
            width: 5px;
            height: 10px;
            border: solid white;
            border-width: 0 2px 2px 0;
            transform: rotate(45deg);
        }

        .custom-checkbox input:checked ~ .checkmark:after {
            display: block;
        }
    </style>
    <!-- Add Font Awesome for the back button icon -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
</head>
<body>
    <form id="form1" runat="server">
        <section class="register-section">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-8">
                        <div class="register-card">
                            <!-- Back Button -->
                            <button type="button" class="back-button" onclick="window.history.back();">
                                <i class="fas fa-arrow-left"></i>
                            </button>

                            <h1 class="register-title">Join JobFinder</h1>

                            <!-- Message Panel -->
                            <asp:Panel ID="messagePanel" runat="server" Visible="false" CssClass="alert-message">
                                <asp:Literal ID="litMessage" runat="server"></asp:Literal>
                            </asp:Panel>

                            <div class="registration-form">
                                <h3 class="section-title">Account Details</h3>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="txtUserName" class="form-label">Username *</label>
                                            <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control"
                                                placeholder="e.g. john_doe" required></asp:TextBox>
                                            <small class="form-text">This will be your unique identifier</small>
                                            <asp:RequiredFieldValidator ID="rfvUserName" runat="server"
                                                ControlToValidate="txtUserName" ErrorMessage="Username is required"
                                                CssClass="validation-error" Display="Dynamic" SetFocusOnError="true">
                                            </asp:RequiredFieldValidator>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="txtEmail" class="form-label">Email Address *</label>
                                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"
                                                placeholder="your@email.com" TextMode="Email"></asp:TextBox>
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
                                    </div>

                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="txtPassword" class="form-label">Password *</label>
                                            <div class="input-group">
                                                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control"
                                                    placeholder="••••••••" TextMode="Password" required></asp:TextBox>
                                                <div class="input-group-append">
                                                    <button class="toggle-password" type="button"
                                                        data-target="<%= txtPassword.ClientID %>">
                                                        <i class="fas fa-eye"></i>
                                                    </button>
                                                </div>
                                            </div>
                                            <div class="password-strength">
                                                <div class="password-strength-bar" id="passwordStrengthBar"></div>
                                            </div>
                                            <small class="form-text">At least 8 characters with uppercase, number and symbol</small>
                                            <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
                                                ControlToValidate="txtPassword" ErrorMessage="Password is required"
                                                CssClass="validation-error" Display="Dynamic" SetFocusOnError="true">
                                            </asp:RequiredFieldValidator>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="txtConfirmPassword" class="form-label">Confirm Password *</label>
                                            <div class="input-group">
                                                <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control"
                                                    placeholder="••••••••" TextMode="Password" required></asp:TextBox>
                                                <div class="input-group-append">
                                                    <button class="toggle-password" type="button"
                                                        data-target="<%= txtConfirmPassword.ClientID %>">
                                                        <i class="fas fa-eye"></i>
                                                    </button>
                                                </div>
                                            </div>
                                            <asp:CompareValidator ID="CompareValidator1" runat="server"
                                                ErrorMessage="Passwords do not match"
                                                ControlToCompare="txtPassword" ControlToValidate="txtConfirmPassword"
                                                CssClass="validation-error" Display="Dynamic" SetFocusOnError="true">
                                            </asp:CompareValidator>
                                        </div>
                                    </div>
                                </div>

                                <h3 class="section-title">Personal Information</h3>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="txtFullName" class="form-label">Full Name *</label>
                                            <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control"
                                                placeholder="John Doe"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvFullName" runat="server"
                                                ControlToValidate="txtFullName" ErrorMessage="Full name is required"
                                                CssClass="validation-error" Display="Dynamic" SetFocusOnError="true">
                                            </asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                                                ErrorMessage="Name must contain only letters"
                                                CssClass="validation-error" Display="Dynamic" SetFocusOnError="true"
                                                ControlToValidate="txtFullName" ValidationExpression="^[a-zA-Z\s]+$">
                                            </asp:RegularExpressionValidator>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="txtMobile" class="form-label">Mobile Number *</label>
                                            <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control"
                                                placeholder="1234567890"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvMobile" runat="server"
                                                ControlToValidate="txtMobile" ErrorMessage="Mobile number is required"
                                                CssClass="validation-error" Display="Dynamic" SetFocusOnError="true">
                                            </asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server"
                                                ErrorMessage="Please enter a valid 10-digit number"
                                                CssClass="validation-error" Display="Dynamic" SetFocusOnError="true"
                                                ControlToValidate="txtMobile" ValidationExpression="^[0-9]{10}$">
                                            </asp:RegularExpressionValidator>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="ddlCountry" class="form-label">Country *</label>
                                            <asp:DropDownList ID="ddlCountry" runat="server"
                                                DataSourceID="SqlDataSource1" DataTextField="CountryName"
                                                DataValueField="CountryId" CssClass="drop-down"
                                                AppendDataBoundItems="true">
                                                <asp:ListItem Value="0">Select Country</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="rfvCountry" runat="server"
                                                ControlToValidate="ddlCountry" InitialValue="0"
                                                ErrorMessage="Please select your country" CssClass="validation-error"
                                                Display="Dynamic" SetFocusOnError="true">
                                            </asp:RequiredFieldValidator>
                                            <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                                                ConnectionString="<%$ ConnectionStrings:JobFinderContext %>"
                                                SelectCommand="SELECT CountryId, CountryName FROM Country"></asp:SqlDataSource>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <label for="txtAddress" class="form-label">Address</label>
                                            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control"
                                                placeholder="123 Main St, City" TextMode="MultiLine" Rows="1"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>

                                <div class="terms-check">
                                    <label class="custom-checkbox">
                                        <asp:CheckBox ID="chkTerms" runat="server" />
                                        <span class="checkmark"></span>
                                        I agree to the <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a>
                                    </label>
                                    <asp:CustomValidator ID="cvTerms" runat="server"
                                        ErrorMessage="You must accept the terms and conditions"
                                        CssClass="validation-error" Display="Dynamic"
                                        ClientValidationFunction="validateTerms"
                                        OnServerValidate="cvTerms_ServerValidate">
                                    </asp:CustomValidator>
                                </div>

                                <div class="form-group mt-4">
                                    <asp:Button ID="btnRegister" runat="server" Text="Create Account"
                                        CssClass="btn-register" OnClick="btnRegister_Click" />
                                </div>

                                <div class="login-link">
                                    Already have an account? <a href="../User/Login.aspx">Sign in</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </form>
    <script>
        // Password strength indicator
        document.getElementById('<%= txtPassword.ClientID %>').addEventListener('input', function () {
            var password = this.value;
            var strengthBar = document.getElementById('passwordStrengthBar');
            var strength = 0;

            // Length check
            if (password.length > 0) strength += 20;
            if (password.length >= 8) strength += 20;

            // Complexity checks
            if (/[A-Z]/.test(password)) strength += 20;
            if (/[0-9]/.test(password)) strength += 20;
            if (/[^A-Za-z0-9]/.test(password)) strength += 20;

            strengthBar.style.width = strength + '%';

            // Update color based on strength
            if (strength < 40) {
                strengthBar.style.background = 'linear-gradient(90deg, #FB246A, #FB246A)';
            } else if (strength < 80) {
                strengthBar.style.background = 'linear-gradient(90deg, #FB246A, #FF7B9C)';
            } else {
                strengthBar.style.background = 'linear-gradient(90deg, #FB246A, #10B981)';
            }
        });

        // Toggle password visibility
        document.querySelectorAll('.toggle-password').forEach(function (button) {
            button.addEventListener('click', function () {
                const targetId = this.getAttribute('data-target');
                const passwordInput = document.getElementById(targetId);
                const icon = this.querySelector('i');

                if (passwordInput.type === 'password') {
                    passwordInput.type = 'text';
                    icon.classList.remove('fa-eye');
                    icon.classList.add('fa-eye-slash');
                } else {
                    passwordInput.type = 'password';
                    icon.classList.remove('fa-eye-slash');
                    icon.classList.add('fa-eye');
                }
            });
        });

        // Add ripple effect to button
        document.querySelectorAll('.btn-register').forEach(button => {
            button.addEventListener('click', function (e) {
                let x = e.clientX - e.target.getBoundingClientRect().left;
                let y = e.clientY - e.target.getBoundingClientRect().top;

                let ripples = document.createElement('span');
                ripples.style.left = x + 'px';
                ripples.style.top = y + 'px';
                this.appendChild(ripples);

                setTimeout(() => {
                    ripples.remove();
                }, 1000);
            });
        });

        // Add animation to form elements
        const formGroups = document.querySelectorAll('.form-group');
        formGroups.forEach((group, index) => {
            group.style.opacity = '0';
            group.style.transform = 'translateY(10px)';
            group.style.animationDelay = `${index * 0.1}s`;
        });

        function validateTerms(source, args) {
            args.IsValid = document.getElementById('<%= chkTerms.ClientID %>').checked;
        }

    </script>
</body>
</html>
