<%@ Page Language="C#" Title="UserList" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="UserList.aspx.cs" Inherits="WebFormDemoProject.UserList" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        function showMessage(msg) {
            // window.location.href = "UserList.aspx";
            alert(msg);
        }

        function showErrorMessage(ex) {
            alert(ex);
        }
    </script>
    <style>
         .gridview {
        width: 100%;
            border-collapse: collapse;
        }
        
        .gridview th, .gridview td {
            padding: 8px;
            border: 1px solid #ddd;
        }
        
        .gridview th {
            background-color: #f2f2f2;
        }
        
        .gridview tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        
        .gridview tr:hover {
            background-color: #ddd;
        }
        
        .gridview .edit-button {
            background-color: green;
            color: white;
            border: none;
            padding: 6px 12px;
            cursor: pointer;
            border-radius: 4px;
        }
        
        .gridview .delete-button {
            background-color: red;
            color: white;
            border: none;
            padding: 6px 12px;
            cursor: pointer;
            border-radius: 4px;
        }
    </style>
    <div style="margin:20px 0px; text-align:right">
        <asp:Label ID="lblSuccessMessage" runat="server"  Style="color:green" ></asp:Label>
        <asp:Label ID="lblErrorMessage" runat="server" Style="color:red" ></asp:Label>
    </div>
      <div style="margin-top:20px;  text-align:center">
       <h3>User List</h3>
          <a href="ManageUser.aspx" style="float:right; margin-bottom:20px" class="btn btn-primary"> Add new </a>
    </div>
<asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="userID" OnRowCommand="GridView1_RowCommand" CssClass="gridview">
    <Columns>
         <asp:TemplateField HeaderText="SN">
               <ItemTemplate>
                     <%# Container.DataItemIndex + 1 %>
              </ItemTemplate>
         </asp:TemplateField>
        <%--<asp:BoundField DataField="userID" HeaderText="UserID" />--%>
        <asp:BoundField DataField="fullName" HeaderText="Full Name" />
        <asp:BoundField DataField="userName" HeaderText="User Name" />
        <asp:BoundField DataField="email" HeaderText="Email Address" />
        <asp:BoundField DataField="phone" HeaderText="Phone Number" />
        <asp:BoundField DataField="address" HeaderText="Address" />
        <asp:BoundField DataField="userStatus" HeaderText="User Status" />
        <asp:TemplateField HeaderText="Actions">
            <ItemTemplate>
                <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandName="EditRow" CssClass="edit-button" CommandArgument='<%# Container.DataItemIndex %>' />
                <asp:Button runat="server" Text="Delete" CommandName="DeleteRow" CssClass="delete-button" CommandArgument='<%# Container.DataItemIndex %>' OnClientClick="return confirm('Are you sure you want to delete this User?');" />
            </ItemTemplate>
        </asp:TemplateField>
    </Columns>
</asp:GridView>
</asp:Content>
