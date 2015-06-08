public class ApexButtonPageController 
{
Account theAccount;
    
    public ApexButtonPageController(ApexPages.StandardController stdController)
    {
        theAccount = (Account)stdController.getRecord();
    }
    
    public PageReference doMyApexLogic()
    {
        theAccount.Industry = 'Spice Trading';   
        update theAccount;
        return new PageReference('/'+theAccount.id);
    }
}