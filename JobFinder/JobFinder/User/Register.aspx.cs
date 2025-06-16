using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace JobFinder.User
{
    public partial class Register : System.Web.UI.Page
    {
        private readonly string _connectionString;
        private readonly string _emailFromAddress;
        private readonly int _otpTimeoutMinutes = 10;

        public Register()
        {
            _connectionString = ConfigurationManager.ConnectionStrings["JobFinderContext"].ConnectionString;
            _emailFromAddress = ConfigurationManager.AppSettings["EmailFromAddress"] ?? "no-reply@jobfinder.com";
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                messagePanel.Visible = false;
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                using (SqlConnection con = new SqlConnection(_connectionString))
                {
                    try
                    {
                        con.Open();

                        // Check if user exists
                        if (UserExists(con, txtUserName.Text.Trim(), txtEmail.Text.Trim(), txtMobile.Text.Trim()))
                        {
                            ShowErrorMessage("Username, email or mobile already exists");
                            return;
                        }

                        // Hash password
                        string hashedPassword = FormsAuthentication.HashPasswordForStoringInConfigFile(
                            txtConfirmPassword.Text.Trim(), "SHA1");

                        // Generate verification code
                        string verificationCode = new Random().Next(100000, 999999).ToString();
                        DateTime expiryTime = DateTime.Now.AddMinutes(_otpTimeoutMinutes);

                        // Insert new user (unverified)
                        int newUserId = InsertUser(con, hashedPassword, verificationCode, expiryTime);

                        if (newUserId > 0)
                        {
                            // Send verification email
                            SendVerificationEmail(txtEmail.Text.Trim(), txtFullName.Text.Trim(), verificationCode);

                            // Store user info in session for verification
                            Session["VerificationEmail"] = txtEmail.Text.Trim();
                            Session["VerificationUserId"] = newUserId;
                            Session["VerificationUsername"] = txtUserName.Text.Trim();

                            // Redirect to verification page
                            Response.Redirect("VerifyEmail.aspx");
                        }
                    }
                    catch (Exception ex)
                    {
                        ShowErrorMessage("Registration failed: " + ex.Message);
                    }
                }
            }
        }

        private bool UserExists(SqlConnection con, string username, string email, string mobile)
        {
            string query = @"SELECT COUNT(*) FROM Users 
                            WHERE Username = @Username OR Email = @Email OR Mobile = @Mobile";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Mobile", mobile);

                return (int)cmd.ExecuteScalar() > 0;
            }
        }

        private int InsertUser(SqlConnection con, string hashedPassword, string verificationCode, DateTime expiryTime)
        {
            string query = @"INSERT INTO Users 
                            (Username, Password, Name, Address, Mobile, Email, Country, 
                             VerificationCode, VerificationExpiry, IsEmailVerified, CreatedDate)
                            VALUES 
                            (@Username, @Password, @Name, @Address, @Mobile, @Email, @Country,
                             @VerificationCode, @VerificationExpiry, 0, GETDATE());
                            SELECT SCOPE_IDENTITY();";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Username", txtUserName.Text.Trim());
                cmd.Parameters.AddWithValue("@Password", hashedPassword);
                cmd.Parameters.AddWithValue("@Name", txtFullName.Text.Trim());
                cmd.Parameters.AddWithValue("@Address",
                    string.IsNullOrEmpty(txtAddress.Text) ? DBNull.Value : (object)txtAddress.Text.Trim());
                cmd.Parameters.AddWithValue("@Mobile", txtMobile.Text.Trim());
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@Country", ddlCountry.SelectedValue);
                cmd.Parameters.AddWithValue("@VerificationCode", verificationCode);
                cmd.Parameters.AddWithValue("@VerificationExpiry", expiryTime);

                return Convert.ToInt32(cmd.ExecuteScalar());
            }
        }

        private void SendVerificationEmail(string email, string name, string verificationCode)
        {
            try
            {
                using (MailMessage mail = new MailMessage())
                {
                    mail.From = new MailAddress(_emailFromAddress, "JobFinder");
                    mail.To.Add(email);
                    mail.Subject = "Verify Your Email Address";
                    mail.IsBodyHtml = true;
                    mail.Body = CreateVerificationEmailBody(name, verificationCode);

                    using (SmtpClient smtp = new SmtpClient())
                    {
                        smtp.Send(mail);
                    }
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Failed to send verification email: " + ex.Message);
            }
        }

        private string CreateVerificationEmailBody(string name, string verificationCode)
        {
            return $@"
                <div style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;'>
                    <h2 style='color: #FB246A;'>Email Verification</h2>
                    <p>Hello {name},</p>
                    <p>Thank you for registering with JobFinder. Please verify your email address by entering this code:</p>
                    <div style='background: #F3F4F6; border-radius: 8px; padding: 16px; text-align: center; margin: 20px 0;'>
                        <strong style='font-size: 24px; letter-spacing: 2px;'>{verificationCode}</strong>
                    </div>
                    <p>This code will expire in {_otpTimeoutMinutes} minutes.</p>
                    <p>If you didn't request this, please ignore this email.</p>
                    <p>Thanks,<br>The JobFinder Team</p>
                </div>";
        }

        private void ShowErrorMessage(string message)
        {
            messagePanel.CssClass = "alert-message error";
            messagePanel.Visible = true;
            litMessage.Text = message;
        }

        protected void cvTerms_ServerValidate(object source, ServerValidateEventArgs args)
        {
            args.IsValid = chkTerms.Checked;
        }
    }
}