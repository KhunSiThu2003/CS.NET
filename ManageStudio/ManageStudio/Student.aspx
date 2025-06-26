<%@ Page Title="Student Management" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Student.aspx.cs" Inherits="ManageStudio.Student" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .student-container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }
        .form-group label {
            width: 150px;
            font-weight: 600;
            color: #495057;
        }
        .form-control {
            flex: 1;
            padding: 8px 12px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            font-size: 14px;
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }
        .btn-primary:hover {
            background-color: #0069d9;
        }
        .grid-view {
            width: 100%;
            margin-top: 30px;
            border-collapse: collapse;
        }
        .grid-view th {
            background-color: #343a40;
            color: white;
            padding: 12px;
            text-align: left;
        }
        .grid-view td {
            padding: 10px;
            border-bottom: 1px solid #dee2e6;
        }
        .grid-view tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .grid-view tr:hover {
            background-color: #e9ecef;
        }
        .header {
            color: #343a40;
            margin-bottom: 20px;
            text-align: center;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="student-container">
        <h2 class="header">Student Management</h2>
        
        <div class="form-group">
            <asp:Label ID="Label1" runat="server" Text="Student Name" CssClass="control-label"></asp:Label>
            <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        
        <div class="form-group">
            <asp:Label ID="Label2" runat="server" Text="Roll Number" CssClass="control-label"></asp:Label>
            <asp:TextBox ID="txtRollNumber" runat="server" CssClass="form-control"></asp:TextBox>
        </div>
        
        <div class="form-group">
            <asp:Label ID="Label3" runat="server" Text="Email" CssClass="control-label"></asp:Label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email"></asp:TextBox>
        </div>
        
        <div class="form-group">
            <asp:Label ID="Label4" runat="server" Text="Phone Number" CssClass="control-label"></asp:Label>
            <asp:TextBox ID="txtPhoneNumber" runat="server" CssClass="form-control" TextMode="Phone"></asp:TextBox>
        </div>

        <div style="text-align: center; margin-top: 20px;">
            <asp:Button ID="Button1" runat="server" Text="Add Student" OnClick="AddStudent_Click" CssClass="btn-primary" />
        </div>

        <asp:GridView ID="GridView1" runat="server"></asp:GridView>
    </div>
</asp:Content>