using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Web.UI;

namespace JobFinder.User
{
    public partial class VerifyEmail : System.Web.UI.Page
    {
        private readonly string _connectionString;
        private readonly string _emailFromAddress;
        private readonly int _otpTimeoutMinutes = 10;

        public VerifyEmail()
        {
            _connectionString = ConfigurationManager.ConnectionStrings["JobFinderContext"].ConnectionString;
            _emailFromAddress = ConfigurationManager.AppSettings["EmailFromAddress"] ?? "no-reply@jobfinder.com";
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["VerificationEmail"] == null || Session["VerificationUserId"] == null)
                {
                    Response.Redirect("Register.aspx");
                }
                messagePanel.Visible = false;
            }
        }

        protected void btnVerify_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                string email = Session["VerificationEmail"].ToString();
                string otp = txtOtp.Text.Trim();
                int userId = Convert.ToInt32(Session["VerificationUserId"]);

                using (SqlConnection con = new SqlConnection(_connectionString))
                {
                    con.Open();

                    // Verify OTP
                    string query = @"SELECT VerificationCode, VerificationExpiry 
                                    FROM Users 
                                    WHERE UserId = @UserId AND Email = @Email";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        cmd.Parameters.AddWithValue("@Email", email);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                string dbCode = reader["VerificationCode"].ToString();
                                DateTime expiryTime = Convert.ToDateTime(reader["VerificationExpiry"]);

                                if (DateTime.Now > expiryTime)
                                {
                                    ShowMessage("OTP has expired. Please request a new one.", "error");
                                    return;
                                }

                                if (otp == dbCode)
                                {
                                    // Mark email as verified
                                    reader.Close();
                                    VerifyEmail(con, userId);

                                    // Clear session
                                    Session.Remove("VerificationEmail");
                                    Session.Remove("VerificationUserId");
                                    Session.Remove("VerificationUsername");

                                    // Set success message
                                    Session["RegistrationSuccess"] = "Email verified successfully! You can now login.";

                                    // Redirect to login page
                                    Response.Redirect("Login.aspx");
                                }
                                else
                                {
                                    ShowMessage("Invalid OTP. Please try again.", "error");
                                }
                            }
                        }
                    }
                }
            }
        }

        protected void lnkResend_Click(object sender, EventArgs e)
        {
            string email = Session["VerificationEmail"].ToString();
            string username = Session["VerificationUsername"].ToString();
            int userId = Convert.ToInt32(Session["VerificationUserId"]);

            // Generate new OTP
            string newOtp = new Random().Next(100000, 999999).ToString();
            DateTime newExpiry = DateTime.Now.AddMinutes(_otpTimeoutMinutes);

            using (SqlConnection con = new SqlConnection(_connectionString))
            {
                con.Open();

                // Update OTP in database
                string updateQuery = @"UPDATE Users 
                                      SET VerificationCode = @Code, 
                                          VerificationExpiry = @Expiry
                                      WHERE UserId = @UserId";

                using (SqlCommand cmd = new SqlCommand(updateQuery, con))
                {
                    cmd.Parameters.AddWithValue("@Code", newOtp);
                    cmd.Parameters.AddWithValue("@Expiry", newExpiry);
                    cmd.Parameters.AddWithValue("@UserId", userId);

                    if (cmd.ExecuteNonQuery() > 0)
                    {
                        // Resend email
                        SendVerificationEmail(email, username, newOtp);
                        ShowMessage("New OTP has been sent to your email.", "success");
                    }
                }
            }
        }

        private void VerifyEmail(SqlConnection con, int userId)
        {
            string query = "UPDATE Users SET IsEmailVerified = 1 WHERE UserId = @UserId";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@UserId", userId);
                cmd.ExecuteNonQuery();
            }
        }

        private void SendVerificationEmail(string email, string name, string otp)
        {
            using (MailMessage mail = new MailMessage())
            {
                mail.From = new MailAddress(_emailFromAddress, "JobFinder");
                mail.To.Add(email);
                mail.Subject = "Your New Verification Code";
                mail.IsBodyHtml = true;
                mail.Body = $@"
                    <div style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;'>
                        <h2 style='color: #FB246A;'>New Verification Code</h2>
                        <p>Hello {name},</p>
                        <p>Here is your new verification code:</p>
                        <div style='background: #F3F4F6; border-radius: 8px; padding: 16px; text-align: center; margin: 20px 0;'>
                            <strong style='font-size: 24px; letter-spacing: 2px;'>{otp}</strong>
                        </div>
                        <p>This code will expire in {_otpTimeoutMinutes} minutes.</p>
                    </div>";

                using (SmtpClient smtp = new SmtpClient())
                {
                    smtp.Send(mail);
                }
            }
        }

        private void ShowMessage(string message, string type)
        {
            messagePanel.Visible = true;
            litMessage.Text = message;
            messagePanel.CssClass = $"alert-message {(type == "error" ? "error" : "")}";
        }
    }
}