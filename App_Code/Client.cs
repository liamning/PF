using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient; 
using System.Web;
using Dapper;


public class Client
{
	#region Standar Function
    SqlConnection db = new SqlConnection(ConfigurationManager.ConnectionStrings["SqlServerConnString"].ConnectionString);  
     

    public List<GeneralCodeDesc> GetClientCodeList(string ClientCode)
    { 
        db.Open();
        String query = "select top 10 ClientCode Code, ClientCode [Desc] from Client where (@ClientCode = '' or ClientCode like '%' + @ClientCode + '%') order by ClientCode";
        var obj = (List<GeneralCodeDesc>)db.Query<GeneralCodeDesc>(query, new { ClientCode = ClientCode });
        db.Close();
        return obj;
    }


    public bool IsExisted(ClientInfo info)
    {
        db.Open();
        String query = "select count(*)  from Client " 
		+ " where ClientCode = @ClientCode ";
        var obj = (List<int>)db.Query<int>(query, info);
        db.Close();
        return obj[0] > 0;
    }

    public void Save(ClientInfo info)
    {
        if(this.IsExisted(info))
            this.Update(info);
        else
            this.Insert(info); 
    }

	 
    public ClientInfo Get(string ClientCode)
    {
		db.Open();

        string query = "select * from Client " 
		+ " where ClientCode = @ClientCode ";
		
        var obj = (List<ClientInfo>)db.Query<ClientInfo>(query, new {  ClientCode = ClientCode  });
        db.Close();
		
        if (obj.Count > 0)
            return obj[0];
        else
            return null;
    }

    public void Delete(string ClientCode)
    {
		db.Open();

        string query = "delete  from Client " 
		+ " where ClientCode = @ClientCode ";
		
        db.Execute(query, new {  ClientCode = ClientCode  });
        db.Close();
    }
	
    public void Update(ClientInfo info)
    {
        db.Open();

        string query = " UPDATE [dbo].[Client] SET  "
		+ " [ClientName] = @ClientName " 
		+ ", [Address] = @Address " 
		+ ", [Phone] = @Phone " 
		+ ", [Fax] = @Fax " 
		+ ", [ContactPerson] = @ContactPerson " 
		+ ", [ContactPhone] = @ContactPhone " 
		+ ", [CreateUser] = @CreateUser " 
		+ ", [CreateDate] = @CreateDate " 
		+ ", [LastModifyUser] = @LastModifyUser " 
		+ ", [LastModifyDate] = @LastModifyDate " 
		+ " where ClientCode = @ClientCode ";

         
        db.Execute(query, info);
        db.Close();
    }

    public void Insert(ClientInfo info)
    {
        db.Open();

        string query = "INSERT INTO [dbo].[Client] ( [ClientCode] " 
		+ ",[ClientName] " 
		+ ",[Address] " 
		+ ",[Phone] " 
		+ ",[Fax] " 
		+ ",[ContactPerson] " 
		+ ",[ContactPhone] " 
		+ ",[CreateUser] " 
		+ ",[CreateDate] " 
		+ ",[LastModifyUser] " 
		+ ",[LastModifyDate] " 
		+") "
		+ "VALUES ( @ClientCode "
		+ ",@ClientName " 
		+ ",@Address " 
		+ ",@Phone " 
		+ ",@Fax " 
		+ ",@ContactPerson " 
		+ ",@ContactPhone " 
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