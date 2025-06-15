<%@ Page Title="Login" Language="C#" MasterPageFile="~/TopHeader.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Online_Banking_Transaction.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .gradient-bg {
            background: linear-gradient(135deg, #4f6bdd 0%, #3a56b1 100%);
        }
        .input-focus-effect:focus {
            box-shadow: 0 0 0 3px rgba(79, 107, 221, 0.2);
        }
        .btn-hover-effect:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        .link-hover:hover {
            text-decoration: underline;
            text-underline-offset: 3px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="min-h-screen flex items-center justify-center p-4 gradient-bg">
        <div class="w-full max-w-md bg-white rounded-xl shadow-2xl overflow-hidden">
            <!-- Header Section -->
            <div class="bg-blue-700 py-6 px-8 text-center">
                <div class="flex justify-center mb-4">
                    <div class="w-16 h-16 bg-white rounded-full flex items-center justify-center">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-blue-700" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 11c0 3.517-1.009 6.799-2.753 9.571m-3.44-2.04l.054-.09A13.916 13.916 0 008 11a4 4 0 118 0c0 1.017-.07 2.019-.203 3m-2.118 6.844A21.88 21.88 0 0015.171 17m3.839 1.132c.645-2.266.99-4.659.99-7.132A8 8 0 008 4.07M3 15.364c.64-1.319 1-2.8 1-4.364 0-1.457.39-2.823 1.07-4" />
                        </svg>
                    </div>
                </div>
                <h1 class="text-2xl font-bold text-white">Welcome Back</h1>
                <p class="text-blue-100 mt-1">Sign in to access your account</p>
            </div>

            <!-- Form Section -->
            <div class="p-8">
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
                    CssClass="mb-4 p-3 bg-red-50 text-red-600 rounded-lg text-sm" 
                    HeaderText="Please correct the following:" />

                <asp:Label ID="lblMessage" runat="server" 
                    CssClass="block mb-4 p-3 rounded-lg text-sm" 
                    Visible="false" />

                <div class="space-y-5">
                    <!-- Username Field -->
                    <div>
                        <label for="txtUsername" class="block text-sm font-medium text-gray-700 mb-1">Username</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <svg class="h-5 w-5 text-gray-400" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z" clip-rule="evenodd"></path>
                                </svg>
                            </div>
                            <asp:TextBox ID="txtUsername" runat="server" 
                                CssClass="pl-10 w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none input-focus-effect" 
                                placeholder="Enter your username" />
                        </div>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                            ControlToValidate="txtUsername" ErrorMessage="Username is required" 
                            CssClass="text-red-500 text-xs mt-1 block" Display="Dynamic" />
                    </div>

                    <!-- Password Field -->
                    <div>
                        <label for="txtPassword" class="block text-sm font-medium text-gray-700 mb-1">Password</label>
                        <div class="relative">
                            <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                <svg class="h-5 w-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path>
                                </svg>
                            </div>
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" 
                                CssClass="pl-10 w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none input-focus-effect" 
                                placeholder="Enter your password" />
                        </div>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                            ControlToValidate="txtPassword" ErrorMessage="Password is required" 
                            CssClass="text-red-500 text-xs mt-1 block" Display="Dynamic" />
                    </div>

                    <!-- Remember Me & Forgot Password -->
                    <div class="flex items-center justify-between">
                        <div class="flex items-center">
                            <input id="remember-me" name="remember-me" type="checkbox" class="h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded">
                            <label for="remember-me" class="ml-2 block text-sm text-gray-700">Remember me</label>
                        </div>
                        <div class="text-sm">
                            <asp:LinkButton ID="lbForgotPassword" runat="server" 
                                CssClass="font-medium text-blue-600 hover:text-blue-500 link-hover" 
                                OnClick="lbForgotPassword_Click">
                                Forgot password?
                            </asp:LinkButton>
                        </div>
                    </div>

                    <!-- Login Button -->
                    <div>
                        <asp:Button ID="btnLogin" runat="server" Text="Sign In" 
                            CssClass="w-full flex justify-center py-3 px-4 border border-transparent rounded-lg shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition-all duration-200 btn-hover-effect" 
                            OnClick="btnLogin_Click" />
                    </div>

                    <!-- Divider -->
                    <div class="relative">
                        <div class="absolute inset-0 flex items-center">
                            <div class="w-full border-t border-gray-300"></div>
                        </div>
                        <div class="relative flex justify-center text-sm">
                            <span class="px-2 bg-white text-gray-500">Or continue with</span>
                        </div>
                    </div>

                    <!-- Register Button -->
                    <div class="text-center">
                        <p class="text-sm text-gray-600">
                            Don't have an account? 
                            <asp:Button ID="btnRegister" runat="server" Text="Register" 
                                CssClass="font-medium text-blue-600 hover:text-blue-500 link-hover bg-transparent border-none cursor-pointer" 
                                OnClick="btnRegister_Click" CausesValidation="false" />
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>