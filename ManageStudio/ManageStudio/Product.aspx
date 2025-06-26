<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Product.aspx.cs" Inherits="ManageStudio.Product" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mx-auto px-4 py-8 max-w-7xl">
        <!-- Header Section -->
        <div class="text-center mb-10">
            <h1 class="text-4xl font-extrabold text-gray-900 mb-3">Product Management</h1>
            <p class="text-lg text-gray-600 max-w-2xl mx-auto">Manage your product inventory with ease</p>
        </div>
        
        <!-- Add Product Card -->
        <div class="bg-white rounded-xl shadow-lg overflow-hidden mb-10 border border-gray-100">
            <div class="bg-gradient-to-r from-blue-500 to-blue-600 px-6 py-4">
                <h2 class="text-xl font-semibold text-white">Add New Product</h2>
            </div>
            
            <div class="p-6">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <!-- Product Name -->
                    <div class="mb-4">
                        <label for="txtProductName" class="block text-sm font-medium text-gray-700 mb-2">Product Name <span class="text-red-500">*</span></label>
                        <asp:TextBox ID="txtProductName" runat="server" 
                            CssClass="w-full px-4 py-2.5 rounded-lg border border-gray-300 focus:border-blue-500 focus:ring-2 focus:ring-blue-200 transition duration-200 outline-none"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvProductName" runat="server" 
                            ControlToValidate="txtProductName" 
                            ErrorMessage="Product name is required" 
                            CssClass="text-red-500 text-xs mt-1"
                            Display="Dynamic"></asp:RequiredFieldValidator>
                    </div>

                    <!-- Price -->
                    <div class="mb-4">
                        <label for="txtPrice" class="block text-sm font-medium text-gray-700 mb-2">Price ($) <span class="text-red-500">*</span></label>
                        <div class="relative">
                            <span class="absolute inset-y-0 left-0 flex items-center pl-3 text-gray-500">$</span>
                            <asp:TextBox ID="txtPrice" runat="server" TextMode="Number" step="0.01" 
                                CssClass="w-full pl-8 pr-4 py-2.5 rounded-lg border border-gray-300 focus:border-blue-500 focus:ring-2 focus:ring-blue-200 transition duration-200 outline-none"></asp:TextBox>
                        </div>
                        <asp:RequiredFieldValidator ID="rfvPrice" runat="server" 
                            ControlToValidate="txtPrice" 
                            ErrorMessage="Price is required" 
                            CssClass="text-red-500 text-xs mt-1"
                            Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="cvPrice" runat="server" 
                            ControlToValidate="txtPrice" 
                            Operator="GreaterThanEqual" 
                            Type="Currency"
                            ValueToCompare="0"
                            ErrorMessage="Price must be greater than 0" 
                            CssClass="text-red-500 text-xs mt-1"
                            Display="Dynamic"></asp:CompareValidator>
                    </div>

                    <!-- Quantity -->
                    <div class="mb-4">
                        <label for="txtQuantity" class="block text-sm font-medium text-gray-700 mb-2">Quantity <span class="text-red-500">*</span></label>
                        <asp:TextBox ID="txtQuantity" runat="server" TextMode="Number" 
                            CssClass="w-full px-4 py-2.5 rounded-lg border border-gray-300 focus:border-blue-500 focus:ring-2 focus:ring-blue-200 transition duration-200 outline-none"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvQuantity" runat="server" 
                            ControlToValidate="txtQuantity" 
                            ErrorMessage="Quantity is required" 
                            CssClass="text-red-500 text-xs mt-1"
                            Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="cvQuantity" runat="server" 
                            ControlToValidate="txtQuantity" 
                            Operator="GreaterThanEqual" 
                            Type="Integer"
                            ValueToCompare="0"
                            ErrorMessage="Quantity must be 0 or more" 
                            CssClass="text-red-500 text-xs mt-1"
                            Display="Dynamic"></asp:CompareValidator>
                    </div>

                    <!-- Date Added -->
                    <div class="mb-4">
                        <label for="txtDateAdded" class="block text-sm font-medium text-gray-700 mb-2">Date Added</label>
                        <div class="relative">
                            <asp:TextBox ID="txtDateAdded" runat="server" TextMode="Date" 
                                CssClass="w-full px-4 py-2.5 rounded-lg border border-gray-300 focus:border-blue-500 focus:ring-2 focus:ring-blue-200 transition duration-200 outline-none"></asp:TextBox>
                        </div>
                        <asp:CompareValidator ID="cvDateAdded" runat="server" 
                            ControlToValidate="txtDateAdded" 
                            Operator="DataTypeCheck" 
                            Type="Date"
                            ErrorMessage="Please enter a valid date" 
                            CssClass="text-red-500 text-xs mt-1"
                            Display="Dynamic"></asp:CompareValidator>
                    </div>
                </div>

                <!-- Submit Button and Message -->
                <div class="flex items-center justify-between mt-8">
                    <asp:Button ID="btnSubmit" runat="server" Text="Add Product" 
                        OnClick="btnSubmit_Click" 
                        CssClass="bg-blue-600 hover:bg-blue-700 text-white font-medium py-2.5 px-8 rounded-lg focus:outline-none focus:ring-4 focus:ring-blue-200 transition duration-200 shadow-md" />
                    
                    <asp:Label ID="lblMessage" runat="server" CssClass="text-sm font-medium px-4 py-2 rounded-lg" style="display: none;"></asp:Label>
                </div>
            </div>
        </div>

        <!-- Product List Section -->
        <div class="bg-white rounded-xl shadow-lg overflow-hidden border border-gray-100">
            <div class="flex flex-col sm:flex-row justify-between items-center bg-gradient-to-r from-gray-50 to-gray-100 px-6 py-4 border-b border-gray-200">
                <h2 class="text-xl font-semibold text-gray-800 mb-2 sm:mb-0">Product Inventory</h2>
                <div class="flex items-center space-x-3">
                    <div class="relative">
                        <asp:TextBox ID="txtSearch" runat="server" placeholder="Search products..." 
                            CssClass="pl-10 pr-4 py-2 rounded-lg border border-gray-300 focus:border-blue-500 focus:ring-2 focus:ring-blue-200 transition duration-200 outline-none text-sm w-48"></asp:TextBox>
                        <span class="absolute inset-y-0 left-0 flex items-center pl-3">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                            </svg>
                        </span>
                    </div>
                    <asp:Button ID="btnRefresh" runat="server" Text="Refresh" 
                        OnClick="btnRefresh_Click" 
                        CssClass="bg-white hover:bg-gray-50 text-gray-700 font-medium py-2 px-4 rounded-lg border border-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-200 transition duration-200 shadow-sm text-sm" />
                </div>
            </div>
            
            <div class="p-6">
                <div class="overflow-x-auto rounded-lg border border-gray-200">
                    <asp:GridView ID="gvProducts" runat="server" AutoGenerateColumns="False" 
                        CssClass="min-w-full divide-y divide-gray-200" DataKeyNames="ProductID" 
                        OnRowDeleting="gvProducts_RowDeleting" 
                        EmptyDataText="No products found. Add your first product above."
                        HeaderStyle-CssClass="bg-gray-50"
                        RowStyle-CssClass="hover:bg-gray-50 transition duration-150"
                        AlternatingRowStyle-CssClass="bg-gray-50">
                        <Columns>
                            <asp:BoundField DataField="ProductID" HeaderText="ID" ReadOnly="True" 
                                ItemStyle-CssClass="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900" 
                                HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" />
                            
                            <asp:BoundField DataField="ProductName" HeaderText="Product Name" 
                                ItemStyle-CssClass="px-6 py-4 whitespace-nowrap text-sm text-gray-500" 
                                HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" />
                            
                            <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:C}" 
                                ItemStyle-CssClass="px-6 py-4 whitespace-nowrap text-sm text-gray-500" 
                                HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" />
                            
                            <asp:BoundField DataField="Quantity" HeaderText="Quantity" 
                                ItemStyle-CssClass="px-6 py-4 whitespace-nowrap text-sm text-gray-500" 
                                HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" />
                            
                            <asp:BoundField DataField="DateAdded" HeaderText="Date Added" DataFormatString="{0:d}" 
                                ItemStyle-CssClass="px-6 py-4 whitespace-nowrap text-sm text-gray-500" 
                                HeaderStyle-CssClass="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider" />
                            
                            <asp:CommandField ShowDeleteButton="True" ButtonType="Link" 
                                DeleteText='<svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-red-400 hover:text-red-600 transition duration-150" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                                </svg>'
                                ItemStyle-CssClass="px-6 py-4 whitespace-nowrap text-right text-sm font-medium"
                                ControlStyle-CssClass="inline-flex items-center justify-center" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>

    <style type="text/css">
        .gridview {
            border-collapse: separate;
            border-spacing: 0;
        }
        
        .gridview th, 
        .gridview td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #e5e7eb;
        }
        
        .gridview th {
            background-color: #f9fafb;
            color: #374151;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.75rem;
            letter-spacing: 0.05em;
        }
        
        .gridview tr:last-child td {
            border-bottom: none;
        }
        
        .gridview tr:hover {
            background-color: #f3f4f6;
        }
    </style>
</asp:Content>