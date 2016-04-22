/**
 * Class Name: DynamicTriggerGenericHandlerTest
 * @description: Test class for DynamicTriggerGenericHandler class.
 * @author: Amruta Kumbhakarn
 * @date:  03-03-2016
 * @revised:   
 */
@isTest
private class DynamicTriggerGenericHandlerTest {
    
   static testMethod void getUserNameFromIDTestCase1() {
      Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
      User u = TestDataFactory.getUser('User1', 'user1', 'test@user1.come', p.Id );
      
      string userName;
      
      system.runAs(u) {
      	test.startTest();
      	userName = DynamicTriggerGenericHandler.getUserNameFromID(UserInfo.getUserId());
      	test.stopTest();
      }
      
      system.assertEquals('User1', userName);
   }
   
   static testMethod void getUserNameFromIDTestCase2() {

      string userName;

      test.startTest();
      userName = DynamicTriggerGenericHandler.getUserNameFromID(null);
      test.stopTest();
      
      system.assertEquals('', userName);
   }
   
   static testMethod void generateActionStringTestCase1() {

      string actionString;

      test.startTest();
      actionString = DynamicTriggerGenericHandler.generateActionString('Email', 'a@b.com','b@c.com');
      test.stopTest();
      
      system.assertEquals('Changed <b>Email From</b> a@b.com To <b>b@c.com</b>', actionString);
   }
   
   static testMethod void generateActionStringTestCase2() {

      string actionString;

      test.startTest();
      actionString = DynamicTriggerGenericHandler.generateActionString('', 'a@b.com','b@c.com');
      test.stopTest();
      
      system.assertEquals(null, actionString);
   }
   
   static testMethod void generateActionStringTestCase3() {

      string actionString;

      test.startTest();
      actionString = DynamicTriggerGenericHandler.generateActionString('Email', '','b@c.com');
      test.stopTest();
      
      system.assertEquals('Changed <b>Email From</b>  To <b>b@c.com</b>', actionString);
   }
   
   static testMethod void generateActionStringTestCase4() {

      string actionString;

      test.startTest();
      actionString = DynamicTriggerGenericHandler.generateActionString('Email', 'a@b.com','');
      test.stopTest();
      
      system.assertEquals('Changed <b>Email From</b> a@b.com To <b></b>', actionString);
   }
   
   static testMethod void onUpdateStoreHistoryDataTestCase1() {
      
      list<Ultra_Track_Container__c> ultraTrackContainerList = new list<Ultra_Track_Container__c>();
      list<Attachment> attachmentList = new list<Attachment>();
      list<Account> accountList = new list<Account>();
      
      Account accObj = TestDataFactory.getAccount('Test Account');
      insert accObj;
      
      accountList.add(accObj);
      accObj.Phone = '12345';
      accObj.Name = 'Test';
      update accObj;
      
      accountList.add(new Account(Id = accObj.Id));

      ultraTrackContainerList.addAll(TestDataFactory.getUltraTrackContainerList(new list<string> {'Account'},
                                                                                  new list<string> {'Account'},
                                                                                  new list<boolean> {true},
                                                                                  new list<string> {'Phone,Name'}
                                                                                  )
                                      );
        
      insert ultraTrackContainerList;
      
      string attachmentBodyForAccount = '{"Phone":{"lstHistory":[],"fieldLabel":"Phone","fieldApiName":"Phone"},"Name":{"lstHistory":[],"fieldLabel":"details","fieldApiName":"Name"}}';
      attachmentList.addAll(TestDataFactory.getAttachementList(new list<string> {'UltraHistoryDataAccount'},
                                                                 new list<blob> {blob.valueOf(attachmentBodyForAccount)},
                                                                 new list<Id> {ultraTrackContainerList[0].Id}
                                                                )
                             );
       insert attachmentList;
       
       DynamicTriggerGenericHandler dynamicTriggerHandlerObj = new DynamicTriggerGenericHandler();
       test.startTest();
       dynamicTriggerHandlerObj.onUpdateStoreHistoryData(new Map<Id, Sobject> {accountList[0].Id => (sObject)accountList[0]},
                                                        new Map<Id, Sobject> {accountList[1].Id => (sObject)accountList[1]},
                                                        'Account'
                                                        );
       test.stopTest();
       
       List<Attachment> updatedAttchmentList = [select Id, Body
                                               from Attachment
                                               where ParentId =: ultraTrackContainerList[0].Id
                                               ];
       map<String,UltraTrackWrapper> ultraTrackWapperMap = (map<String,UltraTrackWrapper>)
                                                            System.JSON.deserialize(updatedAttchmentList[0].body.toString(), 
                                                            map<String,UltraTrackWrapper>.class);
       system.assertEquals(1, ultraTrackWapperMap.get('Name').lstHistory.size());
       system.assertEquals(1, ultraTrackWapperMap.get('Phone').lstHistory.size());
   }
   
