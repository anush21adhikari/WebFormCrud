using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebFormDemoProject
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {

            try
            {

                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString()))
                {
                    connection.Open();

                    using (SqlCommand command = new SqlCommand("sp_UserLogin", connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.AddWithValue("@flag", "userLogin");
                        command.Parameters.AddWithValue("@userName", txtUsername.Text.Replace("'", "`").Replace("&", "And"));                
                        command.Parameters.AddWithValue("@password", PasswordHelper.HashPassword(txtPassword.Text));
                        
                        using (SqlDataAdapter dataAdapter = new SqlDataAdapter(command))
                        {
                            DataSet ds = new DataSet();
                            dataAdapter.Fill(ds);
                            
                            DataTable dt0 = new DataTable();
                            dt0 = ds.Tables[0];
                            string message = dt0.Rows[0]["msg"].ToString();

                            DataTable dt = new DataTable();
                            if (ds.Tables.Count > 1)
                            {
                                dt = ds.Tables[1];
                                if (dt.Rows.Count > 0)
                                {
                                    Session["UserID"] = dt.Rows[0]["userID"];
                                    Session["Username"] = dt.Rows[0]["userName"];
                                    Session["FullName"] = dt.Rows[0]["fullName"];
                                    Session["Email"] = dt.Rows[0]["email"];
                                    Response.Redirect("Dashboard.aspx");

                                }
                                else
                                {
                                    //lblMessage.Text = message.ToString();
                                    lblMessage.Text = "Invalid username or password";
                                    //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>showErrorMessage('"+ message + "');</script>", false);

                                }
                            }
                            else
                            {
                                //lblMessage.Text = message.ToString();
                                lblMessage.Text = "Invalid username or password";
                                //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>showErrorMessage('"+message+"');</script>", false);

                            }
                        }

                       

                        //SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
                        //DataSet ds = new DataSet();
                        //dataAdapter.Fill(ds);
                        //string errorCode = ds[1].Rows[0]["errorCode"].ToString();
                        //string message = dataTable.Rows[0]["msg"].ToString();

                        //if (errorCode == "1")
                        //{
                        //    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>showErrorMessage('" + message + "');</script>", false);
                        //}
                        //else if (errorCode == "0")
                        //{
                        //    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", "<script type='text/javascript'>showMessage('" + message + "');</script>", false);
                        //}
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
