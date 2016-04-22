/**
 * Class Name: UltraTrackWrapperTest
 * @description: Test class for UltraTrackWrapper class.
 * @author: Amruta Kumbhakarn
 * @date:  26-2-2016
 * @revised:   
 */
@isTest
private class UltraTrackWrapperTest {
  
 /** 
  * @author Amruta Kumbhakarn
  * @description: Ultra Track wrapper test
  * Expected Result: Method should assign values to all variables of class.
  * @date: 26-02-2016
  */ 
   static testMethod void UltraTrackWrapperTestCase1() {
      
      list<UltraTrackWrapper> ultraTrackWrapperList = new list<UltraTrackWrapper>();
      list<HistoryWrapper> historyList = new list<HistoryWrapper>();
      
      Account accountObj = TestDataFactory.getAccount('TestAccount');
      insert accountObj;
      historyList.addAll(TestDataFactory.getHistoryList(new list<string> {'2'},
                                                      new list<string> {'5'},
                                                      string.ValueOf(accountObj.Id),
                                                      null,
                                                      null,
                                                      new list<DateTime> {DateTime.newInstance(2016, 02, 26, 20, 45, 00)},
                                                      new list<string> {'Changed from 2 to 5'}
                                                     )
                        );
      test.startTest();
      ultraTrackWrapperList.addAll(TestDataFactory.getUltraTrackList(new list<string> {'Account__c'},
                                                                    new list<string> {'Account'},
                                                                    new list<list<HistoryWrapper>> {historyList},
                                                                    new list<boolean>()
                                                                    )
                        );
      test.stopTest();
      
      system.assertEquals('Account__c', ultraTrackWrapperList[0].fieldApiName);
      system.assertEquals('Account', ultraTrackWrapperList[0].fieldLabel);
      system.assertEquals(historyList.size(), ultraTrackWrapperList[0].lstHistory.size());
   }
   
 /** 
  * @author Amruta Kumbhakarn
  * @description: Ultra Track wrapper test
  * Expected Result: Method should assign values to all variables of class.
  * @date: 26-02-2016
  */ 
   static testMethod void UltraTrackWrapperTestCase2() {
      
      list<UltraTrackWrapper> ultraTrackWrapperList = new list<UltraTrackWrapper>();
      list<HistoryWrapper> historyList1 = new list<HistoryWrapper>();
      list<HistoryWrapper> historyList2 = new list<HistoryWrapper>();
      
      Account accountObj = TestDataFactory.getAccount('TestAccount');
      insert accountObj;
      historyList1.addAll(TestDataFactory.getHistoryList(new list<string> {'2', '3'},
                                                      new list<string> {'5', '6'},
                                                      string.ValueOf(accountObj.Id),
                                                      null,
                                                      null,
                                                      new list<DateTime> {DateTime.newInstance(2016, 02, 26, 20, 45, 00),
                                                                         DateTime.newInstance(2016, 02, 26, 20, 45, 00)},
                                                      new list<string> {'Changed from 2 to 5','Changed from 3 to 6'}
                                                     )
                        );
      historyList1.addAll(TestDataFactory.getHistoryList(new list<string> {'2'},
                                                         new list<string> {'5'},
                                                         string.ValueOf(accountObj.Id),
                                                         null,
                                                         null,
                                                         new list<DateTime> {DateTime.newInstance(2016, 02, 26, 20, 45, 00)},
                                                         new list<string> {'Changed from 2 to 5'}
                                                        )
                        );
      test.startTest();
      ultraTrackWrapperList.addAll(TestDataFactory.getUltraTrackList(new list<string> {'Account__c','Contact__c'},
                                                                    new list<string> {'Account', 'Contact'},
                                                                    new list<list<HistoryWrapper>> {historyList1, historyList2},
                                                                    new list<boolean>()
                                                                    )
                        );
      test.stopTest();
      system.assertEquals('Account__c', ultraTrackWrapperList[0].fieldApiName);
      system.assertEquals('Account', ultraTrackWrapperList[0].fieldLabel);
      system.assertEquals(historyList1.size(), ultraTrackWrapperList[0].lstHistory.size());
      system.assertEquals('Contact__c', ultraTrackWrapperList[1].fieldApiName);
      system.assertEquals('Contact', ultraTrackWrapperList[1].fieldLabel);
      system.assertEquals(historyList2.size(), ultraTrackWrapperList[1].lstHistory.size());
   }
   
 /** 
  * @author Amruta Kumbhakarn
  * @description: Ultra Track wrapper test
  * Expected Result: Method should assign values to all variables of class.
  * @date: 26-02-2016
  */ 
   static testMethod void UltraTrackWrapperTestCase3() {
      
      list<UltraTrackWrapper> ultraTrackWrapperList = new list<UltraTrackWrapper>();
      
      test.startTest();
      ultraTrackWrapperList.addAll(TestDataFactory.getUltraTrackList(new list<string> {'Account__c','Contact__c'},
                                                                    new list<string> {'Account', 'Contact'},
                                                                    new list<list<HistoryWrapper>> (),
                                                                    new list<boolean>{true, false}
                                                                    )
                        );
      test.stopTest();
      system.assertEquals('Account__c', ultraTrackWrapperList[0].fieldApiName);
      system.assertEquals('Account', ultraTrackWrapperList[0].fieldLabel);
      system.assertEquals(true, ultraTrackWrapperList[0].isSelected);
      system.assertEquals('Contact__c', ultraTrackWrapperList[1].fieldApiName);
      system.assertEquals('Contact', ultraTrackWrapperList[1].fieldLabel);
      system.assertEquals(false, ultraTrackWrapperList[1].isSelected);
   }
   
   /** 
  * @author Amruta Kumbhakarn
  * @description: Ultra Track wrapper sort test
  * Expected Result: Method should sort the wrapper list in descending order.
  * @date: 26-02-2016
  */ 
   static testMethod void UltraTrackWrapperTestCase4() {
      
      list<UltraTrackWrapper> ultraTrackWrapperList = new list<UltraTrackWrapper>();
      
      ultraTrackWrapperList.addAll(TestDataFactory.getUltraTrackList(new list<string> {'Account__c','Contact__c','Case__c','Work__c'},
                                                                    new list<string> {'Work', 'Contact','Case','Account'},
                                                                    new list<list<HistoryWrapper>> (),
                                                                    new list<boolean>{true, false, true, false}
                                                                    )
                                  );
      
      test.startTest();
      ultraTrackWrapperList.sort();
      test.stopTest();
      
      system.assertEquals('Account', ultraTrackWrapperList[0].fieldLabel);
      system.assertEquals('Case', ultraTrackWrapperList[1].fieldLabel);
      system.assertEquals('Contact', ultraTrackWrapperList[2].fieldLabel);
      system.assertEquals('Work', ultraTrackWrapperList[3].fieldLabel);
   }
}