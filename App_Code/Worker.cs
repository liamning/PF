using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient; 
using System.Web;
using Dapper;


public class Worker
{
	#region Standar Function
    SqlConnection db = new SqlConnection(ConfigurationManager.ConnectionStrings["SqlServerConnString"].ConnectionString);  
     

    public List<GeneralCodeDesc> GetWorkerIDList(string WorkerID)
    { 
        db.Open();
        String query = "select top 10 WorkerID Code, WorkerID [Desc] from Worker where (@WorkerID = '' or WorkerID like '%' + @WorkerID + '%') order by WorkerID";
        var obj = (List<GeneralCodeDesc>)db.Query<GeneralCodeDesc>(query, new { WorkerID = WorkerID });
        db.Close();
        return obj;
    }


    public bool IsExisted(WorkerInfo info)
    {
        db.Open();
        String query = "select count(*)  from Worker " 
		+ " where WorkerID = @WorkerID ";
        var obj = (List<int>)db.Query<int>(query, info);
        db.Close();
        return obj[0] > 0;
    }

    public void Save(WorkerInfo info)
    {
        if(this.IsExisted(info))
            this.Update(info);
        else
            this.Insert(info); 
    }

	 
    public WorkerInfo Get(string WorkerID)
    {
		db.Open();

        string query = "select * from Worker " 
		+ " where WorkerID = @WorkerID ";
		
        var obj = (List<WorkerInfo>)db.Query<WorkerInfo>(query, new {  WorkerID = WorkerID  });
        db.Close();
		
        if (obj.Count > 0)
            return obj[0];
        else
            return null;
    }

    public void Delete(string WorkerID)
    {
		db.Open();

        string query = "delete  from Worker " 
		+ " where WorkerID = @WorkerID ";
		
        db.Execute(query, new {  WorkerID = WorkerID  });
        db.Close();
    }
	
    public void Update(WorkerInfo info)
    {
        db.Open();

        string query = " UPDATE [dbo].[Worker] SET  "
		+ " [ChineseName] = @ChineseName " 
		+ ", [EnglishName] = @EnglishName " 
		+ ", [Introducer] = @Introducer " 
		+ ", [Address] = @Address " 
		+ ", [HKID1] = @HKID1 " 
		+ ", [HKID2] = @HKID2 " 
		+ ", [HKID3] = @HKID3 " 
		+ ", [DOB] = @DOB " 
		+ ", [Gender] = @Gender " 
		+ ", [PhoneNo] = @PhoneNo " 
		+ ", [PayrollGroup] = @PayrollGroup " 
		+ ", [PayrollRemarks] = @PayrollRemarks " 
		+ ", [BankCode] = @BankCode " 
		+ ", [BankACNo] = @BankACNo " 
		+ ", [BankName] = @BankName " 
		+ ", [MPFOption] = @MPFOption " 
		+ ", [DateJoin] = @DateJoin " 
		+ ", [WorkArea] = @WorkArea " 
		+ ", [Remarks] = @Remarks " 
		+ ", [CreateUser] = @CreateUser " 
		+ ", [CreateDate] = @CreateDate " 
		+ ", [LastModifyUser] = @LastModifyUser " 
		+ ", [LastModifyDate] = @LastModifyDate " 
		+ " where WorkerID = @WorkerID ";

         
        db.Execute(query, info);
        db.Close();
    }

    public void Insert(WorkerInfo info)
    {
        db.Open();

        string query = "INSERT INTO [dbo].[Worker] ( [WorkerID] " 
		+ ",[ChineseName] " 
		+ ",[EnglishName] " 
		+ ",[Introducer] " 
		+ ",[Address] " 
		+ ",[HKID1] " 
		+ ",[HKID2] " 
		+ ",[HKID3] " 
		+ ",[DOB] " 
		+ ",[Gender] " 
		+ ",[PhoneNo] " 
		+ ",[PayrollGroup] " 
		+ ",[PayrollRemarks] " 
		+ ",[BankCode] " 
		+ ",[BankACNo] " 
		+ ",[BankName] " 
		+ ",[MPFOption] " 
		+ ",[DateJoin] " 
		+ ",[WorkArea] " 
		+ ",[Remarks] " 
		+ ",[CreateUser] " 
		+ ",[CreateDate] " 
		+ ",[LastModifyUser] " 
		+ ",[LastModifyDate] " 
		+") "
		+ "VALUES ( @WorkerID "
		+ ",@ChineseName " 
		+ ",@EnglishName " 
		+ ",@Introducer " 
		+ ",@Address " 
		+ ",@HKID1 " 
		+ ",@HKID2 " 
		+ ",@HKID3 " 
		+ ",@DOB " 
		+ ",@Gender " 
		+ ",@PhoneNo " 
		+ ",@PayrollGroup " 
		+ ",@PayrollRemarks " 
		+ ",@BankCode " 
		+ ",@BankACNo " 
		+ ",@BankName " 
		+ ",@MPFOption " 
		+ ",@DateJoin " 
		+ ",@WorkArea " 
		+ ",@Remarks " 
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