public class DocumentExt {
    
    public DocumentExt(ApexPages.StandardController controller) {
        Document d = (Document) controller.getRecord();
        d.folderid = UserInfo.getUserId(); //this puts it in My Personal Documents
    }   
    
}