/**
 * Class Name: DynamicTriggerGeneratorTest
 * @description: Test class for DynamicTriggerGenerator class.
 * @author: Amruta Kumbhakarn
 * @date:  1-3-2016
 * @revised:   
 */
@isTest
private class DynamicTriggerGeneratorTest {
	
	/** 
     * @author Amruta Kumbhakarn
     * @description: checkTriggerExistOrNot test
     *               pass triggerName which are already present in org.
     * Expected Result: Method should check if trigger if already present or not.
     * @date: 1-03-2016
     */ 
	static testMethod void checkTriggerExistOrNotTestCase1() {
		
		test.startTest();
		boolean triggerExistOrNot = DynamicTriggerGenerator.checkTriggerExistOrNot('UltraTrackContainerTrigger');
		test.stopTest();
		
		system.assertEquals(true, triggerExistOrNot);
	}
	
	/** 
     * @author Amruta Kumbhakarn
     * @description: checkTriggerExistOrNot test
     *               pass triggerName which are not present in org.
     * Expected Result: Method should check if trigger if already present or not.
     * @date: 1-03-2016
     */ 
	static testMethod void checkTriggerExistOrNotTestCase2() {
        
        test.startTest();
        boolean triggerExistOrNot = DynamicTriggerGenerator.checkTriggerExistOrNot('abc');
        test.stopTest();
        
        system.assertEquals(false, triggerExistOrNot);
    }
    
    /** 
     * @author Amruta Kumbhakarn
     * @description: generateDynamicTrigger test
     *               pass triggerName which are already present in org.
     * Expected Result: Method should check if trigger is created or not.
     * @date: 1-03-2016
     */ 
    static testMethod void generateDynamicTriggerTestCase1() {
    	
    	Test.setMock(HttpCalloutMock.class, new MockHttpResponseDyanamicTriggerGenrator());
    	Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User u = TestDataFactory.getUser('User1', 'user1', 'test@user1.come', p.Id );
        
        system.runAs(u) {
        	test.startTest();
        	DynamicTriggerGenerator.generateDynamicTrigger('Account', UserInfo.getSessionId());
        	test.stopTest();
        }
    	
    	system.assertEquals(null, DynamicTriggerGenerator.res);
    }
    
    /** 
     * @author Amruta Kumbhakarn
     * @description: generateDynamicTrigger test
     *               pass triggerName which are not present in org.
     * Expected Result: Method should check if trigger is created or not.
     * @date: 1-03-2016
     */ 
    static testMethod void generateDynamicTriggerTestCase2() {
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseDyanamicTriggerGenrator());
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User u = TestDataFactory.getUser('User1', 'user1', 'test@user1.come', p.Id );
        
        system.runAs(u) {
            test.startTest();
            DynamicTriggerGenerator.generateDynamicTrigger('Opportunity', UserInfo.getSessionId());
            test.stopTest();
        }
        
        map<string,Object> resultList =  (map<string,Object>) JSON.deserializeUntyped(DynamicTriggerGenerator.res.getBody());
        system.assertEquals(true, resultList.get('success'));
            
    }
    
    /** 
     * @author Amruta Kumbhakarn
     * @description: createTrigger test
     *               pass triggerName and session id as null.
     * Expected Result: Method should check if trigger is created or not.
     * @date: 1-03-2016
     */ 
    static testMethod void createTriggerTestCase1() {
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseDyanamicTriggerGenrator());
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
        User u = TestDataFactory.getUser('User1', 'user1', 'test@user1.come', p.Id );
        
        system.runAs(u) {
            test.startTest();
            DynamicTriggerGenerator.createTrigger(null, null);
            test.stopTest();
        }
        
       system.assertEquals(null, DynamicTriggerGenerator.res);
            
    }
}