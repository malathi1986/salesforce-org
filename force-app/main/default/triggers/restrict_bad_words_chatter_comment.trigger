trigger restrict_bad_words_chatter_comment on FeedComment (before insert, before  update) {
FeedComment[] feedC = Trigger.new;   
    for(FeedComment feed :feedC ) {
      String textEntered = feed.CommentBody;
        if (textEntered.contains('ugly') || textEntered.contains('racial'))  {
            feed.addError('The word entered is not allowed as per the policy..');
        }
    }   
}