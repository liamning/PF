using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using Dapper;

/// <summary>
/// Summary description for Sample
/// </summary>
public class GeneralMaster
{
    SqlConnection db = new SqlConnection(ConfigurationManager.ConnectionStrings["SqlServerConnString"].ConnectionString);

    public Dictionary<string, List<GeneralCodeDesc>> GetGeneralMasterList(string[] masterNames)
    {
        Dictionary<string, List<GeneralCodeDesc>> dict = new Dictionary<string, List<GeneralCodeDesc>>();

        foreach (string masterName in masterNames)
        {
            switch (masterName)
            {
                case "Relationship":
                    dict.Add(masterName, this.getGeneralMaster(masterName));
                    break;
                //case "Role":
                //    dict.Add(masterName, this.GetRoleList());
                //    break;
                //case "TransactionType":
                //    dict.Add(masterName, new POManagement().getTransactionList());
                //    break;
                //case "Supplier":
                //    dict.Add(masterName, new POManagement().GetSupplierList());
                //    break;
                //case "Currency":
                //    dict.Add(masterName, new PRManagement().GetCurrencyList());
                //    break;
                //case "PriceTerm":
                //    dict.Add(masterName, new POManagement().GetPriceTermList());
                //    break;
                //case "PaymentTerm":
                //    dict.Add(masterName, new POManagement().GetPaymentList());
                //    break;
                //case "Unit":
                //    dict.Add(masterName, new POManagement().GetUnitList());
                //    break;
                //default:
                //    dict.Add(masterName, this.getGeneralMaster(masterName));
                //    break;
            }
        }

        return dict;
    } 

    public List<GeneralCodeDesc> GetRoleList()
    {
        db.Open();
        String query = "select RoleCode Code, RoleName [Desc] from RoleHeader order by RoleName";
        var obj = (List<GeneralCodeDesc>)db.Query<GeneralCodeDesc>(query);
        db.Close();
        return obj;
    }

    public List<GeneralCodeDesc> RefreshTableList(string tableName, string input)
    {
        switch (tableName)
        {
            case "Sample":
                return this.RefreshSampleList(input);
            //case "Supplier":
            //    return this.RefreshSupplierList(input);
            //case "Staff":
            //    return new StaffProfile().GetStaffNoList(input);
            //case "SupplierGRN":
            //    return new GRNHeader().GetGRNNoList(input);
            //case "SuppInvNo":
            //    return new GRNHeader().RefreshInvList(input);
            //case "Role":
            //    return new RoleFunction().GetRoleCodeList(input);
            //case "PO":
            //    return new POManagement().RefreshPOList(input); 
        }

        return null;
    }


    private List<GeneralCodeDesc> RefreshSampleList(string SampleNo)
    {
        db.Open();
        string query = @"(select SampleNo Code, SampleText [Desc] from [Sample] where @SampleNo = SampleNo)
                        union
                    (select top 10 SampleNo Code, SampleText [Desc] from [Sample]
                    where (@SampleNo = '' or SampleNo like '%' + @SampleNo + '%' ))  order by SampleNo";
        var obj = (List<GeneralCodeDesc>)db.Query<GeneralCodeDesc>(query, new { SampleNo = SampleNo });
        db.Close();
        return obj;
    }

    private List<GeneralCodeDesc> getGeneralMaster(string category)
    {
        this.db.Open();

        try
        {
            string query = @" 
                SELECT [Code] Code
                      ,[EngDesc] [Desc]
                  FROM [dbo].[GeneralMaster]
                  where Category = @Category order by Seq
                ";
            List<GeneralCodeDesc> result = (List<GeneralCodeDesc>)this.db.Query<GeneralCodeDesc>(query, new { category = category });
            return result;
        }
        catch
        {
            throw;
        }
        finally
        {
            this.db.Close();
        }
    }

//    private List<GeneralCodeDesc> getLocationList()
//    {
//        this.db.Open();

//        try
//        {
//            string query = @"
//                select '-' Code, '-' [Desc]
//                union all
//                select CustomerCode [Code], CustomerName [Desc] from " + GlobalSetting.TMSWorkshopCompanyDBPolicyValue + @".[dbo].[TmsCustomer]
//                ";
//            List<GeneralCodeDesc> result = (List<GeneralCodeDesc>)this.db.Query<GeneralCodeDesc>(query);
//            return result;
//        }
//        catch
//        {
//            throw;
//        }
//        finally
//        {
//            this.db.Close();
//        }
//    }

//    private List<GeneralCodeDesc> RefreshLocationList(string LocationCode)
//    {
//        db.Open();
//        string query = @"(select CustomerCode Code, CustomerName [Desc] from " + GlobalSetting.TMSWorkshopCompanyDBPolicyValue + @".[dbo].[TmsCustomer] where @Code = CustomerCode)
//                    union
//                (select top 10 CustomerCode Code, CustomerName [Desc] from " + GlobalSetting.TMSWorkshopCompanyDBPolicyValue + @".[dbo].[TmsCustomer]
//                where (@Code = '' or CustomerCode like '%' + @Code + '%' or CustomerName like '%' + @Code + '%'))  order by CustomerCode";
//        var obj = (List<GeneralCodeDesc>)db.Query<GeneralCodeDesc>(query, new { Code = LocationCode });
//        db.Close();
//        return obj;
//    }

//    private List<GeneralCodeDesc> RefreshSupplierList(string supplierCode)
//    {
//        string query = @"(select SupplierCode Code, SupplierName [Desc] from " + GlobalSetting.TMSWorkshopCompanyDBPolicyValue + @".[dbo].[TmsSupplier] where @Code = SupplierCode)
//                    union
//                (select top 10 SupplierCode Code, SupplierName [Desc] from " + GlobalSetting.TMSWorkshopCompanyDBPolicyValue + @".[dbo].[TmsSupplier]
//                where (@Code = '' or SupplierCode like '%' + @Code + '%' ))  order by SupplierCode";
//        var obj = (List<GeneralCodeDesc>)db.Query<GeneralCodeDesc>(query, new { Code = supplierCode });
//        db.Close();
//        return obj;
//    }

}