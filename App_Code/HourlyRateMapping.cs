using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient; 
using System.Web;
using Dapper;


public class HourlyRateMapping
{
	#region Standar Function
    SqlConnection db = new SqlConnection(ConfigurationManager.ConnectionStrings["SqlServerConnString"].ConnectionString);  
     

    public List<string> GetStoreCodeList(string StoreCode)
    { 
        db.Open();
        String query = "select top 10 StoreCode from HourlyRateMapping where (@StoreCode = '' or StoreCode like '%' + @StoreCode + '%') order by StoreCode";
        var obj = (List<string>)db.Query<string>(query, new { StoreCode = StoreCode });
        db.Close();
        return obj;
    }


    public bool IsExisted(HourlyRateMappingInfo info)
    {
        db.Open();
        String query = "select count(*)  from HourlyRateMapping " 
		+ " where StoreCode = @StoreCode ";
        var obj = (List<int>)db.Query<int>(query, info);
        db.Close();
        return obj[0] > 0;
    }

    public void Save(List<HourlyRateMappingInfo> list)
    {
        Clear();
        foreach (var info in list)
        {
            this.Insert(info);
        } 
    }

    public List<HourlyRateMappingInfo> Get()
    {
        db.Open();

        string query = "select * from HourlyRateMapping ";

        var obj = (List<HourlyRateMappingInfo>)db.Query<HourlyRateMappingInfo>(query);
        db.Close();

        return obj;
    }

    public HourlyRateMappingInfo Get(string StoreCode)
    {
		db.Open();

        string query = "select * from HourlyRateMapping " 
		+ " where StoreCode = @StoreCode ";
		
        var obj = (List<HourlyRateMappingInfo>)db.Query<HourlyRateMappingInfo>(query, new {  StoreCode = StoreCode  });
        db.Close();
		
        if (obj.Count > 0)
            return obj[0];
        else
            return null;
    }

    public void Clear()
    {
        db.Open();

        string query = "delete from HourlyRateMapping ";

        db.Execute(query);
        db.Close();
    }

    public void Delete(string StoreCode)
    {
        db.Open();

        string query = "delete  from HourlyRateMapping "
        + " where StoreCode = @StoreCode ";

        db.Execute(query, new { StoreCode = StoreCode });
        db.Close();
    }

    public void Update(HourlyRateMappingInfo info)
    {
        db.Open();

        string query = " UPDATE [dbo].[HourlyRateMapping] SET  "
		+ " [Gender] = @Gender " 
		+ ", [Session] = @Session " 
		+ ", [DayOfWeek] = @DayOfWeek " 
		+ ", [IsHoliday] = @IsHoliday " 
		+ ", [HoursFrom] = @HoursFrom " 
		+ ", [HoursTo] = @HoursTo " 
		+ ", [Rate] = @Rate " 
		+ ", [CreateUser] = @CreateUser " 
		+ ", [CreateDate] = @CreateDate " 
		+ ", [LastModifyUser] = @LastModifyUser " 
		+ ", [LastModifyDate] = @LastModifyDate " 
		+ " where StoreCode = @StoreCode ";

         
        db.Execute(query, info);
        db.Close();
    }

    public void Insert(HourlyRateMappingInfo info)
    {
        db.Open();

        string query = "INSERT INTO [dbo].[HourlyRateMapping] ( [StoreCode] " 
		+ ",[Gender] " 
		+ ",[Session] " 
		+ ",[DayOfWeek] " 
		+ ",[IsHoliday] " 
		+ ",[HoursFrom] " 
		+ ",[HoursTo] " 
		+ ",[Rate] " 
		+ ",[CreateUser] " 
		+ ",[CreateDate] " 
		+ ",[LastModifyUser] " 
		+ ",[LastModifyDate] " 
		+") "
		+ "VALUES ( @StoreCode "
		+ ",@Gender " 
		+ ",@Session " 
		+ ",@DayOfWeek " 
		+ ",@IsHoliday " 
		+ ",@HoursFrom " 
		+ ",@HoursTo " 
		+ ",@Rate " 
		+ ",@CreateUser " 
		+ ",@CreateDate " 
		+ ",@LastModifyUser " 
		+ ",@LastModifyDate " 
		+") ";


        db.Execute(query, info);
        db.Close();
    }
	#endregion 

}