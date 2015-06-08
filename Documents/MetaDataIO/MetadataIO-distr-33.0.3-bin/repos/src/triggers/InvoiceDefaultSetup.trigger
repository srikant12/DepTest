trigger InvoiceDefaultSetup on Invoice_Example__c (before insert) 
{
// After Insert trigger as we need the ID of the Insert object
// Update the default values on Invoice from 
// Account - Billing Address
// Opportunity - Product code list

	for (Invoice_Example__c iE : Trigger.new)
	{
		System.debug ('New IE object '+iE);
        System.debug ('Account billing - '+iE.Account__r.BillingCity);
        //iE.Account__c;
        Account aa = [SELECT ID, NAME, BillingCity, BillingState FROM ACCOUNT WHERE ID=:iE.Account__c];
        System.debug ('New way to access Accout - '+aa.Name);
    	String billingAddress= aa.BillingCity+aa.BillingState;
        iE.Billing_Address__c = billingAddress;
        System.debug('Billing Address is - '+ billingAddress);
        
        System.debug ('Account Name is '+iE.Account__r.Name);
        
        Opportunity opp =
            [SELECT ID, NAME from Opportunity where Account.Name=:aa.Name Limit 1];
    
        System.debug('Opportunity Name is '+opp.Name+' '+opp.Id);
        
        // Get the product list
        // 
        
        List<OpportunityLineItem> olist = 
            [SELECT ID, NAME, PRODUCTCODE from OpportunityLineItem where opportunity.Id=:opp.ID];
        
        
        
       for (OpportunityLineItem oli : olist)
       {
           System.debug('Product Code is '+iE.OppCodes__c);
            iE.OppCodes__c = iE.OppCodes__c + oli.productcode;
            
       }
        
	}
}