/**
 * Class Name: UltraSetupControllerTest
 * @description: Test class for UltraSetupController class.
 * @author: Amruta Kumbhakarn
 * @date:  26-2-2016
 * @revised:   
 */
@isTest
private class UltraSetupControllerTest {
   
   /** 
     * @author Amruta Kumbhakarn
     * @description: ultraSetupController And GetObjectList test
     *               Inserted Configuration record.
     * Expected Result: Method should assign values numberOfColumns, numberOfFieldsPerColumns,
     *                  objList and pageSize.
     * @date: 02-03-2016
    */  
   static testMethod void ultraSetupControllerAndGetObjectListTestCase1() {
    	
    	Configuration__c configurationObj = TestDataFactory.getConfiguration(4, 8);
    	insert configurationObj;
    	
    	Test.setMock(HttpCalloutMock.class, new MockHttpResponseForSetupController());
    	
        PageReference pageRef = Page.Ultra_Setup;
        Test.setCurrentPage(pageRef);
        
        test.startTest();
        UltraSetupController ultraSetupObj = new UltraSetupController();
        test.stopTest();
        
        system.assertEquals(4, ultraSetupObj.numberOfColumns);
        system.assertEquals(8, ultraSetupObj.numberOfFieldsPerColumns);
        system.assertEquals(1, ultraSetupObj.objList.size());
        system.assertEquals(32, ultraSetupObj.pageSize);
    }
    
    /** 
     * @author Amruta Kumbhakarn
     * @description: ultraSetupController And GetObjectList test
     *               Not inserted Configuration record.
     * Expected Result: Method should assign values numberOfColumns, numberOfFieldsPerColumns,
     *                  objList and pageSize.
     * @date: 02-03-2016
    */
    static testMethod void ultraSetupControllerAndGetObjectListTestCase2() {

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseForSetupController());
        
        PageReference pageRef = Page.Ultra_Setup;
        Test.setCurrentPage(pageRef);
        
        test.startTest();
        UltraSetupController ultraSetupObj = new UltraSetupController();
        test.stopTest();
        
