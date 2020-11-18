using System;
using System.Collections.Generic;

namespace QmsCore.Model
{
    public partial class ZTestQmsStatusTransitionMatrix
    {
        public int OrgStatusTransId { get; set; }
        public int StatusTransId { get; set; }
        public int FromOrgId { get; set; }
        public int ToOrgtypeId { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime? DeletedAt { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public int FromStatusId { get; set; }
        public int ToStatusId { get; set; }
        public string FromStatus { get; set; }
        public string ToStatus { get; set; }
        public string FromOrg { get; set; }
        public string ToOrgType { get; set; }
        public string WorkItemType { get; set; }
    }
}
