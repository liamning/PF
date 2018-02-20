<%@ WebHandler Language="C#" Class="AjaxHandler" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Collections.Generic;

public class AjaxHandler : IHttpHandler, IRequiresSessionState
{

    string userID = "";
    public void ProcessRequest(HttpContext context)
    {
        HttpRequest request = context.Request;
        HttpResponse response = context.Response;
        System.Web.SessionState.HttpSessionState session = context.Session;


        if (session[GlobalSetting.SessionKey.LoginID] != null)
            userID = session[GlobalSetting.SessionKey.LoginID].ToString();


        string result = "";
        Newtonsoft.Json.Converters.IsoDateTimeConverter IsoDateTimeConverter = new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateTimeFormat };

        try
        {
            string action = request.Form["action"].ToString();

            switch (action)
            {
                case "saveSample":
                    string sampleString = request["SampleInfo"];
                    var sampleInfo = Newtonsoft.Json.JsonConvert.DeserializeObject<SampleInfo>(sampleString, IsoDateTimeConverter);
                    sampleInfo.CreateUser = userID;
                    new Sample().Save(sampleInfo);
                    result = "{\"message\":\"Done.\"}";
                    break;
                case "getSample":
                    string SampleNo = request["SampleNo"];
                    result = Newtonsoft.Json.JsonConvert.SerializeObject(new Sample().Get(SampleNo), IsoDateTimeConverter);
                    break;
                //case "getClientIDList":
                //    ClientNo = request["ClientNo"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new Sample().GetClientNoList(ClientNo));
                //    break;
                //case "deleteSample":
                //    ClientNo = request["ClientNo"];
                //    List<string> clientNoList = new List<string>();
                //    clientNoList.Add(ClientNo);
                //    new Sample().Delete(clientNoList);
                //    result = "{\"message\":\"Done.\"}";
                //    break;
                //case "getStaffNoList":
                //    staffNo = request["StaffNo"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new StaffProfile().GetStaffNoList(staffNo));
                //    break;
                //case "getStaff":
                //    staffNo = request["staffNo"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new StaffProfile().Get(staffNo), new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });
                //    break;
                //case "saveStaff":
                //    tmpObjString = request["StaffInfo"];
                //    var tmpStaffProfile = Newtonsoft.Json.JsonConvert.DeserializeObject<StaffProfileInfo>(tmpObjString, new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });
                //    tmpStaffProfile.CreateUser = userID;
                //    new StaffProfile().Save(tmpStaffProfile);
                //    result = "{\"message\":\"Done.\"}";
                //    break;
                //case "deleteStaff":
                //    staffNo = request["staffNo"];
                //    new StaffProfile().Delete(staffNo);

                //    result = "{\"message\":\"Done.\"}";
                //    break;
                //case "resetPassword":
                //    password = request["Password"];
                //    newPassword = request["NewPassword"];
                //    success = new StaffProfile().ResetPassword(userID, password, newPassword);
                //    if (success)
                //        result = "{\"message\":\"Done.\", \"result\":\"1\"}";
                //    else
                //        result = "{\"message\":\"Failed to reset the password\", \"result\":\"0\"}";
                //    break;
                //case "saveUserHeader":
                //    string UserHeaderString = request["UserHeaderInfo"];
                //    var UserHeaderInfo = Newtonsoft.Json.JsonConvert.DeserializeObject<UserHeaderInfo>(UserHeaderString, new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateTimeFormat });
                //    UserHeaderInfo.CreateUser = userID;
                //    UserHeaderInfo.LastUpdateUser = userID;
                //    UserHeaderInfo.CreateDate = DateTime.Now;
                //    UserHeaderInfo.LastUpdateDate = DateTime.Now;
                //    new UserSecurityMaster().SaveUserHeader(UserHeaderInfo);
                //    result = "{\"message\":\"Done.\"}";
                //    break;
                //case "getUserHeader":
                //    UserCode = request["UserCode"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new UserSecurityMaster().GetUserHeader(UserCode), new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateTimeFormat });
                //    break;
                ////case "refreshUserList":
                ////    UserCode = request["UserCode"];
                ////    result = Newtonsoft.Json.JsonConvert.SerializeObject(new UserSecurityMaster().RefreshUserList(UserCode));
                ////    break;
                //case "refreshRoleList":
                //    RoleCode = request["RoleCode"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new UserSecurityMaster().RefreshRoleList(RoleCode));
                //    break;
                //case "deleteUserHeader":
                //    UserCode = request["UserCode"];
                //    List<string> UserCodeList = new List<string>();
                //    UserCodeList.Add(UserCode);
                //    new UserSecurityMaster().Delete(UserCodeList);
                //    result = "{\"message\":\"Done.\"}";
                //    break;
                //case "getFunctionList":
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new RoleFunction().GetFunctionAndRight());
                //    break;
                //case "saveRole":
                //    string RoleString = request["RoleInfo"];
                //    var RoleInfo = Newtonsoft.Json.JsonConvert.DeserializeObject<RoleHeaderInfo>(RoleString, new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateTimeFormat });
                //    RoleInfo.CreateUser = userID;
                //    RoleInfo.LastUpdateUser = userID;
                //    RoleInfo.CreateDate = DateTime.Now;
                //    RoleInfo.LastUpdateDate = DateTime.Now;
                //    new RoleFunction().SaveRoleHeader(RoleInfo);
                //    result = "{\"message\":\"Done.\"}";
                //    break;
                //case "getRole":
                //    RoleCode = request["RoleCode"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new RoleFunction().GetRoleHeader(RoleCode), new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateTimeFormat });
                //    break;
                //case "getRoleList":
                //    RoleCode = request["RoleCode"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new RoleFunction().GetRoleCodeList(RoleCode));
                //    break;
                //case "deleteRole":
                //    RoleCode = request["RoleCode"];
                //    List<string> RoleCodeList = new List<string>();
                //    RoleCodeList.Add(RoleCode);
                //    new RoleFunction().Delete(RoleCodeList);
                //    result = "{\"message\":\"Done.\"}";
                //    break;
                //case "savePolicy":
                //    string PolicyString = request["PolicyInfo"];
                //    var PolicyInfo = Newtonsoft.Json.JsonConvert.DeserializeObject<PolicyInfo>(PolicyString, new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateTimeFormat });
                //    PolicyInfo.CreateUser = userID;
                //    PolicyInfo.LastUpdateUser = userID;
                //    PolicyInfo.CreateDate = DateTime.Now;
                //    PolicyInfo.LastUpdateDate = DateTime.Now;
                //    new PolicyMaster().SavePolicy(PolicyInfo);
                //    result = "{\"message\":\"Done.\"}";
                //    break;
                //case "getPolicy":
                //    Policy = request["Policy"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new PolicyMaster().GetPolicy(Policy), new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateTimeFormat });
                //    break;
                //case "getPolicyList":
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new PolicyMaster().GetPolicyList());
                //    break;
                //case "deleteAutoGenSetup":
                //    AutoGenNoSetupId = request["AutoGenNoSetupId"];
                //    List<string> AutoGenNoSetupIdList = new List<string>();
                //    AutoGenNoSetupIdList.Add(AutoGenNoSetupId);
                //    new AutoGenNo().Delete(AutoGenNoSetupIdList);
                //    result = "{\"message\":\"Done.\"}";
                //    break;
                //case "saveAutoGen":
                //    string AutoGenString = request["AutoGenSetupInfo"];
                //    var AutoGenSetupInfo = Newtonsoft.Json.JsonConvert.DeserializeObject<AutoGenSetupInfo>(AutoGenString, new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateTimeFormat });
                //    AutoGenSetupInfo.CreateUser = userID;
                //    AutoGenSetupInfo.LastUpdateUser = userID;
                //    AutoGenSetupInfo.CreateDate = DateTime.Now;
                //    AutoGenSetupInfo.LastUpdateDate = DateTime.Now;
                //    new AutoGenNo().SaveAutoGen(AutoGenSetupInfo);
                //    result = "{\"message\":\"Done.\"}";
                //    break;
                //case "getAutoGen":
                //    AutoGenNoSetupId = request["AutoGenNoSetupId"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new AutoGenNo().GetAutoGen(AutoGenNoSetupId), new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateTimeFormat });
                //    break;
                //case "getAutoGenList":
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new AutoGenNo().GetAutoGenSetupList());
                //    break;
                //case "refreshModuleList":
                //    string Module = request["Module"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new AutoGenNo().RefreshModuleList(Module));
                //    break;
                //case "showLastRunningNumber":
                //    ModuleCode = request["ModuleCode"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new AutoGenNo().ShowLastRunningNumber(ModuleCode), new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateTimeFormat });
                //    break;
                //case "getPOList":
                //    string filterString = request["POFilterInfo"];
                //    var filterInfo = Newtonsoft.Json.JsonConvert.DeserializeObject<POFilterInfo>(filterString, new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new POManagement().GetPOList(filterInfo), new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });
                //    break;
                //case "refreshPOList":
                //    PONo = request["PONo"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new POManagement().RefreshPOList(PONo));
                //    break;
                //case "refreshLocationList":
                //    string Location = request["Location"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new POManagement().RefreshLocationList(Location));
                //    break;
                //case "refreshRemarkList":
                //    string Remark = request["Remark"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new POManagement().RefreshRemarkList(Remark));
                //    break;
                //case "refreshTransactionList":
                //    string Transaction = request["Transaction"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new POManagement().RefreshTransactionList(Transaction));
                //    break;
                //case "refreshPriceTermList":
                //    string PriceTerm = request["PriceTerm"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new POManagement().RefreshPriceTermList(PriceTerm));
                //    break;
                //case "refreshPaymentList":
                //    string Payment = request["Payment"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new POManagement().RefreshPaymentList(Payment));
                //    break;
                //case "refreshInchargeList":
                //    string Incharge = request["Incharge"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new POManagement().RefreshInchargeList(Incharge));
                //    break;
                //case "refreshSupplierList":
                //    Supplier = request["Supplier"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new POManagement().RefreshSupplierList(Supplier));
                //    break;
                //case "refreshDeliveryAddressList":
                //    DeliveryAddress = request["DeliveryAddress"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new POManagement().RefreshDeliveryAddressList(DeliveryAddress));
                //    break;
                //case "refreshProductList":
                //    ProductCode = request["Product"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new POManagement().RefreshProductList(ProductCode));
                //    break;
                //case "refreshChargeList":
                //    ProductCode = request["Product"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new POManagement().RefreshChargeList(ProductCode));
                //    break;
                //case "refreshUnitList":
                //    string Unit = request["Unit"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new POManagement().RefreshUnitList(Unit));
                //    break;
                //case "getUnitRate":
                //    string[] UnitArray = Newtonsoft.Json.JsonConvert.DeserializeObject<string[]>(request["UnitArray"]);
                //    ProductCode = request["ProductCode"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new POManagement().GetUnitRate(ProductCode, UnitArray));
                //    break;
                //case "getBaseUnitRate":
                //    tmpString = request["UnitCode"];
                //    tmpString2 = request["ConUnitCode"];
                //    tmpString3 = request["ProductCode"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new POManagement().GetBaseUnitRate(tmpString, tmpString2, tmpString3));
                //    break;
                //case "getBaseUnitRate2":
                //    tmpObjString = request["TemplateDetailObj"];
                //    var PRTemplateDetail = Newtonsoft.Json.JsonConvert.DeserializeObject<PRTemplateDetailInfo>(tmpObjString);
                //    string UnitCode = PRTemplateDetail.BaseUnit;
                //    string ConUnitCode = PRTemplateDetail.QtyUnit;
                //    ProductCode = PRTemplateDetail.ProductCode;
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new POManagement().GetBaseUnitRate(UnitCode, ConUnitCode, ProductCode));
                //    break;
                //case "getSupplier":
                //    Supplier = request["Supplier"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new POManagement().GetSupplier(Supplier));
                //    break;
                //case "getDeliveryAddress":
                //    DeliveryAddress = request["DeliveryAddress"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new POManagement().GetDeliveryAddress(DeliveryAddress));
                //    break;
                //case "getCustomerLocation":
                //    tmpString = request["CustomerCode"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new POManagement().GetCustomerLocation(tmpString));
                //    break;
                //case "getPOHeader":
                //    PONo = request["PONo"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new POManagement().GetPOHeader(PONo), new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateTimeFormat });
                //    break;
                //case "getProductBaseUnit":
                //    ProductCode = request["ProductCode"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new POManagement().GetProductBaseUnit(ProductCode));
                //    break;
                //case "getChargeUnit":
                //    ProductCode = request["ProductCode"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new POManagement().GetChargeUnit(ProductCode));
                //    break;
                //case "getPODetailList":
                //    PONo = request["PONo"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new POManagement().GetPODetailList(PONo), new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });
                //    break;
                //case "savePODetail":
                //    string PODetailListString = request["PODetailList"];
                //    var PODetailList = Newtonsoft.Json.JsonConvert.DeserializeObject<List<PODetailInfo>>(PODetailListString, new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });
                //    POHeader = request["POHeaderInfo"];
                //    var POHeaderObj1 = Newtonsoft.Json.JsonConvert.DeserializeObject<POHeaderInfo>(POHeader, new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateTimeFormat });
                //    new POManagement().SavePODetail(PODetailList, POHeaderObj1, userID);
                //    result = "{\"message\":\"Done.\"}";
                //    break;
                //case "savePOHeader":
                //    POHeader = request["POHeaderInfo"];
                //    POHeaderObj1 = Newtonsoft.Json.JsonConvert.DeserializeObject<POHeaderInfo>(POHeader, new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateTimeFormat });
                //    POHeaderObj1.CreateUser = userID;
                //    POHeaderObj1.LastUpdateUser = userID;
                //    POHeaderObj1.CreateDate = DateTime.Now;
                //    POHeaderObj1.LastUpdateDate = DateTime.Now;
                //    POHeaderObj1.ApproveUser = userID;
                //    POHeaderObj1.ApproveDate = DateTime.Now;
                //    POHeaderObj1.CancelUser = userID;
                //    POHeaderObj1.CancelDate = DateTime.Now;
                //    new POManagement().SavePO(POHeaderObj1);
                //    result = "{\"message\":\"Done.\"}";
                //    break;
                //case "deletePO":
                //    PONo = request["PONo"];
                //    new POManagement().DeletePO(PONo);
                //    result = "{\"message\":\"Done.\"}";
                //    break;
                //case "cancelPO":
                //    PONo = request["PONo"];
                //    new POManagement().UpdatePOStatus(PONo, "X");
                //    result = "{\"message\":\"Done.\"}";
                //    break;
                //case "resetPO":
                //    PONo = request["PONo"];
                //    new POManagement().UpdatePOStatus(PONo, "A");
                //    result = "{\"message\":\"Done.\"}";
                //    break;
                //case "getPODetailDeliveryList":
                //    PONo = request["PONo"];
                //    DetId = int.Parse(request["DetId"]);
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new POManagement().GetPODetailDeliveryList(PONo, DetId), new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });
                //    break;
                //case "savePOAddress":
                //    POHeader = request["POHeaderInfo"];
                //    var POHeaderObj2 = Newtonsoft.Json.JsonConvert.DeserializeObject<POHeaderInfo>(POHeader, new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateTimeFormat });
                //    POHeaderObj2.CreateUser = userID;
                //    POHeaderObj2.LastUpdateUser = userID;
                //    POHeaderObj2.CreateDate = DateTime.Now;
                //    POHeaderObj2.LastUpdateDate = DateTime.Now;
                //    POHeaderObj2.ApproveUser = userID;
                //    POHeaderObj2.ApproveDate = DateTime.Now;
                //    POHeaderObj2.CancelUser = userID;
                //    POHeaderObj2.CancelDate = DateTime.Now;
                //    new POManagement().SavePOAddress(POHeaderObj2);
                //    result = "{\"message\":\"Done.\"}";
                //    break;

                //case "savePORemark":
                //    POHeader = request["POHeaderInfo"];
                //    var POHeaderObj3 = Newtonsoft.Json.JsonConvert.DeserializeObject<POHeaderInfo>(POHeader, new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateTimeFormat });
                //    POHeaderObj3.CreateUser = userID;
                //    POHeaderObj3.LastUpdateUser = userID;
                //    POHeaderObj3.CreateDate = DateTime.Now;
                //    POHeaderObj3.LastUpdateDate = DateTime.Now;
                //    POHeaderObj3.ApproveUser = userID;
                //    POHeaderObj3.ApproveDate = DateTime.Now;
                //    POHeaderObj3.CancelUser = userID;
                //    POHeaderObj3.CancelDate = DateTime.Now;
                //    new POManagement().SavePOHeader(POHeaderObj3);
                //    result = "{\"message\":\"Done.\"}";
                //    break;
                //case "approvePOList":
                //    string POApproveList = request["POApproveList"];
                //    List<POHeaderInfo> ApproveList = Newtonsoft.Json.JsonConvert.DeserializeObject<List<POHeaderInfo>>(POApproveList);
                //    foreach (POHeaderInfo info in ApproveList)
                //    {
                //        info.POStatus = "A";
                //        info.ApproveUser = userID;
                //        info.ApproveDate = DateTime.Now;
                //    }
                //    new POManagement().ApprovePO(ApproveList);
                //    result = "{\"message\":\"Done.\"}";
                //    break;
                //case "getPRList":
                //    tmpString = request["PRFilterInfo"];
                //    var PRFilterInfo = Newtonsoft.Json.JsonConvert.DeserializeObject<PRFilterInfo>(tmpString, new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new PRManagement().GetPRList(PRFilterInfo), new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });
                //    break;
                //case "genPO":
                //    tmpString = request["genPOList"];
                //    var genPOList = Newtonsoft.Json.JsonConvert.DeserializeObject<List<PRShowClassInfo>>(tmpString, new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new PRManagement().Classify(genPOList, userID), new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });
                //    break;
                //case "refreshProductList2":
                //    ProductCode = request["Product"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new PRManagement().RefreshProductList2(ProductCode));
                //    break;
                //case "savePRTemplate":
                //    tmpString = request["TemplateObj"];
                //    var TemplateObj = Newtonsoft.Json.JsonConvert.DeserializeObject<PRTemplateHeaderInfo>(tmpString, new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateTimeFormat });
                //    new PRManagement().SavePRTemplate(TemplateObj, userID);
                //    result = "{\"message\":\"Done.\"}";
                //    break;
                //case "deletePRTemplate":
                //    tmpString = request["TemplateObj"];
                //    TemplateObj = Newtonsoft.Json.JsonConvert.DeserializeObject<PRTemplateHeaderInfo>(tmpString, new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateTimeFormat });
                //    new PRManagement().DeletePRTemplate(TemplateObj);
                //    result = "{\"message\":\"Done.\"}";
                //    break;
                //case "getPRTemplate":
                //    tmpString = request["TemplateObj"];
                //    TemplateObj = Newtonsoft.Json.JsonConvert.DeserializeObject<PRTemplateHeaderInfo>(tmpString, new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateTimeFormat });
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new PRManagement().GetPRTemplate(TemplateObj), new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateTimeFormat });
                //    break;
                //case "getLocationName":
                //    tmpString = request["staffid"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new PRManagement().GetLocationName(tmpString));
                //    break;
                //case "getSupplierList":
                //    tmpString = request["location"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new PRManagement().GetSupplierList(tmpString));
                //    break;
                //case "getWorkshopList":
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new PRManagement().GetWorkshopList());
                //    break;
                //case "checkPR":
                //    tmpString = request["date"];
                //    tmpString2 = request["supplier"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new PRManagement().CheckPR(tmpString, tmpString2), new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });
                //    break;
                //case "checkPR2":
                //    tmpString = request["date"];
                //    tmpString2 = request["workshop"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new PRManagement().CheckPR2(tmpString, tmpString2), new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });
                //    break;
                //case "getTemplateProductList":
                //    tmpString = request["TemplateType"];
                //    tmpString2 = request["SupplierCode"];
                //    tmpString3 = request["WorkshopType"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new PRManagement().GetTemplateProductList(tmpString, tmpString2, tmpString3));
                //    break;
                //case "getSubstituteList":
                //    tmpString = request["PRNo"];
                //    DetId =int.Parse(request["AppDetId"]);
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new PRManagement().GetSubstituteList(tmpString, DetId));
                //    break;
                //case "savePRApp":
                //    tmpString = request["PRAppObj"];
                //    var PRObj = Newtonsoft.Json.JsonConvert.DeserializeObject<PRAppHeaderInfo>(tmpString, new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new PRManagement().SavePRApp(PRObj, userID));
                //    break;
                //case "saveAndGenPRApp":
                //    tmpString = request["PRAppObj"];
                //    PRObj = Newtonsoft.Json.JsonConvert.DeserializeObject<PRAppHeaderInfo>(tmpString, new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });
                //    //PRNo= new PRManagement().SavePRApp(PRObj, userID);
                //    //new PRManagement().GenPRConfirm(new PRManagement().SavePRApp(PRObj, userID), userID);
                //    new PRManagement().GenPRConfirm(PRObj, userID);
                //    result = "{\"message\":\"Done.\"}";
                //    break;
                //case "amendPRApp":
                //    PRNo = request["PRNo"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new PRManagement().AmendPRApp(PRNo));
                //    break;
                //case "deletePRApp":
                //    PRNo = request["PRNo"];
                //    new PRManagement().DeletePRApp(PRNo);
                //    result = "{\"message\":\"Done.\"}";
                //    break;
                //case "getPRAppSupplierList":
                //    tmpString = request["FilterObj"];
                //    var FilterObj = Newtonsoft.Json.JsonConvert.DeserializeObject<PRFilterInfo>(tmpString, new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new PRManagement().GetPRAppSupplierList(FilterObj), new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });
                //    break;
                //case "getPRAppWorkshopList":
                //    tmpString = request["FilterObj"];
                //    FilterObj = Newtonsoft.Json.JsonConvert.DeserializeObject<PRFilterInfo>(tmpString, new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new PRManagement().GetPRAppWorkshopList(FilterObj), new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });
                //    break;
                //case "getConfirmPRList":
                //    tmpString = request["PRFilterInfo"];
                //    PRFilterInfo = Newtonsoft.Json.JsonConvert.DeserializeObject<PRFilterInfo>(tmpString, new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new PRManagement().GetConfirmPRList(PRFilterInfo), new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });
                //    break;
                //case "getConfirmPRHeader":
                //    PRNo = request["PRNo"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new PRManagement().GetConfirmPRHeader(PRNo), new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateTimeFormat });
                //    break;
                //case "getConfirmPRDetail":
                //    PRNo = request["PRNo"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new PRManagement().GetConfirmPRDetail(PRNo));
                //    break;
                //case "searchSupplierList":
                //    tmpString = request["ProductCode"];
                //    tmpString2 = request["Location"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new PRManagement().SearchSupplierList(tmpString, tmpString2));
                //    break;
                //case "searchUnitPriceList":
                //    tmpString = request["ProductCode"];
                //    tmpString2 = request["SupplierCode"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new PRManagement().SearchUnitPriceList(tmpString, tmpString2), new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });
                //    break;
                //case "refreshProductList3":
                //    ProductCode = request["Product"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new PRManagement().RefreshProductList3(ProductCode));
                //    break;
                //case "saveConfirmSubstitution":
                //    tmpString = request["PRConfirm"];
                //    var tmpObj = Newtonsoft.Json.JsonConvert.DeserializeObject<PRConfirmHeader>(tmpString, new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateTimeFormat });
                //    new PRManagement().SaveConfirmSubstitution(tmpObj, userID);
                //    result = "{\"message\":\"Done.\"}";
                //    break;
                //case "refreshCurrencyList":
                //    tmpString = request["Currency"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new PRManagement().RefreshCurrencyList(tmpString));
                //    break;
                //case "getExchangeRate":
                //    tmpString = request["CcyCode"];
                //    tmpString2 = request["PRDate"];
                //    var PRDate = DateTime.ParseExact(tmpString2, GlobalSetting.DateFormat, null);
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new PRManagement().GetExchangeRate(tmpString, PRDate));
                //    break;
                //case "savePRConfirm":
                //    tmpString = request["PRConfirm"];
                //    tmpObj = Newtonsoft.Json.JsonConvert.DeserializeObject<PRConfirmHeader>(tmpString, new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateTimeFormat });
                //    new PRManagement().SaveConfirmSubstitution(tmpObj, userID);
                //    result = "{\"message\":\"Done.\"}";
                //    break;
                //case "approvePRConfirm":
                //    tmpString = request["PRConfirm"];
                //    tmpObj = Newtonsoft.Json.JsonConvert.DeserializeObject<PRConfirmHeader>(tmpString, new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateTimeFormat });
                //    new PRManagement().SaveConfirmSubstitution(tmpObj, userID);
                //    new PRManagement().ApprovePRConfirm(tmpObj, userID);
                //    result = "{\"message\":\"Done.\"}";
                //    break;
                //case "refreshCustomerList":
                //    tmpString = request["input"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new PRManagement().RefreshCustomerList(tmpString));
                //    break;
                //case "saveShopSupplierList":
                //    tmpString = request["ShopSuppllierList"];
                //    var ShopSuppllierList = Newtonsoft.Json.JsonConvert.DeserializeObject<List<ShopSupplierInfo>>(tmpString, new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateTimeFormat });
                //    new PRManagement().SaveShopSupplierList(ShopSuppllierList, userID);
                //    result = "{\"message\":\"Done.\"}";
                //    break;
                //case "getShopSupplierInfo":
                //    tmpString = request["ShopCode"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new PRManagement().GetShopSupplierInfo(tmpString), new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateTimeFormat });
                //    break;
                //case "getPolicyValue":
                //    tmpString = request["Policy"];
                //    result = new PRManagement().GetPolicyValue(tmpString);
                //    break;
                //case "getSupplierCcyCode":
                //    tmpString = request["SupplierCode"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new PRManagement().GetSupplierCcyCode(tmpString));
                //    break;
 
                ////Added By Ning
                //case "constructDNDetails":
                //    //DNHeaderInfo DNHeaderInfo = Newtonsoft.Json.JsonConvert.DeserializeObject<DNHeaderInfo>(request["info"], new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });
                //    List<string> PRNoList = Newtonsoft.Json.JsonConvert.DeserializeObject<List<string>>(request["PRNoList"]);
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new DNHeader().ConstructDNDetails(PRNoList), new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });
                //    break;

                //case "constructGRNDetails":
                //    List<string> PONoList = Newtonsoft.Json.JsonConvert.DeserializeObject<List<string>>(request["PONoList"]);
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new GRNHeader().ConstructGRNDetails(PONoList), new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });

                //    break;
                //case "saveGRN":
                //    GRNHeaderInfo GRNHeaderInfo = Newtonsoft.Json.JsonConvert.DeserializeObject<GRNHeaderInfo>(request["info"], new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });
                //    GRNHeaderInfo.CreateUser = userID;
                //    GRNHeaderInfo.CreateDate = DateTime.Now;
                //    GRNHeaderInfo.LastUpdateUser = userID;
                //    GRNHeaderInfo.LastUpdateDate = DateTime.Now;

                //    new GRNHeader().Save(GRNHeaderInfo);
                //    result = "{\"message\":\"Done.\"}";

                //    break;
                //case "postGRN":
                //    GRNHeaderInfo = Newtonsoft.Json.JsonConvert.DeserializeObject<GRNHeaderInfo>(request["info"], new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });
                //    GRNHeaderInfo.CreateUser = userID;
                //    GRNHeaderInfo.CreateDate = DateTime.Now;
                //    GRNHeaderInfo.LastUpdateUser = userID;
                //    GRNHeaderInfo.LastUpdateDate = DateTime.Now;
                //    GRNHeaderInfo.PostDate = DateTime.Now;
                //    GRNHeaderInfo.PostFlag = "Y";
                //    GRNHeaderInfo.PostUser = userID;

                //    new GRNHeader().Save(GRNHeaderInfo);
                //    result = "{\"message\":\"Done.\"}";

                //    break;
                //case "saveDN":
                //    DNHeaderInfo DNHeaderInfo = Newtonsoft.Json.JsonConvert.DeserializeObject<DNHeaderInfo>(request["info"], new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });
                //    DNHeaderInfo.CreateUser = userID;
                //    DNHeaderInfo.CreateDate = DateTime.Now;
                //    DNHeaderInfo.LastUpdateUser = userID;
                //    DNHeaderInfo.LastUpdateDate = DateTime.Now;

                //    new DNHeader().Save(DNHeaderInfo);
                //    result = "{\"message\":\"Done.\"}";

                //    break;
                //case "postDN":
                //    DNHeaderInfo = Newtonsoft.Json.JsonConvert.DeserializeObject<DNHeaderInfo>(request["info"], new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });
                //    DNHeaderInfo.CreateUser = userID;
                //    DNHeaderInfo.CreateDate = DateTime.Now;
                //    DNHeaderInfo.LastUpdateUser = userID;
                //    DNHeaderInfo.LastUpdateDate = DateTime.Now;
                //    DNHeaderInfo.PostDate = DateTime.Now;
                //    DNHeaderInfo.PostFlag = "Y";
                //    DNHeaderInfo.PostUser = userID;

                //    new DNHeader().Save(DNHeaderInfo);
                //    result = "{\"message\":\"Done.\"}";
                //    break;
                //case "getDN":
                //    string DNNo = request["DNNo"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new DNHeader().Get(DNNo), new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });
                //    break;
                //case "getGRN":
                //    string GRNNo = request["GRNNo"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new GRNHeader().Get(GRNNo), new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });
                //    break;
                //case "getGRNWithTMS":
                //    GRNNo = request["GRNNo"];
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new GRNHeader().GetWithTMS(GRNNo), new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });
                //    break;
                case "getGeneralMasterList":
                    string[] masterNames = Newtonsoft.Json.JsonConvert.DeserializeObject<string[]>(request["categories"]);
                    result = Newtonsoft.Json.JsonConvert.SerializeObject(new GeneralMaster().GetGeneralMasterList(masterNames));
                    break;
                //case "checkDuplicateFormat":
                //    AutoGenSetupInfo autoGenSetupInfo = Newtonsoft.Json.JsonConvert.DeserializeObject<AutoGenSetupInfo>(request["info"], new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });
                //    if (new AutoGenNo().CheckDuplicateFormat(autoGenSetupInfo))
                //    {
                //        result = "{\"result\":true}";
                //    }
                //    else
                //    {
                //        result = "{\"result\":false}";
                //    }
                //    break;
                //case "searchWorkshopDN":
                //    tmpString = request["FilterObj"];
                //    DNSearchFilterInfo DNSearchFilterInfo = Newtonsoft.Json.JsonConvert.DeserializeObject<DNSearchFilterInfo>(tmpString, new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new DNHeader().SearchWorkshopDN(DNSearchFilterInfo), new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });
                //    break;
                //case "searchGRN":
                //    tmpString = request["FilterObj"];
                //    GRNSearchFilterInfo GRNSearchFilterInfo = Newtonsoft.Json.JsonConvert.DeserializeObject<GRNSearchFilterInfo>(tmpString, new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new GRNHeader().SearchGRN(GRNSearchFilterInfo), new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });
                //    break;
                //case "searchGRN_GenSI":
                //    tmpString = request["FilterObj"];
                //    GenSIFilterInfo GenSIFilterInfo = Newtonsoft.Json.JsonConvert.DeserializeObject<GenSIFilterInfo>(tmpString, new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(new GRNHeader().SearchGRN(GenSIFilterInfo), new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });
                //    break;

                //case "deleteDN":
                //    DNNo = request["DNNo"];
                //    new DNHeader().Delete(DNNo);
                //    result = "{\"message\":\"Done.\"}";
                //    break;

                //case "deleteGRN":
                //    GRNNo = request["GRNNo"];
                //    new GRNHeader().Delete(GRNNo);
                //    result = "{\"message\":\"Done.\"}";
                //    break;

                case "refreshList":
                    string table = request["Table"];
                    string input = request["Input"];
                    result = Newtonsoft.Json.JsonConvert.SerializeObject(new GeneralMaster().RefreshTableList(table, input), new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateTimeFormat });
                    break;

                //case "genSI":
                //    var GRNNoList = Newtonsoft.Json.JsonConvert.DeserializeObject<List<string>>(request["GRNNoList"]);
                //    List<string> tmpNoList  = new GRNHeader().GenSI(GRNNoList);
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(tmpNoList);
                //    break;
                    
                //case "getOutstandingAppList":
                //    Location = request["Location"];
                //    var outstandingList = new PRManagement().GetOutstandingAppListByLocation(Location);
                //    result = Newtonsoft.Json.JsonConvert.SerializeObject(outstandingList, new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = GlobalSetting.DateFormat });
                //    break;

                default:
                    break;

            }


            Log.Info(action);
        }
        catch (Exception e)
        {
            result = "{\"message\":\"" + e.Message.Replace("\r\n", "") + "\"}";
            Log.Error(e.Message);
            Log.Error(e.StackTrace);
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


//case "genPOHeader":
//    DetId = request["DetId"];
//    PRNo = request["PRNo"];
//    PONo = request["PONo"];
//    Incharge = userID;
//    tmpDate = DateTime.Now;
//    new PRManagement().GenPOHeader(PONo, PRNo, DetId, Incharge, tmpDate);
//    result = "{\"message\":\"Done.\"}";
//    break;
//case "getAutoGenPONo":
//    string fmt = new AutoGenNo().GetAutoGen("1").AutoGenNoFormat;
//    string year = DateTime.Now.Year.ToString();
//    string month = DateTime.Now.Month.ToString("00");

//    fmt = System.Text.RegularExpressions.Regex.Replace(fmt, "{YYYY}", year);
//    fmt = System.Text.RegularExpressions.Regex.Replace(fmt, "{MM}", month);
//    PONo = new AutoGenNo().getLastRunningNumber("PO", fmt, userID).ToString(fmt);
//    PONo = System.Text.RegularExpressions.Regex.Replace(PONo, "{", "");
//    PONo = System.Text.RegularExpressions.Regex.Replace(PONo, "}", "");
//    result = "{\"message\":\""+PONo+"\"}";
//    break;
