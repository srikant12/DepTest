public class AVFAccountController 
{
//- Following variables maintain the state

    Account account;
    Contact contact;
    Service__c service;
    
    public Account getAccount() {
        if (account == null) account = new Account();
        return account;
    }
    
    public Contact getContact () {
        if (contact == null) contact = new Contact();
        return contact;
    }
    
    public Service__c getService() {
        if (service == null) service = new Service__c();
        return service;
    }
    
    //-- Steps to control navigation
    //
    
    public PageReference step2() 
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
         return Page.ServiceSelection;   
      }
    }

    public PageReference step3() {
      //  Show selection summary page
      
      return Page.ServiceSelectionSummary;
    }

    public PageReference Next() {
      //  return Page.
      return (PageReference)null;
    }
    
    public PageReference prev() {
      //  return Page.
      return Page.AVFAccountWizard;
    }


    public PageReference cancel() {
      return (PageReference)null;
        
    }
    
    public PageReference step4() {
      //  Save selected values
      insert account;
      
      contact.account = account;  
        
      insert contact;
      return ApexPages.currentPage();
    }
    
}