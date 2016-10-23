using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR;
using System.Collections;
using System.Threading.Tasks;
using MySql.Data.MySqlClient;

namespace SignalRDemo
{
    public class ChatHub : Hub
    {
        void dataentr(string sid, string rid, string message)
        {


            MySqlConnection cn = new MySqlConnection();
            cn.ConnectionString = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["cnstring"].ToString();

            try
            {
                cn.Open();
                string str = "insert into chat (sid,cid,msg) values(?sid,?cid,?msg)";
                MySqlCommand cmd = new MySqlCommand(str, cn);

                cmd.Parameters.AddWithValue("?sid", sid);
                cmd.Parameters.AddWithValue("?cid", rid);
                cmd.Parameters.AddWithValue("?msg", message);
                
                cmd.ExecuteNonQuery();

                cmd.Dispose();
                cn.Close();

              
                   //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record Inserted Successfully')", true);
            }
            catch
            { }

        }



        static Hashtable h = new Hashtable();
        public override Task OnConnected()
        {  // name=auto generated chat id
            //id=database unique id
            var split = Context.QueryString["id"].Split('}');
            string name = Context.ConnectionId;
         
            string id = split.First();
            Clients.All.addNewMessageToPage(name, id, 1);

            if (h.Count != 0)
            {
                foreach (string key in h.Keys)
                {

                    Clients.Client(Context.ConnectionId).addNewMessageToPage((string)h[key], key, 1);

                }
            }
            try
            {

                h.Add(id, name);
            }
            catch { }
            return base.OnConnected();
        }

        public void Send(string key1, string message, string name, string sid)
        {

            dataentr(sid, key1, message);
            Clients.Client((string)h[key1]).addNewMessageToPage(sid+"}"+name, message, 3);
        
        

        }
        public override Task OnDisconnected()
        {
            var split = Context.QueryString["id"].Split('}');

            h.Remove(split.First());
            Clients.All.addNewMessageToPage("", split.First(), 2);


            return base.OnDisconnected();
        }
    }
}