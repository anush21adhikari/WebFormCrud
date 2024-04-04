using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebFormDemoProject
{
    public partial class EditUser : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect(ResolveClientUrl("~/Login.aspx"));
            }
            if (!IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    FetchEditData();
                }
                else
                {                 
                 Response.Redirect(ResolveClientUrl("~/UserList.aspx"));              
                }
            }
        }
        protected void FetchEditData()
        {

            if (Request.QueryString["id"] != null)
            {
                int userId;
                if (int.TryParse(Request.QueryString["id"], out userId))
                {
                    string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnString"].ConnectionString;

                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {

                        using (SqlCommand command = new SqlCommand("sp_UserRegistration", connection))
                        {
                            command.CommandType = CommandType.StoredProcedure;
                            command.Parameters.AddWithValue("@flag", "edit");
                            command.Parameters.AddWithValue("@userID", userId);

                            connection.Open();
                            SqlDataReader reader = command.ExecuteReader();

                            if (reader.HasRows)
                            {
                                DataTable dataTable = new DataTable();
                                dataTable.Load(reader);
                                if (dataTable.Rows.Count > 0)
                                {
                                    txtFirstName.Text = dataTable.Rows[0]["firstName"].ToString();
                                    txtLastName.Text = dataTable.Rows[0]["lastName"].ToString();
                                    ddlGender.SelectedValue = dataTable.Rows[0]["gender"].ToString();
                                    txtUsername.Text = dataTable.Rows[0]["userName"].ToString();
                                    txtEmail.Text = dataTable.Rows[0]["email"].ToString();
                                    txtPhone.Text = dataTable.Rows[0]["phone"].ToString();
                                    txtAddress.Text = dataTable.Rows[0]["address"].ToString();
                                    ddlIsActive.SelectedValue = dataTable.Rows[0]["isActive"].ToString();
                                    hdnUserID.Value = userId.ToString();
                                }
                            }
                            else
                            {
                                Session["ErrorMessage"] = "Something went Wrong!!";
                                Response.Redirect("UserList.aspx");
                            }
                            reader.Close();
                        }
                    }
                }
                else
                {
                    Session["ErrorMessage"] = "Something went Wrong!!";
                    Response.Redirect("UserList.aspx");
                }
            }
            else
            {
                Session["ErrorMessage"] = "Something went Wrong!!";
                Response.Redirect("UserList.aspx");
            }
        }


        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {

                String User = Convert.ToString(Session["UserName"]);

                if (string.IsNullOrWhiteSpace(txtFirstName.Text) || string.IsNullOrWhiteSpace(txtLastName.Text) || string.IsNullOrWhiteSpace(txtUsername.Text)
                          || string.IsNullOrWhiteSpace(ddlGender.Text) || string.IsNullOrWhiteSpace(txtEmail.Text)
                          || string.IsNullOrWhiteSpace(txtPhone.Text))
                {

                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>AlertErrorMessage();</script>", false);
                    return;
                }
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString()))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand("sp_UserRegistration", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@flag", "update");
                        command.Parameters.AddWithValue("@firstName", txtFirstName.Text.Replace("'", "`").Replace("&", "And"));
                        command.Parameters.AddWithValue("@lastName", txtFirstName.Text.Replace("'", "`").Replace("&", "And"));
                        command.Parameters.AddWithValue("@userName", txtUsername.Text.Replace("'", "`").Replace("&", "And"));
                        command.Parameters.AddWithValue("@gender", ddlGender.Text);
                        command.Parameters.AddWithValue("@address", txtAddress.Text);
                        command.Parameters.AddWithValue("@password", PasswordHelper.HashPassword(txtPassword.Text));
                        command.Parameters.AddWithValue("@phone", txtPhone.Text);
                        command.Parameters.AddWithValue("@email", txtEmail.Text);
                        command.Parameters.AddWithValue("@createdBy", User);
                        command.Parameters.AddWithValue("@isActive", ddlIsActive.Text);
                        command.Parameters.AddWithValue("@userID", hdnUserID.Value);


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
                                Session["SuccessMessage"] = message;
                                Response.Redirect("UserList.aspx");

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