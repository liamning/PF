using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using Dapper;


public class Attendance
{
    #region Standar Function
    SqlConnection db = new SqlConnection(ConfigurationManager.ConnectionStrings["SqlServerConnString"].ConnectionString);
    SqlTransaction transaction;


    public List<string> GetAttendanceIDList(string AttendanceID)
    {
        db.Open();
        String query = "select top 10 AttendanceID from Attendance where (@AttendanceID = '' or AttendanceID like '%' + @AttendanceID + '%') order by AttendanceID";
        var obj = (List<string>)db.Query<string>(query, new { AttendanceID = AttendanceID });
        db.Close();
        return obj;
    }


    public bool IsExisted(AttendanceInfo info)
    {
        db.Open();
        String query = "select count(*)  from Attendance "
        + " where AttendanceID = @AttendanceID ";
        var obj = (List<int>)db.Query<int>(query, info);
        db.Close();
        return obj[0] > 0;
    }

    public void Save(AttendanceInfo info)
    {
        if (this.IsExisted(info))
            this.Update(info);
        else
            this.Insert(info);
    }


    public AttendanceInfo Get(int AttendanceID)
    {
        db.Open();

        string query = "select * from Attendance "
        + " where AttendanceID = @AttendanceID ";

        var obj = (List<AttendanceInfo>)db.Query<AttendanceInfo>(query, new { AttendanceID = AttendanceID });
        db.Close();

        if (obj.Count > 0)
            return obj[0];
        else
            return null;
    }

    public void Delete(int AttendanceID)
    {
        db.Open();

        string query = "delete  from Attendance "
        + " where AttendanceID = @AttendanceID ";

        db.Execute(query, new { AttendanceID = AttendanceID });
        db.Close();
    }

    public void Update(AttendanceInfo info)
    {
        db.Open();

        string query = " UPDATE [dbo].[Attendance] SET  "
        + " [WorkerID] = @WorkerID "
        + ", [Client] = @Client "
        + ", [Store] = @Store "
        + ", [ClientStaffNo] = @ClientStaffNo "
        + ", [ClientStaffName] = @ClientStaffName "
        + ", [AttendanceDate] = @AttendanceDate "
        + ", [TimeIn] = @TimeIn "
        + ", [TimeOut] = @TimeOut "
        + ", [TotalHours] = @TotalHours "
        + ", [AdjustedHours] = @AdjustedHours "
        + ", [AdjustedOTHours] = @AdjustedOTHours "
        + ", [HourRate] = @HourRate "
        + ", [OTHourRate] = @OTHourRate "
        + ", [Amount] = @Amount "
        + ", [Remarks] = @Remarks "
        + " where AttendanceID = @AttendanceID ";


        db.Execute(query, info);
        db.Close();
    }

    public void Insert(AttendanceInfo info)
    {
        db.Open();

        string query = "INSERT INTO [dbo].[Attendance] ( [AttendanceID] "
        + ",[WorkerID] "
        + ",[Client] "
        + ",[Store] "
        + ",[ClientStaffNo] "
        + ",[ClientStaffName] "
        + ",[AttendanceDate] "
        + ",[TimeIn] "
        + ",[TimeOut] "
        + ",[TotalHours] "
        + ",[AdjustedHours] "
        + ",[AdjustedOTHours] "
        + ",[HourRate] "
        + ",[OTHourRate] "
        + ",[Amount] "
        + ",[Remarks] "
        + ") "
        + "VALUES ( @AttendanceID "
        + ",@WorkerID "
        + ",@Client "
        + ",@Store "
        + ",@ClientStaffNo "
        + ",@ClientStaffName "
        + ",@AttendanceDate "
        + ",@TimeIn "
        + ",@TimeOut "
        + ",@TotalHours "
        + ",@AdjustedHours "
        + ",@AdjustedOTHours "
        + ",@HourRate "
        + ",@OTHourRate "
        + ",@Amount "
        + ",@Remarks "
        + ") ";


        db.Execute(query, info);
        db.Close();
    }
    #endregion


    public void BatchInsert(List<AttendanceInfo> list)
    {

        db.Open();
        transaction = db.BeginTransaction();

        string query = "INSERT INTO [dbo].[Attendance] ( "
        + "[WorkerID] "
        + ",[Client] "
        + ",[Store] "
        + ",[ClientStaffNo] "
        + ",[ClientStaffName] "
        + ",[AttendanceDate] "
        + ",[TimeIn] "
        + ",[TimeOut] "
        + ",[TotalHours] "
        + ",[AdjustedHours] "
        + ",[AdjustedOTHours] "
        + ",[HourRate] "
        + ",[OTHourRate] "
        + ",[Amount] "
        + ",[Remarks] "
        + ") "
        + "VALUES ( "
        + "@WorkerID "
        + ",@Client "
        + ",@Store "
        + ",@ClientStaffNo "
        + ",@ClientStaffName "
        + ",@AttendanceDate "
        + ",@TimeIn "
        + ",@TimeOut "
        + ",@TotalHours "
        + ",@AdjustedHours "
        + ",@AdjustedOTHours "
        + ",@HourRate "
        + ",@OTHourRate "
        + ",@Amount "
        + ",@Remarks "
        + ") ";
        try
        {
            foreach (AttendanceInfo info in list)
            {
                db.Execute(query, info, transaction);
            }

            transaction.Commit();
        }
        catch
        {
            transaction.Rollback();
            throw;
        }
        finally
        {
            db.Close();
        }

    }
}