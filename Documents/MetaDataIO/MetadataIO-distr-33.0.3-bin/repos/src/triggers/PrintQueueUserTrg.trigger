trigger PrintQueueUserTrg on User (after update) 
{

    List<User> userList = Trigger.new;
    
    for (User u : userList)
    {
        System.debug('USER UPDATED '+u.FirstName+u.LastName+  '  '+u.IsActive);
        if (!(u.IsActive))
            PrintQTrigHdlr.removeUser(u.FirstName,u.LastName , 'PRINT CASE QUEUE');
    }
    
}