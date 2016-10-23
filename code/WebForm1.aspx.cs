using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;

namespace SignalRDemo
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        static string anshu;
        protected void Page_Load(object sender, EventArgs e)
        {
            anshu = "anshu@gmail.com/vino@gmail.com/kunal@gmail.com/randeep@gmail.com";

        }

        protected void Button1_Click(object sender, EventArgs e)
        {

            Label1.Text = Application["anshul"].ToString();
        }


    }
}