public class PrintQTrigHdlr 
{

    public PrintQTrigHdlr() {}
    
    @future
    public static void removeUser (String uF,String uL, String prntQ)
    {
        String userType = Schema.SObjectType.User.getKeyPrefix();
        
        System.debug('REMOVEUSER '+uF+uL+'  '+prntQ);
        Group prtGrp = 
         [SELECT ID FROM GROUP WHERE NAME=:prntQ and type='QUEUE'];
        System.debug('Group is '+prtGrp);
        
        List<GroupMember> uIDList = 
            [Select Id From GroupMember Where GroupId=:prtGrp.id];
        System.debug('Group Member list '+uIDList);
        
        USER userID = 
            [SELECT ID FROM USER WHERE FIRSTName=:uF AND LASTName=:uL];
        Integer i, index;
        for(i=0;i<uIDList.size();i++)
        {
            if (uIDList[i].ID ==userId.ID) {
                System.debug('Found a match '+i);
                index = i;
            }
        }
        
    }
}