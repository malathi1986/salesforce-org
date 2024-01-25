trigger CloseComment on CaseComment (before insert) 
{
Set<Id> parentCase=new Set<Id>();
Map<Id,Case> mapCase=new Map<Id,Case>();
for (CaseComment t: Trigger.new)
{
parentCase.add(t.ParentId);
}
List<Case> lstCase=[Select Id,Status from case where Id in :parentCase ];
for(case c:lstCase)
{
mapCase.put(c.Id,c);
}

for (CaseComment t: Trigger.new)
{
if(mapCase.containskey(t.ParentId))
{
if(mapCase.get(t.ParentId).Status=='Closed' && System.Userinfo.getUserType()!= 'Standard')
    {
        t.addError('You cannot add comments to closed cases.');     
    }
}
}
}