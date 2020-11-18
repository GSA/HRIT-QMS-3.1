using System;
using System.Collections.Generic;

namespace QmsCore.Model
{
    public partial class QmsCorrectiveactionrequest
    {
        public QmsCorrectiveactionrequest()
        {
            QmsCorrectiveactionErrortype = new HashSet<QmsCorrectiveactionErrortype>();
            QmsDataerror = new HashSet<QmsDataerror>();
        }

        public int Id { get; set; }
        public int? ActionRequestTypeId { get; set; }
        public string EmplId { get; set; }
        public string NatureOfAction { get; set; }
        public DateTime EffectiveDateOfPar { get; set; }
        public string IsPaymentMismatch { get; set; }
        public DateTime? PareffectiveDate { get; set; }
        public DateTime? Createdat { get; set; }
        public DateTime? Updatedat { get; set; }
        public DateTime? Resolvedat { get; set; }
        public int? AssignedByUserId { get; set; }
        public int? AssignedToUserId { get; set; }
        public int? AssignedToOrgId { get; set; }
        public DateTime? Assignedat { get; set; }
        public int? StatusId { get; set; }
        public DateTime? Submittedat { get; set; }
        public DateTime? Deletedat { get; set; }
        public int? CreatedByUserId { get; set; }
        public string Details { get; set; }
        public int? CreatedAtOrgId { get; set; }
        public byte RowVersion { get; set; }

        public virtual QmsCorrectiveactiontype ActionRequestType { get; set; }
        public virtual SecUser AssignedByUser { get; set; }
        public virtual SecOrg AssignedToOrg { get; set; }
        public virtual SecUser AssignedToUser { get; set; }
        public virtual SecOrg CreatedAtOrg { get; set; }
        public virtual SecUser CreatedByUser { get; set; }
        public virtual QmsEmployee Empl { get; set; }
        public virtual QmsNatureofaction NatureOfActionNavigation { get; set; }
        public virtual QmsStatus Status { get; set; }
        public virtual ICollection<QmsCorrectiveactionErrortype> QmsCorrectiveactionErrortype { get; set; }
        public virtual ICollection<QmsDataerror> QmsDataerror { get; set; }
    }
}
