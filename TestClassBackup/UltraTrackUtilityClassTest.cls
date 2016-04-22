/**
 * Class Name: UltraTrackUtilityClassTest
 * @description: Test class for UltraTrackUtilityClass class.
 * @author: Amruta Kumbhakarn
 * @date:  1-3-2016
 * @revised:   
 */
@isTest
private class UltraTrackUtilityClassTest {
    
    /** 
	  * @author Amruta Kumbhakarn
	  * @description: getFieldNamesAndLabels test
	  *               object name is null
	  * Expected Result: Method should returned empty map for fields.
	  * @date: 1-03-2016
	  */ 
    static testMethod void getFieldNamesAndLabelsTestCase1() {
    	
    	UltraTrackUtilityClass util = new UltraTrackUtilityClass();
    	
    	test.startTest();
    	Map<String,String> fieldNameVsLabelMap = util.getFieldNamesAndLabels(null);
    	test.stopTest();
    	
    	system.assertEquals(0, fieldNameVsLabelMap.size());
    }
    
    /** 
      * @author Amruta Kumbhakarn
      * @description: getFieldNamesAndLabels test
      *               object name is not null
      * Expected Result: Method should returned map for fields.
      * @date: 1-03-2016
      */ 
    static testMethod void getFieldNamesAndLabelsTestCase2() {
        
        UltraTrackUtilityClass util = new UltraTrackUtilityClass();
        
        test.startTest();
        Map<String,String> fieldNameVsLabelMap = util.getFieldNamesAndLabels('Account');
        test.stopTest();
        
        system.assertNotEquals(0, fieldNameVsLabelMap.size());
    }
    
    /** 
      * @author Amruta Kumbhakarn
      * @description: getFieldNamesAndLabels test
      *               object name is not null but object is not present in the org.
      * Expected Result: Method should returned empty map for fields.
      * @date: 1-03-2016
      */ 
    static testMethod void getFieldNamesAndLabelsTestCase3() {
        
        UltraTrackUtilityClass util = new UltraTrackUtilityClass();
        
        test.startTest();
        Map<String,String> fieldNameVsLabelMap = util.getFieldNamesAndLabels('abc');
        test.stopTest();
        
        system.assertEquals(0, fieldNameVsLabelMap.size());
    }
    
    /** 
      * @author Amruta Kumbhakarn
      * @description: displayMessage test
      *               message is null
      * Expected Result: Method should add apex page message.
      * @date: 1-03-2016
      */ 
    static testMethod void displayMessageTestCase1() {
        
        UltraTrackUtilityClass util = new UltraTrackUtilityClass();
        
        test.startTest();
        util.displayMessage('');
        test.stopTest();
        
        ApexPages.Message[] pageMessages = ApexPages.getMessages();
        system.assertEquals(1, pageMessages.size());
        
        system.assertEquals('CONFIRM', string.valueOf(pageMessages[0].getSeverity()));
        system.assertEquals('', pageMessages[0].getSummary());
    }
    
    /** 
      * @author Amruta Kumbhakarn
      * @description: displayMessage test
      *               message is not null
      * Expected Result: Method should add apex page message.
      * @date: 1-03-2016
      */ 
    static testMethod void displayMessageTestCase2() {
        
        UltraTrackUtilityClass util = new UltraTrackUtilityClass();
        
        test.startTest();
        util.displayMessage('Record Saved.');
        test.stopTest();
        
        ApexPages.Message[] pageMessages = ApexPages.getMessages();
        system.assertEquals(1, pageMessages.size());
        
        system.assertEquals('CONFIRM', string.valueOf(pageMessages[0].getSeverity()));
        system.assertEquals('Record Saved.', pageMessages[0].getSummary());
    }
}