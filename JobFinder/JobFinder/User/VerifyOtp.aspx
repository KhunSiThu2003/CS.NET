<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VerifyOtp.aspx.cs" Inherits="JobFinder.User.VerifyOtp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Verify OTP</title>
    <link rel="stylesheet" href="../assets/css/bootstrap.min.css" />
    <style>
        /* Add similar styles to your ForgotPassword page */
        .otp-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            background: white;
        }
        .otp-input {
            letter-spacing: 5px;
            font-size: 24px;
            text-align: center;
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="otp-container">
                <h2 class="text-center mb-4">Verify OTP</h2>
                
                <asp:Panel ID="messagePanel" runat="server" Visible="false" CssClass="alert alert-dismissible fade show">
                    <asp:Literal ID="litMessage" runat="server"></asp:Literal>
                </asp:Panel>
                
                <div class="form-group">
                    <label>Enter 6-digit OTP sent to your email</label>
                    <asp:TextBox ID="txtOtp" runat="server" CssClass="form-control otp-input" 
                        MaxLength="6" TextMode="Number" placeholder="123456"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvOtp" runat="server" 
                        ControlToValidate="txtOtp" ErrorMessage="OTP is required"
                        CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                </div>
                
                <div class="form-group">
                    <asp:Button ID="btnVerifyOtp" runat="server" Text="Verify OTP" 
                        CssClass="btn btn-primary btn-block" OnClick="btnVerifyOtp_Click" />
                </div>
                
                <div class="text-center">
                    <asp:LinkButton ID="lnkResendOtp" runat="server" OnClick="lnkResendOtp_Click">Resend OTP</asp:LinkButton>
                </div>
            </div>
        </div>
    </form>
</body>
</html>