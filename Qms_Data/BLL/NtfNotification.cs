using System;
using System.Collections.Generic;

namespace QmsCore.Model
{
    public partial class NtfNotification
    {
        public NtfNotification()
        {

        }
        public NtfNotification Clone()
        {
            NtfNotification retval = new NtfNotification();
            retval.CreatedAt = this.CreatedAt;
            retval.DeletedAt = this.DeletedAt;
            retval.HasBeenRead = this.HasBeenRead;
            retval.Message = this.Message;
            retval.Title = this.Title;
            retval.NotificationEventId = this.NotificationEventId;
            retval.ReadAt = this.ReadAt;
            retval.SendAsEmail = this.SendAsEmail;
            retval.SentAt = this.SentAt;
            retval.UserId = this.UserId;
            retval.WorkitemId = this.WorkitemId;
            retval.WorkItemTypeCode = this.WorkItemTypeCode;
            return retval;

        }
    }//end class
}//end namespace