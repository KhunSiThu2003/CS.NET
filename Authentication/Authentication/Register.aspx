<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Authentication.Register" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex items-center justify-center min-h-screen">
    <form id="form1" runat="server" class="bg-white p-8 rounded-2xl shadow-lg w-full max-w-md">
        <h2 class="text-2xl font-bold mb-6 text-center text-gray-700">Create an Account</h2>

        <div class="mb-4">
            <asp:Label ID="Label1" runat="server" AssociatedControlID="txtName" CssClass="block text-sm font-medium text-gray-700"
                Text="Full Name"></asp:Label>
            <asp:TextBox ID="txtName" runat="server" CssClass="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring focus:border-blue-300"></asp:TextBox>
        </div>

        <div class="mb-4">
            <asp:Label ID="Label2" runat="server" AssociatedControlID="txtEmail" CssClass="block text-sm font-medium text-gray-700"
                Text="Email"></asp:Label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring focus:border-blue-300"></asp:TextBox>
        </div>

        <div class="mb-4">
            <asp:Label ID="Label3" runat="server" AssociatedControlID="txtPassword" CssClass="block text-sm font-medium text-gray-700"
                Text="Password"></asp:Label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring focus:border-blue-300"></asp:TextBox>
        </div>

        <div class="mb-6">
            <asp:Label ID="Label4" runat="server" AssociatedControlID="txtConPassword" CssClass="block text-sm font-medium text-gray-700"
                Text="Confirm Password"></asp:Label>
            <asp:TextBox ID="txtConPassword" runat="server" TextMode="Password" CssClass="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring focus:border-blue-300"></asp:TextBox>
        </div>

        <div class="mb-4">
            <asp:Button ID="btnSignUp" runat="server" Text="Sign Up" OnClick="btnSignUp_Click"
                CssClass="w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-2 px-4 rounded-md shadow transition duration-300" />
        </div>

        <div class="mb-4 flax items-center justify-center">
            <span>Your account is already exit? </span>
            <a class="text-blue-400" href="Login.aspx">Login</a>
        </div>

        <div>
            <asp:Label ID="lblMessage" runat="server"
                CssClass="block text-center text-sm font-medium p-2 rounded-md transition-all duration-300"
                EnableViewState="true"></asp:Label>
        </div>

    </form>
</body>
</html>
