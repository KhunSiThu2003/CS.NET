using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Net.NetworkInformation;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Authentication
{
    public partial class Login : System.Web.UI.Page
    {
        SqlConnection conn = new SqlConnection(@"Data Source=KHUN\SQLEXPRESS;Initial Catalog=AuthDB;Integrated Security=True");
        SqlCommand cmd;
        protected void Page_Load(object sender, EventArgs e)
        {
            conn.Open();
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text;
            string password = txtPassword.Text;

            if (LoginUser(email, password))
            {
                conn.Close();
                Response.Redirect("HomePage.aspx");
               
            } else
            {
                conn.Close();

                // Error message
                lblMessage.Text = "Email or Password is incorrect.";
                lblMessage.CssClass = "block text-center text-sm font-medium p-2 rounded-md bg-red-100 text-red-700";
            }
        }

        public bool LoginUser (string email, string password)
        {
            string loginQuery = "SELECT COUNT(1) FROM Users WHERE Email = @Email AND Password = @Password";
            SqlCommand cmd = new SqlCommand(loginQuery, conn);
            cmd.Parameters.AddWithValue("@Email", email);
            cmd.Parameters.AddWithValue("@Password", password);

            int userCount = (int)cmd.ExecuteScalar();
            return userCount > 0;

        }
    }
}