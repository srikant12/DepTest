trigger MyDrvBdg on Driver__c (before delete, after delete) {


	System.debug('THIS DRIVER WAS deleted .....');

}