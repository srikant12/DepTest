public with sharing class DynamicComponentExample {
	public DynamicComponentExample(ApexPages.StandardController con) { }

	public Component.Apex.PageBlock getDynamicForm() {
    Component.Apex.PageBlock dynPageBlock = new Component.Apex.PageBlock();

    Component.Apex.PageBlockSection pb = new Component.Apex.PageBlockSection();

Component.Apex.PageBlockSection pb2 = new Component.Apex.PageBlockSection();
    
//Component.Apex.Repeat fS = new Component.Apex.Repeat();

//List<String> s1 = new List<String>();
//s1.add ('ggg');
//fS.value = s1;


List<Schema.FieldSetMember> fieldSetMemberList =  readFieldSet('ggg','Account');

if (null == fieldSetMemberList)
	System.debug('FieldSet is null');
else
	System.debug(' Size of field Set '+fieldSetMemberList.size());

	//fS.value = fieldSetMemberList;

/*
for(Schema.FieldSetMember fieldSetMemberObj : fieldSetMemberList)
{
System.debug(fieldSetMemberObj.getFieldPath()); 
String s = '{!Account.'+fieldSetMemberObj.getFieldPath()+'}';
Component.Apex.InputField a = new Component.Apex.InputField();
a.label = fieldSetMemberObj.getLabel();
System.debug('Label is '+fieldSetMemberObj.getLabel()+ '   '+a.label);
a.expressions.value = s;

//a.value = fieldSetMemberObj.getFieldPath();

dynPageBlock.childComponents.add (a);

   system.debug('API Name ====>' + fieldSetMemberObj.getFieldPath()); //api name
    system.debug('Label ====>' + fieldSetMemberObj.getLabel());
    system.debug('Required ====>' + fieldSetMemberObj.getRequired());
    system.debug('DbRequired ====>' + fieldSetMemberObj.getDbRequired());
    system.debug('Type ====>' + fieldSetMemberObj.getType());   //type - STRING,PICKLIST
}
*/
/**/
Integer i = 10;

for(Schema.FieldSetMember fieldSetMemberObj : fieldSetMemberList)
{
    system.debug('API Name ====>' + fieldSetMemberObj.getFieldPath()); //api name
    system.debug('Label ====>' + fieldSetMemberObj.getLabel());
    system.debug('Required ====>' + fieldSetMemberObj.getRequired());
    system.debug('DbRequired ====>' + fieldSetMemberObj.getDbRequired());
    system.debug('Type ====>' + fieldSetMemberObj.getType());   //type - STRING,PICKLIST

    //Schema.DisplayType StringType = new Schema.DisplayType('STRING');
  
  Component.Apex.InputField theNameField1 = null;
  Component.Apex.OutputLabel theNameLabel1 = null;

  if ((fieldSetMemberObj.getType() == Schema.DisplayType.String) || (fieldSetMemberObj.getType() == Schema.DisplayType.TextArea))
    {
    	System.debug ('Adding a child conponent - '+fieldSetMemberObj.getFieldPath());
		 theNameField1 = new Component.Apex.InputField();
    	theNameField1.expressions.value = '{!Account.'+fieldSetMemberObj.getFieldPath()+'}';
    	theNameField1.id = 'theName'+i;
    	 theNameLabel1 = new Component.Apex.OutputLabel();
    	theNameLabel1.value = fieldSetMemberObj.getLabel();
    	theNameLabel1.for = 'theName'+i;
    	
    	pb.childComponents.add (theNameLabel1);
    	pb.childComponents.add (theNameField1);
    	i++;
    } 

}
dynPageBlock.childComponents.add(pb);
/**/
    // Create an input field for Account Name
    Component.Apex.InputField theNameField = new Component.Apex.InputField();
    theNameField.expressions.value = '{!Account.Name}';
    theNameField.id = 'theName';
    Component.Apex.OutputLabel theNameLabel = new Component.Apex.OutputLabel();
    theNameLabel.value = 'Rename Account?';
    theNameLabel.for = 'theName';
    
    // Create an input field for Account Number
    Component.Apex.InputField theAccountNumberField = new Component.Apex.InputField();
    theAccountNumberField.expressions.value = '{!Account.AccountNumber}';
    theAccountNumberField.id = 'theAccountNumber';
    Component.Apex.OutputLabel theAccountNumberLabel = new Component.Apex.OutputLabel();
    theAccountNumberLabel.value = 'Change Account #?';
    theAccountNumberLabel.for = 'theAccountNumber';
    
    // Create a button to submit the form
    Component.Apex.CommandButton saveButton = new Component.Apex.CommandButton();
    saveButton.value = 'Save';
    saveButton.expressions.action = '{!Save}';
    
    

    pb2.childComponents.add(theNameLabel);
    pb2.childComponents.add(theNameField);
    pb2.childComponents.add(theAccountNumberLabel);
    pb2.childComponents.add(theAccountNumberField);
    pb2.childComponents.add(saveButton);

	dynPageBlock.childComponents.add(pb2);    
    
    return dynPageBlock;
}

public  List<Schema.FieldSetMember> readFieldSet(String fieldSetName, String ObjectName)
{
    Map<String, Schema.SObjectType> GlobalDescribeMap = Schema.getGlobalDescribe(); 
    Schema.SObjectType SObjectTypeObj = GlobalDescribeMap.get(ObjectName);
    Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();

    //system.debug('====>' + DescribeSObjectResultObj.FieldSets.getMap().get(fieldSetName));

    Schema.FieldSet fieldSetObj = DescribeSObjectResultObj.FieldSets.getMap().get(fieldSetName);

    //List<Schema.FieldSetMember> fieldSetMemberList =  fieldSetObj.getFields();
    //system.debug('fieldSetMemberList ====>' + fieldSetMemberList);  
    return fieldSetObj.getFields(); 
}
}