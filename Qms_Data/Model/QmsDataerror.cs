using System;
using System.Collections.Generic;

namespace QmsCore.Model
{
    public partial class QmsDataerror
    {
        public int DataErrorId { get; set; }
        public string DataErrorKey { get; set; }
        public int ErrorListId { get; set; }
        public string Emplid { get; set; }
        public string QmsErrorCode { get; set; }
        public int? AssignedToUserId { get; set; }
        public int? AssignedByUserId { get; set; }
        public int? AssignedToOrgId { get; set; }
        public int? CreatedByUserId { get; set; }
        public int CreatedByOrgId { get; set; }
        public DateTime? AssignedAt { get; set; }
        public string Details { get; set; }
        public int? StatusId { get; set; }
        public DateTime? SubmittedAt { get; set; }
        public string QmsErrorMessageText { get; set; }
        public int? CorrectiveActionId { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime? ResolvedAt { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public DateTime? DeletedAt { get; set; }
        public byte? RowVersion { get; set; }

        public virtual SecUser AssignedByUser { get; set; }
        public virtual SecOrg AssignedToOrg { get; set; }
        public virtual SecUser AssignedToUser { get; set; }
        public virtual QmsCorrectiveactionrequest CorrectiveAction { get; set; }
        public virtual SecOrg CreatedByOrg { get; set; }
        public virtual SecUser CreatedByUser { get; set; }
        public virtual QmsEmployee Empl { get; set; }
        public virtual QmsMasterErrorList ErrorList { get; set; }
        public virtual QmsStatus Status { get; set; }
    }
}
