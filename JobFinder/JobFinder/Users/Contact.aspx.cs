using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;

namespace JobFinder.User
{
    public partial class Contact : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CreateContactMessagesTableIfNotExists();
            }
        }

        private void CreateContactMessagesTableIfNotExists()
        {
            try
            {
                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["JobFinderContext"].ConnectionString;

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string checkTableQuery = @"
                IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'ContactMessages')
                BEGIN
                    CREATE TABLE ContactMessages (
                        Id INT IDENTITY(1,1) PRIMARY KEY,
                        Name NVARCHAR(100) NOT NULL,
                        Email NVARCHAR(100) NOT NULL,
                        Subject NVARCHAR(200) NULL,
                        Message NVARCHAR(MAX) NOT NULL,
                        SubmissionDate DATETIME NOT NULL
                    )
                END";

                    using (SqlCommand cmd = new SqlCommand(checkTableQuery, con))
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Trace.TraceError($"Error creating ContactMessages table: {ex}");
            }
        }

        protected void SubmitForm(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                Validate("ContactForm");

                if (Page.IsValid)
                {
                    try
                    {
                        string name = txtName.Text.Trim();
                        string email = txtEmail.Text.Trim();
                        string subject = txtSubject.Text.Trim();
                        string message = txtMessage.Text.Trim();

                        string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["JobFinderContext"].ConnectionString;

                        using (SqlConnection con = new SqlConnection(connectionString))
                        {
                            string query = @"INSERT INTO ContactMessages 
                                    (Name, Email, Subject, Message, SubmissionDate) 
                                    VALUES (@Name, @Email, @Subject, @Message, @SubmissionDate)";

                            using (SqlCommand cmd = new SqlCommand(query, con))
                            {
                                cmd.Parameters.Add("@Name", SqlDbType.NVarChar, 100).Value = name;
                                cmd.Parameters.Add("@Email", SqlDbType.NVarChar, 100).Value = email;

                                if (!string.IsNullOrEmpty(subject))
                                    cmd.Parameters.Add("@Subject", SqlDbType.NVarChar, 200).Value = subject;
                                else
                                    cmd.Parameters.AddWithValue("@Subject", DBNull.Value);

                                cmd.Parameters.Add("@Message", SqlDbType.NVarChar, -1).Value = message;
                                cmd.Parameters.Add("@SubmissionDate", SqlDbType.DateTime).Value = DateTime.Now;

                                con.Open();
                                int rowsAffected = cmd.ExecuteNonQuery();

                                if (rowsAffected > 0)
                                {
                                    // Clear form
                                    txtName.Text = string.Empty;
                                    txtEmail.Text = string.Empty;
                                    txtSubject.Text = string.Empty;
                                    txtMessage.Text = string.Empty;

                                    // Show success
                                    messagePanel.Visible = true;
                                    messagePanel.CssClass = "alert alert-success";
                                    litMessage.Text = "Your message has been sent successfully!";

                                    // Scroll to message
                                    ScriptManager.RegisterStartupScript(this, this.GetType(), "scrollToMessage",
                                        "document.getElementById('" + messagePanel.ClientID + "').scrollIntoView({behavior: 'smooth'});", true);
                                }
                            }
                        }
                    }
                    catch (SqlException sqlEx)
                    {
                        // Log error
                        System.Diagnostics.Trace.TraceError($"Database error: {sqlEx}");

                        // Show error
                        messagePanel.Visible = true;
                        messagePanel.CssClass = "alert alert-danger";
                        litMessage.Text = "Sorry, we encountered an error. Please try again later.";

                        ScriptManager.RegisterStartupScript(this, this.GetType(), "scrollToMessage",
                            "document.getElementById('" + messagePanel.ClientID + "').scrollIntoView({behavior: 'smooth'});", true);
                    }
                    catch (Exception ex)
                    {
                        // Log error
                        System.Diagnostics.Trace.TraceError($"General error: {ex}");

                        // Show error
                        messagePanel.Visible = true;
                        messagePanel.CssClass = "alert alert-danger";
                        litMessage.Text = "An unexpected error occurred. Please try again.";

                        ScriptManager.RegisterStartupScript(this, this.GetType(), "scrollToMessage",
                            "document.getElementById('" + messagePanel.ClientID + "').scrollIntoView({behavior: 'smooth'});", true);
                    }
                }
                else
                {
                    // Validation failed
                    messagePanel.Visible = true;
                    messagePanel.CssClass = "alert alert-warning";
                    litMessage.Text = "Please correct the form errors and try again.";

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "scrollToMessage",
                        "document.getElementById('" + messagePanel.ClientID + "').scrollIntoView({behavior: 'smooth'});", true);
                }
            }
        }
    }
}