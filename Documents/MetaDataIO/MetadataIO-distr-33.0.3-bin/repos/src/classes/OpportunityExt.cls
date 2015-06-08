public with sharing class OpportunityExt {

List<String> displayFieldList = new List<String>();
ApexPages.StandardController stdCon ;

	public OpportunityExt(ApexPages.StandardController con) { 
		stdCon = con;
	}

	public Component.Apex.PageBlock getDynamicForm() {
    	Component.Apex.PageBlock dynPageBlock = new Component.Apex.PageBlock();
	    Component.Apex.PageBlockSection pb = new Component.Apex.PageBlockSection();

//-- TEST describeSObjects

	List<String> sList = new List<String>();
	sList.add ('Opportunity');

	Schema.DescribeSObjectResult dsr = 
							Opportunity.getSObjectType().getDescribe();

	Map<String,Schema.DescribeFieldResult> finalMap = 
    							new Map<String, Schema.DescribeFieldResult>();
  // map of all fields in the object
  Map<String, Schema.SObjectField> objectFields = dsr.fields.getMap();		

	System.debug('Describe obj result - '+dsr);

	System.debug('Object Fields '+objectFields);


	if (objectFields.containsKey('PrivBK')) {
      Schema.DescribeFieldResult dr = objectFields.get('PrivBK').getDescribe();
      // add the results to the map to be returned
      System.debug('DR is '+dr);
    }



//--



	    pb = buildFieldSetComponent (pb, 'PrivBK');
	
	    // Create a button to submit the form
	    Component.Apex.CommandButton saveButton = new Component.Apex.CommandButton();
	    saveButton.value = 'Save';
	    saveButton.expressions.action = '{!Save}';
	    pb.childComponents.add (saveButton);
		dynPageBlock.childComponents.add(pb);    
	    
	    return dynPageBlock;
	}

	// https://www.salesforce.com/us/developer/docs/apexcode/Content/apex_enum_Schema_DisplayType.htm


	public Component.Apex.PageBlockSection buildFieldSetComponent(Component.Apex.PageBlockSection pb, 
																					String name ) 
	{

		List<Schema.FieldSetMember> fieldSetMemberList =  readFieldSet(name,'Opportunity');
		Integer i = 1;
		for(Schema.FieldSetMember fieldSetMemberObj : fieldSetMemberList)
		{
		    system.debug('API Name ====>' + fieldSetMemberObj.getFieldPath()); //api name
		    system.debug('Label ====>' + fieldSetMemberObj.getLabel());
		    system.debug('Required ====>' + fieldSetMemberObj.getRequired());
		    system.debug('DbRequired ====>' + fieldSetMemberObj.getDbRequired());
		    system.debug('Type ====>' + fieldSetMemberObj.getType());   //type - STRING,PICKLIST	
/*
			if ((fieldSetMemberObj.getType() == Schema.DisplayType.String) || 
		  						(fieldSetMemberObj.getType() == Schema.DisplayType.TextArea))
		    {
		    	System.debug ('Adding a child conponent - '+fieldSetMemberObj.getFieldPath());	
		    	Component.Apex.InputField theNameField1 = new Component.Apex.InputField();
//		    	theNameField1.expressions.value = '{!Opportunity.Description}';
				displayFieldList.add (fieldSetMemberObj.getFieldPath());
		    	theNameField1.expressions.value = '{!Opportunity.'+fieldSetMemberObj.getFieldPath()+'}';
//		    	theNameField1.expressions.value = oPP.Description;
		    	theNameField1.id = 'theName'+i;
		    	Component.Apex.OutputLabel theNameLabel1 = new Component.Apex.OutputLabel();
		    	theNameLabel1.value = fieldSetMemberObj.getLabel();
		    	theNameLabel1.for = 'theName'+i;	
		    	//pb.childComponents.add (theNameLabel1);
		    	pb.childComponents.add (theNameField1);
		    	i++;
		    }
		    else */
/*		    if ((fieldSetMemberObj.getType() == Schema.DisplayType.DateTime) || 
		    				(fieldSetMemberObj.getType() == Schema.DisplayType.Date))
		    {*/
		    	Component.Apex.InputField  theNameField = new Component.Apex.InputField ();
		    	displayFieldList.add (fieldSetMemberObj.getFieldPath());
		    	theNameField.expressions.value = '{!Opportunity.'+fieldSetMemberObj.getFieldPath()+'}';
		    	theNameField.id = 'theName' + i;
		    	pb.childComponents.add (theNameField);
		    	i++;
		    /*}*/ 
/*		    else if (fieldSetMemberObj.getType() == Schema.DisplayType.Picklist)
		    {
		    	Component.Apex.InputField  thePicklistField = new Component.Apex.InputField ();
		    	displayFieldList.add (fieldSetMemberObj.getFieldPath());

		    	thePicklistField.expressions.value = '{!Opportunity.'+fieldSetMemberObj.getFieldPath()+'}';
		    	thePicklistField.id = 'theDate' + i;
		    	pb.childComponents.add (thePicklistField);
		    	i++;
		    } 
*/
		}
		stdCon.addFields(displayFieldList);
		return pb;
	}


public  Component.Apex.PageBlockSection buildFieldComponent(Component.Apex.PageBlockSection pb, 
																	String name) {
    
    Component.Apex.InputField theNameField1 = null;
      Component.Apex.OutputLabel theNameLabel1 = null;
    
    // make this more generic
      theNameField1 = new Component.Apex.InputField();
      theNameField1.expressions.value = '{!Opportunity.'+name+'}';
      displayFieldList.add (name);
//      theNameField1.id = 'theName'+i;
      pb.childComponents.add (theNameField1);
      stdCon.addFields(displayFieldList);

      
      //    theNameLabel1 = new Component.Apex.OutputLabel();
      //    theNameLabel1.value = 'Test';
      //    theNameLabel1.for = 'theName'+i;
      //      pb.childComponents.add (theNameLabel1);
	 return pb;
  }



	public  List<Schema.FieldSetMember> readFieldSet(String fieldSetName, String ObjectName)
	{
	    Map<String, Schema.SObjectType> GlobalDescribeMap = Schema.getGlobalDescribe(); 
	    Schema.SObjectType SObjectTypeObj = GlobalDescribeMap.get(ObjectName);
	    Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();
	    Schema.FieldSet fieldSetObj = DescribeSObjectResultObj.FieldSets.getMap().get(fieldSetName);
	    return fieldSetObj.getFields(); 
	}
}