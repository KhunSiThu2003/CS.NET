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
        string str = ConfigurationManager.ConnectionStrings["JobFinderContext"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check for existing authentication cookie
                if (Request.Cookies["JobFinderAuth"] != null)
                {
                    HttpCookie authCookie = Request.Cookies["JobFinderAuth"];
                    txtUsernameOrEmail.Text = authCookie.Values["UsernameOrEmail"];
                    chkRememberMe.Checked = true;
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                using (SqlConnection con = new SqlConnection(str))
                {
                    try
                    {
                        con.Open();

                        // Check if user exists with either username or email
                        string query = @"
                        SELECT UserId, Username, Email, Password 
                        FROM Users 
                        WHERE (Username = @UsernameOrEmail OR Email = @UsernameOrEmail)";

                        using (SqlCommand cmd = new SqlCommand(query, con))
                        {
                            cmd.Parameters.AddWithValue("@UsernameOrEmail", txtUsernameOrEmail.Text.Trim());

                            using (SqlDataReader reader = cmd.ExecuteReader())
                            {
                                if (reader.Read())
                                {
                                    string storedPassword = reader["Password"].ToString();
                                    string enteredPassword = txtPassword.Text.Trim();

                                    // Verify the password (using the same hashing method as registration)
                                    if (FormsAuthentication.HashPasswordForStoringInConfigFile(enteredPassword, "SHA1") == storedPassword)
                                    {
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
                                        ShowErrorMessage("Invalid password. Please try again.");
                                    }
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
            messagePanel.CssClass = "alert-message alert alert-danger";
            messagePanel.Visible = true;
            litMessage.Text = message;
        }
    }
}