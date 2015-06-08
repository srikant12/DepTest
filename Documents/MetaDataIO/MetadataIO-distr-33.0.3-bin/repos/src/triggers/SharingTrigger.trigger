trigger SharingTrigger on Apex_Sharing_Test__c (after insert) 
{
    ShTrigHdlr s1 = new ShTrigHdlr();
    s1.handleT();
    
    if (trigger.IsInsert){
        
        List<Apex_Sharing_Test__Share> aShare = new List<Apex_Sharing_Test__Share>();
        
        for (Apex_Sharing_Test__c atc : trigger.new)
        {
            Apex_Sharing_Test__Share overShare = new Apex_Sharing_Test__Share ();
            overShare.ParentId = atc.Id;
            overShare.UserOrGroupId = atc.OversightUser__c;
            overShare.AccessLevel = 'edit';
            overShare.RowCause = Schema.Apex_Sharing_Test__Share.RowCause.ShareWithOverseer__c;
            aShare.add (overShare);
        }
    Database.SaveResult[] ovrShareInsertResult = Database.insert (aShare,false);

    }
}