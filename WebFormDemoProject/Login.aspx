<%@ Page Title="Login" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebFormDemoProject.Login" %>

<!DOCTYPE html>
<html >
<head runat="server">
    <title>Login</title>
           <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" 
           integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
       <script type="text/javascript">
              function showErrorMessage(ex) {
                  alert(ex);
              }
       </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <%--<div class="row" style="display:flex; justify-content:center">--%>
            <div class=" d-flex justify-content-center align-items-center " style="height:100vh" >
                <div class="col-md-4 mt-5 ">
                    <asp:Panel ID="pnlLogin" runat="server" CssClass="card card-body p-5">
                         <h2 class="text-center mb-4">Sign In</h2>

                        <div class="form-group mb-3">
                            <asp:Label ID="lblUsername" runat="server" Text="Username"></asp:Label>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" autocomplete="off"></asp:TextBox>
                              <asp:RequiredFieldValidator ID="validateUserName" runat="server" ControlToValidate="txtUsername"
                                  ErrorMessage="User Name is required." ForeColor="Red" Display="Dynamic">
                             </asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group mb-3">
                            <asp:Label ID="lblPassword" runat="server" Text="Password" autocomplete="off"></asp:Label>
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="validatePassword" runat="server" ControlToValidate="txtPassword"
                                  ErrorMessage="Password is required." ForeColor="Red" Display="Dynamic">
                             </asp:RequiredFieldValidator>
                        </div>  
                        <div class="form-group">
                               <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-primary btn-block w-100" OnClick="btnLogin_Click" />
                        </div>
                        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
                        <hr />
                        <div class="form-group m-2">
                            <p>Don't have an account? <a href="Register.aspx">Sign Up</a></p>       

                        </div>
                    </asp:Panel>
                </div>
            </div>
        </div>
    </form>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

</body>
</html>
