using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebFormDemoProject
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            try
            {
                String User = Convert.ToString(Session["UserID"]);

                if (string.IsNullOrWhiteSpace(txtFirstName.Text) || string.IsNullOrWhiteSpace(txtLastName.Text) || string.IsNullOrWhiteSpace(txtUsername.Text)
                          || string.IsNullOrWhiteSpace(ddlGender.Text) || string.IsNullOrWhiteSpace(txtPassword.Text) || string.IsNullOrWhiteSpace(txtEmail.Text)
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
                        command.Parameters.AddWithValue("@flag", "insert");
                        command.Parameters.AddWithValue("@firstName", txtFirstName.Text.Replace("'", "`").Replace("&", "And"));
                        command.Parameters.AddWithValue("@lastName", txtFirstName.Text.Replace("'", "`").Replace("&", "And"));
                        command.Parameters.AddWithValue("@userName", txtUsername.Text.Replace("'", "`").Replace("&", "And"));
                        command.Parameters.AddWithValue("@gender", ddlGender.Text);
                        command.Parameters.AddWithValue("@password", PasswordHelper.HashPassword(txtPassword.Text));
                        command.Parameters.AddWithValue("@address", txtAddress.Text);
                        command.Parameters.AddWithValue("@phone", txtPhone.Text);
                        command.Parameters.AddWithValue("@email", txtEmail.Text);
                        command.Parameters.AddWithValue("@createdBy", User);

                        ///  command.ExecuteNonQuery();
                        SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
                        DataTable dataTable = new DataTable();
                        dataAdapter.Fill(dataTable);
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