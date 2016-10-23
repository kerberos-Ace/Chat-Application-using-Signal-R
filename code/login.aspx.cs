using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace SignalRDemo
{
    public partial class signup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
           MySqlConnection   cn = new MySqlConnection();
            cn.ConnectionString = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["cnstring"].ToString();
            cn.Open();
            string str = "select * from login where id='" + TextBox1.Text + "' and name='" + TextBox2.Text+ "'";
            MySqlCommand cmd = new MySqlCommand(str, cn);
            MySqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                Session["id"] = dr[0].ToString()+"-"+dr[1].ToString();
              
                    Response.Redirect("Level-3.aspx");
                }
          
            else
            {

               Label1.Text="Invalid credentials";


            }
            dr.Close();
            cmd.Dispose();
            cn.Close();
        }
     
    }
}