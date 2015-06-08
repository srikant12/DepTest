/**
 * An apex page controller that exposes the site login functionality
 */
global with sharing class CommunitiesLoginController {

    global CommunitiesLoginController () {}
    
    // Code we will invoke on page load.
    global PageReference forwardToAuthPage() {
    	String startUrl = System.currentPageReference().getParameters().get('startURL');
        System.debug('START URL '+startUrl);
    	String displayType = System.currentPageReference().getParameters().get('display');
 		System.debug('Display Type '+displayType);
        return Network.forwardToAuthPage(startUrl, displayType);
    }
}