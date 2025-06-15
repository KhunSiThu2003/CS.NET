<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true"
    CodeBehind="Register.aspx.cs" Inherits="JobFinder.User.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .register-section {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            padding: 3rem 0;
            min-height: 100vh;
            display: flex;
            align-items: center;
        }

        .register-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            padding: 2.5rem;
            margin: 2rem 0;
            position: relative;
            border: none;
            overflow: hidden;
        }


        .register-title {
            color: #2c3e50;
            font-weight: 700;
            margin-bottom: 1.5rem;
            text-align: center;
            font-size: 2rem;
            position: relative;
            padding-bottom: 10px;
        }



        .section-title {
            color: #FB246A;
            font-weight: 600;
            margin: 1.5rem 0 1rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid #f1f1f1;
            font-size: 1.2rem;
        }

        .form-label {
            font-weight: 500;
            color: #495057;
            margin-bottom: 0.5rem;
            display: block;
        }

        .form-control {
            border-radius: 8px;
            padding: 0.75rem 1rem;
            border: 1px solid #e0e0e0;
            transition: all 0.3s;
            width: 100%;
            font-size: 0.95rem;
            box-shadow: inset 0 1px 2px rgba(0,0,0,0.05);
        }

        .drop-down {
            border-radius: 8px;
            border: 1px solid #e0e0e0;
            transition: all 0.3s;
            width: 100%;
            font-size: 0.95rem;
            box-shadow: inset 0 1px 2px rgba(0,0,0,0.05);
        }

        .form-control:focus {
            border-color: #FB246A;
            box-shadow: 0 0 0 0.2rem rgba(251, 36, 106, 0.25);
            outline: none;
        }

        /* Custom Select Box Styling */
        .custom-select {
            position: relative;
            display: block;
        }

            .custom-select select {
                appearance: none;
                -webkit-appearance: none;
                -moz-appearance: none;
                background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='%23FB246A'%3e%3cpath d='M7 10l5 5 5-5z'/%3e%3c/svg%3e");
                background-repeat: no-repeat;
                background-position: right 1rem center;
                background-size: 1rem;
                padding-right: 2.5rem;
            }

        .btn-register {
            background: linear-gradient(135deg, #FB246A, #ff7b9c);
            border: none;
            color: white;
            padding: 0.75rem 2rem;
            font-weight: 600;
            border-radius: 8px;
            width: 100%;
            margin-top: 1.5rem;
            transition: all 0.3s;
            cursor: pointer;
            font-size: 1rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            box-shadow: 0 4px 6px rgba(251, 36, 106, 0.2);
        }

            .btn-register:hover {
                transform: translateY(-2px);
                box-shadow: 0 7px 14px rgba(251, 36, 106, 0.3);
                background: linear-gradient(135deg, #e61e5d, #FB246A);
            }

        .validation-error {
            color: #e74c3c;
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
        }

        .password-strength {
            height: 5px;
            background: #f1f1f1;
            margin-top: 0.5rem;
            border-radius: 5px;
            overflow: hidden;
        }

        .password-strength-bar {
            height: 100%;
            width: 0;
            transition: width 0.3s, background-color 0.3s;
            border-radius: 5px;
            background: linear-gradient(90deg, #FB246A, #ff7b9c);
        }

        .back-button {
            position: absolute;
            top: 1.5rem;
            left: 1.5rem;
            background: #f8f9fa;
            border: none;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            z-index: 1;
        }

            .back-button:hover {
                background: #e9ecef;
                transform: translateX(-3px);
                box-shadow: 0 3px 8px rgba(0,0,0,0.15);
            }

            .back-button i {
                font-size: 1.2rem;
                color: #495057;
            }

        .login-link {
            text-align: center;
            margin-top: 1.5rem;
            color: #6c757d;
            font-size: 0.95rem;
        }

            .login-link a {
                color: #FB246A;
                font-weight: 600;
                text-decoration: none;
                transition: color 0.3s;
            }

                .login-link a:hover {
                    color: #e61e5d;
                    text-decoration: underline;
                }

        .form-text {
            font-size: 0.85rem;
            color: #6c757d;
            margin-top: 0.25rem;
        }

        /* Floating label effect */
        .floating-label-group {
            position: relative;
            margin-bottom: 1.5rem;
        }

        .floating-label {
            position: absolute;
            pointer-events: none;
            left: 15px;
            top: 12px;
            transition: 0.2s ease all;
            color: #999;
            font-size: 0.95rem;
            background: white;
            padding: 0 5px;
        }

        .form-control:focus ~ .floating-label,
        .form-control:not(:placeholder-shown) ~ .floating-label {
            top: -10px;
            left: 10px;
            font-size: 0.8rem;
            color: #FB246A;
            background: white;
        }

        @media (max-width: 768px) {
            .register-card {
                padding: 2rem 1.5rem;
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

        /* Update existing styles for the input group */
        .input-group-append .btn {
            border-color: #e0e0e0;
            border-left: none;
            border-radius: 0 8px 8px 0;
            background-color: #f8f9fa;
            color: #495057;
            transition: all 0.3s;
            height: 100%; /* Match the height of the input field */
            padding: 0 12px; /* Adjust padding to make it more compact */
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* Make sure the button doesn't stretch */
        .input-group-append {
            width: auto;
        }

            /* Adjust the icon size */
            .input-group-append .btn i {
                font-size: 1rem; /* Slightly smaller icon */
            }

            /* Hover state */
            .input-group-append .btn:hover {
                background-color: #e9ecef;
                color: #FB246A;
            }

        /* Input field adjustments */
        .input-group .form-control {
            border-right: none;
            border-radius: 8px 0 0 8px !important;
            height: auto; /* Ensure consistent height */
        }

        .input-group {
            display: flex;
            align-items: stretch; /* Make sure button stretches to input height */
        }
    </style>
    <!-- Add Font Awesome for the back button icon -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="register-section">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="register-card">
                        <!-- Back Button -->
                        <button class="back-button" onclick="window.history.back();">
                            <i class="fas fa-arrow-left"></i>
                        </button>

                        <h1 class="register-title">Create Your Account</h1>

                        <!-- Message Panel -->
                        <asp:Panel ID="messagePanel" runat="server" Visible="false" CssClass="alert-message alert alert-success">
                            <asp:Literal ID="litMessage" runat="server"></asp:Literal>
                        </asp:Panel>

                        <div class="registration-form">
                            <h3 class="section-title">Login Information</h3>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="txtUserName" class="form-label">Username</label>
                                        <asp:TextBox ID="txtUserName" runat="server" CssClass="form-control"
                                            placeholder="Enter unique username" required></asp:TextBox>
                                        <small class="form-text text-muted">This will be your login ID</small>
                                        <asp:RequiredFieldValidator ID="rfvUserName" runat="server"
                                            ControlToValidate="txtUserName" ErrorMessage="Username is required"
                                            CssClass="validation-error" Display="Dynamic" SetFocusOnError="true">
                                        </asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="txtEmail" class="form-label">Email Address</label>
                                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"
                                            placeholder="Enter your email" TextMode="Email"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                                            ControlToValidate="txtEmail" ErrorMessage="Email is required"
                                            CssClass="validation-error" Display="Dynamic" SetFocusOnError="true">
                                        </asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="revEmail" runat="server"
                                            ErrorMessage="Invalid email format"
                                            CssClass="validation-error" Display="Dynamic" SetFocusOnError="true"
                                            ControlToValidate="txtEmail"
                                            ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$">
                                        </asp:RegularExpressionValidator>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="txtPassword" class="form-label">Password</label>
                                        <div class="input-group">
                                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control"
                                                placeholder="Enter password" TextMode="Password" required></asp:TextBox>
                                            <div class="input-group-append">
                                                <button class="btn btn-outline-secondary toggle-password" type="button"
                                                    data-target="<%= txtPassword.ClientID %>" style="min-width: 40px;">
                                                    <i class="fas fa-eye"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <div class="password-strength">
                                            <div class="password-strength-bar" id="passwordStrengthBar"></div>
                                        </div>
                                        <small class="form-text text-muted">Minimum 8 characters with uppercase, number and
                                            symbol</small>
                                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server"
                                            ControlToValidate="txtPassword" ErrorMessage="Password is required"
                                            CssClass="validation-error" Display="Dynamic" SetFocusOnError="true">
                                        </asp:RequiredFieldValidator>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="txtConfirmPassword" class="form-label">Confirm Password</label>
                                        <div class="input-group">
                                            <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control"
                                                placeholder="Confirm password" TextMode="Password" required></asp:TextBox>
                                            <div class="input-group-append">
                                                <button class="btn btn-outline-secondary toggle-password" type="button"
                                                    data-target="<%= txtConfirmPassword.ClientID %>" style="min-width: 40px;">
                                                    <i class="fas fa-eye"></i>
                                                </button>
                                            </div>
                                        </div>
                                        <asp:CompareValidator ID="CompareValidator1" runat="server"
                                            ErrorMessage="Passwords must match"
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
                                        <label for="txtFullName" class="form-label">Full Name</label>
                                        <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control"
                                            placeholder="Enter your full name"></asp:TextBox>
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
                                        <label for="txtMobile" class="form-label">Mobile Number</label>
                                        <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control"
                                            placeholder="Enter 10-digit mobile number"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvMobile" runat="server"
                                            ControlToValidate="txtMobile" ErrorMessage="Mobile number is required"
                                            CssClass="validation-error" Display="Dynamic" SetFocusOnError="true">
                                        </asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server"
                                            ErrorMessage="Mobile number must have 10 digits"
                                            CssClass="validation-error" Display="Dynamic" SetFocusOnError="true"
                                            ControlToValidate="txtMobile" ValidationExpression="^[0-9]{10}$">
                                        </asp:RegularExpressionValidator>
                                    </div>
                                </div>


                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label for="ddlCountry" class="form-label">Country</label>
                                        <asp:DropDownList ID="ddlCountry" runat="server"
                                            DataSourceID="SqlDataSource1" DataTextField="CountryName"
                                            DataValueField="CountryId" CssClass="drop-down"
                                            AppendDataBoundItems="true">
                                            <asp:ListItem Value="0">Select your country</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvCountry" runat="server"
                                            ControlToValidate="ddlCountry" InitialValue="0"
                                            ErrorMessage="Country is required" CssClass="validation-error"
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
                                            placeholder="Enter your address" TextMode="MultiLine" Rows="1"></asp:TextBox>
                                    </div>
                                </div>
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
                strengthBar.style.backgroundColor = '#e74c3c'; // Red
            } else if (strength < 80) {
                strengthBar.style.backgroundColor = '#f39c12'; // Orange
            } else {
                strengthBar.style.backgroundColor = '#2ecc71'; // Green
            }
        });

        // Handle back button click
        function goBack() {
            window.history.back();
        }

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
    </script>
</asp:Content>
