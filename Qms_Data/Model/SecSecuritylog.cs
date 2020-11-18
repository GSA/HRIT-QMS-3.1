using System;
using System.Collections.Generic;

namespace QmsCore.Model
{
    public partial class SecSecuritylog
    {
        public int SecurityLogId { get; set; }
        public int SecurityLogTypeId { get; set; }
        public int ActionTakenByUserId { get; set; }
        public int ActiontakenOnItemId { get; set; }
        public string Description { get; set; }
        public DateTime CreatedAt { get; set; }

        public virtual SecUser ActionTakenByUser { get; set; }
        public virtual SecSecuritylogtype SecurityLogType { get; set; }
    }
}
