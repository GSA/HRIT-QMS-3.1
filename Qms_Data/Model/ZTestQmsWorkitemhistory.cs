using System;
using System.Collections.Generic;

namespace QmsCore.Model
{
    public partial class ZTestQmsWorkitemhistory
    {
        public int Id { get; set; }
        public int Workitemid { get; set; }
        public string Workitemtype { get; set; }
        public string ActionTakenBy { get; set; }
        public string PreviouslyAssignedTo { get; set; }
        public string PreviouslyAssignedBy { get; set; }
        public string PreviousStatus { get; set; }
        public string PreviousAssignedOrganization { get; set; }
        public string ActionDescription { get; set; }
        public DateTime? CreatedAt { get; set; }
    }
}
