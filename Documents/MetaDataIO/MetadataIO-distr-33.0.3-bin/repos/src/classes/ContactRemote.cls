global  class ContactRemote 
{
    public String contactName {get;set;}
    public static Contact cont {get;set;}
    public ContactRemote(){}
    
@RemoteAction
    global static Contact findContacts(String Name)
    {
        system.debug('I got called = '+Name);
        Name = '%'+Name+'%';
        Contact c = 
            [SELECT ID, Name, Phone, Email from Contact where Name like :Name LIMIT 1];
    	return c;
    }
}