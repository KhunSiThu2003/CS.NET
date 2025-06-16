using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.Security;
using System.Web.UI;

namespace JobFinder.User
{
    public partial class Login : System.Web.UI.Page
    {
        private readonly string _connectionString;

        public Login()
        {
            _connectionString = ConfigurationManager.ConnectionStrings["JobFinderContext"].ConnectionString;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check for registration success message
                if (Session["RegistrationSuccess"] != null)
                {
                    ShowSuccessMessage(Session["RegistrationSuccess"].ToString());
                    Session.Remove("RegistrationSuccess");
                }

                // Check for existing authentication cookie
                if (Request.Cookies["JobFinderAuth"] != null)
                {
                    HttpCookie authCookie = Request.Cookies["JobFinderAuth"];
                    txtUsernameOrEmail.Text = authCookie.Values["UsernameOrEmail"];
                    chkRememberMe.Checked = true;
                }
            }
        }

        private void ShowSuccessMessage(string message)
        {
            messagePanel.CssClass = "alert-message";
            messagePanel.Visible = true;
            litMessage.Text = message;
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                using (SqlConnection con = new SqlConnection(_connectionString))
                {
                    try
                    {
                        con.Open();

                        // 1. First check if user exists and get their verification status
                        string userQuery = @"
                        SELECT UserId, Username, Email, Password, IsEmailVerified 
                        FROM Users 
                        WHERE Username = @UsernameOrEmail OR Email = @UsernameOrEmail";

                        using (SqlCommand cmd = new SqlCommand(userQuery, con))
                        {
                            cmd.Parameters.AddWithValue("@UsernameOrEmail", txtUsernameOrEmail.Text.Trim());

                            using (SqlDataReader reader = cmd.ExecuteReader())
                            {
                                if (reader.Read())
                                {
                                    string storedPassword = reader["Password"].ToString();
                                    bool isEmailVerified = Convert.ToBoolean(reader["IsEmailVerified"]);
                                    string enteredPassword = txtPassword.Text.Trim();

                                    // Verify password first
                                    if (FormsAuthentication.HashPasswordForStoringInConfigFile(enteredPassword, "SHA1") != storedPassword)
                                    {
                                        ShowErrorMessage("Invalid password. Please try again.");
                                        return;
                                    }

                                    // Check if email is verified
                                    if (!isEmailVerified)
                                    {
                                        // Store user info in session for verification page
                                        Session["VerificationUserId"] = reader["UserId"];
                                        Session["VerificationEmail"] = reader["Email"];
                                        Session["VerificationUsername"] = reader["Username"];

                                        // Redirect to verification page
                                        Response.Redirect("VerifyEmail.aspx?returnUrl=Login.aspx");
                                        return;
                                    }

                                    // Authentication successful
                                    Session["UserId"] = reader["UserId"].ToString();
                                    Session["Username"] = reader["Username"].ToString();

                                    // Set remember me cookie if checked
                                    if (chkRememberMe.Checked)
                                    {
                                        HttpCookie authCookie = new HttpCookie("JobFinderAuth");
                                        authCookie.Values["UsernameOrEmail"] = txtUsernameOrEmail.Text.Trim();
                                        authCookie.Expires = DateTime.Now.AddDays(30);
                                        Response.Cookies.Add(authCookie);
                                    }
                                    else
                                    {
                                        // Clear the cookie if remember me is not checked
                                        if (Request.Cookies["JobFinderAuth"] != null)
                                        {
                                            HttpCookie authCookie = new HttpCookie("JobFinderAuth");
                                            authCookie.Expires = DateTime.Now.AddDays(-1);
                                            Response.Cookies.Add(authCookie);
                                        }
                                    }

                                    // Redirect to dashboard or home page
                                    Response.Redirect("~/User/Dashboard.aspx");
                                }
                                else
                                {
                                    ShowErrorMessage("Username or email not found. Please register first.");
                                }
                            }
                        }
                    }
                    catch (SqlException sqlEx)
                    {
                        ShowErrorMessage("Database error occurred. Please try again later.");
                        // Log the error: Logger.LogError(sqlEx);
                    }
                    catch (Exception ex)
                    {
                        ShowErrorMessage("An unexpected error occurred. Please try again.");
                        // Log the error: Logger.LogError(ex);
                    }
                }
            }
        }

        private void ShowErrorMessage(string message)
        {
            messagePanel.CssClass = "alert-message error";
            messagePanel.Visible = true;
            litMessage.Text = message;
        }

       
    }
}