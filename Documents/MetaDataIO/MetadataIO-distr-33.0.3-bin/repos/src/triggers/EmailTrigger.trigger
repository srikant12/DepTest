trigger EmailTrigger on Account (after insert) {

final String templateName = 'PATEMPLATE';
Id templateId;


try {
    templateId = [select id from EmailTemplate where Name = :templateName].Id;
}
catch (QueryException qE) {
    System.debug('Query Failed');
}


List<Messaging.SingleEmailMessage> messages = new List<Messaging.SingleEmailMessage>();

    for (Account so : [select lastname, firstname, personemail, personcontactid from Account where Id in :Trigger.new]) 
    {
        //friends remind friends to bulkify
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.setTemplateId (templateId);
        message.setTargetObjectId (so.personcontactid);
        message.setToAddresses (new String[]{so.personemail});
        messages.add (message);
    }
Messaging.sendEmail (messages);
}