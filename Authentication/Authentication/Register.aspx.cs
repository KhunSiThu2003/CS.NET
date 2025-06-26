using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Authentication
{
    public partial class Register : System.Web.UI.Page
    {
        SqlConnection conn = new SqlConnection(@"Data Source=KHUN\SQLEXPRESS;Initial Catalog=AuthDB;Integrated Security=True");
        SqlCommand cmd;
        protected void Page_Load(object sender, EventArgs e)
        {
            conn.Open();
        }

        protected void btnSignUp_Click(object sender, EventArgs e)
        {
            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            if(EmailIsExit(email))
            {
                conn.Close();

                // Error message
                lblMessage.Text = "Email is already exit, Try again!";
                lblMessage.CssClass = "block text-center text-sm font-medium p-2 rounded-md bg-red-100 text-red-700";
                return;
            }
            
            else

            {
                if (AddUser(name, email, password))
                {
                    conn.Close();

                    Response.Redirect("Login.aspx");

                }

                else

                {
                    conn.Close();

                    // Error message
                    lblMessage.Text = "Something is ERROR!";
                    lblMessage.CssClass = "block text-center text-sm font-medium p-2 rounded-md bg-red-100 text-red-700";
                }
            }

            
        }

        public bool EmailIsExit (string email)
        {

            string emailCheck = "SELECT COUNT(1) FROM Users WHERE Email = @Email";
            cmd = new SqlCommand(emailCheck, conn);
            cmd.Parameters.AddWithValue("@Email", email);
            int count = (int)cmd.ExecuteScalar();
            return count > 0;

        }

        public bool AddUser (string name, string email, string password)
        {

            string insertQuery = "Insert into Users (Name,Email,Password) values (@Name,@Email,@Password)";

            cmd = new SqlCommand(insertQuery, conn);

            cmd.Parameters.AddWithValue("@Name", name);
            cmd.Parameters.AddWithValue("@Email", email);
            cmd.Parameters.AddWithValue("@Password", password);

            int r = cmd.ExecuteNonQuery();

            if (r > 0)
            {
                return true;
            } else
            {
                return false;
            }
        }
    }
}