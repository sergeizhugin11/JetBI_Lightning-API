trigger CheckBoxRule on Goods__c (before insert, before update) {
    for(Goods__c item : Trigger.New) 
        if(item.Amount__c>0) item.Available__c=true;
}