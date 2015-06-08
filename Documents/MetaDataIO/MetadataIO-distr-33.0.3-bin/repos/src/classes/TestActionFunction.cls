public with sharing class TestActionFunction 
{

    public PageReference save() {
        Page.CommunitiesLogin.setRedirect(true);
        System.debug('Reached Redirect page');
        return  Page.CommunitiesLogin;
    }


String uname;


    public TestActionFunction() 
    {
        
    }


public String getUserName()
{
    return uname;
}

public PageReference sayHello()
{
    uname = UserInfo.getName();
    return null;
}

public void setState (String n) {
    state = n ;
}

public String getState () {
    return state;
}

public PageReference methodOne() {
    return null;
}


    private String state = 'no';
}