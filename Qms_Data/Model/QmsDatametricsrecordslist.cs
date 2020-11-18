using System;
using System.Collections.Generic;

namespace QmsCore.Model
{
    public partial class QmsDatametricsrecordslist
    {
        public int Id { get; set; }
        public string Emplid { get; set; }
        public string EmployeeName { get; set; }
        public string Poi { get; set; }
        public string OfficeSymbol { get; set; }
        public string Noa { get; set; }
        public string CreatedAt { get; set; }
        public DateTime? Created { get; set; }
        public string Closed { get; set; }
        public string CurrentStatus { get; set; }
        public long? DaysOpen { get; set; }
        public DateTime? LastDateToPprm { get; set; }
        public long? DaysAtPprm { get; set; }
        public long? ReturnedCount { get; set; }
        public string Submitter { get; set; }
        public string Resolver { get; set; }
        public string AssignedTo { get; set; }
        public string PayImpacting { get; set; }
    }
}
