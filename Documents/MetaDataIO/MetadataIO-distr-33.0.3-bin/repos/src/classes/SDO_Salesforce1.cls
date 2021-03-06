public with sharing class SDO_Salesforce1 {

    public String n {get;set;}
    public boolean founduser {get;set;}
    List<User> u;
    public String loginString {get;set;}
    public SDO_Salesforce1(){
        n =  ApexPages.currentPage().getParameters().get('name');
        u = [Select ID, UserName From User Where Name =: n Limit 1];
        founduser = !u.isEmpty();    
    }
    
    public void loginS1() {
        if(founduser)
        {           
            loginString = 'http://login.salesforce.com';
            String pwd = 'salesforce1';
            if(u[0] != null) { 
                loginString += '?un=' + u[0].UserName;
                loginString += '&pw=' + pwd;
                loginString += '&startURL=/apex/iPhonePage';
            }
        }      
        //return new PageReference(loginString);
    }
}