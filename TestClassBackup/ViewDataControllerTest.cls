/**
 * Class Name: ViewDataControllerTest
 * @description: Test class for ViewDataController class.
 * @author: Amruta Kumbhakarn
 * @date:  29-2-2016
 * @revised:   
 */
@isTest
private class ViewDataControllerTest {
	
	/** 
     * @author Amruta Kumbhakarn
     * @description: getObjects test case
     *               Two object having tracking enabled.
     * Expected Result: Method should return objects who has tracking enabled.
     * @date: 29-02-2016
     */ 
	static testMethod void getObjectsTestCase1() {
		
		list<Ultra_Track_Container__c> ultraTrackContainerList = new list<Ultra_Track_Container__c>();
		
		PageReference pageRef = Page.ViewData;
        Test.setCurrentPage(pageRef);
        
        ultraTrackContainerList.addAll(TestDataFactory.getUltraTrackContainerList(new list<string> {'Work__c','Opportunity'},
                                                                                  new list<string> {'Work','Opportunity'},
                                                                                  new list<boolean> {true, true},
                                                                                  new list<string> {'Email,Name', 'Name'}
                                                                                  )
                                      );
        
        insert ultraTrackContainerList;
        ultraTrackContainerList.sort();
        
        ViewDataController viewDataObj = new ViewDataController();
        
        test.startTest();
        List<SelectOption> objectList = viewDataObj.getObjects();
        test.stopTest();
        
        system.assertEquals(3, objectList.size());
        system.assertEquals('', objectList[0].getValue());
        for(integer index = 1; index < objectList.size(); index++) {
        	system.assertEquals(ultraTrackContainerList[index-1].Object_Name__c, objectList[index].getValue());
        }
	}
	
	/** 
     * @author Amruta Kumbhakarn
     * @description: getObjects test case
     *               No object having tracking enabled.
     * Expected Result: Method should return no objects. 
     * @date: 29-02-2016
     */
	static testMethod void getObjectsTestCase2() {
        
        list<Ultra_Track_Container__c> ultraTrackContainerList = new list<Ultra_Track_Container__c>();
        
        PageReference pageRef = Page.ViewData;
        Test.setCurrentPage(pageRef);
        
        ultraTrackContainerList.addAll(TestDataFactory.getUltraTrackContainerList(new list<string> {'Work__c','Opportunity'},
                                                                                  new list<string> {'Work','Opportunity'},
                                                                                  new list<boolean> {false, false},
                                                                                  new list<string> {'Email,Name', 'Name'}
                                                                                  )
                                      );
        
        insert ultraTrackContainerList;
        
        ViewDataController viewDataObj = new ViewDataController();
        
        test.startTest();
        List<SelectOption> objectList = viewDataObj.getObjects();
        test.stopTest();
        
        system.assertEquals(1, objectList.size());
        system.assertEquals('', objectList[0].getValue());
    }
    
    /** 
     * @author Amruta Kumbhakarn
     * @description: getObjects test case
     *               one object having tracking enabled and one object with no tracking enabled.
     * Expected Result: Method should return objects who has tracking enabled.
     * @date: 29-02-2016
     */
    static testMethod void getObjectsTestCase3() {
        
        list<Ultra_Track_Container__c> ultraTrackContainerList = new list<Ultra_Track_Container__c>();
        
        PageReference pageRef = Page.ViewData;
        Test.setCurrentPage(pageRef);
        
        ultraTrackContainerList.addAll(TestDataFactory.getUltraTrackContainerList(new list<string> {'Work__c','Opportunity'},
                                                                                  new list<string> {'Work','Opportunity'},
                                                                                  new list<boolean> {true, false},
                                                                                  new list<string> {'Email,Name', 'Name'}
                                                                                  )
                                      );
        
        insert ultraTrackContainerList;
        
        ViewDataController viewDataObj = new ViewDataController();
        
        test.startTest();
        List<SelectOption> objectList = viewDataObj.getObjects();
        test.stopTest();
        
        system.assertEquals(2, objectList.size());
        system.assertEquals('', objectList[0].getValue());
        system.assertEquals('Work__c', objectList[1].getValue());
    }
    
