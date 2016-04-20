--account address coming from related addresses tab

select 
cvr.id as rC_Bios__external_id__c,
sf_cnt.Accountid as rC_Bios__Account__c,
addr.id  as   rC_Bios__Address__c,
cvr.cv__Mailing_Street__c as rC_Bios__Original_Street_Line_1__c,
cvr.cv__Mailing_City__c as rC_Bios__Original_City__c,
cvr.cv__Mailing_State__c as rC_Bios__Original_State__c,
cvr.cv__Mailing_Zip__c as rC_Bios__Original_Postal_Code__c,
cvr.cv__Mailing_Country__c as rC_Bios__Original_Country__c,
'false' as rC_Bios__Active__c,
'false' as rC_Bios__Preferred_Billing__c,
CONVERT(VARCHAR(24),cvr.cv__Start_Date__c,20)  as rC_Bios__Start_Date__c,
CONVERT(VARCHAR(24),cvr.cv__End_Date__c,20)  as rC_Bios__End_Date__c,
cvr.cv__Address_Type__c as rC_Bios__Type__c
--into AccountAddressRel
from [HABITAT_final].dbo.[cv__Related_Address__c] cvr
 
left JOIN [HABITAT_Staging_Final].dbo.sf_contact sf_cnt 
	on right(sf_cnt.HISTORIC_CONTACT_ID,LEN(sf_cnt.HISTORIC_CONTACT_ID)-CHARINDEX('-',sf_cnt.HISTORIC_CONTACT_ID))
			= cvr.cv__Contact__c

JOIN sf_address addr
	on addr.rc_bios__external_Id__c = cvr.ID







-------------------------------------------------------------
--Account address coming from account tab

select 
  acc.id as rc_Bios__external_id__c,
 sfacc.id as RC_BIOS__ACCOUNT__c, 
  addr.id as  rC_Bios__Address__c,
Case when acc.BillingStreet != '' then acc.BillingStreet
     end  as rC_Bios__Original_Street_Line_1__c,
Case when acc.BillingCity != '' then acc.BillingCity 
     end as rC_Bios__Original_City__c,
Case when acc.BillingState != '' then acc.BillingState
    end  as rC_Bios__Original_State__c,
Case when acc.BillingPostalCode!= '' then acc.BillingPostalCode
    end as rC_Bios__Original_Postal_Code__c,
Case when acc.BillingCountry!= '' then acc.BillingCountry
    end as rC_Bios__Original_Country__c,
'true' as rC_Bios__Active__c,
Case when acc.BillingStreet != '' then 'true'
     else 'false'     
    end as rC_Bios__Preferred_Billing__c
--into AccountAddressFromAccount
from [HABITAT_final].dbo.account acc 

left join [HABITAT_Staging_Final].dbo.SF_Account sfacc
on acc.id = sfacc.Historic_id

left JOIN sf_address addr
	on addr.rc_bios__external_Id__c = acc.ID

where acc.BillingStreet != '' or
      acc.BillingCity != '' or
	  acc.BillingState != '' or
	  acc.BillingPostalCode != '' or
	  acc.BillingCountry != '' 


--account organization recordtype = '012F0000001AaWjIAK'
--account Household recordtype = '	012F0000001AaWiIAK'

------------------------------------------------------------------------

create table sf_account_Address
(
rC_Bios__external_id__c varchar(max),
RC_BIOS__ACCOUNT__c varchar(max),
rC_Bios__Address__c varchar(max),
rC_Bios__Original_Street_Line_1__c varchar(max),
rC_Bios__Original_City__c varchar(max),
rC_Bios__Original_State__c varchar(max),
rC_Bios__Original_Postal_Code__c varchar(max),
rC_Bios__Original_Country__c varchar(max),
rC_Bios__Active__c varchar(max),
rC_Bios__Preferred_Billing__c varchar(max),
rC_Bios__Start_Date__c varchar(max),
rC_Bios__End_Date__c varchar(max),
rC_Bios__Type__c varchar(max),
id varchar(max)
)

---------------------------------------------------------
insert into sf_account_Address
(
rC_Bios__external_id__c ,
RC_BIOS__ACCOUNT__c ,
rC_Bios__Address__c ,
rC_Bios__Original_Street_Line_1__c ,
rC_Bios__Original_City__c ,
rC_Bios__Original_State__c ,
rC_Bios__Original_Postal_Code__c ,
rC_Bios__Original_Country__c ,
rC_Bios__Active__c ,
rC_Bios__Preferred_Billing__c 

)



select * from AccountAddressFromAccount

select * from sf_account_Address















 


