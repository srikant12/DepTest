trigger MyOppBdg123 on Opportunity (before update, after update) {

	System.debug('THIS OPPORTUNITY WAS updated .....');

}