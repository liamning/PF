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

/// <summary>
/// Summary description for AttendanceImport
/// </summary>
public class AttendanceImport
{
    public AttendanceImport()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public void Import(Stream file, string clientCode)
    {
        if (clientCode == "Zara")
            Import_Zara(file, clientCode);
        else
            Import_Nike(file, clientCode);
    }
    public void Import_Zara(Stream file, string clientCode)
    {
        List<AttendanceInfo> attendanceList = new List<AttendanceInfo>();
        Attendance attendanceObj = new Attendance();
        AttendanceInfo tempAttendance;

        XSSFWorkbook hssfwb = new XSSFWorkbook(file);
        ISheet sheet = hssfwb.GetSheet("每日出勤表");
        IRow currentRow;
        //ICell currentCell;

        //Newtonsoft.Json.Converters.IsoDateTimeConverter IsoDateTimeConverter = new Newtonsoft.Json.Converters.IsoDateTimeConverter { DateTimeFormat = "yyyy-MM-dd" };
        string dateFormat = "yyyy-MM-dd";
        string datetimeFormat = "yyyy-MM-dd HH:mm";
        for (int row = 1; row <= sheet.LastRowNum; row++)
        {

            System.Diagnostics.Debug.WriteLine(row);

            currentRow = sheet.GetRow(row);
            if (currentRow != null) //null is when the row only contains empty cells 
            {
                //考勤日期	小組 	員工編號	員工姓名	班次	扣減工時   (分鐘)	上班	下班	考勤工時	考勤工時2	加班	加班2	Total hrs	備注	hrs	22:00後
                if (currentRow.GetCell(0) == null || string.IsNullOrEmpty(currentRow.GetCell(0).StringCellValue)) break;
                if (currentRow.GetCell(2) == null) continue;

                tempAttendance = new AttendanceInfo();
                tempAttendance.Client = clientCode;
                tempAttendance.AttendanceDate = DateTime.ParseExact(currentRow.GetCell(0).StringCellValue, dateFormat, CultureInfo.InvariantCulture);
                tempAttendance.Store = currentRow.GetCell(1).StringCellValue;
                tempAttendance.ClientStaffNo = currentRow.GetCell(2).StringCellValue;
                tempAttendance.ClientStaffName = currentRow.GetCell(3).StringCellValue;
                tempAttendance.Remarks = currentRow.GetCell(4).StringCellValue;

                if (currentRow.GetCell(6).CellType == CellType.Numeric)
                {
                    tempAttendance.TimeIn = currentRow.GetCell(6).DateCellValue;
                }
                else if (!string.IsNullOrEmpty(currentRow.GetCell(6).StringCellValue))
                {
                    tempAttendance.TimeIn = DateTime.ParseExact(currentRow.GetCell(0).StringCellValue + " " + getTimeInExceptionInput(currentRow.GetCell(6).StringCellValue), datetimeFormat, CultureInfo.InvariantCulture);
                }

                if (currentRow.GetCell(7).CellType == CellType.Numeric)
                {
                    tempAttendance.TimeIn = currentRow.GetCell(7).DateCellValue;
                }
                else if (!string.IsNullOrEmpty(currentRow.GetCell(7).StringCellValue))
                {
                    tempAttendance.TimeOut = DateTime.ParseExact(currentRow.GetCell(0).StringCellValue + " " + getTimeInExceptionInput(currentRow.GetCell(7).StringCellValue), datetimeFormat, CultureInfo.InvariantCulture);
                }

                tempAttendance.TotalHours = currentRow.GetCell(12).NumericCellValue;

                attendanceList.Add(tempAttendance);

            }
        }

        attendanceObj.BatchInsert(attendanceList);



    }

    public void Import_Nike(Stream file, string clientCode)
    {
        List<AttendanceInfo> attendanceList = new List<AttendanceInfo>();
        Attendance attendanceObj = new Attendance();
        AttendanceInfo tempAttendance;

        XSSFWorkbook hssfwb = new XSSFWorkbook(file);
        ISheet sheet = hssfwb.GetSheet("Export to PDF");
        IRow currentRow;
        //ICell currentCell;

        string dateFormat = "MM/dd/yyyy";
        /// string datetimeFormat = "yyyy-MM-dd HH:mm";

        //get the week day
        currentRow = sheet.GetRow(1);
        Dictionary<DateTime, int> dateColMapping = new Dictionary<DateTime, int>();
        DateTime workingDate;
        for (int col = 4; col < currentRow.LastCellNum - 1; col++)
        {
            System.Diagnostics.Debug.WriteLine(col);
            if (currentRow.GetCell(col) == null) continue;

            if (currentRow.GetCell(col).CellType == CellType.Numeric)
            {
                dateColMapping.Add(currentRow.GetCell(col).DateCellValue, col);
            }
            else if (!string.IsNullOrEmpty(currentRow.GetCell(col).StringCellValue))
            {
                //if (currentRow.GetCell(col).StringCellValue == "Grand Total") break;
                workingDate = DateTime.ParseExact(currentRow.GetCell(col).StringCellValue, dateFormat, CultureInfo.InvariantCulture);
                dateColMapping.Add(workingDate, col);
            }

        }

        for (int row = 3; row < sheet.LastRowNum; row++)
        {
            System.Diagnostics.Debug.WriteLine(row);
            currentRow = sheet.GetRow(row);
            if (currentRow != null) //null is when the row only contains empty cells 
            {
                if (currentRow.GetCell(1) == null || string.IsNullOrEmpty(currentRow.GetCell(1).StringCellValue)) continue;

                foreach (DateTime attendanceDate in dateColMapping.Keys)
                {
                    System.Diagnostics.Debug.WriteLine(attendanceDate.ToString("ddMMyyyy"));
                    if (currentRow.GetCell(dateColMapping[attendanceDate]) == null) continue;

                    tempAttendance = new AttendanceInfo();
                    tempAttendance.Client = clientCode;
                    tempAttendance.AttendanceDate = attendanceDate;
                    tempAttendance.ClientStaffNo = currentRow.GetCell(1).StringCellValue;
                    tempAttendance.TotalHours = currentRow.GetCell(dateColMapping[attendanceDate]).NumericCellValue;

                    if (tempAttendance.TotalHours == 0) continue;

                    attendanceList.Add(tempAttendance);
                }
            }
        }

        attendanceObj.BatchInsert(attendanceList);

    }

    private string getTimeInExceptionInput(string input)
    {
        string result = "";

        MatchCollection matches = Regex.Matches(input, @"\d{2}:\d{2}");
        if (matches.Count > 0)
        {
            result = matches[0].Value;
        }

        return result;
    }
}