    /** 
     * @author Amruta Kumbhakarn
     * @description: getshowTrackHistoryData test case
     *               No History records present for selected object.
     *               startDate and endDate is null.
     * Expected Result: Method should return empty map of recordVsHiatoryRecord.
     * @date: 29-02-2016
     */
    static testMethod void getshowTrackHistoryDataTestCase1() {
    	
    	list<Ultra_Track_Container__c> ultraTrackContainerList = new list<Ultra_Track_Container__c>();
    	list<Attachment> attachmentList = new list<Attachment>();
    	
    	PageReference pageRef = Page.ViewData;
        Test.setCurrentPage(pageRef);
        
        ultraTrackContainerList.addAll(TestDataFactory.getUltraTrackContainerList(new list<string> {'Account','Opportunity'},
                                                                                  new list<string> {'Account','Opportunity'},
                                                                                  new list<boolean> {true, false},
                                                                                  new list<string> {'Email__c,Name', 'Name'}
                                                                                  )
                                      );
        
        insert ultraTrackContainerList;
        
        string attachmentBodyForAccount = '{"Email__c":{"lstHistory":[],"fieldLabel":"Email","fieldApiName":"Email__c"},"Name":{"lstHistory":[],"fieldLabel":"details","fieldApiName":"Name"}}';
        string attachmentBodyForOpportunity = '{"Name":{"lstHistory":[],"fieldLabel":"details","fieldApiName":"Name"}}';
        
        attachmentList.addAll(TestDataFactory.getAttachementList(new list<string> {'UltraHistoryDataAccount',
        	                                                                       'UltraHistoryDataOpportunity'},
                                                                 new list<blob> {blob.valueOf(attachmentBodyForAccount),
                                                                                 blob.valueOf(attachmentBodyForOpportunity)},
                                                                 new list<Id> {ultraTrackContainerList[0].Id,
                                                                               ultraTrackContainerList[1].Id}
                                                                )
                             );
        insert attachmentList;
        
        ViewDataController viewDataObj = new ViewDataController();
        viewDataObj.selectedObject = 'Account';
        viewDataObj.getObjects();
        
        test.startTest();
        viewDataObj.getshowTrackHistoryData();
        test.stopTest();
        
        system.assertEquals(0, viewDataObj.recordIdVsUltraTrackWrapperMap.size());
        system.assertEquals(0, viewDataObj.IdVsAccountNameMap.size());
    }
    
     /** 
     * @author Amruta Kumbhakarn
     * @description: getshowTrackHistoryData test case
     *               History records present for selected object.
     *               startDate and endDate is null.
     * Expected Result: Method should return map of recordVsHiatoryRecord.
     * @date: 29-02-2016
     */
     static testMethod void getshowTrackHistoryDataTestCase2() {
        
        list<Ultra_Track_Container__c> ultraTrackContainerList = new list<Ultra_Track_Container__c>();
        list<Attachment> attachmentList = new list<Attachment>();
        list<HistoryWrapper> historyList = new list<HistoryWrapper>();
        
        PageReference pageRef = Page.ViewData;
        Test.setCurrentPage(pageRef);
        
        Account accountObj = TestDataFactory.getAccount('TestAccount');
        insert accountObj;
        
        ultraTrackContainerList.addAll(TestDataFactory.getUltraTrackContainerList(new list<string> {'Account','Opportunity'},
                                                                                  new list<string> {'Account','Opportunity'},
                                                                                  new list<boolean> {true, false},
                                                                                  new list<string> {'Email__c,Name', 'Name'}
                                                                                  )
                                      );
        
        insert ultraTrackContainerList;
        
        historyList.addAll(TestDataFactory.getHistoryList(new list<string> {'a@b.com','c@b.com'},
                                                          new list<string> {'c@b.com','a@b.com'},
                                                          string.ValueOf(accountObj.Id),
                                                          null,
                                                          null,
                                                          new list<DateTime> {DateTime.newInstance(2016, 02, 26, 20, 45, 00),
                                                                             DateTime.newInstance(2016, 02, 27, 20, 45, 00)},
                                                          new list<string> {'Changed from a@b.com to c@b.com', 'Changed from c@b.com to a@b.com'}
                                                         )
                           );
        string attachmentBodyForAccount = '{"Email__c":{"lstHistory":' + System.JSON.serialize(historyList); 
        attachmentBodyForAccount += ',"fieldLabel":"Email","fieldApiName":"Email__c"},"Name":{"lstHistory":[],"fieldLabel":"details","fieldApiName":"Name"}}';
        string attachmentBodyForOpportunity = '{"Name":{"lstHistory":[],"fieldLabel":"details","fieldApiName":"Name"}}';
        system.debug('DDDDD'+attachmentBodyForAccount);
        attachmentList.addAll(TestDataFactory.getAttachementList(new list<string> {'UltraHistoryDataAccount',
                                                                                   'UltraHistoryDataOpportunity'},
                                                                 new list<blob> {blob.valueOf(attachmentBodyForAccount),
                                                                                 blob.valueOf(attachmentBodyForOpportunity)},
                                                                 new list<Id> {ultraTrackContainerList[0].Id,
                                                                               ultraTrackContainerList[1].Id}
                                                                )
                             );
        insert attachmentList;
        
        ViewDataController viewDataObj = new ViewDataController();
        viewDataObj.selectedObject = 'Account';
        viewDataObj.getObjects();
        
        test.startTest();
        viewDataObj.getshowTrackHistoryData();
        test.stopTest();
        
        system.assertEquals(1, viewDataObj.IdVsAccountNameMap.size());
        system.assertEquals(1, viewDataObj.recordIdVsUltraTrackWrapperMap.size());
        system.assertEquals(2, viewDataObj.recordIdVsUltraTrackWrapperMap.get(accountObj.Id).size());
    }
    
