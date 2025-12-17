<%@ Page Title="GO Rentals XML integration demo" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="false" CodeBehind="Default.aspx.cs" Inherits="OTADemo._Default" ValidateRequest="false" Debug="true" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <h1>GO Rentals XML integration demo</h1>
        
        <div class="col-md-12">
            <a href="https://uat-xml.gorentals.nz" class="btn btn-primary" target="_blank">View XML metadata &raquo;</a>
            <a href="https://github.com/gorentalsxml/OTADemo" class="btn btn-primary"  target="_blank">View source &raquo;</a>
            <asp:Button ID="btnDownloadOta" runat="server" CssClass="btn btn-primary" Text="Download XSD files" OnClick="DownLoadSchema_Click"></asp:Button>
        </div>
    </div>

    <div class="form-horizontal">
        <div class="form-group">
            <label class="control-label col-sm-2" for="email">Version:</label>
            <div class="col-sm-10">
                <asp:DropDownList ID="version" runat="server" ClientIDMode="Static" AutoPostBack="true" CssClass="form-control" OnSelectedIndexChanged="Version_SelectedIndexChanged">
                    <asp:ListItem Text="v1" Value="v1" Selected></asp:ListItem>
                    <asp:ListItem Text="v2" Value="v2"></asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-2" for="email">Operations:</label>
            <div class="col-sm-10">
                <asp:DropDownList ID="operation" runat="server" ClientIDMode="Static" AutoPostBack="true" CssClass="form-control" OnSelectedIndexChanged="Operation_SelectedIndexChanged">
                    <asp:ListItem Text="" Value=""></asp:ListItem>
                    <asp:ListItem Text="OTA_Ping" Value="OTA_Ping"></asp:ListItem>
                    <asp:ListItem Text="OTA_VehAvailRate" Value="OTA_VehAvailRate"></asp:ListItem>
                    <asp:ListItem Text="OTA_VehCancel" Value="OTA_VehCancel"></asp:ListItem>
                    <asp:ListItem Text="OTA_VehLocSearch" Value="OTA_VehLocSearch"></asp:ListItem>
                    <asp:ListItem Text="OTA_VehRes" Value="OTA_VehRes"></asp:ListItem>
                    <asp:ListItem Text="OTA_VehRetRes" Value="OTA_VehRetRes"></asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-2" for="email">Header:</label>
            <div class="col-sm-10">
                <asp:TextBox TextMode="MultiLine" Rows="2" ReadOnly runat="server" CssClass="form-control" ID="header" Text="Content-Type: application/xml, Content-Encoding:gzip"></asp:TextBox>
            </div>
        </div>
        <div class="form-group">
            <label class="control-label col-sm-2" for="email">Request body:</label>
            <div class="col-sm-10">
                <asp:TextBox TextMode="MultiLine" Rows="20" runat="server" ID="requestBody" CssClass="form-control"></asp:TextBox>
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <asp:Button ID="send" runat="server" UseSubmitBehavior="false" CssClass="btn btn-primary" Text="Send" OnClick="Send_Click" />
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-sm-2" for="email">Response:</label>
            <div class="col-sm-10">
                <asp:TextBox TextMode="MultiLine" Rows="20" ReadOnly runat="server" ID="txtResponse" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
    </div>
</asp:Content>

