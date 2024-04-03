<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="WebFormDemoProject.Register" %>

<!DOCTYPE html>
<html >
<head runat="server">
    <title>Register</title>
           <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" 
           integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
          <script type="text/javascript">

              function showMessage(msg) {
                  alert(msg);
                  window.location.href = "Login.aspx";
              }

              function showErrorMessage(ex) {
                  alert(ex);
              }
              function reloadPage() {
                  window.location.href = "Register.aspx";
              }
          </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <%--<div class="row" style="display:flex; justify-content:center">--%>
            <div class=" d-flex justify-content-center align-items-center " style="height:100vh" >
                <div class="col-md-9 mt-2">
                    <asp:Panel ID="pnlRegister" runat="server" CssClass="card card-body px-5">
                         <h2 class="text-center mb-4">Sign Up</h2>

                      <div class="row mb-4">           
                        <div class="col-md-4 ">
                            <label id="lblFirstName">  First Name</label>
                            <asp:TextBox ID="txtFirstName" runat="server" class="form-control" autocomplete="off"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="validateFirstName" runat="server" ControlToValidate="txtFirstName"
                                  ErrorMessage="First Name is required." ForeColor="Red" Display="Dynamic">
                             </asp:RequiredFieldValidator>

                         </div>
                      <div class="col-md-4">
                            <label id="lblLastName">  Last Name</label>
                            <asp:TextBox ID="txtLastName" runat="server" class="form-control" autocomplete="off"></asp:TextBox>
                              <asp:RequiredFieldValidator ID="validateLastName" runat="server" ControlToValidate="txtLastName"
                                  ErrorMessage="Last Name is required." ForeColor="Red" Display="Dynamic">
                             </asp:RequiredFieldValidator>
                         </div>
                         <div class="col-md-4">
                            <label id="lblGender"> Gender</label>
                            <asp:DropDownList ID="ddlGender" class="form-control" runat="server" >
                                <asp:ListItem Text="" Value="">Select Gender</asp:ListItem>
                                <asp:ListItem Text="Male" Value="M"></asp:ListItem>
                                <asp:ListItem Text="Female" Value="F"></asp:ListItem>
                                <asp:ListItem Text="Other" Value="O"></asp:ListItem>
                            </asp:DropDownList>     
                             <asp:RequiredFieldValidator ID="validateGender" runat="server" ControlToValidate="ddlGender"
                                    InitialValue="" ErrorMessage="Please select Gender." ForeColor="Red" Display="Dynamic">
                            </asp:RequiredFieldValidator>
                        </div>
                    </div>
                      <div class="row mb-4">
                        <div class="col-md-4">
                            <label id="lblUsername"> User Name</label>
                            <asp:TextBox ID="txtUsername" runat="server" class="form-control" autocomplete="off"></asp:TextBox> 
                             <asp:RequiredFieldValidator ID="validateUsernname" runat="server" ControlToValidate="txtUsername"
                                  ErrorMessage="User Name is required." ForeColor="Red" Display="Dynamic">
                             </asp:RequiredFieldValidator>
                        </div>
                           <div class="col-md-4">
                            <label id="lblPassword"> Password</label>
                            <asp:TextBox ID="txtPassword" class="form-control" TextMode="Password" runat="server"  autocomplete="off"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="validatePasswordRequired" runat="server" ControlToValidate="txtPassword"
                                  ErrorMessage="Password is required." ForeColor="Red" Display="Dynamic">
                             </asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidatorPassword" runat="server" ControlToValidate="txtPassword"
                                ErrorMessage="Password must be at least 8 characters long and contain at least one special character and one number"
                                ValidationExpression="^(?=.*[0-9])(?=.*[^\w\s]).{8,}$" ForeColor="Red" Display="Dynamic">
                            </asp:RegularExpressionValidator>
                       
                        </div>
                        <div class="col-md-4">
                            <label id="lblConfirmPassword"> Confirm Password</label>
                            <asp:TextBox ID="txtConfirmPassword" class="form-control" TextMode="Password" runat="server"  autocomplete="off"></asp:TextBox>      
                             <asp:RequiredFieldValidator ID="validateConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword"
                                  ErrorMessage="Confirm Password is required." ForeColor="Red" Display="Dynamic">
                             </asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="comparePasswords" runat="server" ControlToCompare="txtPassword"
                                ForeColor="Red" ControlToValidate="txtConfirmPassword" ErrorMessage="Your passwords do not match up!"
                                Display="Dynamic" />
                        </div>


                    </div>
                    <div class="row mb-4">
                          <div class="col-md-4">
                            <label id="lblPhone"> Phone</label>
                            <asp:TextBox ID="txtPhone" runat="server" class="form-control" autocomplete="off"></asp:TextBox>  
                             <asp:RequiredFieldValidator ID="validatePhone" runat="server" ControlToValidate="txtPhone"
                                  ErrorMessage="Phone Number is required." ForeColor="Red" Display="Dynamic">
                             </asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidatorPhone" ControlToValidate="txtPhone"
                                runat="server" ErrorMessage="Only Numbers allowed and Number must be 10 Digit"
                                ValidationExpression="[0-9]{10}" ForeColor="Red" Display="Dynamic">
                            </asp:RegularExpressionValidator>
                        </div>
                        <div class="col-md-4">
                            <label id="lblEmail">Email</label>
                            <asp:TextBox ID="txtEmail" runat="server" class="form-control" autocomplete="off"></asp:TextBox>   
                             <asp:RequiredFieldValidator ID="validateEmail" runat="server" ControlToValidate="txtEmail"
                                  ErrorMessage="Email is required." ForeColor="Red" Display="Dynamic">
                             </asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="regEmail" ControlToValidate="txtEmail" Text="Enter valid email id"
                                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" runat="server"
                                ForeColor="Red" Display="Dynamic" >
                             </asp:RegularExpressionValidator>
                        </div>
                        <div class="col-md-4">
                            <label id="lblAddress">Address</label>
                                <asp:TextBox ID="txtAddress" runat="server" class="form-control" autocomplete="off"></asp:TextBox>
                            </div>
                    </div>

                        <div class="form-group text-center">
                               <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn btn-primary btn-block w-25" OnClick="btnRegister_Click" />
                               <input type="reset" class="btn btn-info btn-block w-25 mx-2" value="Reset" onclick="reloadPage();" />

                        </div>
                        <hr />
                        <div class="form-group">
                            <p>Already have an account? <a href="Login.aspx">Sign In</a></p>       
                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </form>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
      <script type="text/javascript" language="javascript">
          function AlertErrorMessage() {
              var FirstName = document.getElementById("MainContent_txtFirstName");
              var LastName = document.getElementById("MainContent_txtLastName");
              var Gender = document.getElementById("MainContent_ddlGender");
              var UserName = document.getElementById("MainContent_txtUsername");
              var Phone = document.getElementById("MainContent_txtPhone");
              var Email = document.getElementById("MainContent_txtEmail");
              var Password = document.getElementById("MainContent_txtPassword");

              if (FirstName.value == "") {
                  alert(" Full Name is Required!");
                  FirstName.focus();
              }
              else if (LastName.value == "") {
                  alert(" Last Name is Required!");
                  LastName.focus();
              }
              else if (Gender.value == "") {
                  alert(" Gender is Required!");
                  Gender.focus();
              }
              else if (UserName.value == "") {
                  alert("User Name is Required!");
                  UserName.focus();
              }
              else if (Phone.value == "") {
                  alert(" Phone Number is Required!");
                  Phone.focus();
              }
              else if (Email.value == "") {
                  alert(" Email AddressValue is Required!");
                  Email.focus();
              }
              else if (Password.value == "") {
                  alert(" Password is Required!");
                  Password.focus();
              }
              else if (ConfirmPassword.value == "") {
                  alert(" Confirm Password is Required!");
                  ConfirmPassword.focus();
              }

          }

      </script>

</body>
</html>
