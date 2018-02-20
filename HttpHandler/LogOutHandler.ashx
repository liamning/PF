<%@ WebHandler Language="C#" Class="LogoutHandler" %>

using System;
using System.Web;
using System.Web.SessionState;

public class LogoutHandler : IHttpHandler, IRequiresSessionState
{
     
    public void ProcessRequest(HttpContext context)
    { 

        HttpRequest request = context.Request;
        HttpResponse response = context.Response;
        HttpSessionState session = context.Session;

        session.Clear(); 
        
        response.Clear();
        response.Redirect("~/");
        response.End();
        
    }
     
    public bool IsReusable
    {
        get
        {
            return false;
        }
    }


}