     /** 
     * @author Amruta Kumbhakarn
     * @description: getshowTrackHistoryData test case
     *               History records present for selected object.
     *               startDate is not null and endDate is null.
     * Expected Result: Method should return empty map of recordVsHiatoryRecord.
     * @date: 29-02-2016
     */
    static testMethod void getshowTrackHistoryDataTestCase3() {
        
        list<Ultra_Track_Container__c> ultraTrackContainerList = new list<Ultra_Track_Container__c>();
        list<Attachment> attachmentList = new list<Attachment>();
        list<HistoryWrapper> historyList = new list<HistoryWrapper>();
        
        PageReference pageRef = Page.ViewData;
        Test.setCurrentPage(pageRef);
        
        Account accountObj = TestDataFactory.getAccount('TestAccount');
        insert accountObj;
        
        ultraTrackContainerList.addAll(TestDataFactory.getUltraTrackContainerList(new list<string> {'Opportunity','Account'},
                                                                                  new list<string> {'Opportunity','Account'},
                                                                                  new list<boolean> {true, true},
                                                                                  new list<string> {'Email__c,Name', 'Name'}
                                                                                  )
                                      );
        
        insert ultraTrackContainerList;
        
        historyList.addAll(TestDataFactory.getHistoryList(new list<string> {'a@b.com','c@b.com'},
                                                          new list<string> {'c@b.com','a@b.com'},
                                                          string.ValueOf(accountObj.Id),
                                                          null,
                                                          null,
                                                          new list<DateTime> {system.now(),
                                                                             system.now()+1},
                                                          new list<string> {'Changed from a@b.com to c@b.com', 'Changed from c@b.com to a@b.com'}
                                                         )
                           );
        string attachmentBodyForAccount = '{"Name":{"lstHistory":'+ System.JSON.serialize(historyList) + ',"fieldLabel":"details","fieldApiName":"Name"}}' ; 
        string attachmentBodyForOpportunity = '{"Email__c":{"lstHistory":[],"fieldLabel":"Email","fieldApiName":"Email__c"},"Name":{"lstHistory":[],"fieldLabel":"details","fieldApiName":"Name"}}';
        attachmentList.addAll(TestDataFactory.getAttachementList(new list<string> {'UltraHistoryDataAccount',
                                                                                   'UltraHistoryDataOpportunity'},
                                                                 new list<blob> {blob.valueOf(attachmentBodyForOpportunity),
                                                                                 blob.valueOf(attachmentBodyForAccount)},
                                                                 new list<Id> {ultraTrackContainerList[0].Id,
                                                                               ultraTrackContainerList[1].Id}
                                                                )
                             );
        insert attachmentList;
        
        
        ViewDataController viewDataObj = new ViewDataController();
        viewDataObj.selectedObject = 'Account';
        viewDataObj.startDate = Date.Today();
        viewDataObj.getObjects();
        
        test.startTest();
        viewDataObj.getshowTrackHistoryData();
        test.stopTest();
        
        system.assertEquals(1, viewDataObj.IdVsAccountNameMap.size());
        system.assertEquals(1, viewDataObj.recordIdVsUltraTrackWrapperMap.size());
        system.assertEquals(2, viewDataObj.recordIdVsUltraTrackWrapperMap.get(accountObj.Id).size());
    }
    
