using System;
using System.Data.SqlClient;
using System.Web.UI;
using System.Security.Cryptography;
using System.Text;

namespace Online_Banking_Transaction
{
    public partial class Registration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblAccountNumber.Text = GenerateAccountNumber();
                lblAccountType.Text = "Savings"; // Default account type
            }
        }

        private string GenerateAccountNumber()
        {
            string accountNumber = string.Empty;

            try
            {
                using (SqlConnection con = new SqlConnection(Common.GetConnectionString()))
                {
                    string query = @"SELECT 'ASC20220000' + CAST(MAX(CAST(SUBSTRING(AccountNumber, 12, 50) AS INT)) + 1 AS VARCHAR)
                                 AS AccountNumber FROM Account";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        con.Open();
                        accountNumber = cmd.ExecuteScalar()?.ToString() ?? "ASC202200001"; // Default if no accounts exist
                    }
                }
            }
            catch (Exception ex)
            {
                // Log error
                accountNumber = "ASC202200001"; // Fallback value
            }

            return accountNumber;
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            try
            {
                using (SqlConnection con = new SqlConnection(Common.GetConnectionString()))
                {
                    string query = @"INSERT INTO [Banking].[db0].[Account] 
                          (AccountNumber, AccountType, UserName, Password, Gender, 
                           Email, SecurityQuestionId, Answer, Amount, Address) 
                          VALUES 
                          (@AccountNumber, @AccountType, @UserName, @Password, @Gender, 
                           @Email, @SecurityQuestionId, @Answer, @Amount, @Address)";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        // Add parameters matching your database schema
                        cmd.Parameters.AddWithValue("@AccountNumber", lblAccountNumber.Text);
                        cmd.Parameters.AddWithValue("@AccountType", lblAccountType.Text);
                        cmd.Parameters.AddWithValue("@UserName", txtUsername.Text.Trim()); // Note: matches UserName in DB
                        cmd.Parameters.AddWithValue("@Password", HashPassword(txtPassword.Text.Trim()));
                        cmd.Parameters.AddWithValue("@Gender", ddlGender.SelectedValue);
                        cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                        cmd.Parameters.AddWithValue("@SecurityQuestionId", ddlSecurityQuestion.SelectedValue);
                        cmd.Parameters.AddWithValue("@Answer", HashPassword(txtAnswer.Text.Trim())); // Securely hash answer
                        cmd.Parameters.AddWithValue("@Amount", Convert.ToDecimal(txtAmount.Text));
                        cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());

                        con.Open();
                        int result = cmd.ExecuteNonQuery();

                        if (result > 0)
                        {
                            Response.Redirect("Login.aspx", false);
                        }
                        else
                        {
                            lblMessage.Text = "Registration failed. Please try again.";
                            lblMessage.CssClass = "text-red-500";
                        }
                    }
                }
            }
            catch (SqlException sqlEx)
            {
                if (sqlEx.Number == 2627) // Unique key violation
                {
                    lblMessage.Text = "Username already exists. Please choose a different username.";
                    lblMessage.CssClass = "text-red-500";
                }
                else
                {
                    lblMessage.Text = "A database error occurred. Please try again.";
                    lblMessage.CssClass = "text-red-500";
                    // Log error: sqlEx.Message
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "An unexpected error occurred. Please try again.";
                lblMessage.CssClass = "text-red-500";
                // Log error: ex.Message
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }

        private string HashPassword(string input)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(input));
                StringBuilder builder = new StringBuilder();
                foreach (byte b in bytes)
                {
                    builder.Append(b.ToString("x2"));
                }
                return builder.ToString();
            }
        }
    }
}