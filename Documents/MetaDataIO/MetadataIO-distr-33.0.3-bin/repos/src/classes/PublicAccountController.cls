public class PublicAccountController 
{
//- Following variables maintain the state

    Account account;
//    Contact contact;
    
    public Account getAccount() {
        if (account == null) account = new Account();
        return account;
    }

    public void setAccount(Account a){
    	account = a;
    } 
    
  /*  public Contact getContact () {
        if (contact == null) contact = new Contact();
        return contact;
    }
    */
     //-- Steps to control navigation
    //
    
    public PageReference save() 
    {
      // Check if the Account exist, if it
      // does not, return error
      Integer count = [SELECT count() From Account where name=:ApexPages.CurrentPage().getParameters().get('Name')];
        if (0 != count)
        {
         ApexPages.Message myMsg = 
             new ApexPages.Message(ApexPages.Severity.ERROR,'This is an existing Account');
         ApexPages.addMessage(myMsg);
         return null;
        }
      else
      {
      	RecordType recType =
			 [select id, name, sobjecttype, ispersontype from recordtype where ispersontype=true and sobjecttype='account' limit 1];
		 account.recordtypeid = recType.id;			 
		 insert account;
         return ApexPages.currentPage();
    	}
    }

    /*public PageReference step4() {
      //  Save selected values
      insert account;
      
      contact.account = account;  
        
      insert contact;
      return ApexPages.currentPage();
    }*/
    
}