     /** 
     * @author Amruta Kumbhakarn
     * @description: getshowTrackHistoryData test case
     *               History records present for selected object.
     *               startDate and endDate is not null.
     * Expected Result: Method should return empty map of recordVsHiatoryRecord.
     * @date: 29-02-2016
     */
    static testMethod void getshowTrackHistoryDataTestCase4() {
        
        list<Ultra_Track_Container__c> ultraTrackContainerList = new list<Ultra_Track_Container__c>();
        list<Attachment> attachmentList = new list<Attachment>();
        list<HistoryWrapper> historyList = new list<HistoryWrapper>();
        
        PageReference pageRef = Page.ViewData;
        Test.setCurrentPage(pageRef);
        
        Account accountObj = TestDataFactory.getAccount('TestAccount');
        insert accountObj;
        
        ultraTrackContainerList.addAll(TestDataFactory.getUltraTrackContainerList(new list<string> {'Opportunity','Account'},
                                                                                  new list<string> {'Opportunity','Account'},
                                                                                  new list<boolean> {true, true},
                                                                                  new list<string> {'Email__c,Name', 'Name'}
                                                                                  )
                                      );
        
        insert ultraTrackContainerList;
        
        historyList.addAll(TestDataFactory.getHistoryList(new list<string> {'a@b.com','c@b.com'},
                                                          new list<string> {'c@b.com','a@b.com'},
                                                          string.ValueOf(accountObj.Id),
                                                          null,
                                                          null,
                                                          new list<DateTime> {system.now(),
                                                                             system.now()+1},
                                                          new list<string> {'Changed from a@b.com to c@b.com', 'Changed from c@b.com to a@b.com'}
                                                         )
                           );
        string attachmentBodyForAccount = '{"Name":{"lstHistory":'+ System.JSON.serialize(historyList) + ',"fieldLabel":"details","fieldApiName":"Name"}}' ; 
        string attachmentBodyForOpportunity = '{"Email__c":{"lstHistory":[],"fieldLabel":"Email","fieldApiName":"Email__c"},"Name":{"lstHistory":[],"fieldLabel":"details","fieldApiName":"Name"}}';
        attachmentList.addAll(TestDataFactory.getAttachementList(new list<string> {'UltraHistoryDataAccount',
                                                                                   'UltraHistoryDataOpportunity'},
                                                                 new list<blob> {blob.valueOf(attachmentBodyForOpportunity),
                                                                                 blob.valueOf(attachmentBodyForAccount)},
                                                                 new list<Id> {ultraTrackContainerList[0].Id,
                                                                               ultraTrackContainerList[1].Id}
                                                                )
                             );
        insert attachmentList;
        
        
        
        ViewDataController viewDataObj = new ViewDataController();
        viewDataObj.selectedObject = 'Account';
        viewDataObj.startDate = Date.Today();
        viewDataObj.endDate = Date.Today().addDays(1);
        viewDataObj.getObjects();

        test.startTest();
        viewDataObj.getshowTrackHistoryData();
        test.stopTest();
        
        system.assertEquals(1, viewDataObj.IdVsAccountNameMap.size());
        system.assertEquals(1, viewDataObj.recordIdVsUltraTrackWrapperMap.size());
        system.assertEquals(2, viewDataObj.recordIdVsUltraTrackWrapperMap.get(accountObj.Id).size());
    }
    
