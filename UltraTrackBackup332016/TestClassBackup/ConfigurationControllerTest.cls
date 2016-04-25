/**
 * Class Name: ConfigurationControllerTest
 * @description: Test class for ConfigurationController class.
 * @author: Amruta Kumbhakarn
 * @date:  26-2-2016
 * @revised:   
 */
@isTest
private class ConfigurationControllerTest {
    
    /** 
     * @author Amruta Kumbhakarn
     * @description: Get columns for Configuration Test
     * Expected Result: Method should return all picklist values and default value from Configuration
     *                  number of columns list
     * @date: 26-02-2016
     */   
    static testMethod void getColumnsTestCase() {

        list<Number_Of_Columns__c> numberOfColumnList = TestDataFactory.getNumberOfColumnList(new list<string> {'1','2','3','4'});
        insert numberOfColumnList;
        
        PageReference pageRef = Page.Configuration;
        Test.setCurrentPage(pageRef);
        
        ConfigurationController controllerObj;

        test.startTest();
        controllerObj = new ConfigurationController();
        test.stopTest();
        
        system.assertEquals(5,controllerObj.numberOfColValues.size());
        system.assertEquals(1,controllerObj.numberOfFieldsPerColValues.size());
        
        system.assertEquals(system.label.PicklistDefaultLabel,controllerObj.numberOfColValues[0].getLabel());
        system.assertEquals('5',controllerObj.numberOfColValues[0].getValue());
        
        system.assertEquals(system.label.PicklistDefaultLabel,controllerObj.numberOfFieldsPerColValues[0].getLabel());
        system.assertEquals('10',controllerObj.numberOfFieldsPerColValues[0].getValue());
        
        for(integer index = 1; index < controllerObj.numberOfColValues.size(); index++) {
            system.assertEquals(numberOfColumnList[index - 1].Name,controllerObj.numberOfColValues[index].getLabel());
            system.assertEquals(numberOfColumnList[index - 1].Name,controllerObj.numberOfColValues[index].getValue());
        }
    }
    
     /** 
     * @author Amruta Kumbhakarn
     * @description: get Fields Per Column for Configuration Test
     * Expected Result: Method should return all picklist values and default value from Configuration
     *                  number of fields per columns list
     * @date: 26-02-2016
     */  
    static testMethod void getFieldsPerColumnTestCase() {

        list<Number_Of_Fields_Per_Column__c> numberOfFieldPerColumnList = TestDataFactory.getNumberOfFieldPerColumnList
                                                                          (new list<string> {'6','7','8','9'});
        insert numberOfFieldPerColumnList;
        
        PageReference pageRef = Page.Configuration;
        Test.setCurrentPage(pageRef);
        
        ConfigurationController controllerObj;

        test.startTest();
        controllerObj = new ConfigurationController();
        test.stopTest();
        
        system.assertEquals(1,controllerObj.numberOfColValues.size());
        system.assertEquals(5,controllerObj.numberOfFieldsPerColValues.size());
        
        system.assertEquals(system.label.PicklistDefaultLabel,controllerObj.numberOfColValues[0].getLabel());
        system.assertEquals('5',controllerObj.numberOfColValues[0].getValue());
        
        system.assertEquals(system.label.PicklistDefaultLabel,controllerObj.numberOfFieldsPerColValues[0].getLabel());
        system.assertEquals('10',controllerObj.numberOfFieldsPerColValues[0].getValue());
        
        for(integer index = 1; index < controllerObj.numberOfFieldsPerColValues.size(); index++) {
            system.assertEquals(numberOfFieldPerColumnList[index - 1].Name,controllerObj.numberOfFieldsPerColValues[index].getLabel());
            system.assertEquals(numberOfFieldPerColumnList[index - 1].Name,controllerObj.numberOfFieldsPerColValues[index].getValue());
        }
    }
    
    
     /** 
     * @author Amruta Kumbhakarn
     * @description: get Fields Per Column for Configuration Test
     * Expected Result: Method should return all picklist values and default value from Configuration
     *                  number of fields per columns list
     * @date: 26-02-2016
     */  
    static testMethod void getBothNumberFieldsAndColumnTestCase() {

        list<Number_Of_Columns__c> numberOfColumnList = TestDataFactory.getNumberOfColumnList(new list<string> {'1','2','3','4'});
        insert numberOfColumnList;
        
        list<Number_Of_Fields_Per_Column__c> numberOfFieldPerColumnList = TestDataFactory.getNumberOfFieldPerColumnList
                                                                          (new list<string> {'6','7','8','9'});
        insert numberOfFieldPerColumnList;
        
        PageReference pageRef = Page.Configuration;
        Test.setCurrentPage(pageRef);
        
        ConfigurationController controllerObj;

        test.startTest();
        controllerObj = new ConfigurationController();
        test.stopTest();
        
        system.assertEquals(5,controllerObj.numberOfColValues.size());
        system.assertEquals(5,controllerObj.numberOfFieldsPerColValues.size());
        
        system.assertEquals(system.label.PicklistDefaultLabel,controllerObj.numberOfColValues[0].getLabel());
        system.assertEquals('5',controllerObj.numberOfColValues[0].getValue());
        
        system.assertEquals(system.label.PicklistDefaultLabel,controllerObj.numberOfFieldsPerColValues[0].getLabel());
        system.assertEquals('10',controllerObj.numberOfFieldsPerColValues[0].getValue());
        
        for(integer index = 1; index < controllerObj.numberOfColValues.size(); index++) {
            system.assertEquals(numberOfColumnList[index - 1].Name,controllerObj.numberOfColValues[index].getLabel());
            system.assertEquals(numberOfColumnList[index - 1].Name,controllerObj.numberOfColValues[index].getValue());
        }
        for(integer index = 1; index < controllerObj.numberOfFieldsPerColValues.size(); index++) {
            system.assertEquals(numberOfFieldPerColumnList[index - 1].Name,controllerObj.numberOfFieldsPerColValues[index].getLabel());
            system.assertEquals(numberOfFieldPerColumnList[index - 1].Name,controllerObj.numberOfFieldsPerColValues[index].getValue());
        }
    }
    
