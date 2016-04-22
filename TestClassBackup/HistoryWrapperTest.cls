/**
 * Class Name: HistoryWrapperTest
 * @description: Test class for HistoryWrapper class.
 * @author: Amruta Kumbhakarn
 * @date:  26-2-2016
 * @revised:   
 */
@isTest
private class HistoryWrapperTest {
    
     /** 
     * @author Amruta Kumbhakarn
     * @description: History wrapper test
     * Expected Result: Method should assign values to all variables of class.
     * @date: 26-02-2016
     */ 
     static testMethod void historyTestCase1() {
        
      list<HistoryWrapper> historyList = new list<HistoryWrapper>();
      Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
      User u = TestDataFactory.getUser('User1', 'user1', 'test@user1.come', p.Id );
        
        
        Account accountObj = TestDataFactory.getAccount('TestAccount');
        insert accountObj;
        
        system.runAs(u) {
            
            test.startTest();
            historyList.addAll(TestDataFactory.getHistoryList(new list<string> {'2'},
                                                              new list<string> {'5'},
                                                              string.ValueOf(accountObj.Id),
                                                              UserInfo.getProfileId(),
                                                              UserInfo.getUserName(),
                                                              new list<DateTime> {DateTime.newInstance(2016, 02, 26, 20, 45, 00)},
                                                              new list<string> {'Changed from 2 to 5'}
                                                              )
                              );
            test.stopTest();
        }
        system.assertEquals(1, historyList.size());
        system.assertEquals('2', historyList[0].oldValue);
        system.assertEquals('5', historyList[0].newValue);
        system.assertEquals('test@user1.come', historyList[0].ModifiedByName);
        system.assertEquals(p.Id, historyList[0].ModifiedById);
        system.assertEquals('2/26/2016 8:45 PM', historyList[0].ModifiedDateTime);
        system.assertEquals(string.ValueOf(accountObj.Id), historyList[0].parentID);
        system.assertEquals('Changed from 2 to 5', historyList[0].action);
    }
    
     /** 
     * @author Amruta Kumbhakarn
     * @description: History wrapper sort test
     * Expected Result: Method should history wrapper record in descending order of ModifiedDatetime.
     * @date: 26-02-2016
     */
     static testMethod void historySortTestCase2() {
        
      list<HistoryWrapper> historyList = new list<HistoryWrapper>();
      Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
      User u = TestDataFactory.getUser('User2', 'user2', 'test@user2.come', p.Id );
        
        
        Account accountObj = TestDataFactory.getAccount('TestAccount');
        insert accountObj;
        
        system.runAs(u) {
            
            test.startTest();
            historyList.addAll(TestDataFactory.getHistoryList(new list<string> {'2','3','4'},
                                                              new list<string> {'5','6','7'},
                                                              string.ValueOf(accountObj.Id),
                                                              UserInfo.getProfileId(),
                                                              UserInfo.getUserName(),
                                                              new list<DateTime> {DateTime.newInstance(2016, 02, 26, 20, 45, 00), 
                                                                                  DateTime.newInstance(2016, 02, 27, 20, 45, 00),
                                                                                  DateTime.newInstance(2016, 02, 28, 20, 45, 00)},
                                                              new list<string> {'Changed from 2 to 5',
                                                                                'Changed from 3 to 6',
                                                                                'Changed from 4 to 7'}
                                                              )
                              );
            historyList.sort();
            test.stopTest();
            
            system.assertEquals('2/28/2016 8:45 PM', historyList[0].ModifiedDateTime);
            system.assertEquals('2/27/2016 8:45 PM', historyList[1].ModifiedDateTime);
            system.assertEquals('2/26/2016 8:45 PM', historyList[2].ModifiedDateTime);
            
        }
        
    }
    
    /** 
     * @author Amruta Kumbhakarn
     * @description: History wrapper sort test
     * Expected Result: Method should history wrapper record in descending order of ModifiedDatetime.
     * @date: 26-02-2016
     */
    static testMethod void historySortTestCase3() {
        
      list<HistoryWrapper> historyList = new list<HistoryWrapper>();
      Profile p = [SELECT Id FROM Profile WHERE Name='Standard User'];
      User u = TestDataFactory.getUser('User2', 'user2', 'test@user2.come', p.Id );
        
        
        Account accountObj = TestDataFactory.getAccount('TestAccount');
        insert accountObj;
        
        system.runAs(u) {
            
            test.startTest();
            historyList.addAll(TestDataFactory.getHistoryList(new list<string> {'2','3','4'},
                                                              new list<string> {'5','6','7'},
                                                              string.ValueOf(accountObj.Id),
                                                              UserInfo.getProfileId(),
                                                              UserInfo.getUserName(),
                                                              new list<DateTime> {DateTime.newInstance(2016, 02, 28, 20, 45, 00),
                                                                                  DateTime.newInstance(2016, 02, 26, 20, 45, 00), 
                                                                                  DateTime.newInstance(2016, 02, 27, 20, 45, 00)
                                                                                  },
                                                              new list<string> {'Changed from 2 to 5',
                                                                                'Changed from 3 to 6',
                                                                                'Changed from 4 to 7'}
                                                              )
                              );
            historyList.sort();
            test.stopTest();
            
            system.assertEquals('2/28/2016 8:45 PM', historyList[0].ModifiedDateTime);
            system.assertEquals('2/27/2016 8:45 PM', historyList[1].ModifiedDateTime);
            system.assertEquals('2/26/2016 8:45 PM', historyList[2].ModifiedDateTime);
            
        }
        
    }
    
}