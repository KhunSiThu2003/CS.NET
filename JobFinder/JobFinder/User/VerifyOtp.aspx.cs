using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace JobFinder.User
{
    public partial class VerifyOtp : System.Web.UI.Page
    {
        private string _connectionString;
        private int _otpTimeoutMinutes;

        protected void Page_Load(object sender, EventArgs e)
        {
            _connectionString = ConfigurationManager.ConnectionStrings["JobFinderContext"].ConnectionString;
            _otpTimeoutMinutes = int.Parse(ConfigurationManager.AppSettings["OtpTimeoutMinutes"] ?? "10");

            if (!IsPostBack)
            {
                if (Session["ResetEmail"] == null)
                {
                    Response.Redirect("ForgotPassword.aspx");
                }
                messagePanel.Visible = false;
            }
        }

        protected void btnVerifyOtp_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string email = Session["ResetEmail"].ToString();
            string enteredOtp = txtOtp.Text.Trim();

            using (var con = new SqlConnection(_connectionString))
            {
                con.Open();

                string query = @"SELECT OTPCode, OTPExpiry FROM Users 
                                WHERE Email = @Email AND OTPCode = @OTP";

                using (var cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@OTP", enteredOtp);

                    using (var reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            DateTime expiryTime = Convert.ToDateTime(reader["OTPExpiry"]);

                            if (DateTime.Now > expiryTime)
                            {
                                ShowMessage("OTP has expired. Please request a new one.", "danger");
                                return;
                            }

                            // OTP is valid, redirect to password reset page
                            Session["OTPVerified"] = true;
                            Response.Redirect("ResetPassword.aspx");
                        }
                        else
                        {
                            ShowMessage("Invalid OTP. Please try again.", "danger");
                        }
                    }
                }
            }
        }

        protected void lnkResendOtp_Click(object sender, EventArgs e)
        {
            string email = Session["ResetEmail"].ToString();

            using (var con = new SqlConnection(_connectionString))
            {
                con.Open();

                // Generate new OTP
                string newOtp = new Random().Next(100000, 999999).ToString();
                DateTime newExpiry = DateTime.Now.AddMinutes(_otpTimeoutMinutes);

                // Update database
                string updateQuery = @"UPDATE Users SET OTPCode = @OTP, OTPExpiry = @Expiry 
                                      WHERE Email = @Email";

                using (var cmd = new SqlCommand(updateQuery, con))
                {
                    cmd.Parameters.AddWithValue("@OTP", newOtp);
                    cmd.Parameters.AddWithValue("@Expiry", newExpiry);
                    cmd.Parameters.AddWithValue("@Email", email);

                    if (cmd.ExecuteNonQuery() > 0)
                    {
                        // Resend email (you would call your email sending method here)
                        ShowMessage("New OTP has been sent to your email.", "success");
                    }
                    else
                    {
                        ShowMessage("Failed to resend OTP. Please try again.", "danger");
                    }
                }
            }
        }

        private void ShowMessage(string message, string type)
        {
            messagePanel.Visible = true;
            litMessage.Text = message;
            messagePanel.CssClass = $"alert alert-{type} alert-dismissible fade show";
        }
    }
}