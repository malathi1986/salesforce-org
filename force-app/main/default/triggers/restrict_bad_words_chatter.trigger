trigger restrict_bad_words_chatter on FeedItem (before insert,before update) {
FeedItem[] feedItem = Trigger.new;   
    for(FeedItem feed :feedItem ) {
      String textEntered = feed.body;
        if (textEntered.contains('ugly') || textEntered.contains('racial'))  {
            feed.addError('The word entered is not allowed as per the policy..');
        }
    }   
    
}