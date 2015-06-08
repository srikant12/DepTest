//Comment added today

public class AccountContactController 
{
    private Integer totalRecs = 0;
    private Integer index = 0;
    private Integer blockSize = 10;
    
    List<AccountWrapper> wrapList = new List<AccountWrapper>();
    
    public AccountContactController ()
    {
        totalRecs = [SELECT COUNT() FROM ACCOUNT];
        
    }
    
    public List<AccountWrapper> getaccounts()
    {
        Map<Id, AccountWrapper> accMap =
                        new Map<Id,AccountWrapper>();
        List<Account> aList = 
         Database.Query('SELECT CreatedByID, Account.Name, (SELECT Name, Contact.FirstName, Contact.LastName FROM Account.Contacts) FROM Account LIMIT :blockSize OFFSET :index');
        for (Account a : aList) 
        {
        
       // String aaa = a.WhtFOOO__c;
            AccountWrapper accWrap = accMap.get(a.CreatedByID);
            if (null == accWrap)
            {
                accWrap = new AccountWrapper();
                accMap.put(a.CreatedById, accWrap);
                accWrap.userId = a.CreatedById;
            }
            accWrap.accounts.add(a);
        }
        wrapList = accMap.values();
        return wrapList;
    }
    
    public void beggining()
    {
        index = 0;
    }
    
    public void previous ()
    {
        index = index - blockSize;
    }
    
    public void next()
    {
        index = index + blocksize;
    }
    public class AccountWrapper
    {
        public Id userId {get;set;}
        public List<Account> accounts {get;set;}
        public AccountWrapper ()
        {
            accounts =  new List<Account>();
        }
    }
    
}