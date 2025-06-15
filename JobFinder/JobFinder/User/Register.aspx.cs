using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Security; // For password hashing
using System.Web.UI;

namespace JobFinder.User
{
    public partial class Register : System.Web.UI.Page
    {
        string str = ConfigurationManager.ConnectionStrings["JobFinderContext"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Any initialization code can go here
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                using (SqlConnection con = new SqlConnection(str))
                {
                    try
                    {
                        con.Open();

                        // 1. First check if username/email/mobile already exists
                        string checkQuery = @"
                    SELECT 
                        COALESCE(SUM(CASE WHEN Username = @Username THEN 1 ELSE 0 END), 0) as UsernameExists,
                        COALESCE(SUM(CASE WHEN Email = @Email THEN 1 ELSE 0 END), 0) as EmailExists,
                        COALESCE(SUM(CASE WHEN Mobile = @Mobile THEN 1 ELSE 0 END), 0) as MobileExists
                    FROM [Users] 
                    WHERE Username = @Username OR Email = @Email OR Mobile = @Mobile";

                        using (SqlCommand checkCmd = new SqlCommand(checkQuery, con))
                        {
                            checkCmd.Parameters.AddWithValue("@Username", txtUserName.Text.Trim());
                            checkCmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                            checkCmd.Parameters.AddWithValue("@Mobile", txtMobile.Text.Trim());

                            using (SqlDataReader reader = checkCmd.ExecuteReader())
                            {
                                if (reader.Read())
                                {
                                    int usernameExists = reader.GetInt32(0);
                                    int emailExists = reader.GetInt32(1);
                                    int mobileExists = reader.GetInt32(2);

                                    if (usernameExists > 0 || emailExists > 0 || mobileExists > 0)
                                    {
                                        messagePanel.CssClass = "alert alert-danger";
                                        messagePanel.Visible = true;

                                        List<string> existingItems = new List<string>();
                                        if (usernameExists > 0) existingItems.Add("Username");
                                        if (emailExists > 0) existingItems.Add("Email");
                                        if (mobileExists > 0) existingItems.Add("Mobile Number");

                                        litMessage.Text = "The following already exist: " + string.Join(", ", existingItems);
                                        return;
                                    }
                                }
                            }
                        }

                        // 2. If checks pass, proceed with registration
                        string insertQuery = @"
                    INSERT INTO [Users] 
                    (Username, Password, Name, Address, Mobile, Email, Country) 
                    VALUES 
                    (@Username, @Password, @Name, @Address, @Mobile, @Email, @Country);
                    SELECT SCOPE_IDENTITY();";

                        using (SqlCommand insertCmd = new SqlCommand(insertQuery, con))
                        {
                            // Hash the password (consider upgrading to more secure hashing like PBKDF2)
                            string hashedPassword = FormsAuthentication.HashPasswordForStoringInConfigFile(
                                txtConfirmPassword.Text.Trim(), "SHA1");

                            insertCmd.Parameters.AddWithValue("@Username", txtUserName.Text.Trim());
                            insertCmd.Parameters.AddWithValue("@Password", hashedPassword);
                            insertCmd.Parameters.AddWithValue("@Name", txtFullName.Text.Trim());
                            insertCmd.Parameters.AddWithValue("@Address",
                                string.IsNullOrEmpty(txtAddress.Text) ? DBNull.Value : (object)txtAddress.Text.Trim());
                            insertCmd.Parameters.AddWithValue("@Mobile", txtMobile.Text.Trim());
                            insertCmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                            insertCmd.Parameters.AddWithValue("@Country", ddlCountry.SelectedValue);

                            // Execute and get the new user ID
                            int newUserId = Convert.ToInt32(insertCmd.ExecuteScalar());

                            if (newUserId > 0)
                            {
                                // Registration successful
                                messagePanel.CssClass = "alert alert-success";
                                messagePanel.Visible = true;
                                litMessage.Text = "Registration successful! Welcome, " + txtFullName.Text.Trim();

                                // Clear form
                                ClearForm();

                                // Optionally redirect to login or dashboard
                                // Response.Redirect("~/User/Login.aspx");
                            }
                            else
                            {
                                throw new Exception("Registration failed - no rows affected");
                            }
                        }
                    }
                    catch (SqlException sqlEx)
                    {
                        // Handle SQL-specific errors
                        messagePanel.CssClass = "alert alert-danger";
                        messagePanel.Visible = true;
                        litMessage.Text = "Database error occurred. Please try again later.";
                        // Log the error: Logger.LogError(sqlEx);
                    }
                    catch (Exception ex)
                    {
                        // Handle other exceptions
                        messagePanel.CssClass = "alert alert-danger";
                        messagePanel.Visible = true;
                        litMessage.Text = "An unexpected error occurred. Please try again.";
                        // Log the error: Logger.LogError(ex);
                    }
                }
            }
        }

        private void ClearForm()
        {
            txtUserName.Text = string.Empty;
            txtPassword.Text = string.Empty;
            txtConfirmPassword.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtFullName.Text = string.Empty;
            txtMobile.Text = string.Empty;
            txtAddress.Text = string.Empty;
            ddlCountry.ClearSelection();
        }
    }
}