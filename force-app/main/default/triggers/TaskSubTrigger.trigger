trigger TaskSubTrigger on CaseComment (after insert) {

List<CaseComment> NewComment = new List<CaseComment>();
    
    for(CaseComment ca: Trigger.new){
        
        CaseComment com = new CaseComment();
        com.ParentId = ca.id;
       // com.CommentBody= ca.Description;
        NewComment.add(com) ;

                            }

Insert NewComment;

}