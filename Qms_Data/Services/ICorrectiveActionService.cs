using System.Linq;
using System.Collections.Generic;
using QmsCore.UIModel;

namespace QmsCore.Services
{
    public interface ICorrectiveActionService
    {
        void SaveComment(string message, int correctiveActionId, int authorId);
        int Save(CorrectiveAction newVersion, User submitter);
        List<CorrectiveActionComment> RetrieveComments(int correctiveActionId);
        List<CorrectiveActionHistory> RetrieveHistory(int correctiveActionId);
        CorrectiveAction RetrieveById(int Id, User searcher);
        IQueryable<CorrectiveAction> RetrieveAllForUser(User user);
        IQueryable<CorrectiveAction> RetrieveAllForUserArchive(User user);
        IQueryable<CorrectiveAction> RetrieveAllForOrganization(User user);
        IQueryable<CorrectiveAction> RetrieveAllForOrganizationArchive(User user);
        IQueryable<CorrectiveAction> RetrieveAll();
        IQueryable<CorrectiveAction> RetrieveAllArchive();
        IQueryable<CorrectiveAction> RetrieveAllByEmployeePOID(User user);
        IQueryable<CorrectiveAction> RetrieveAllByEmployeePOIDArchive(User user);
        IQueryable<CorrectiveAction> RetrieveAgingReport(User user);

    }
}