     /** 
     * @author Amruta Kumbhakarn
     * @description: save configuration test
     *               number of configuration inserted is one.
     *               numberOfColumns and numberOfFieldsPerColumns  with some values.
     * Expected Result: Method should update configuration record with new values.
     * @date: 26-02-2016
     */
    static testMethod void saveConfigurationTestCase1() {
    	
        Configuration__c configurationObj = TestDataFactory.getConfiguration(1, 5);
        insert configurationObj;
        
        PageReference pageRef = Page.Configuration;
        Test.setCurrentPage(pageRef);
        
        ConfigurationController controllerObj = new ConfigurationController();
        controllerObj.numberOfColumns = 4;
        controllerObj.numberOfFieldsPerColumns = 15;

        test.startTest();
        controllerObj.saveConfiguration();
        test.stopTest();
        
        Map<String,Configuration__c> mapConfig = Configuration__c.getAll();
        list<Configuration__c> configurationUpdatedList = new list<Configuration__c> 
                                                         {Configuration__c.getAll().get
                                                         (system.Label.ConfigureColsAndFieldsCustomSettingRecordName)
                                                         };
        
        system.assertNotEquals(1, configurationUpdatedList[0].Number_Of_Columns__c);
        system.assertNotEquals(5, configurationUpdatedList[0].Number_Of_Fields_Per_Column__c);
        
        system.assertEquals(4, configurationUpdatedList[0].Number_Of_Columns__c);
        system.assertEquals(15, configurationUpdatedList[0].Number_Of_Fields_Per_Column__c);
        
        ApexPages.Message[] pageMessages = ApexPages.getMessages();
        system.assertEquals(1, pageMessages.size());
        
        system.assertEquals('CONFIRM', string.valueOf(pageMessages[0].getSeverity()));
        system.assertEquals(system.label.ConfigurationMessage, pageMessages[0].getSummary());
    }
    
    /** 
     * @author Amruta Kumbhakarn
     * @description: doCancel test
     * Expected Result: Method should return on Ultra_Setup page.
     * @date: 02-03-2016
    */
    static testMethod void doCancelTestCase() {
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseForSetupController());
        PageReference pageRef = Page.Configuration;
        Test.setCurrentPage(pageRef);
       
        ConfigurationController controllerObj = new ConfigurationController();
        
        test.startTest();
        PageReference cancelUrl = controllerObj.doCancel();
        test.stopTest();
        
        system.assertEquals(pageRef.getUrl(), cancelUrl.getUrl());
    }
}