trigger ApexSecuTest on Apex_Sharing_Test__c (before update) 
{
    if (trigger.IsUpdate)
    {
        ApexSecuTestHandler h = new ApexSecuTestHandler();
        h.beforeInsert(Trigger.new);
	}
    
    
}