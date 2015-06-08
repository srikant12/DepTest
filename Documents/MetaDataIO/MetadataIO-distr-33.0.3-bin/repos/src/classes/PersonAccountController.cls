public with sharing class PersonAccountController {
	public String salutation {get; set;}
	public String fname {get;set;}
	public String lname {get;set;}
	Account acct;

	public PageReference save()
	{

		try {
			RecordType recType =
			 [select id, name, sobjecttype, ispersontype from recordtype where ispersontype=true and sobjecttype='account' limit 1];

			if (acct.recordtypeid == recType.id)
			{
				acct.Salutation = salutation;
				acct.FirstName = fname;
				acct.LastName = lname;
				insert (acct);
				System.debug('Current Page - '+ApexPages.currentPage().getUrl()+'   '+ApexPages.currentPage().getCookies());
				PageReference newPage =
					New PageReference ('/'+acct.id);
				newPage.setRedirect(true);
				return newPage;	
			} 
			else {
				insert (acct);
				System.debug('Current Page - '+ApexPages.currentPage().getUrl()+'   '+ApexPages.currentPage().getCookies());
				PageReference newPage = new PageReference ('/'+acct.id);
				newPage.setRedirect(true);
				return newPage;
			}
		}
		catch (System.DMLException e) {
			ApexPages.addMessages(e);
			return null;
		}
		return null;
	}

	public PersonAccountController() {
		acct = new Account();
	
		 RecordType rT = [select id, name, sobjecttype, ispersontype from recordtype where ispersontype=true and sobjecttype='account' limit 1];
	
			acct.recordtypeid = rT.id;	
	}
}