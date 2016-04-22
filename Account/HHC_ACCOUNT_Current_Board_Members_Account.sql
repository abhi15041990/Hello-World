SELECT sf_acc.ID
	   , 'true' AS Current_Board_Members_Account__c
FROM SF_Account sf_acc
JOIN sf_contact sf_cnt
	on sf_acc.historic_id = LEFT(sf_cnt.HISTORIC_CONTACT_ID
							, LEN(sf_cnt.HISTORIC_CONTACT_ID)
							- CHARINDEX('-',sf_cnt.HISTORIC_CONTACT_ID))
JOIN [Habitat_final].dbo.cv__Constituent_Engagement_Channel__c src_eng
	on RIGHT(sf_cnt.HISTORIC_CONTACT_ID
			, LEN(sf_cnt.HISTORIC_CONTACT_ID)
			- CHARINDEX('-',sf_cnt.HISTORIC_CONTACT_ID)) = src_eng.cv__Contact__c
where src_eng.cv__Engagement_Channel__c = 'a0AA0000001Kp6ZMAS';

