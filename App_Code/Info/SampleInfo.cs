using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for SampleInfo
/// </summary>
public class SampleInfo
{
	public SampleInfo()
	{
		//
		// TODO: Add constructor logic here
		//
       // this.StaffList = new List<StaffInfo>();
	}

    public string SampleNo { get; set; }
    public string SampleText { get; set; }
    public string SampleTextarea { get; set; }
    public string SampleRadioButton { get; set; } 
    public string Email { get; set; }
    public string Relationship { get; set; }
    public decimal Asset { get; set; }
    public decimal Liability { get; set; }
    public DateTime? SampleDate { get; set; }
    public DateTime? SampleTime { get; set; }
    public string CreateUser { get; set; }
    public DateTime? UpdateDate { get; set; }
    public string UpdateUser { get; set; }

    //public List<StaffInfo> StaffList { get; set; }

}
