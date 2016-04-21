--update TIVC__Created_by_Website_Contact__c field after inserting the contact
Update SF_ACCOUNT
set SF_ACCOUNT.TIVC__Created_by_Website_Contact__c = sf_cnt.new_OrgId
from (SELECT acct.Id AS historic_id,sf_cnt.id as new_OrgId
		from [HABITAT_final].dbo.Account acct
		JOIN SF_contact sf_cnt
			on RIGHT(sf_cnt.HISTORIC_CONTACT_ID,LEN(sf_cnt.HISTORIC_CONTACT_ID)-CHARINDEX('-',sf_cnt.HISTORIC_CONTACT_ID)) = acct.TIVC__Created_by_Website_Contact__c
) sf_cnt
where sf_cnt.historic_id = SF_ACCOUNT.Historic_Id;

alter table sf_account
alter column TIVC__Created_by_Website_Contact__c varchar(20)


select   TIVC__Created_by_Website_Contact__c from [HABITAT_final].dbo.account where TIVC__Created_by_Website_Contact__c!=''