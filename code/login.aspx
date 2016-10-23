<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="SignalRDemo.signup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/jquery-1.8.2.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <title></title>
</head>
<body>
    <form id="form1" class="form-control" runat="server">
    <div><br /><br /><br /><br />

        <div class="container">
          
            <div class="panel panel-default">
            <div class="panel-heading">Log in</div>
            <div class="panel-body">
                     <asp:TextBox CssClass="form-control" ID="TextBox1" placeholder="ID" required="" runat="server"></asp:TextBox>
            <br />
                <asp:TextBox ID="TextBox2"  CssClass="form-control" required="" placeholder="Name" runat="server"></asp:TextBox>
              <br />
                         <asp:Button ID="Button1" OnClick="Button1_Click" CssClass=" btb btn-danger form-control" runat="server" Text="login" />
                <asp:Label ID="Label1" runat="server" ForeColor="IndianRed" ></asp:Label>
            </div>
        </div>



               <div class="panel panel-default">
            <div class="panel-heading">Credentials</div>
            <div class="panel-body">
                      <table class="table">
    <thead style="color:tomato;font-size:medium">
      <tr>
        <th>ID</th>
        <th>NAME</th>
       
      </tr>
    </thead>
    <tbody style="font-size:15px;color:white">
      <tr class="success">
        <td>1</td>
        <td>Anshul</td>
      
      </tr>
      <tr class="danger">
        <td>2</td>
        <td>Anil</td>
     
      </tr>
      <tr class="info">
        <td>3</td>
        <td>Sunil</td>
      
      </tr>
         <tr class="success">
        <td>4</td>
        <td>Rahul</td>
      
      </tr>
         <tr class="info">
        <td>5</td>
        <td>Alex</td>
      
      </tr>
    </tbody>
  </table>
            </div>
        </div>


           



        </div>
     
    </div>
    </form>
</body>
</html>
