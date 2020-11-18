using System;
using System.Collections.Generic;

namespace QmsCore.Model
{
    public partial class ZTestQmsCorrectiveactionerrors
    {
        public int Id { get; set; }
        public int CorrectiveActionId { get; set; }
        public int ErrorTypeId { get; set; }
        public string Description { get; set; }
    }
}
