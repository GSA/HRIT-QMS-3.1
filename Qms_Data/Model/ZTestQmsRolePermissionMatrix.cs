using System;
using System.Collections.Generic;

namespace QmsCore.Model
{
    public partial class ZTestQmsRolePermissionMatrix
    {
        public int RolePermissionId { get; set; }
        public DateTime? RolepermDeletedAt { get; set; }
        public int RoleId { get; set; }
        public string RoleLabel { get; set; }
        public DateTime? RoleDeletedAt { get; set; }
        public int PermissionId { get; set; }
        public string PermissionLabel { get; set; }
        public DateTime? PermissionDeletedAt { get; set; }
    }
}
