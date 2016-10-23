using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;


    public class retu_name
    {


        public string name_(string  id)
        {
            string name = "";

            MySqlConnection cn = new MySqlConnection();
                cn.ConnectionString = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["cnstring"].ToString();

                String s = "select name from login where id = '"+id+"'  ";


                cn.Open();
               
               MySqlCommand cmd = new MySqlCommand(s, cn);
                MySqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    name = dr[0].ToString();
                }
                cmd.Dispose();
                cn.Close();



            return name;
        
        
        }
      




    
}