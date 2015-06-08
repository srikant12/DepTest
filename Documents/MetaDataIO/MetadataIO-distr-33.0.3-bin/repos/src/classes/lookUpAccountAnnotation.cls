global class lookUpAccountAnnotation {
   @InvocableMethod
   public static List<Account> getAccountIds() 
   {
      String aName='Valley Supply Inc.';
      List<Account> accounts = [SELECT Id FROM Account WHERE Name=:aName];
      return accounts;
   }
}