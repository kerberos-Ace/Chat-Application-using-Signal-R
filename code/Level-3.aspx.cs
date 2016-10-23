using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace SignalRDemo
{
    public partial class Level_3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["id"] == null)
            {
                Response.Redirect("login.aspx");


            }
            else
            {
                var temp1 = Session["id"].ToString().Split('-');
                Label1.Text = temp1.First();
                Label2.Text = temp1.Last();
                
                MySqlConnection cn = new MySqlConnection();
                cn.ConnectionString = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["cnstring"].ToString();

                String s = "select * from frndz where sid = '" + temp1.First() + "' or cid= '" + temp1.First() + "' ";


                cn.Open();

                MySqlCommand cmd = new MySqlCommand(s, cn);
                MySqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    retu_name na = new retu_name();
                 
                    

                    string name = "";
                    string id= "";
                    if (dr[2].ToString() == temp1.First())
                    {
                        name = na.name_(dr[1].ToString());
                        id=dr[1].ToString();
                  
                  }
                    else if (dr[1].ToString() == temp1.First()) {
                        name = na.name_(dr[2].ToString());
                       id=dr[2].ToString();
                    }

                    pane.Controls.Add(new LiteralControl(" <div class='sidebar-name'>"));

                    pane.Controls.Add(new LiteralControl(" <div class='row'>"));
                   pane.Controls.Add(new LiteralControl(" <div  class='col-lg-4'>"));

                   
                   
                    LinkButton b12 = new LinkButton();
                    b12.Text = name;
             
                    b12.Style.Add("font-size", "15px");
                    b12.Attributes.Add("href", "javascript:register_popup('"+id+"' , '"+name+"');");
                    pane.Controls.Add(new LiteralControl(" <img src='css/d.png'  id='" + id+ "-i'   />"));
                   pane.Controls.Add(new LiteralControl(" </div>"));
                    pane.Controls.Add(new LiteralControl(" <div  class='col-lg-4'>"));
                    pane.Controls.Add(b12);
                  

                    pane.Controls.Add(new LiteralControl("	</div></div></div>"));
                  

		
					
					
				

                }
                cmd.Dispose();
                cn.Close();
             
            }
        }
    }
}
