using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebFormDemoProject
{
    public partial class UserList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect(ResolveClientUrl("~/Login.aspx"));
            }
            if (!IsPostBack)
           {
                    // Bind data to the GridView
                 BindGridView();

                if (Session["SuccessMessage"] != null)
                {
                    lblSuccessMessage.Text = Session["SuccessMessage"].ToString();
                    Session.Remove("SuccessMessage");
                } 
                if (Session["ErrorMessage"] != null)
                {
                    lblErrorMessage.Text = Session["ErrorMessage"].ToString();
                    Session.Remove("ErrorMessage");
                }
            }

        
        }

            private void BindGridView() 
            {
                string connectionString = DbConStr.ConnectionString;

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
               

                     using (SqlCommand command = new SqlCommand("sp_UserRegistration", connection))
                     {
                         command.CommandType = CommandType.StoredProcedure;
                         command.Parameters.AddWithValue("@flag", "getUserList");

                         connection.Open();

                         SqlDataReader reader = command.ExecuteReader();

                         if (reader.HasRows)
                         {
                             DataTable dataTable = new DataTable();
                             dataTable.Load(reader);
                             GridView1.DataSource = dataTable;
                             GridView1.DataBind();
                         }
                         else
                         {
                             GridView1.DataSource = null; 
                             GridView1.DataBind();                     
                         }

                          reader.Close();
                     }
                }
            }


        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int rowIndex = Convert.ToInt32(e.CommandArgument);
            int id = Convert.ToInt32(GridView1.DataKeys[rowIndex].Value);

            if (e.CommandName == "EditRow")
            {           
                Response.Redirect("EditUser.aspx?id=" + id);
            }
            else if (e.CommandName == "DeleteRow")
            {
                DeleteItem(id);
                BindGridView();
                // Handle delete operation
            }
        }
        private void DeleteItem(int id)
        {
            try
            {            
              
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString()))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand("sp_UserRegistration", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@flag", "deleteUser");
                        command.Parameters.AddWithValue("@userID", id);


                        SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
                        DataTable dataTable = new DataTable();
                        dataAdapter.Fill(dataTable);
                        if (dataTable.Rows.Count > 0)
                        {
                            string errorCode = dataTable.Rows[0]["errorCode"].ToString();
                            string message = dataTable.Rows[0]["msg"].ToString();
                            if (errorCode == "1")
                            {
                                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>showErrorMessage('" + message + "');</script>", false);
                            }
                            else if (errorCode == "0")
                            {
                                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>showMessage('" + message + "');</script>", false);
                            }
                            else
                            {
                                message = "Something Went Worng!!";
                                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>showErrorMessage('" + message + "');</script>", false);

                            }
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                string exception = ex.Message;
                var message = new JavaScriptSerializer().Serialize(ex.Message.ToString());
                var alert = string.Format("alert({0});", message);
                System.Web.UI.ScriptManager.RegisterStartupScript(this, this.GetType(), "message", alert, true);
            }
        }
    }
}
