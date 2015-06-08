public with sharing class OppFutureTest {

	List<ID> oList = new List<ID>();

	public OppFutureTest() 
	{
		for (Opportunity o:[SELECT ID, Name from Opportunity Limit 10])
			oList.add(o.ID) ;
	}

	public void callFuture()
	{
		System.debug('Calling at future');
		futureC(oList);
	}


	@future
	public static void futureC (List<Id> oL)
	{
		for (ID i:oL) 
		{
			System.debug('REACHED FUTURE METHOD');
			Opportunity o = [SELECT ID, Name from Opportunity where ID=:i];
			System.debug('Op is '+o.Name);
		}

	}

}