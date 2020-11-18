using System;
using System.Collections.Generic;

namespace QmsCore.Model
{
    public partial class QmsWorkitemhistory
    {
        public int Id { get; set; }
        public int WorkItemId { get; set; }
        public string WorkItemTypeCode { get; set; }
        public DateTime? CreatedAt { get; set; }
        public int? ActionTakenByUserId { get; set; }
        public int? PreviousStatusId { get; set; }
        public int? PreviousAssignedToOrgId { get; set; }
        public int? PreviousAssignedtoUserId { get; set; }
        public int? PreviousAssignedByUserId { get; set; }
        public string ActionDescription { get; set; }

        public virtual SecUser ActionTakenByUser { get; set; }
        public virtual SecUser PreviousAssignedByUser { get; set; }
        public virtual SecOrg PreviousAssignedToOrg { get; set; }
        public virtual SecUser PreviousAssignedtoUser { get; set; }
        public virtual QmsStatus PreviousStatus { get; set; }
        public virtual QmsWorkitemtype WorkItemTypeCodeNavigation { get; set; }
    }
}
