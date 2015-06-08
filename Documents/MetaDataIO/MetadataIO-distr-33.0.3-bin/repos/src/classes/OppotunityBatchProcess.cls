global class OppotunityBatchProcess implements Database.Batchable<sObject>, Database.AllowsCallouts
{

    public OppotunityBatchProcess(){}
    
    global Database.QueryLocator start(Database.BatchableContext BC)
    {
        String query = 'SELECT ID, Name, Account.Name FROM OPPORTUNITY where isclosed='+'true'+ ' and CloseDate=Today';
        return Database.getQueryLocator(query);
    }
    
    global void execute (Database.BatchableContext BC, List<Opportunity> scope)
    {
        for(Opportunity opp:scope)
        {
            System.debug('Opportunities in scope '+opp.Name);
            callOppWS (opp);
        }
    }

    public void callOppWS(Opportunity oppID)
    {
       System.debug('In Opportunity callout');
            onboardingSalesforceCom.GetCommisionsPort  os 
	    		= new onboardingSalesforceCom.GetCommisionsPort ();
			String opp= oppID.Name;
			//Account a = opp.Account;
			Double dC = os.getCommissions  (opp, oppID.Account.Name);
			System.debug ('Output commision for Opp Name = '+opp+'is '+dC);

    }
    
    global void finish(Database.BatchableContext BC)
    {
        
    }
}