<%@ WebHandler Language="C#" Class="LoginHandler" %>

using System;
using System.Web;
using System.Web.SessionState;

public class LoginHandler : IHttpHandler, IRequiresSessionState
{

    string userID = "";
    public void ProcessRequest(HttpContext context)
    { 

        HttpRequest request = context.Request;
        HttpResponse response = context.Response;
        HttpSessionState session = context.Session;

        if (session[GlobalSetting.SessionKey.LoginID] != null)
            userID = session[GlobalSetting.SessionKey.LoginID].ToString();
        
        string result = "";

        try
        {

            string action = request.Form["action"].ToString();
             
            switch (action)
            {
                //case "login":
                //    userID = request["StaffNo"];
                //    password = request["Password"];
                //    bool success = new StaffProfile().Login(userID, password);
                //    if (success)
                //    {
                //        result = "{\"result\":\"1\"}";
                //    }
                //    else
                //    {
                //        result = "{\"result\":\"0\"}";
                //    }
                //    break;

                //case "logout":
                //    session.Clear();
                //    break;

                //case "getLoginID":
                //    result = "{\"loginID\":\"" + userID + "\"}";
                //    break;

                //case "getLocationName":
                //    string tmpString = request["staffid"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new PRManagement().GetLocationName(tmpString));
                //    break;
                    
                default:
                    break;
                     
            }
        }
        catch (Exception e)
        {
            result = "{\"message\":\"" + e.Message.Replace("\r\n", "") + "\"}";
            //Log.Error(e.StackTrace);
        }

        response.Clear();
        response.ContentType = "application/json;charset=UTF-8;";
        response.Write(result);
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

