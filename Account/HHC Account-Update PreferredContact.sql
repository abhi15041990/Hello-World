Update sf_account
set sf_account.rC_Bios__Preferred_Contact__c = sf_cnt.new_OrgId
from (SELECT acct.Id AS historic_id,acct.cv__Primary_Contact__c, sf_cnt.id as new_OrgId
		from [HABITAT_final].dbo.Account acct
		JOIN SF_contact sf_cnt
			on RIGHT(sf_cnt.HISTORIC_CONTACT_ID,LEN(sf_cnt.HISTORIC_CONTACT_ID)-CHARINDEX('-',sf_cnt.HISTORIC_CONTACT_ID)) = acct.cv__Primary_Contact__c
) sf_cnt
where sf_cnt.historic_id = sf_account.Historic_Id;


alter table sf_account 
alter column rC_Bios__Preferred_Contact__c varchar(20)

