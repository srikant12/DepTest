global class JSremoteTestController 
{  
    public JSremoteTestController ()
    {
        System.debug ('In remote constructor');
      
    }
    
@RemoteAction
    global static Contact[] findContacts(string Name) 
    {
        System.debug ('In find contacts Name is '+Name);
        Name = '%'+Name+'%';
        Contact[] c = [SELECT ID, Name, Phone, Email from Contact where NAME LIKE :Name ];
        return c;
    }
}