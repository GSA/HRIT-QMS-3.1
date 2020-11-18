using System;
using System.Collections.Generic;

namespace QmsCore.Model
{
    public partial class ZTestQmsCorrectiveaction
    {
        public int Id { get; set; }
        public int? ActionRequestTypeId { get; set; }
        public string EmplId { get; set; }
        public string EmployeeName { get; set; }
        public string NatureOfAction { get; set; }
        public DateTime EffectiveDateOfPar { get; set; }
        public string IsPaymentMismatch { get; set; }
        public DateTime? PareffectiveDate { get; set; }
        public string Details { get; set; }
        public DateTime? SubmittedAt { get; set; }
        public int? AssignedByUserId { get; set; }
        public string AssigndByName { get; set; }
        public int? AssignedToUserId { get; set; }
        public string AssignedToName { get; set; }
        public int? AssignedToOrgId { get; set; }
        public string AssignedToOrg { get; set; }
        public DateTime? AssignedAt { get; set; }
        public int? StatusId { get; set; }
        public string StatusLabel { get; set; }
        public int? CreatedByUserId { get; set; }
        public string CreatedByName { get; set; }
        public int? CreatedAtOrgId { get; set; }
        public string CreatedAtOrgName { get; set; }
        public DateTime? CreatedAt { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public DateTime? ResolvedAt { get; set; }
        public DateTime? DeletedAt { get; set; }
    }
}
