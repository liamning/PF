<%@ WebHandler Language="C#" Class="BatchHandler" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Collections.Generic;
using Newtonsoft.Json.Linq;

public class BatchHandler : IHttpHandler, IRequiresSessionState
{

    string userID = "";
    public void ProcessRequest(HttpContext context)
    {
        HttpRequest request = context.Request;
        HttpResponse response = context.Response;
        System.Web.SessionState.HttpSessionState session = context.Session;

        if (session[GlobalSetting.SessionKey.LoginID] != null)
            userID = session[GlobalSetting.SessionKey.LoginID].ToString();

        if (userID == "")
        {
            response.StatusCode = 403;
            response.End();
        }

        string result = "", action = "";
        Dictionary<string, string> resultDict = new Dictionary<string, string>();
        Newtonsoft.Json.Converters.IsoDateTimeConverter IsoDateTimeConverter = new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateTimeFormat };

        try
        {
            JArray serviceRequest = JArray.Parse(request.Form["params"]);
            foreach (JObject dataDict in serviceRequest)
            {
                action = dataDict["action"].ToString();
                switch (action)
                {
                    case "getSample":
                        string SampleNo = request["SampleNo"];
                        result = Newtonsoft.Json.JsonConvert.SerializeObject(new Sample().Get(SampleNo), IsoDateTimeConverter);
                        break;
                    case "saveSample":
                        string sampleString = dataDict["SampleInfo"].ToString();
                        var sampleInfo = Newtonsoft.Json.JsonConvert.DeserializeObject<SampleInfo>(sampleString, IsoDateTimeConverter);
                        sampleInfo.CreateUser = userID;
                        new Sample().Save(sampleInfo);
                        result = "{\"message\":\"Done.\"}";
                        break;

                    case "getTimeSlot":
                        string timeSlotCode = dataDict["TimeSlotCode"].ToString();
                        result = Newtonsoft.Json.JsonConvert.SerializeObject(new TimeSlot().Get(timeSlotCode), IsoDateTimeConverter);
                        break;
                    case "saveTimeSlot":
                        string timeSlotInfoString = dataDict["TimeSlotInfo"].ToString();
                        var timeSlotInfo = Newtonsoft.Json.JsonConvert.DeserializeObject<TimeSlotInfo>(timeSlotInfoString, IsoDateTimeConverter);
                        timeSlotInfo.CreateUser = userID;
                        new TimeSlot().Save(timeSlotInfo);
                        result = "{\"message\":\"Done.\"}";
                        break;
                    case "deleteTimeSlot":
                        timeSlotCode = dataDict["TimeSlotCode"].ToString();
                        new TimeSlot().Delete(timeSlotCode);
                        result = "{\"message\":\"Done.\"}";
                        break;

                    //Introducer 
                    case "getIntroducer":
                        string introducerCode = dataDict["IntroducerCode"].ToString();
                        result = Newtonsoft.Json.JsonConvert.SerializeObject(new Introducer().Get(introducerCode), IsoDateTimeConverter);
                        break;
                    case "saveIntroducer":
                        string introducerInfoString = dataDict["IntroducerInfo"].ToString();
                        var introducerInfo = Newtonsoft.Json.JsonConvert.DeserializeObject<IntroducerInfo>(introducerInfoString, IsoDateTimeConverter);
                        introducerInfo.CreateUser = userID;
                        new Introducer().Save(introducerInfo);
                        result = "{\"message\":\"Done.\"}";
                        break;
                    case "deleteIntroducer":
                        introducerCode = dataDict["IntroducerCode"].ToString();
                        new Introducer().Delete(introducerCode);
                        result = "{\"message\":\"Done.\"}";
                        break;


                    //Client 
                    case "getClient":
                        string clientCode = dataDict["ClientCode"].ToString();
                        result = Newtonsoft.Json.JsonConvert.SerializeObject(new Client().Get(clientCode), IsoDateTimeConverter);
                        break;
                    case "saveClient":
                        string clientInfoString = dataDict["ClientInfo"].ToString();
                        var clientInfo = Newtonsoft.Json.JsonConvert.DeserializeObject<ClientInfo>(clientInfoString, IsoDateTimeConverter);
                        clientInfo.CreateUser = userID;
                        new Client().Save(clientInfo);
                        result = "{\"message\":\"Done.\"}";
                        break;
                    case "deleteClient":
                        clientCode = dataDict["ClientCode"].ToString();
                        new Client().Delete(clientCode);
                        result = "{\"message\":\"Done.\"}";
                        break;


                    //Worker 
                    case "getWorker":
                        string WorkerID = dataDict["WorkerID"].ToString();
                        result = Newtonsoft.Json.JsonConvert.SerializeObject(new Worker().Get(WorkerID), IsoDateTimeConverter);
                        break;
                    case "saveWorker":
                        string WorkerInfoString = dataDict["WorkerInfo"].ToString();
                        var WorkerInfo = Newtonsoft.Json.JsonConvert.DeserializeObject<WorkerInfo>(WorkerInfoString, IsoDateTimeConverter);
                        WorkerInfo.CreateUser = userID;
                        new Worker().Save(WorkerInfo);
                        result = "{\"message\":\"Done.\"}";
                        break;
                    case "deleteWorker":
                        WorkerID = dataDict["WorkerID"].ToString();
                        new Worker().Delete(WorkerID);
                        result = "{\"message\":\"Done.\"}";
                        break;

                    //PayrollGroup 
                    case "getPayrollGroup":
                        string PayrollGroupID = dataDict["PayrollGroupID"].ToString();
                        result = Newtonsoft.Json.JsonConvert.SerializeObject(new PayrollGroup().Get(PayrollGroupID), IsoDateTimeConverter);
                        break;
                    case "savePayrollGroup":
                        string PayrollGroupInfoString = dataDict["PayrollGroupInfo"].ToString();
                        var PayrollGroupInfo = Newtonsoft.Json.JsonConvert.DeserializeObject<PayrollGroupInfo>(PayrollGroupInfoString, IsoDateTimeConverter);
                        PayrollGroupInfo.CreateUser = userID;
                        new PayrollGroup().Save(PayrollGroupInfo);
                        result = "{\"message\":\"Done.\"}";
                        break;
                    case "deletePayrollGroup":
                        PayrollGroupID = dataDict["PayrollGroupID"].ToString();
                        new PayrollGroup().Delete(PayrollGroupID);
                        result = "{\"message\":\"Done.\"}";
                        break;


                    //UserProfile 
                    case "getUserProfile":
                        string UserID = dataDict["UserID"].ToString();
                        result = Newtonsoft.Json.JsonConvert.SerializeObject(new UserProfile().Get(UserID), IsoDateTimeConverter);
                        break;
                    case "saveUserProfile":
                        string UserProfileInfoString = dataDict["UserProfileInfo"].ToString();
                        var UserProfileInfo = Newtonsoft.Json.JsonConvert.DeserializeObject<UserProfileInfo>(UserProfileInfoString, IsoDateTimeConverter);
                        UserProfileInfo.CreateUser = userID;
                        new UserProfile().Save(UserProfileInfo);
                        result = "{\"message\":\"Done.\"}";
                        break;
                    case "deleteUserProfile":
                        UserID = dataDict["UserID"].ToString();
                        new UserProfile().Delete(UserID);
                        result = "{\"message\":\"Done.\"}";
                        break;

                    case "changePassword":
                        string currentPassword = dataDict["CurrentPassword"].ToString();
                        string newPassword = dataDict["NewPassword"].ToString();
                        bool status = new UserProfile().UpdatePassword(userID, currentPassword, newPassword);
                        if (status)
                            result = "{\"message\":\"Done.\"}";
                        else
                        {
                            result = "{\"message\":\"Failure to update the password, please input the correct password.\"}";
                        }
                        break;


                    case "inquiry":
                            
                        JArray filters = JArray.Parse(dataDict["Filters"].ToString());
                        string view = dataDict["View"].ToString();

                        result = new Inquiry().View_Search(filters, view);
                        break;

                    default:
                        break;

                }
                resultDict.Add(action, result);
            }

        }
        catch (Exception e)
        {
            resultDict.Add("error", e.Message.Replace("\r\n", ""));
            Log.Error(e.Message);
            Log.Error(e.StackTrace);
        }

        response.Clear();
        response.ContentType = "application/json;charset=UTF-8;";
        response.Write(Newtonsoft.Json.JsonConvert.SerializeObject(resultDict));
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
