trigger block_chatter_post_attach on FeedItem (before insert) {
FeedItem[] feedItem = Trigger.new;   
    for(FeedItem feed :feedItem ) {
        if(feed.ContentFileName==null || feed.ContentFileName==''){
            feed.addError('As per the policy, You are not authorized to attach anything');
        }
        //feed.addError('As per the policy, You are not authorized to attach anything');
        
    }
}