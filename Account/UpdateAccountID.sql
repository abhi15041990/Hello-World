update [HABITAT_Staging_Final].dbo.sf_Account
set id=tbl_accid.id
from [HELLER_ID_Database].[dbo].[Account ID] tbl_accid
where [HABITAT_Staging_Final].dbo.sf_Account.historic_id=tbl_accid.Historic_Account_Id__c

select id from [HABITAT_Staging_Final].dbo.sf_Account