    static testMethod void onUpdateStoreHistoryDataTestCase2() {
      
      list<Ultra_Track_Container__c> ultraTrackContainerList = new list<Ultra_Track_Container__c>();
      list<Attachment> attachmentList = new list<Attachment>();
      list<Account> accountList = new list<Account>();
      
      Account accObj = TestDataFactory.getAccount('Test Account');
      insert accObj;
      
      accountList.add(accObj);
      accObj.Phone = '12345';
      accObj.Name = 'Test';
      update accObj;
      
      accountList.add(new Account(Id = accObj.Id));

      ultraTrackContainerList.addAll(TestDataFactory.getUltraTrackContainerList(new list<string> {'Account'},
                                                                                  new list<string> {'Account'},
                                                                                  new list<boolean> {true},
                                                                                  new list<string> {'Phone,Name'}
                                                                                  )
                                      );
        
      insert ultraTrackContainerList;
     
       DynamicTriggerGenericHandler dynamicTriggerHandlerObj = new DynamicTriggerGenericHandler();
       test.startTest();
       dynamicTriggerHandlerObj.onUpdateStoreHistoryData(new Map<Id, Sobject> {accountList[0].Id => (sObject)accountList[0]},
                                                        new Map<Id, Sobject> {accountList[1].Id => (sObject)accountList[1]},
                                                        'Account'
                                                        );
       test.stopTest();
       
       List<Attachment> updatedAttchmentList = [select Id, Body
                                               from Attachment
                                               where ParentId =: ultraTrackContainerList[0].Id
                                               ];
       map<String,UltraTrackWrapper> ultraTrackWapperMap = (map<String,UltraTrackWrapper>)
                                                            System.JSON.deserialize(updatedAttchmentList[0].body.toString(), 
                                                            map<String,UltraTrackWrapper>.class);
       system.assertEquals(1, ultraTrackWapperMap.get('Name').lstHistory.size());
       system.assertEquals(1, ultraTrackWapperMap.get('Phone').lstHistory.size());
   }
   
   static testMethod void onUpdateStoreHistoryDataTestCase3() {
      
      list<Ultra_Track_Container__c> ultraTrackContainerList = new list<Ultra_Track_Container__c>();
      list<Attachment> attachmentList = new list<Attachment>();
      list<Account> accountList = new list<Account>();
      
      Account accObj = TestDataFactory.getAccount('Test Account');
      insert accObj;
      
      accountList.add(accObj);

      ultraTrackContainerList.addAll(TestDataFactory.getUltraTrackContainerList(new list<string> {'Account'},
                                                                                  new list<string> {'Account'},
                                                                                  new list<boolean> {true},
                                                                                  new list<string> {'Phone,Name'}
                                                                                  )
                                      );
        
      insert ultraTrackContainerList;
      
      string attachmentBodyForAccount = '{"Phone":{"lstHistory":[],"fieldLabel":"Phone","fieldApiName":"Phone"}}';
      attachmentList.addAll(TestDataFactory.getAttachementList(new list<string> {'UltraHistoryDataAccount'},
                                                                 new list<blob> {blob.valueOf(attachmentBodyForAccount)},
                                                                 new list<Id> {ultraTrackContainerList[0].Id}
                                                                )
                             );
       insert attachmentList;
       
       DynamicTriggerGenericHandler dynamicTriggerHandlerObj = new DynamicTriggerGenericHandler();
       test.startTest();
       dynamicTriggerHandlerObj.onUpdateStoreHistoryData(new Map<Id, Sobject> {accountList[0].Id => (sObject)accountList[0]},
                                                        new Map<Id, Sobject> {accountList[0].Id => (sObject)accountList[0]},
                                                        'Account'
                                                        );
       test.stopTest();
       
       List<Attachment> updatedAttchmentList = [select Id, Body
                                               from Attachment
                                               where ParentId =: ultraTrackContainerList[0].Id
                                               ];
       map<String,UltraTrackWrapper> ultraTrackWapperMap = (map<String,UltraTrackWrapper>)
                                                            System.JSON.deserialize(updatedAttchmentList[0].body.toString(), 
                                                            map<String,UltraTrackWrapper>.class);
       system.assertEquals(0, ultraTrackWapperMap.get('Name').lstHistory.size());
       system.assertEquals(0, ultraTrackWapperMap.get('Phone').lstHistory.size());
   }
}