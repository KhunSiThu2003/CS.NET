<%@ Page Title="Register" Language="C#" MasterPageFile="~/TopHeader.Master" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="Online_Banking_Transaction.Registration" %>

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
        .card-shadow {
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="min-h-screen gradient-bg py-12 px-4 sm:px-6 lg:px-8">
        <div class="max-w-4xl mx-auto">
            <div class="bg-white rounded-xl card-shadow overflow-hidden">
                <!-- Header Section -->
                <div class="bg-blue-700 py-6 px-8 text-center">
                    <div class="flex justify-center mb-4">
                        <div class="w-16 h-16 bg-white rounded-full flex items-center justify-center">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-blue-700" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 11c0 3.517-1.009 6.799-2.753 9.571m-3.44-2.04l.054-.09A13.916 13.916 0 008 11a4 4 0 118 0c0 1.017-.07 2.019-.203 3m-2.118 6.844A21.88 21.88 0 0015.171 17m3.839 1.132c.645-2.266.99-4.659.99-7.132A8 8 0 008 4.07M3 15.364c.64-1.319 1-2.8 1-4.364 0-1.457.39-2.823 1.07-4" />
                            </svg>
                        </div>
                    </div>
                    <h1 class="text-2xl font-bold text-white">Create New Account</h1>
                    <p class="text-blue-100 mt-1">Fill in your details to register</p>
                </div>

                <!-- Form Section -->
                <div class="p-8">
                    <asp:Label ID="lblMessage" runat="server" 
                        CssClass="block mb-6 p-3 rounded-lg text-sm" 
                        Visible="false" />

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <!-- Account Info -->
                        <div class="bg-blue-50 p-4 rounded-lg col-span-2 grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Account Number</label>
                                <asp:Label ID="lblAccountNumber" runat="server" 
                                    CssClass="block text-blue-800 font-semibold" />
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Account Type</label>
                                <asp:Label ID="lblAccountType" runat="server" 
                                    CssClass="block text-blue-800 font-semibold" />
                            </div>
                        </div>

                        <!-- Username -->
                        <div>
                            <label for="txtUsername" class="block text-sm font-medium text-gray-700 mb-1">Username</label>
                            <asp:TextBox ID="txtUsername" runat="server" 
                                CssClass="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none input-focus-effect" 
                                placeholder="Choose a username" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                ControlToValidate="txtUsername" ErrorMessage="Username is required" 
                                CssClass="text-red-500 text-xs mt-1 block" Display="Dynamic" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                                ErrorMessage="6-15 alphanumeric characters" ControlToValidate="txtUsername" 
                                CssClass="text-red-500 text-xs mt-1 block" Display="Dynamic" 
                                ValidationExpression="^[a-zA-Z0-9]{6,15}$" />
                        </div>

                        <!-- Password -->
                        <div>
                            <label for="txtPassword" class="block text-sm font-medium text-gray-700 mb-1">Password</label>
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" 
                                CssClass="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none input-focus-effect" 
                                placeholder="Create password" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                ControlToValidate="txtPassword" ErrorMessage="Password is required" 
                                CssClass="text-red-500 text-xs mt-1 block" Display="Dynamic" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                                ErrorMessage="6-15 characters required" ControlToValidate="txtPassword" 
                                CssClass="text-red-500 text-xs mt-1 block" Display="Dynamic" 
                                ValidationExpression="^[a-zA-Z0-9'@&#.\s]{6,15}$" />
                        </div>

                        <!-- Confirm Password -->
                        <div>
                            <label for="txtConfirmPassword" class="block text-sm font-medium text-gray-700 mb-1">Confirm Password</label>
                            <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" 
                                CssClass="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none input-focus-effect" 
                                placeholder="Confirm password" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                                ControlToValidate="txtConfirmPassword" ErrorMessage="Please confirm password" 
                                CssClass="text-red-500 text-xs mt-1 block" Display="Dynamic" />
                            <asp:CompareValidator ID="CompareValidator1" runat="server" 
                                ErrorMessage="Passwords don't match" ControlToValidate="txtConfirmPassword" 
                                ControlToCompare="txtPassword" CssClass="text-red-500 text-xs mt-1 block" 
                                Display="Dynamic" />
                        </div>

                        <!-- Gender -->
                        <div>
                            <label for="ddlGender" class="block text-sm font-medium text-gray-700 mb-1">Gender</label>
                            <asp:DropDownList ID="ddlGender" runat="server" 
                                CssClass="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none input-focus-effect">
                                <asp:ListItem Text="Male" Value="Male" />
                                <asp:ListItem Text="Female" Value="Female" />
                                <asp:ListItem Text="Other" Value="Other" />
                            </asp:DropDownList>
                        </div>

                        <!-- Email -->
                        <div>
                            <label for="txtEmail" class="block text-sm font-medium text-gray-700 mb-1">Email</label>
                            <asp:TextBox ID="txtEmail" runat="server" 
                                CssClass="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none input-focus-effect" 
                                placeholder="your@email.com" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                                ControlToValidate="txtEmail" ErrorMessage="Email is required" 
                                CssClass="text-red-500 text-xs mt-1 block" Display="Dynamic" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" 
                                ErrorMessage="Invalid email format" ControlToValidate="txtEmail" 
                                CssClass="text-red-500 text-xs mt-1 block" Display="Dynamic" 
                                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                        </div>

                        <!-- Security Question -->
                        <div>
                            <label for="ddlSecurityQuestion" class="block text-sm font-medium text-gray-700 mb-1">Security Question</label>
                            <asp:DropDownList ID="ddlSecurityQuestion" runat="server" 
                                DataSourceID="SqlDataSource1" DataTextField="SecurityQuestionName" 
                                DataValueField="SecurityQuestionId" 
                                CssClass="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none input-focus-effect" />
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server"
    ConnectionString="<%$ ConnectionStrings:OnlineBankingDB %>"
    SelectCommand="SELECT * FROM [SecurityQuestion]" />
                        </div>

                        <!-- Answer -->
                        <div>
                            <label for="txtAnswer" class="block text-sm font-medium text-gray-700 mb-1">Answer</label>
                            <asp:TextBox ID="txtAnswer" runat="server" 
                                CssClass="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none input-focus-effect" 
                                placeholder="Your answer" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                                ControlToValidate="txtAnswer" ErrorMessage="Answer is required" 
                                CssClass="text-red-500 text-xs mt-1 block" Display="Dynamic" />
                        </div>

                        <!-- Amount -->
                        <div>
                            <label for="txtAmount" class="block text-sm font-medium text-gray-700 mb-1">Initial Deposit</label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <span class="text-gray-500">$</span>
                                </div>
                                <asp:TextBox ID="txtAmount" runat="server" TextMode="Number" 
                                    CssClass="pl-7 w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none input-focus-effect" 
                                    placeholder="0.00" />
                            </div>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" 
                                ControlToValidate="txtAmount" ErrorMessage="Amount is required" 
                                CssClass="text-red-500 text-xs mt-1 block" Display="Dynamic" />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" 
                                ErrorMessage="Max 5 digits" ControlToValidate="txtAmount" 
                                CssClass="text-red-500 text-xs mt-1 block" Display="Dynamic" 
                                ValidationExpression="^\d{1,5}$" />
                        </div>

                        <!-- Address -->
                        <div class="col-span-2">
                            <label for="txtAddress" class="block text-sm font-medium text-gray-700 mb-1">Address</label>
                            <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Rows="3" 
                                CssClass="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none input-focus-effect" 
                                placeholder="Your full address" />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                                ControlToValidate="txtAddress" ErrorMessage="Address is required" 
                                CssClass="text-red-500 text-xs mt-1 block" Display="Dynamic" 
                                SetFocusOnError="true" />
                        </div>
                    </div>

                    <!-- Buttons -->
                    <div class="mt-8 flex flex-col sm:flex-row justify-end gap-4">
                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" 
                            CssClass="px-6 py-3 border border-gray-300 rounded-lg font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition-all duration-200 btn-hover-effect" 
                            OnClick="btnCancel_Click" CausesValidation="false" />
                        <asp:Button ID="btnRegister" runat="server" Text="Register" 
                            CssClass="px-6 py-3 border border-transparent rounded-lg font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition-all duration-200 btn-hover-effect" 
                            OnClick="btnRegister_Click" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>