     /** 
     * @author Amruta Kumbhakarn
     * @description: getshowTrackHistoryData test case
     *               No History records present for selected object.
     *               startDate is null and endDate is not null.
     * Expected Result: Method should return empty map of recordVsHiatoryRecord.
     * @date: 29-02-2016
     */
    static testMethod void getshowTrackHistoryDataTestCase5() {
        
        list<Ultra_Track_Container__c> ultraTrackContainerList = new list<Ultra_Track_Container__c>();
        list<Attachment> attachmentList = new list<Attachment>();
        list<HistoryWrapper> historyList = new list<HistoryWrapper>();
        
        PageReference pageRef = Page.ViewData;
        Test.setCurrentPage(pageRef);
        
        Account accountObj = TestDataFactory.getAccount('TestAccount');
        insert accountObj;
        
        ultraTrackContainerList.addAll(TestDataFactory.getUltraTrackContainerList(new list<string> {'Opportunity','Account'},
                                                                                  new list<string> {'Opportunity','Account'},
                                                                                  new list<boolean> {true, true},
                                                                                  new list<string> {'Email__c,Name', 'Name'}
                                                                                  )
                                      );
        
        insert ultraTrackContainerList;
        
        historyList.addAll(TestDataFactory.getHistoryList(new list<string> {'a@b.com','c@b.com'},
                                                          new list<string> {'c@b.com','a@b.com'},
                                                          string.ValueOf(accountObj.Id),
                                                          null,
                                                          null,
                                                          new list<DateTime> {system.now(),
                                                                             system.now()+1},
                                                          new list<string> {'Changed from a@b.com to c@b.com', 'Changed from c@b.com to a@b.com'}
                                                         )
                           );
        string attachmentBodyForAccount = '{"Name":{"lstHistory":'+ System.JSON.serialize(historyList) + ',"fieldLabel":"details","fieldApiName":"Name"}}' ; 
        string attachmentBodyForOpportunity = '{"Email__c":{"lstHistory":[],"fieldLabel":"Email","fieldApiName":"Email__c"},"Name":{"lstHistory":[],"fieldLabel":"details","fieldApiName":"Name"}}';
        attachmentList.addAll(TestDataFactory.getAttachementList(new list<string> {'UltraHistoryDataAccount',
                                                                                   'UltraHistoryDataOpportunity'},
                                                                 new list<blob> {blob.valueOf(attachmentBodyForOpportunity),
                                                                                 blob.valueOf(attachmentBodyForAccount)},
                                                                 new list<Id> {ultraTrackContainerList[0].Id,
                                                                               ultraTrackContainerList[1].Id}
                                                                )
                             );
        insert attachmentList;
        
        
        
        ViewDataController viewDataObj = new ViewDataController();
        viewDataObj.selectedObject = 'Account';
        viewDataObj.endDate = Date.Today();
        viewDataObj.getObjects();

        test.startTest();
        viewDataObj.getshowTrackHistoryData();
        test.stopTest();
        
        system.assertEquals(1, viewDataObj.IdVsAccountNameMap.size());
        system.assertEquals(1, viewDataObj.recordIdVsUltraTrackWrapperMap.size());
        system.assertEquals(1, viewDataObj.recordIdVsUltraTrackWrapperMap.get(accountObj.Id).size());
    }
    
    /** 
     * @author Amruta Kumbhakarn
     * @description: getRendered test case
     *               IdVsAccountNameMap is empty
     * Expected Result: Method should return false.
     * @date: 29-02-2016
     */
    static testMethod void getRenderedTestCase1() {
    	
    	PageReference pageRef = Page.ViewData;
        Test.setCurrentPage(pageRef);
        
    	ViewDataController viewDataObj = new ViewDataController();
    	
    	test.startTest();
        boolean check = viewDataObj.getRendered();
        test.stopTest();
        
        system.assertEquals(false, check);
    }
    
    /** 
     * @author Amruta Kumbhakarn
     * @description: getRendered test case
     *               IdVsAccountNameMap is not empty
     * Expected Result: Method should return true.
     * @date: 29-02-2016
     */
    static testMethod void getRenderedTestCase2() {
        
        PageReference pageRef = Page.ViewData;
        Test.setCurrentPage(pageRef);
        
        Account accountObj = TestDataFactory.getAccount('TestAccount');
        insert accountObj;
        
        ViewDataController viewDataObj = new ViewDataController();
        viewDataObj.IdVsAccountNameMap.put(accountObj.Id, accountObj.Name);
        
        test.startTest();
        boolean check = viewDataObj.getRendered();
        test.stopTest();
        
        system.assertEquals(true, check);
    }
    
    /** 
     * @author Amruta Kumbhakarn
     * @description: redirectToUser test case
     *               redirectToUserId is not empty
     * Expected Result: Method should return url to redirect to user.
     * @date: 29-02-2016
     */
    static testMethod void redirectToUserTestCase1() {
    	Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User u = TestDataFactory.getUser('User2', 'user2', 'test@user2.come', p.Id );
        
        PageReference redirectToUser;
        ViewDataController viewDataObj = new ViewDataController();
        
        system.runAs(u) {
        	viewDataObj.redirectToUserId = UserInfo.getUserId();
        	test.startTest();
            redirectToUser = viewDataObj.redirectToUser();
            test.stopTest();
        }
        system.assertEquals(URL.getSalesforceBaseUrl().toExternalForm() + '/' + viewDataObj.redirectToUserId, redirectToUser.getUrl());
    }
    
     /** 
     * @author Amruta Kumbhakarn
     * @description: redirectToUser test case
     *               redirectToUserId is empty
     * Expected Result: Method should return null.
     * @date: 29-02-2016
     */
    static testMethod void redirectToUserTestCase2() {
        
        PageReference redirectToUser;
        ViewDataController viewDataObj = new ViewDataController();

        test.startTest();
        redirectToUser = viewDataObj.redirectToUser();
        test.stopTest();
        
        system.assertEquals(null, redirectToUser);
    }

}