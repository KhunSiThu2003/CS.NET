using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ManageStudio
{
    public partial class Product : System.Web.UI.Page
    {
        private string connectionString = "Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=D:\\C#\\ManageStudio\\ManageStudio\\App_Data\\ManageStudioDB.mdf;Integrated Security=True";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMessage.Text = "";
                txtDateAdded.Text = DateTime.Now.ToString("yyyy-MM-dd");
                BindGridView();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                SqlConnection con = null;
                SqlCommand cmd = null;

                try
                {
                    con = new SqlConnection(connectionString);
                    string query = @"INSERT INTO Products (ProductName, Price, Quantity, DateAdded) 
                                    VALUES (@ProductName, @Price, @Quantity, @DateAdded)";

                    cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@ProductName", txtProductName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Price", decimal.Parse(txtPrice.Text));
                    cmd.Parameters.AddWithValue("@Quantity", int.Parse(txtQuantity.Text));
                    cmd.Parameters.AddWithValue("@DateAdded", DateTime.Parse(txtDateAdded.Text));

                    con.Open();
                    cmd.ExecuteNonQuery();

                    lblMessage.Text = "Product added successfully!";
                    lblMessage.CssClass = "text-green-500";
                    ClearForm();
                    BindGridView();
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error: " + ex.Message;
                    lblMessage.CssClass = "text-red-500";
                }
                finally
                {
                    if (cmd != null) cmd.Dispose();
                    if (con != null)
                    {
                        con.Close();
                        con.Dispose();
                    }
                }
            }
        }

        protected void gvProducts_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            SqlConnection con = null;
            SqlCommand cmd = null;

            try
            {
                if (gvProducts.DataKeys != null && e.RowIndex >= 0)
                {
                    int productId = Convert.ToInt32(gvProducts.DataKeys[e.RowIndex].Value);
                    con = new SqlConnection(connectionString);
                    string query = "DELETE FROM Products WHERE ProductID = @ProductID";

                    cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@ProductID", productId);

                    con.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        lblMessage.Text = "Product deleted successfully!";
                        lblMessage.CssClass = "text-green-500";
                        BindGridView();
                    }
                    else
                    {
                        lblMessage.Text = "No product found with the specified ID.";
                        lblMessage.CssClass = "text-yellow-500";
                    }
                }
                else
                {
                    lblMessage.Text = "Invalid row index for deletion.";
                    lblMessage.CssClass = "text-red-500";
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error deleting product: " + ex.Message;
                lblMessage.CssClass = "text-red-500";
            }
            finally
            {
                if (cmd != null) cmd.Dispose();
                if (con != null)
                {
                    con.Close();
                    con.Dispose();
                }
            }
        }

        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            BindGridView();
            lblMessage.Text = "Product list refreshed.";
            lblMessage.CssClass = "text-blue-500";
        }

        private void BindGridView()
        {
            SqlConnection con = null;
            SqlCommand cmd = null;
            SqlDataAdapter da = null;
            DataTable dt = null;

            try
            {
                con = new SqlConnection(connectionString);
                string query = "SELECT ProductID, ProductName, Price, Quantity, DateAdded FROM Products ORDER BY ProductID DESC";

                cmd = new SqlCommand(query, con);
                da = new SqlDataAdapter(cmd);
                dt = new DataTable();
                da.Fill(dt);

                gvProducts.DataSource = dt;
                gvProducts.DataBind();
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error loading products: " + ex.Message;
                lblMessage.CssClass = "text-red-500";
            }
            finally
            {
                if (dt != null) dt.Dispose();
                if (da != null) da.Dispose();
                if (cmd != null) cmd.Dispose();
                if (con != null)
                {
                    con.Close();
                    con.Dispose();
                }
            }
        }

        private void ClearForm()
        {
            txtProductName.Text = "";
            txtPrice.Text = "";
            txtQuantity.Text = "";
            txtDateAdded.Text = DateTime.Now.ToString("yyyy-MM-dd");
        }
    }
}