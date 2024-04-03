<%@ Page Title="Dashboard" Language="C#"  MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="WebFormDemoProject.Dashboard" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
  
    <asp:UpdatePanel runat="server" ID="UpdPanel1">
        <ContentTemplate>
            <div>
                  <h1>Welcome to the Dashboard!</h1>
              
            </div>
      
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
