using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

namespace ManageStudio
{
    public partial class Student : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\C#\\ManageStudio\\ManageStudio\\App_Data\\ManageStudioDB.mdf;Integrated Security=True");
        SqlCommand cmd = new SqlCommand();
        SqlDataAdapter da = new SqlDataAdapter();
        DataTable DataTable = new DataTable();
        protected void Page_Load(object sender, EventArgs e)
        {
            con.Open();
            da = new SqlDataAdapter("Select * from Students",con);
            da.Fill(DataTable);
            GridView1.DataSource = DataTable;
            GridView1.DataBind();
        }

        protected void AddStudent_Click(object sender, EventArgs e)
        {
            try
            {
                // Create SQL command for insertion
                cmd = new SqlCommand("INSERT INTO Students (Name, RollNumber, Email, PhoneNumber) VALUES (@Name, @RollNumber, @Email, @PhoneNumber)", con);

                // Add parameters to prevent SQL injection
                cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                cmd.Parameters.AddWithValue("@RollNumber", txtRollNumber.Text.Trim());
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@PhoneNumber", txtPhoneNumber.Text.Trim());

                // Execute the command
                cmd.ExecuteNonQuery();

                // Clear the form fields
                txtName.Text = "";
                txtRollNumber.Text = "";
                txtEmail.Text = "";
                txtPhoneNumber.Text = "";

                // Refresh the GridView to show the new data
                DataTable.Clear();
                da = new SqlDataAdapter("SELECT * FROM Students", con);
                da.Fill(DataTable);
                GridView1.DataSource = DataTable;
                GridView1.DataBind();

                // Show success message
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Student added successfully!');", true);
            }
            catch (Exception ex)
            {
                // Show error message
                ClientScript.RegisterStartupScript(this.GetType(), "alert", $"alert('Error: {ex.Message}');", true);
            }
        }


    }
}