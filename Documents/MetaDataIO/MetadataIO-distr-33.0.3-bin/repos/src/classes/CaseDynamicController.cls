public class CaseDynamicController 
{
    
//-- Reference
// -- https://www.salesforce.com/us/developer/docs/pages/Content/pages_dynamic_vf_components_implementation.htm    
// -- To add checkboxes = http://www.salesforce.com/us/developer/docs/pages/Content/pages_compref_selectCheckboxes.htm
// http://www.salesforce.com/us/developer/docs/pages/Content/pages_compref_selectOption.htm
Case casev;
List<String> caseFields;  
List<SelectOption> FieldList;
List<String> selectedFields = new List<String>();


    
    public void setSelectedFields(String[] fds)
    {
        system.debug('Selected fields are '+fds);
        selectedFields = fds;
    }    
    
    public List<String> getSelectedFields()
    {
        return selectedFields;
    }
    
  public Case getCase() 
{
        if (casev == null) casev = new Case();
        return casev;
}
 
 public Component.Apex.PageBlock getDynamicDetail() 
 {
     Component.Apex.PageBlock dynPageBlock = new Component.Apex.PageBlock();
     
     Component.Apex.InputField caseTypeField = new Component.Apex.InputField();
     caseTypeField.expressions.value = '{!Case.Type}';
     caseTypeField.id = 'conId';
     Component.Apex.OutputLabel theNameLabel = new Component.Apex.OutputLabel();
     theNameLabel.value = 'Type';
     theNameLabel.for = 'conId';
     
      Component.Apex.InputField caseSubjField = new Component.Apex.InputField();
     caseSubjField.expressions.value = '{!Case.Subject}';
     caseSubjField.id = 'subId';
     Component.Apex.OutputLabel theSubjLabel = new Component.Apex.OutputLabel();
     theSubjLabel.value = 'Subject';
     theSubjLabel.for = 'subId';
     
     Component.Apex.CommandButton saveButton = new Component.Apex.CommandButton();
     saveButton.value = 'Save';
     saveButton.expressions.action = '{!Save}';
     
     dynPageBlock.childComponents.add(caseSubjField);
     
     dynPageBlock.childComponents.add(caseTypeField);
     
     dynPageBlock.childComponents.add(saveButton);
     
     system.debug('SELECTED FIELD SIZE '+selectedFields.size());
 	 if (selectedFields.size() > 0)
     {
	  	system.debug('Rerender - selected fields are '+selectedFields);
         addAddlFields (dynPageBlock);
     }
     return dynPageBlock;
    }

    public List<String> getcaseFields()
    {
        //-- Get a list of fields and field labels for the case object
        
      Schema.DescribeSObjectResult dfr = Case.sObjectType.getDescribe();
        
      Map<String, Schema.SObjectField> objectFields = dfr.fields.getMap();
        
      //Iterate thru the Map and print field names
      //
        
      List<String> lStr = new List<String>();
        
        for (String kName:objectFields.keySet())
        {
        	    lStr.add(kName);
        }  
          
      if (0==lStr.size())
	      return null;  
      else
      	  return lStr;      
    }
    
    public List<SelectOption> getFieldList()
    {
        //-- Get a list of fields and field labels for the case object
        
      Schema.DescribeSObjectResult dfr = Case.sObjectType.getDescribe();
        
      Map<String, Schema.SObjectField> objectFields = dfr.fields.getMap();
        
      //Iterate thru the Map and print field names
      //
      List<SelectOption> options = new List<SelectOption>();  
        
        for (String kName:objectFields.keySet())
        {
        	    options.add(new SelectOption(kName, kname+' Fd'));
        }  
          
      if (0==options.size())
	      return null;  
      else
      	  return options;      
    }


    public void Save()
    {
        insert casev;
    }

    public PageReference SaveConfig()
    {
     	system.debug(':::In Save Config');   
        //return ApexPages.currentPage();
        return null;
    }
    
    public void addAddlFields (Component.Apex.PageBlock dynPageBlock)
    {
        Integer count = selectedFields.size();
        system.debug('ADD Fields - count is '+count);
        for (Integer i=0; i<count;i++)
        {
                Component.Apex.InputField confTypeField = new Component.Apex.InputField();
     			confTypeField.expressions.value = '{!Case.'+ selectedFields[i]+'}';
     			//confTypeField.id = selectedFields[i]+i;
confTypeField.id = 'BB'+i;
            Component.Apex.OutputLabel theNameLabel = new Component.Apex.OutputLabel();
     			theNameLabel.value = 'AA'+i;
     			theNameLabel.for = confTypeField.id;
            //System.debug ('confTypeField '+confTypeField);
            System.debug('confTypeField.expressions.value '+confTypeField.expressions.value);
 			system.debug('confTypeField.id '+confTypeField.id);
            dynPageBlock.childComponents.add(confTypeField);
        }
    }
    
}