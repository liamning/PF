using System;
public class HourlyRateMappingInfo
{
	public int ID { get; set; }
	public string StoreCode { get; set; }
	public string Gender { get; set; }
	public string Session { get; set; }
	public string DayOfWeek { get; set; }
	public string IsHoliday { get; set; }
	public int HoursFrom { get; set; }
	public int HoursTo { get; set; }
	public decimal Rate { get; set; }
	public string CreateUser { get; set; }
	public DateTime? CreateDate { get; set; }
	public string LastModifyUser { get; set; }
	public DateTime? LastModifyDate { get; set; }
	public class FieldName
	{
		public const string ID = "ID";
		public const string StoreCode = "StoreCode";
		public const string Gender = "Gender";
		public const string Session = "Session";
		public const string DayOfWeek = "DayOfWeek";
		public const string IsHoliday = "IsHoliday";
		public const string HoursFrom = "HoursFrom";
		public const string HoursTo = "HoursTo";
		public const string Rate = "Rate";
		public const string CreateUser = "CreateUser";
		public const string CreateDate = "CreateDate";
		public const string LastModifyUser = "LastModifyUser";
		public const string LastModifyDate = "LastModifyDate";
	}
}
