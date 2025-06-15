using System;
using System.Web.UI;

namespace Online_Banking_Transaction
{
    public partial class Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Response.Redirect("~/Login.aspx");
            }
        }
    }
} 