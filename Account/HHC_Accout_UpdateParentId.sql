--update the parentid filed after inserting the Account
UPDATE SF_ACCOUNT
	set SF_ACCOUNT.ParentId = acc.new_Parent_id
FROM (SELECT acc.ID As new_Parent_id, acc1.ParentId As old_parent_id, acc.Historic_Id, acc1.Id as old_id FROM SF_ACCOUNT acc
		join [HABITAT_final].dbo.Account acc1
			on acc.Historic_Id = acc1.ParentId) acc
where SF_ACCOUNT.Historic_Id = acc.old_id;

alter table SF_ACCOUNT
alter column ParentId varchar(max)

select id,Parentid,[rC_Bios__Preferred_Contact__c],[TIVC__Created_by_Website_Contact__c] from sf_account

select [cv__Primary_Contact__c] from account where [cv__Primary_Contact__c] is not null and [cv__Primary_Contact__c]!=''