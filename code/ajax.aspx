<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ajax.aspx.cs" Inherits="SignalRDemo.ajax" %>

<%@ Import Namespace="MySql.Data.MySqlClient" %>
<%@ Import Namespace="System.Net.Mail" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Web.Security" %>

<%
    string check_status = Request.QueryString["status"].ToString();
   
     MySqlConnection cn;
 
   
            if (check_status.Equals("1")) //  Chatbox
    {



        cn = new MySqlConnection();
         cn.ConnectionString = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["cnstring"].ToString();
                cn.Open();
                String s = "select * from chat where (sid='" + Request.QueryString["sid"].ToString() + "' and cid='" + Request.QueryString["rid"].ToString() + "') or (sid='" + Request.QueryString["rid"].ToString() + "' and cid='" + Request.QueryString["sid"].ToString() + "')  order by id   ";
                MySqlCommand cmd = new MySqlCommand(s, cn);
                MySqlDataReader dr = cmd.ExecuteReader();
                string ret = "";
                string name1="";
                retu_name name = new retu_name();
                while (dr.Read())
                {



                    name1 = name.name_(dr[1].ToString());

                    if (Request.QueryString["newid"].ToString() == name1)
                    {

                        ret = ret + "<div style='border-radius:5px' class='cond alert alert-dismissible alert-warning'>" + name1 + ": " + dr[3].ToString() + "</div>";
                    }
                    else
                    {
                        ret = ret + "<div style='border-radius:5px' class='cond alert alert-dismissible alert-success'>" + name1 + ": " + dr[3].ToString() + "</div>";
                        
                    }
                        
                    
                }
                cmd.Dispose();
                cn.Close();

                Response.Write(ret);
            
            
            }
    
      
   
  
            
                  
%>