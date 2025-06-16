using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Web;
using System.Web.UI;

namespace JobFinder.User
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        // Configuration settings
        private readonly string _connectionString;
        private readonly int _otpTimeoutMinutes;
        private readonly string _emailFromAddress;

        public ForgotPassword()
        {
            _connectionString = GetConnectionString();
            _otpTimeoutMinutes = GetOtpTimeoutMinutes();
            _emailFromAddress = GetEmailFromAddress();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                messagePanel.Visible = false;
            }
        }

        protected void btnResetPassword_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string email = txtEmail.Text.Trim();

            try
            {
                using (var con = new SqlConnection(_connectionString))
                {
                    con.Open();

                    // Get user by email
                    var user = GetUserByEmail(con, email);

                    if (user == null)
                    {
                        ShowErrorMessage("No account found with that email address.");
                        return;
                    }

                    // Generate 6-digit OTP
                    string otp = new Random().Next(100000, 999999).ToString();
                    DateTime expiryTime = DateTime.Now.AddMinutes(_otpTimeoutMinutes);

                    // Store OTP in database
                    if (!StoreOtp(con, user.UserId, otp, expiryTime))
                    {
                        ShowErrorMessage("Failed to generate OTP. Please try again.");
                        return;
                    }

                    // Send OTP email
                    SendOtpEmail(user.Email, user.Username, otp);

                    // Redirect to OTP verification page
                    Session["ResetEmail"] = user.Email;
                    Response.Redirect("VerifyOtp.aspx", false);
                }
            }
            catch (SmtpException smtpEx)
            {
                LogError($"SMTP Error: {smtpEx.Message}");
                ShowErrorMessage("Failed to send OTP email. Please try again later.");
            }
            catch (SqlException sqlEx)
            {
                LogError($"SQL Error: {sqlEx.Message}");
                ShowErrorMessage("Database error occurred. Please try again later.");
            }
            catch (Exception ex)
            {
                LogError($"Unexpected Error: {ex.Message}");
                ShowErrorMessage("An unexpected error occurred. Please try again.");
            }
        }

        #region Database Methods
        private UserData GetUserByEmail(SqlConnection connection, string email)
        {
            const string query = "SELECT UserId, Username, Email FROM Users WHERE Email = @Email";

            using (var cmd = new SqlCommand(query, connection))
            {
                cmd.Parameters.AddWithValue("@Email", email);

                using (var reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        return new UserData
                        {
                            UserId = reader["UserId"].ToString(),
                            Username = reader["Username"].ToString(),
                            Email = reader["Email"].ToString()
                        };
                    }
                }
            }
            return null;
        }

        private bool StoreOtp(SqlConnection connection, string userId, string otp, DateTime expiryTime)
        {
            const string query = @"
                UPDATE Users 
                SET OTPCode = @OTP, 
                    OTPExpiry = @Expiry
                WHERE UserId = @UserId";

            using (var cmd = new SqlCommand(query, connection))
            {
                cmd.Parameters.AddWithValue("@OTP", otp);
                cmd.Parameters.AddWithValue("@Expiry", expiryTime);
                cmd.Parameters.AddWithValue("@UserId", userId);

                return cmd.ExecuteNonQuery() > 0;
            }
        }
        #endregion

        #region Email Methods
        private void SendOtpEmail(string email, string username, string otp)
        {
            using (var mail = new MailMessage())
            {
                mail.From = new MailAddress("no-reply@yourdomain.com", "JobFinder");
                mail.To.Add(email);
                mail.Subject = "Your JobFinder Verification Code";
                mail.IsBodyHtml = true;
                mail.Body = CreateOtpEmailBody(username, otp);

                // Important headers for deliverability
                mail.Headers.Add("X-SMTPAPI", "{\"category\": \"otp\"}");
                mail.Headers.Add("List-Unsubscribe", "<mailto:unsubscribe@yourdomain.com>");
                mail.Priority = MailPriority.High;

                using (var smtp = new SmtpClient())
                {
                    smtp.Timeout = 30000; // 30 seconds timeout
                    smtp.Send(mail);
                }
            }
        }

        private string CreateOtpEmailBody(string username, string otp)
        {
            return $@"
    <div style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;'>
        <div style='text-align: center; margin-bottom: 20px;'>
            <h2 style='color: #FB246A;'>JobFinder Password Reset</h2>
        </div>
        
        <p>Hello {username},</p>
        
        <p>We received a request to reset your password. Here is your verification code:</p>
        
        <div style='background: #F3F4F6; border-radius: 8px; padding: 16px; text-align: center; margin: 20px 0;'>
            <strong style='font-size: 24px; letter-spacing: 2px;'>{otp}</strong>
        </div>
        
        <p style='color: #6B7280; font-size: 14px;'>
            This code will expire in {_otpTimeoutMinutes} minutes. 
            If you didn't request this, please ignore this email.
        </p>
        
        <div style='margin-top: 30px; padding-top: 20px; border-top: 1px solid #E5E7EB;'>
            <p>Thank you,<br>The JobFinder Team</p>
        </div>
        
        <!-- Footer for spam prevention -->
        <div style='font-size: 12px; color: #9CA3AF; margin-top: 30px; text-align: center;'>
            <p>© {DateTime.Now.Year} JobFinder. All rights reserved.</p>
            <p>
                <a href='https://yourdomain.com' style='color: #9CA3AF;'>Website</a> | 
                <a href='https://yourdomain.com/privacy' style='color: #9CA3AF;'>Privacy Policy</a>
            </p>
        </div>
    </div>";
        }
        #endregion

        #region Configuration Methods
        private string GetConnectionString()
        {
            var connectionString = ConfigurationManager.ConnectionStrings["JobFinderContext"]?.ConnectionString;
            if (string.IsNullOrWhiteSpace(connectionString))
            {
                throw new ApplicationException("Database connection string is not configured in web.config");
            }
            return connectionString;
        }

        private int GetOtpTimeoutMinutes()
        {
            var timeoutSetting = ConfigurationManager.AppSettings["OtpTimeoutMinutes"];
            if (!int.TryParse(timeoutSetting, out int timeout) || timeout <= 0)
            {
                return 10; // Default to 10 minutes if not properly configured
            }
            return timeout;
        }

        private string GetEmailFromAddress()
        {
            var fromAddress = ConfigurationManager.AppSettings["EmailFromAddress"];
            if (string.IsNullOrWhiteSpace(fromAddress))
            {
                var smtpSection = ConfigurationManager.GetSection("system.net/mailSettings/smtp") as System.Net.Configuration.SmtpSection;
                return smtpSection?.From ?? "no-reply@jobfinder.com";
            }
            return fromAddress;
        }
        #endregion

        #region UI Methods
        private void ShowSuccessMessage(string message)
        {
            messagePanel.CssClass = "alert-message";
            messagePanel.Visible = true;
            litMessage.Text = message;
            txtEmail.Text = string.Empty;
        }

        private void ShowErrorMessage(string message)
        {
            messagePanel.CssClass = "alert-message error";
            messagePanel.Visible = true;
            litMessage.Text = message;
        }

        private void LogError(string message)
        {
            System.Diagnostics.Trace.WriteLine($"[{DateTime.Now}] {message}");
        }
        #endregion

        private class UserData
        {
            public string UserId { get; set; }
            public string Username { get; set; }
            public string Email { get; set; }
        }
    }
}