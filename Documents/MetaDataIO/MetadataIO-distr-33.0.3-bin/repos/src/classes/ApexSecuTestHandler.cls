public  class ApexSecuTestHandler
{
    public ApexSecuTestHandler(){}
    public void beforeInsert(Apex_Sharing_Test__c[] atObj)
    {
		for (Apex_Sharing_Test__c atc : atObj)
        {
            Schema.DescribeFieldResult F = Apex_Sharing_Test__c.instanceName__c.getDescribe();
            if (F.isUpdateable())
                {
  			          atc.instanceName__c = atc.instanceName__c + 'UUUUUAA';        
                }    
            else                
            	atc.instanceName__c = atc.instanceName__c + 'BAA';
        }
    }
}