        system.assertEquals(5, ultraSetupObj.numberOfColumns);
        system.assertEquals(10, ultraSetupObj.numberOfFieldsPerColumns);
        system.assertEquals(1, ultraSetupObj.objList.size());
        system.assertEquals(50, ultraSetupObj.pageSize);
    }
    
    /** 
     * @author Amruta Kumbhakarn
     * @description: getFieldsList test
     *               Inserted Ultra_Track_Container__c record for an object.
     *               Select an object.
     *               Two fields selected for field tracking
     * Expected Result: Method should assign values in isSelected true for 2 fields for an object.
     * @date: 02-03-2016
    */
    static testMethod void getFieldsListTestCase1() {
    	
    	list<Ultra_Track_Container__c> ultraTrackContainerList = new list<Ultra_Track_Container__c>();
    	ultraTrackContainerList.addAll(TestDataFactory.getUltraTrackContainerList(new list<string> {'Account'},
                                                                                  new list<string> {'Account'},
                                                                                  new list<boolean> {true},
                                                                                  new list<string> {'Email,Name,Phone'}
                                                                                  )
                                      );
        
        insert ultraTrackContainerList;
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseForSetupController());
        
        PageReference pageRef = Page.Ultra_Setup;
        Test.setCurrentPage(pageRef);
        
        UltraSetupController ultraSetupObj = new UltraSetupController();
        ultraSetupObj.objects = 'Account(Account)';
        test.startTest();
        ultraSetupObj.getFieldsList();
        test.stopTest();
        
        UltraTrackUtilityClass objUtility = new UltraTrackUtilityClass();
        map<string, string> fieldsForObject = objUtility.getFieldNamesAndLabels('Account');
        integer selectedFieldCount = 0;
        
        system.assertEquals(fieldsForObject.size(), ultraSetupObj.allFieldswrapperClassList.size());
        for(UltraTrackWrapper wrapper : ultraSetupObj.allFieldswrapperClassList) {
        	if(wrapper.isSelected) {
        		selectedFieldCount++;
        	}
        }
        system.assertEquals(2, selectedFieldCount);
    }
    
    /** 
     * @author Amruta Kumbhakarn
     * @description: getFieldsList test
     *               Inserted Ultra_Track_Container__c record for an object.
     *               Select an object.
     *               no fields selected for field tracking
     * Expected Result: Method should assign values in isSelected is false for all fields of an object.
     * @date: 02-03-2016
    */
     static testMethod void getFieldsListTestCase2() {
        
        list<Ultra_Track_Container__c> ultraTrackContainerList = new list<Ultra_Track_Container__c>();
        ultraTrackContainerList.addAll(TestDataFactory.getUltraTrackContainerList(new list<string> {'Account'},
                                                                                  new list<string> {'Account'},
                                                                                  new list<boolean> {true},
                                                                                  new list<string> ()
                                                                                  )
                                      );
        
        insert ultraTrackContainerList;
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseForSetupController());
        
        PageReference pageRef = Page.Ultra_Setup;
        Test.setCurrentPage(pageRef);
        
        UltraSetupController ultraSetupObj = new UltraSetupController();
        ultraSetupObj.objects = 'Account(Account)';
        test.startTest();
        ultraSetupObj.getFieldsList();
        test.stopTest();
        
        UltraTrackUtilityClass objUtility = new UltraTrackUtilityClass();
        map<string, string> fieldsForObject = objUtility.getFieldNamesAndLabels('Account');
        integer selectedFieldCount = 0;
        
        system.assertEquals(fieldsForObject.size(), ultraSetupObj.allFieldswrapperClassList.size());
        for(UltraTrackWrapper wrapper : ultraSetupObj.allFieldswrapperClassList) {
            if(wrapper.isSelected) {
                selectedFieldCount++;
            }
        }
        system.assertEquals(0, selectedFieldCount);
    }
    
    /** 
     * @author Amruta Kumbhakarn
     * @description: selectedFieldsName test
     *               Inserted Ultra_Track_Container__c record for an object.
     *               Select an object.
     *               Two fields selected for field tracking
     * Expected Result: Method should assign values for all selected fields in selectedFieldSet.
     * @date: 02-03-2016
    */
    static testMethod void selectedFieldsNameTestCase1() {
    	
    	list<Ultra_Track_Container__c> ultraTrackContainerList = new list<Ultra_Track_Container__c>();
        ultraTrackContainerList.addAll(TestDataFactory.getUltraTrackContainerList(new list<string> {'Account'},
                                                                                  new list<string> {'Account'},
                                                                                  new list<boolean> {true},
                                                                                  new list<string> {'Name,Phone'}
                                                                                  )
                                      );
        
        insert ultraTrackContainerList;
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseForSetupController());
        
        PageReference pageRef = Page.Ultra_Setup;
        Test.setCurrentPage(pageRef);
        
        UltraSetupController ultraSetupObj = new UltraSetupController();
        ultraSetupObj.objects = 'Account(Account)';
        ultraSetupObj.getFieldsList();
        
        test.startTest();
        ultraSetupObj.selectedFieldsName();
        test.stopTest();
       
        system.assertEquals(2, ultraSetupObj.selectedFieldSet.size());
    }
    
    /** 
     * @author Amruta Kumbhakarn
     * @description: selectedFieldsName test
     *               no Ultra_Track_Container__c record for an object.
     *               Select an object.
     *               no fields selected for field tracking
     * Expected Result: Method should assign values for no selected fields in selectedFieldSet.
     * @date: 02-03-2016
    */
     static testMethod void selectedFieldsNameTestCase2() {
      
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseForSetupController());
        
        PageReference pageRef = Page.Ultra_Setup;
        Test.setCurrentPage(pageRef);
        
        UltraSetupController ultraSetupObj = new UltraSetupController();
        ultraSetupObj.objects = 'Account(Account)';
        ultraSetupObj.getFieldsList();
        
        test.startTest();
        ultraSetupObj.selectedFieldsName();
        test.stopTest();
       
        system.assertEquals(0, ultraSetupObj.selectedFieldSet.size());
    }
    
    /** 
     * @author Amruta Kumbhakarn
     * @description: selectedFieldsName test
     *               no Ultra_Track_Container__c record for an object.
     *               Select an object.
     *               Two fields selected for field tracking
     * Expected Result: Method should assign values for two selected fields in selectedFieldSet.
     * @date: 02-03-2016
    */
    static testMethod void selectedFieldsNameTestCase3() {
      
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseForSetupController());
        
        PageReference pageRef = Page.Ultra_Setup;
        Test.setCurrentPage(pageRef);
        
        UltraSetupController ultraSetupObj = new UltraSetupController();
        ultraSetupObj.objects = 'Account(Account)';
        ultraSetupObj.getFieldsList();
        ultraSetupObj.allFieldswrapperClassList[0].isSelected = true;
        ultraSetupObj.allFieldswrapperClassList[1].isSelected = true;
        
        test.startTest();
        ultraSetupObj.selectedFieldsName();
        test.stopTest();
       
        system.assertEquals(2, ultraSetupObj.selectedFieldSet.size());
    }
    
    /** 
     * @author Amruta Kumbhakarn
     * @description: UpdateSetting test
     *               Inserted Ultra_Track_Container__c record for an object.
     *               Select an object.
     *               Two fields selected for field tracking
     * Expected Result: Method should update Ultra_Track_Container__c record with selected fields.
     * @date: 02-03-2016
    */
    static testMethod void UpdateSettingTestCase1() {
        
        list<Ultra_Track_Container__c> ultraTrackContainerList = new list<Ultra_Track_Container__c>();
        ultraTrackContainerList.addAll(TestDataFactory.getUltraTrackContainerList(new list<string> {'Account'},
                                                                                  new list<string> {'Account'},
                                                                                  new list<boolean> {true},
                                                                                  new list<string> {'Name,Phone'}
                                                                                  )
                                      );
        
        insert ultraTrackContainerList;
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseForSetupController());
        
        PageReference pageRef = Page.Ultra_Setup;
        Test.setCurrentPage(pageRef);
        
        UltraSetupController ultraSetupObj = new UltraSetupController();
        ultraSetupObj.objects = 'Account(Account)';
        ultraSetupObj.getFieldsList();
        ultraSetupObj.allFieldswrapperClassList[0].isSelected = true;
        ultraSetupObj.allFieldswrapperClassList[1].isSelected = true;
        
        test.startTest();
        ultraSetupObj.selectedFieldsName();
        test.stopTest();
       
        list<Ultra_Track_Container__c> updatedUltraultraTrackContainerList = [select Id, 
                                                                                     Is_Tracking_Enabled__c,
                                                                                     Tracked_Fields__c
                                                                             from Ultra_Track_Container__c
                                                                             where Id =: ultraTrackContainerList[0].Id];
        
        system.assertEquals(4, ultraSetupObj.selectedFieldSet.size());
        list<string> trackedField = updatedUltraultraTrackContainerList[0].Tracked_Fields__c.split(',');
        system.assertEquals(4, trackedField.size());
        system.assertEquals(false, ultraSetupObj.isObject);
        
    }
    
    /** 
     * @author Amruta Kumbhakarn
     * @description: UpdateSetting test
     *               Inserted Ultra_Track_Container__c record for an object.
     *               Select an object.
     *               no fields selected for field tracking
     * Expected Result: Method should update Ultra_Track_Container__c record with selected fields and Is_Tracking_Enabled__c as false.
     * @date: 02-03-2016
    */
    static testMethod void UpdateSettingTestCase2() {
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseForSetupController());
        list<Ultra_Track_Container__c> ultraTrackContainerList = new list<Ultra_Track_Container__c>();
        ultraTrackContainerList.addAll(TestDataFactory.getUltraTrackContainerList(new list<string> {'Account'},
                                                                                  new list<string> {'Account'},
                                                                                  new list<boolean> {true},
                                                                                  new list<string> ()
                                                                                  )
                                      );
        
        insert ultraTrackContainerList;

        PageReference pageRef = Page.Ultra_Setup;
        Test.setCurrentPage(pageRef);
        
        UltraSetupController ultraSetupObj = new UltraSetupController();
        ultraSetupObj.objects = 'Account(Account)';
        ultraSetupObj.getFieldsList();
        
        test.startTest();
        ultraSetupObj.selectedFieldsName();
        test.stopTest();
       
        list<Ultra_Track_Container__c> updatedUltraultraTrackContainerList = [select Id, 
                                                                                     Is_Tracking_Enabled__c,
                                                                                     Tracked_Fields__c
                                                                             from Ultra_Track_Container__c
                                                                             where Id =: ultraTrackContainerList[0].Id];
        
        system.assertEquals(0, ultraSetupObj.selectedFieldSet.size());
        system.assertEquals(null, updatedUltraultraTrackContainerList[0].Tracked_Fields__c);
        system.assertEquals(false, updatedUltraultraTrackContainerList[0].Is_Tracking_Enabled__c);
        ApexPages.Message[] pageMessages = ApexPages.getMessages();

        system.assertEquals('WARNING', string.valueOf(pageMessages[1].getSeverity()));
        system.assertEquals(system.label.Field_Not_Selected, pageMessages[1].getSummary());
        
        system.assertEquals(false, ultraSetupObj.isObject);
    }
   
    /** 
     * @author Amruta Kumbhakarn
     * @description: UpdateSetting test
     *               Inserted Ultra_Track_Container__c record for an object.
     *               Select an object.
     *               Two fields selected for field tracking
     * Expected Result: Method should update Ultra_Track_Container__c record with selected fields and Is_Tracking_Enabled__c as true.
     * @date: 02-03-2016
    */ 
   static testMethod void UpdateSettingTestCase3() {
        
        list<Ultra_Track_Container__c> ultraTrackContainerList = new list<Ultra_Track_Container__c>();
        ultraTrackContainerList.addAll(TestDataFactory.getUltraTrackContainerList(new list<string> {'Account'},
                                                                                  new list<string> {'Account'},
                                                                                  new list<boolean> {false},
                                                                                  new list<string> ()
                                                                                  )
                                      );
        
        insert ultraTrackContainerList;
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseForSetupController());
        
        PageReference pageRef = Page.Ultra_Setup;
        Test.setCurrentPage(pageRef);
        
        UltraSetupController ultraSetupObj = new UltraSetupController();
        ultraSetupObj.objects = 'Account(Account)';
        ultraSetupObj.getFieldsList();
        ultraSetupObj.allFieldswrapperClassList[0].isSelected = true;
        ultraSetupObj.allFieldswrapperClassList[1].isSelected = true;
        
        test.startTest();
        ultraSetupObj.selectedFieldsName();
        test.stopTest();
       
        list<Ultra_Track_Container__c> updatedUltraultraTrackContainerList = [select Id, 
                                                                                     Is_Tracking_Enabled__c,
                                                                                     Tracked_Fields__c
                                                                             from Ultra_Track_Container__c
                                                                             where Id =: ultraTrackContainerList[0].Id];
        
        system.assertEquals(2, ultraSetupObj.selectedFieldSet.size());
        list<string> trackedField = updatedUltraultraTrackContainerList[0].Tracked_Fields__c.split(',');
        system.assertEquals(2, trackedField.size());
        system.assertEquals(true, updatedUltraultraTrackContainerList[0].Is_Tracking_Enabled__c);
        system.assertEquals(false, ultraSetupObj.isObject);
       
    }
    
   /** 
     * @author Amruta Kumbhakarn
     * @description: saveSetting test
     *               no Ultra_Track_Container__c record for an object.
     *               Select an object.
     *               Two fields selected for field tracking
     * Expected Result: Method should insert Ultra_Track_Container__c record with selected fields and Is_Tracking_Enabled__c as true.
     * @date: 02-03-2016
    */
    static testMethod void saveSettingTestCase1() {
    	
    	Test.setMock(HttpCalloutMock.class, new MockHttpResponseForSetupController());
        
        PageReference pageRef = Page.Ultra_Setup;
        Test.setCurrentPage(pageRef);
        
        UltraSetupController ultraSetupObj = new UltraSetupController();
        ultraSetupObj.objects = 'Account(Account)';
        ultraSetupObj.getFieldsList();
        ultraSetupObj.allFieldswrapperClassList[0].isSelected = true;
        ultraSetupObj.allFieldswrapperClassList[1].isSelected = true;
        
        test.startTest();
        ultraSetupObj.selectedFieldsName();
        test.stopTest();
        
        list<Ultra_Track_Container__c> insertedUltraultraTrackContainerList = [select Id, 
                                                                                     Is_Tracking_Enabled__c,
                                                                                     Tracked_Fields__c,
                                                                                     Object_Label__c,
                                                                                     Object_Name__c
                                                                             from Ultra_Track_Container__c
                                                                             ];
                                                                             
        system.assertEquals(2, ultraSetupObj.selectedFieldSet.size());
        list<string> trackedField = insertedUltraultraTrackContainerList[0].Tracked_Fields__c.split(',');
        system.assertEquals(2, trackedField.size());
        system.assertEquals(true, insertedUltraultraTrackContainerList[0].Is_Tracking_Enabled__c);
        system.assertEquals('Account', insertedUltraultraTrackContainerList[0].Object_Name__c);
        system.assertEquals('Account(Account)', insertedUltraultraTrackContainerList[0].Object_Label__c);
        system.assertEquals(false, ultraSetupObj.isObject);
        
        ApexPages.Message[] pageMessages = ApexPages.getMessages();

        system.assertEquals('CONFIRM', string.valueOf(pageMessages[0].getSeverity()));
        system.assertEquals(system.label.Ultra_Track_Container_Save_Message1+' Account(Account) '+system.label.Ultra_Track_Container_Save_Message2, 
                            pageMessages[0].getSummary());
        
    }
   /** 
     * @author Amruta Kumbhakarn
     * @description: saveSetting test
     *               no Ultra_Track_Container__c record for an object.
     *               Select an object.
     *               no fields selected for field tracking
     * Expected Result: Method should not insert Ultra_Track_Container__c record.
     * @date: 02-03-2016
    */
      static testMethod void saveSettingTestCase2() {
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseForSetupController());
        
        PageReference pageRef = Page.Ultra_Setup;
        Test.setCurrentPage(pageRef);
        
        UltraSetupController ultraSetupObj = new UltraSetupController();
        ultraSetupObj.objects = 'Account(Account)';
        ultraSetupObj.getFieldsList();

        test.startTest();
        ultraSetupObj.selectedFieldsName();
        test.stopTest();
                                                                     
        system.assertEquals(0, ultraSetupObj.selectedFieldSet.size());

        ApexPages.Message[] pageMessages = ApexPages.getMessages();

        system.assertEquals('WARNING', string.valueOf(pageMessages[0].getSeverity()));
        system.assertEquals(system.label.Field_Not_Selected, pageMessages[0].getSummary());
        
    }
    
    /** 
     * @author Amruta Kumbhakarn
     * @description: refresh test
     *               Inserted Ultra_Track_Container__c record for an object.
     *               Select an object.
     *               Not All fields selected for field tracking
     * Expected Result: Method should assign value to false value to isAllSelected.
     * @date: 02-03-2016
    */
    static testMethod void refreshTestCase1() {
    	
    	list<Ultra_Track_Container__c> ultraTrackContainerList = new list<Ultra_Track_Container__c>();
    	
        ultraTrackContainerList.addAll(TestDataFactory.getUltraTrackContainerList(new list<string> {'Account'},
                                                                                  new list<string> {'Account'},
                                                                                  new list<boolean> {true},
                                                                                  new list<string> {'Email,Name,Phone'}
                                                                                  )
                                      );
        
        insert ultraTrackContainerList;
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseForSetupController());
        
        PageReference pageRef = Page.Ultra_Setup;
        Test.setCurrentPage(pageRef);
        
        UltraSetupController ultraSetupObj = new UltraSetupController();
        ultraSetupObj.objects = 'Account(Account)';
        test.startTest();
        ultraSetupObj.refresh();
        test.stopTest();
       
        system.assertEquals(false, ultraSetupObj.isAllSelected);
    }
    
    /** 
     * @author Amruta Kumbhakarn
     * @description: previous test
     *               Inserted Ultra_Track_Container__c record for an object.
     *               Select an object.
     *               Two All fields selected for field tracking
     * Expected Result: Method should assign value to false value to isAllSelected.
     * @date: 02-03-2016
    */
    static testMethod void previousTestCase() {
        
        list<Ultra_Track_Container__c> ultraTrackContainerList = new list<Ultra_Track_Container__c>();
        
        ultraTrackContainerList.addAll(TestDataFactory.getUltraTrackContainerList(new list<string> {'Account'},
                                                                                  new list<string> {'Account'},
                                                                                  new list<boolean> {true},
                                                                                  new list<string> {'Email,Name,Phone'}
                                                                                  )
                                      );
        
        insert ultraTrackContainerList;
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseForSetupController());
        
        PageReference pageRef = Page.Ultra_Setup;
        Test.setCurrentPage(pageRef);
        
        UltraSetupController ultraSetupObj = new UltraSetupController();
        ultraSetupObj.objects = 'Account(Account)';
        ultraSetupObj.refresh();
        test.startTest();
        ultraSetupObj.previous();
        test.stopTest();
       
        system.assertEquals(false, ultraSetupObj.isAllSelected);
    }
    
    /** 
     * @author Amruta Kumbhakarn
     * @description: previous test
     *               Inserted Ultra_Track_Container__c record for an object.
     *               Select an object.
     *               All fields selected for field tracking
     * Expected Result: Method should assign value to true value to isAllSelected.
     * @date: 02-03-2016
    */
    static testMethod void nextTestCase() {
        
        list<Ultra_Track_Container__c> ultraTrackContainerList = new list<Ultra_Track_Container__c>();
        
        Configuration__c configurationObj = TestDataFactory.getConfiguration(4, 8);
        insert configurationObj;
        
        ultraTrackContainerList.addAll(TestDataFactory.getUltraTrackContainerList(new list<string> {'Account'},
                                                                                  new list<string> {'Account'},
                                                                                  new list<boolean> {true},
                                                                                  new list<string> {'Email,Name,Phone'}
                                                                                  )
                                      );
        
        insert ultraTrackContainerList;
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseForSetupController());
        
        PageReference pageRef = Page.Ultra_Setup;
        Test.setCurrentPage(pageRef);
        
        UltraSetupController ultraSetupObj = new UltraSetupController();
        ultraSetupObj.objects = 'Account(Account)';
    
        ultraSetupObj.getFieldsList();
        
        for(integer index = 0; index < ultraSetupObj.allFieldswrapperClassList.size(); index++) {
            ultraSetupObj.allFieldswrapperClassList[index].isSelected = true;
        }
        
        test.startTest();
        ultraSetupObj.next();
        test.stopTest();
       
        system.assertEquals(true, ultraSetupObj.isAllSelected);
    }
    
    /** 
     * @author Amruta Kumbhakarn
     * @description: previous test
     *               Inserted Ultra_Track_Container__c record for an object.
     *               Select an object.
     *               All fields selected for field tracking
     * Expected Result: Method should assign value to true value to isAllSelected.
     * @date: 02-03-2016
    */
    static testMethod void lastTestCase() {
        
        list<Ultra_Track_Container__c> ultraTrackContainerList = new list<Ultra_Track_Container__c>();
        
        Configuration__c configurationObj = TestDataFactory.getConfiguration(4, 8);
        insert configurationObj;
        
        ultraTrackContainerList.addAll(TestDataFactory.getUltraTrackContainerList(new list<string> {'Account'},
                                                                                  new list<string> {'Account'},
                                                                                  new list<boolean> {true},
                                                                                  new list<string> {'Email,Name,Phone'}
                                                                                  )
                                      );
        
        insert ultraTrackContainerList;
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseForSetupController());
        
        PageReference pageRef = Page.Ultra_Setup;
        Test.setCurrentPage(pageRef);
        
        UltraSetupController ultraSetupObj = new UltraSetupController();
        ultraSetupObj.objects = 'Account(Account)';
    
        ultraSetupObj.getFieldsList();
        ultraSetupObj.totalSize = ultraSetupObj.allFieldswrapperClassList.size();
        for(integer index = 0; index < ultraSetupObj.allFieldswrapperClassList.size(); index++) {
            ultraSetupObj.allFieldswrapperClassList[index].isSelected = true;
        }
        
        test.startTest();
        ultraSetupObj.last();
        test.stopTest();
       
        system.assertEquals(true, ultraSetupObj.isAllSelected);
    }
    /** 
     * @author Amruta Kumbhakarn
     * @description: getHasPrevious test
     *               Inserted Ultra_Track_Container__c record for an object.
     *               Select an object.
     *               Two fields selected for field tracking
     *               Page in on first
     * Expected Result: Method should return true.
     * @date: 02-03-2016
    */
     static testMethod void getHasPreviousTestCase1() {
        
        list<Ultra_Track_Container__c> ultraTrackContainerList = new list<Ultra_Track_Container__c>();
        
        Configuration__c configurationObj = TestDataFactory.getConfiguration(4, 8);
        insert configurationObj;
        
        ultraTrackContainerList.addAll(TestDataFactory.getUltraTrackContainerList(new list<string> {'Account'},
                                                                                  new list<string> {'Account'},
                                                                                  new list<boolean> {true},
                                                                                  new list<string> {'Email,Name,Phone'}
                                                                                  )
                                      );
        
        insert ultraTrackContainerList;
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseForSetupController());
        
        PageReference pageRef = Page.Ultra_Setup;
        Test.setCurrentPage(pageRef);
        
        UltraSetupController ultraSetupObj = new UltraSetupController();
        ultraSetupObj.objects = 'Account(Account)';
    
        ultraSetupObj.refresh();
        
        test.startTest();
        boolean hasPrevious = ultraSetupObj.getHasPrevious();
        test.stopTest();
       
        system.assertEquals(true, hasPrevious);
     }  
    /** 
     * @author Amruta Kumbhakarn
     * @description: getHasPrevious test
     *               Inserted Ultra_Track_Container__c record for an object.
     *               Select an object.
     *               Two fields selected for field tracking
     *               Page in on next 
     * Expected Result: Method should return false.
     * @date: 02-03-2016
    */
    static testMethod void getHasPreviousTestCase2() {
        
        list<Ultra_Track_Container__c> ultraTrackContainerList = new list<Ultra_Track_Container__c>();
        
        Configuration__c configurationObj = TestDataFactory.getConfiguration(4, 8);
        insert configurationObj;
        
        ultraTrackContainerList.addAll(TestDataFactory.getUltraTrackContainerList(new list<string> {'Account'},
                                                                                  new list<string> {'Account'},
                                                                                  new list<boolean> {true},
                                                                                  new list<string> {'Email,Name,Phone'}
                                                                                  )
                                      );
        
        insert ultraTrackContainerList;
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseForSetupController());
        
        PageReference pageRef = Page.Ultra_Setup;
        Test.setCurrentPage(pageRef);
        
        UltraSetupController ultraSetupObj = new UltraSetupController();
        ultraSetupObj.objects = 'Account(Account)';
        ultraSetupObj.refresh();
        ultraSetupObj.next();

        test.startTest();
        boolean hasPrevious = ultraSetupObj.getHasPrevious();
        test.stopTest();
       
        system.assertEquals(false, hasPrevious);
    }
    
    /** 
     * @author Amruta Kumbhakarn
     * @description: getHasPrevious test
     *               Inserted Ultra_Track_Container__c record for an object.
     *               Select an object.
     *               Two fields selected for field tracking
     *               Page in on first 
     * Expected Result: Method should return false.
     * @date: 02-03-2016
    */
    static testMethod void getHasNextTestCase1() {
        
        list<Ultra_Track_Container__c> ultraTrackContainerList = new list<Ultra_Track_Container__c>();
        
        Configuration__c configurationObj = TestDataFactory.getConfiguration(4, 8);
        insert configurationObj;
        
        ultraTrackContainerList.addAll(TestDataFactory.getUltraTrackContainerList(new list<string> {'Account'},
                                                                                  new list<string> {'Account'},
                                                                                  new list<boolean> {true},
                                                                                  new list<string> {'Email,Name,Phone'}
                                                                                  )
                                      );
        
        insert ultraTrackContainerList;
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseForSetupController());
        
        PageReference pageRef = Page.Ultra_Setup;
        Test.setCurrentPage(pageRef);
        
        UltraSetupController ultraSetupObj = new UltraSetupController();
        ultraSetupObj.objects = 'Account(Account)';
    
        ultraSetupObj.refresh();
        
        test.startTest();
        boolean hasNext = ultraSetupObj.getHasNext();
        test.stopTest();
       
        system.assertEquals(false, hasNext);
    }
    
    /** 
     * @author Amruta Kumbhakarn
     * @description: getHasPrevious test
     *               Inserted Ultra_Track_Container__c record for an object.
     *               Select an object.
     *               Two fields selected for field tracking
     *               Page in on last 
     * Expected Result: Method should return true.
     * @date: 02-03-2016
    */
    static testMethod void getHasNextTestCase2() {
        
        list<Ultra_Track_Container__c> ultraTrackContainerList = new list<Ultra_Track_Container__c>();
        
        Configuration__c configurationObj = TestDataFactory.getConfiguration(4, 8);
        insert configurationObj;
        
        ultraTrackContainerList.addAll(TestDataFactory.getUltraTrackContainerList(new list<string> {'Account'},
                                                                                  new list<string> {'Account'},
                                                                                  new list<boolean> {true},
                                                                                  new list<string> {'Email,Name,Phone'}
                                                                                  )
                                      );
        
        insert ultraTrackContainerList;
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseForSetupController());
        
        PageReference pageRef = Page.Ultra_Setup;
        Test.setCurrentPage(pageRef);
        
        UltraSetupController ultraSetupObj = new UltraSetupController();
        ultraSetupObj.objects = 'Account(Account)';
        ultraSetupObj.refresh();
        ultraSetupObj.last();

        test.startTest();
        boolean hasNext = ultraSetupObj.getHasNext();
        test.stopTest();
       
        system.assertEquals(true, hasNext);
    }
    
    /** 
     * @author Amruta Kumbhakarn
     * @description: doCancel test
     * Expected Result: Method should return on Ultra_Setup page.
     * @date: 02-03-2016
    */
    static testMethod void doCancelTestCase() {
    	
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseForSetupController());
    	PageReference pageRef = Page.Ultra_Setup;
        Test.setCurrentPage(pageRef);
       
        UltraSetupController ultraSetupObj = new UltraSetupController();
    	
    	test.startTest();
        PageReference cancelUrl = ultraSetupObj.doCancel();
        test.stopTest();
        
        system.assertEquals(pageRef.getUrl(), cancelUrl.getUrl());
    }
    
    /** 
     * @author Amruta Kumbhakarn
     * @description: getCommaSepratedFields test
     *               Pass 3 string to functions
     * Expected Result: Method should return comma separated fields.
     * @date: 02-03-2016
    */
    static testMethod void getCommaSepratedFieldsTestCase1() {
    	
    	Test.setMock(HttpCalloutMock.class, new MockHttpResponseForSetupController());
        PageReference pageRef = Page.Ultra_Setup;
        Test.setCurrentPage(pageRef);
       
        UltraSetupController ultraSetupObj = new UltraSetupController();
        
        test.startTest();
        string commaSeparatedString = ultraSetupObj.getCommaSepratedFields(new set<string> {'abc','cde','fg'});
        test.stopTest();
        
        system.assertEquals('abc,cde,fg', commaSeparatedString);
    }
    
    /** 
     * @author Amruta Kumbhakarn
     * @description: getCommaSepratedFields test
     *               no string is pass
     * Expected Result: Method should return empty string.
     * @date: 02-03-2016
    */
    static testMethod void getCommaSepratedFieldsTestCase2() {
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseForSetupController());
        PageReference pageRef = Page.Ultra_Setup;
        Test.setCurrentPage(pageRef);
       
        UltraSetupController ultraSetupObj = new UltraSetupController();
        
        test.startTest();
        string commaSeparatedString = ultraSetupObj.getCommaSepratedFields(new set<string> ());
        test.stopTest();
        
        system.assertEquals('', commaSeparatedString);
    }
}