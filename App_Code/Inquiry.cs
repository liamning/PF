using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using NPOI;
using NPOI.HSSF.UserModel;
using System.IO;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using System.Globalization;
using System.Text.RegularExpressions;
using Newtonsoft.Json.Linq;
using System.Data.SqlClient;
using System.Configuration;
using Dapper;

/// <summary>
/// Summary description for Inquiry
/// </summary>
public class Inquiry
{
    SqlConnection db = new SqlConnection(ConfigurationManager.ConnectionStrings["SqlServerConnString"].ConnectionString);

    public Inquiry()
    {
        //
        // TODO: Add constructor logic here
        //
    } 
    public string View_Search(JArray criterias, string view)
    {
        string result = "";
        List<string> conditions = new List<string>();
        foreach (JObject obj in criterias)
        {
        }
         
        foreach (JObject content in criterias.Children<JObject>())
        {
            foreach (JProperty prop in content.Properties())
            {
                Console.WriteLine(prop.Name);
                conditions.Add(string.Format("{0} = '{1}'", prop.Name, prop.Value));
            }
        }


        string query = string.Format(@"select * from {0}", view);
        if(conditions.Count > 0)
        {
            query += " where " + string.Join(" and ", conditions);
        }

        db.Open();

        var datas = db.Query(query);
        db.Close();
        result = Newtonsoft.Json.JsonConvert.SerializeObject(datas);

        return result;
    }
}