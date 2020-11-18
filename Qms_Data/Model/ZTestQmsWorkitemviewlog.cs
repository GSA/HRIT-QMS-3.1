using System;
using System.Collections.Generic;

namespace QmsCore.Model
{
    public partial class ZTestQmsWorkitemviewlog
    {
        public int Id { get; set; }
        public DateTime Createdat { get; set; }
        public int? Workitemid { get; set; }
        public string Workitemtype { get; set; }
        public int Userid { get; set; }
        public string DisplayName { get; set; }
    }
}
