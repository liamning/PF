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
        string userID = "";

        if (session[GlobalSetting.SessionKey.LoginID] != null)
            userID = session[GlobalSetting.SessionKey.LoginID].ToString();

        response.Clear();
        response.ContentType = "application/json;charset=UTF-8;";
        response.Write(@"
                                    window.LoginInfo = {
                                        UserID: '" + userID + @"'
                                    }; 
//alert(window.LoginInfo.UserID);
");
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

