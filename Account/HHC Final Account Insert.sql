SELECT 
     acc.Id AS historic_id 
	,acc.Account_Record_ID__c AS CG_Account_Record_ID__c
	,acc.Volunteer_Team_Participation__c  AS Volunteer_Team_Participation__c
	,acc.TIVC__Active_Volunteer__c AS TIVC__Active_Volunteer__c
	,acc.TIVC__Active__c AS TIVC__Active__c
	,case
	  when  acc.Secondary_Account_Owner__c='005A00000016EtmIAE' then '005F0000003Lgn2IAC'
	  when  acc.Secondary_Account_Owner__c='005G00000024ez0IAA' then '005F0000003OPbDIAW'
	  when  acc.Secondary_Account_Owner__c='005G00000025P8pIAE' then '005F0000004E8F6IAK'
	  when  acc.Secondary_Account_Owner__c='005G0000003N0JjIAK' then '005F0000003OPbNIAW'
	  else NULL 
	 end AS Secondary_Account_Owner__c 
	,NULL AS TIVC__Created_by_Website_Contact__c			--field for Lookup of contact and update according contact 
	,CONVERT(VARCHAR(24),CAST(acc.TIVC__First_Volunteer_Shift__c AS datetime),20) AS tivc__first_volunteer_shift__c
	,acc.TIVC__Group_Shifts_Last_Year__c AS tivc__group_shifts_last_year__c
	,acc.TIVC__Group_Shifts_This_Year__c AS tivc__group_shifts_this_year__c
	,acc.TIVC__Group_Shifts_Total__c AS tivc__group_shifts_total__c
	,acc.TIVC__Groups_Total__c AS tivc__groups_total__c
	,acc.TIVC__Last_Volunteer_Shift__c AS tivc__last_volunteer_shift__c
	,Case when acc.TIVC__Pending_Affiliation_Request__c = '0' then 'false'
	      when acc.TIVC__Pending_Affiliation_Request__c = '1' then 'true' 
		  end as tivc__pending_affiliation_request__c      --TIVC__Pending_Affiliation_Request__c  AS tivc__pending_affiliation_request__c
	,acc.TIVC__Volunteer_Hours_Last_Year__c AS tivc__volunteer_hours_last_year__c
	,acc.TIVC__Volunteer_Hours_This_Year__c AS tivc__volunteer_hours_this_year__c
	,acc.TIVC__Volunteer_Hours_Total__c AS tivc__volunteer_hours_total__c
	,acc.TIVC__Volunteers_Last_Year__c AS tivc__volunteers_last_year__c
	,acc.TIVC__Volunteers_This_Year__c AS tivc__volunteers_this_year__c
	,acc.TIVC__Volunteers_Total__c AS tivc__volunteers_total__c
	,acc.TIVC__ignitionID__c AS tivc__ignitionid__c
	,acc.Description AS Description
	,acc.Fax AS Fax
	,acc.Industry AS Industry
	,acc.Name AS Name
	,NULL AS ParentId 
	,acc.Phone AS Phone
	,case 
		when acc.cv__Active__c = '1' then 'true'
		else 'false' end as [rc_BIOS__Active__c]
    ,NULL AS rC_Bios__Preferred_Contact__c
	,CASE 
		WHEN (acc.Type = 'Corporation') then 'Corporation'
		when (acc.Type = 'Foundation') then 'Foundation' 
		when (acc.Type = 'Nonprofit') then 'Nonprofit'
		when (acc.Type = 'Religious Organization') then 'Religious Organization'
		when (acc.Type = 'School') then 'School'
		when (acc.Type = 'Small Business') then 'Small Business'
		END AS Type
	,acc.Website AS Website
	,CASE WHEN acc.RecordTypeId = '012A0000000btrz' THEN '012F0000001AaWjIAK' 		--Organization
		  WHEN acc.RecordTypeId = '012G0000001AGSp' THEN '012F0000001M3VeIAK'		--Volunteer Organization
		  WHEN acc.RecordTypeId = '012A0000000btry' THEN '012F0000001AaWiIAK'		--Household 
		  END AS Recordtype_id
	,case
		when acc.CreatedById='005G0000001d9E6IAI' then '005F0000003OPbhIAG' 
		when acc.CreatedById='005G00000024ez0IAA' then '005F0000003OPbDIAW' 
		when acc.CreatedById='005G00000025P8pIAE' then '005F0000004E8F6IAK'
		when acc.CreatedById='005G0000003N0JjIAK' then '005F0000003OPbNIAW'
		else '005F0000003Lgn2IAC'		--Lauren Gibson   
	end as CreatedBy					
	,CONVERT(VARCHAR(24),CAST(acc.LastActivityDate AS datetime),20) as Last_Activity_Date__c
	,CONVERT(VARCHAR(24),CAST(acc.CreatedDate AS datetime),20)      as CreatedDate                  -- Issue No. 39
	,acc.[cv__Salutation_Casual__c] as rC_Bios__Salutation__c                                       -- Issue no. 42     
	,acc.[cv__Salutation_Formal__c] as Formal_Salutation__c											-- Issue no. 43
	,case when acc.cv__Anonymous__c='0' then 'false'
         when acc.cv__Anonymous__c='1'then 'true'
		/* when con.cv__Anonymous__c='0' then 'false'	
		 when con.cv__Anonymous__c='1'then 'true'	*/				
		 end as Anonymous__c 												                     --field come from source contact table                    -- Issue no. 45
	,acc.cv__Foundation_Type__c     as Foundation_Type__c	-- Issue no. 285
	,acc.TIVC__CustomerPriority__c as TIVC__CustomerPriority__c
	,acc.TIVC__Division_Department__c as TIVC__Division_Department__c
	,case when acc.TIVC__IsBatchUpdate__c='0' then 'false'
          when acc.TIVC__IsBatchUpdate__c='1'then 'true' end as TIVC__IsBatchUpdate__c
	,case when acc.TIVC__IsDirty__c='0' then 'false'
          when acc.TIVC__IsDirty__c='1'then 'true'end as TIVC__IsDirty__c
	,acc.TIVC__NumberofLocations__c as TIVC__NumberofLocations__c
	,CONVERT(VARCHAR(24),CAST(acc.TIVC__SLAExpirationDate__c AS datetime),20) as TIVC__SLAExpirationDate__c
	,acc.TIVC__SLASerialNumber__c as TIVC__SLASerialNumber__c
	,acc.TIVC__SLA__c as TIVC__SLA__c
	,acc.TIVC__UpsellOpportunity__c as TIVC__UpsellOpportunity__c
	--following fields added on 14/7/2014
	,acc.BillingStreet as BillingStreet
	,acc.BillingCity as BillingCity
	,acc.BillingState as BillingState
	,acc.BillingPostalCode as BillingPostalCode
	,acc.BillingCountry as BillingCountry	
	/*,case
	when con.cv__Postal_Mail_Opt_Out__c ='0' then 'false'
	when con.cv__Postal_Mail_Opt_Out__c='1' then 'true'
	end as Postal_Mail_Opt_Out__c	*/					--field come from source contact table
 	,'005F0000003Lgn2IAC' as OwnerId	  -- after change the owner id 
/* Case when Ownerid =	'005G0000001d9ELIAY'	then	'005F0000004EcvVIAS'
when Ownerid =	'005G0000001d9ELIAY'	then	'005F0000004EcvVIAS'
when Ownerid =	'005G0000001d9ELIAY'	then	'005F0000004EcvVIAS'
when Ownerid =	'005G0000001d9ELIAY'	then	'005F0000004EcvVIAS'
when Ownerid =	'005G0000001d9ELIAY'	then	'005F0000004EcvVIAS'
when Ownerid =	'005G0000001d9ELIAY'	then	'005F0000004EcvVIAS'
when Ownerid =	'005G0000001d9ELIAY'	then	'005F0000004EcvVIAS'
when Ownerid =	'005G0000001d9ELIAY'	then	'005F0000004EcvVIAS'
when Ownerid =	'005G0000001d9ELIAY'	then	'005F0000004EcvVIAS'
when Ownerid =	'005G0000001d9ELIAY'	then	'005F0000004EcvVIAS'
when Ownerid =	'005G00000025P8pIAE'	then	'005F0000004EcvVIAS'
when Ownerid =	'005G00000025P8pIAE'	then	'005F0000004EcvVIAS'
when Ownerid =	'005G00000025P8pIAE'	then	'005F0000004EcvVIAS'
when Ownerid =	'005G0000003N0JjIAK'	then	'005F0000004EcvVIAS'
when Ownerid =	'005G0000002wUCoIAM'	then	'005F0000004EcvVIAS'
when Ownerid =	'005G0000002wUCoIAM'	then	'005F0000004EcvVIAS'
when Ownerid =	'005G0000002wUCoIAM'	then	'005F0000004EcvVIAS'
when Ownerid =	'005G0000002wUCoIAM'	then	'005F0000004EcvVIAS'
when Ownerid =	'005G0000002wUCoIAM'	then	'005F0000004EcvVIAS'
when Ownerid =	'005G0000002z8vgIAA'	then	'005F0000004EcvkIAC'
when Ownerid =	'005G0000002z8vgIAA'	then	'005F0000004EcvkIAC'
when Ownerid =	'005G0000002z8vgIAA'	then	'005F0000004EcvkIAC'
when Ownerid =	'005G0000002z8vgIAA'	then	'005F0000004EcvkIAC'
when Ownerid =	'005G0000002z8vgIAA'	then	'005F0000004EcvkIAC'
when Ownerid =	'005G0000002z8vgIAA'	then	'005F0000004EcvkIAC'
when Ownerid =	'005G0000002z8vgIAA'	then	'005F0000004EcvkIAC'
when Ownerid =	'005G00000024ez0IAA'	then	'005F0000003OPbDIAW'
when Ownerid =	'005G00000024ez0IAA'	then	'005F0000003OPbDIAW'
when Ownerid =	'005G00000024ez0IAA'	then	'005F0000003OPbDIAW'
when Ownerid =	'005G00000024ez0IAA'	then	'005F0000003OPbDIAW'
when Ownerid =	'005G00000024ez0IAA'	then	'005F0000003OPbDIAW'
when Ownerid =	'005G00000024ez0IAA'	then	'005F0000003OPbDIAW'
when Ownerid =	'005G00000024ez0IAA'	then	'005F0000003OPbDIAW'
when Ownerid =	'005G00000024ez0IAA'	then	'005F0000003OPbDIAW'
when Ownerid =	'005G00000024ez0IAA'	then	'005F0000003OPbDIAW'
when Ownerid =	'005G0000002wUCoIAM'	then	'005F0000003OPbDIAW'
when Ownerid =	'005G0000002wUCoIAM'	then	'005F0000003OPbDIAW'
when Ownerid =	'005A0000001JgeNIAS'	then	'005F0000004EcvpIAC'
when Ownerid =	'005A0000001JgeNIAS'	then	'005F0000004EcvpIAC'
when Ownerid =	'005A0000001JgeNIAS'	then	'005F0000004EcvpIAC'
when Ownerid =	'005A0000001JgeNIAS'	then	'005F0000004EcvpIAC'
when Ownerid =	'005A0000001JgeNIAS'	then	'005F0000004EcvpIAC'
when Ownerid =	'005A0000001JgeNIAS'	then	'005F0000004EcvpIAC'
when Ownerid =	'005A0000001JgeNIAS'	then	'005F0000004EcvpIAC'
when Ownerid =	'005A0000001JgeNIAS'	then	'005F0000004EcvpIAC'
when Ownerid =	'005A0000001JgeNIAS'	then	'005F0000004EcvpIAC'
when Ownerid =	'005A0000001JgeNIAS'	then	'005F0000004EcvpIAC'
when Ownerid =	'005A0000001JgeNIAS'	then	'005F0000004EcvpIAC'
when Ownerid =	'005A0000001JgeNIAS'	then	'005F0000004EcvpIAC'
when Ownerid =	'005A0000001JgeNIAS'	then	'005F0000004EcvpIAC'
when Ownerid =	'005G00000023LVFIA2'	then	'005F0000004EcvuIAC'
when Ownerid =	'005G00000023LVFIA2'	then	'005F0000004EcvuIAC'
when Ownerid =	'005G00000023LVFIA2'	then	'005F0000004EcvuIAC'
when Ownerid =	'005G00000023LVFIA2'	then	'005F0000004EcvuIAC'
when Ownerid =	'005G00000023LVFIA2'	then	'005F0000004EcvuIAC'
when Ownerid =	'005G0000001d9ELIAY'	then	'005F0000004EcvQIAS'
when Ownerid =	'005G0000001d9ELIAY'	then	'005F0000004EcvQIAS'
when Ownerid =	'005G0000001d9ELIAY'	then	'005F0000004EcvQIAS'
when Ownerid =	'005G0000001d9ELIAY'	then	'005F0000004EcvQIAS'
when Ownerid =	'005G0000001d9ELIAY'	then	'005F0000004EcvQIAS'
when Ownerid =	'005G0000001d9ELIAY'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A0000001O3DNIA0'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A0000001O3DNIA0'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A0000001O3DNIA0'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A0000001O3DNIA0'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A0000001O3DNIA0'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A0000001O3DNIA0'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A0000001O3DNIA0'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A0000001O3DNIA0'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A00000014lQuIAI'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A00000014lQuIAI'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A0000001b6fZIAQ'	then	'005F0000004EcvQIAS'
when Ownerid =	'005G0000001cpKOIAY'	then	'005F0000004EcvQIAS'
when Ownerid =	'005G0000001cpKOIAY'	then	'005F0000004EcvQIAS'
when Ownerid =	'005G0000001cpKOIAY'	then	'005F0000004EcvQIAS'
when Ownerid =	'005G0000003N0JjIAK'	then	'005F0000004EcvQIAS'
when Ownerid =	'005G0000003N0JjIAK'	then	'005F0000004EcvQIAS'
when Ownerid =	'005G0000003N0JjIAK'	then	'005F0000004EcvQIAS'
when Ownerid =	'005G0000003N0JjIAK'	then	'005F0000004EcvQIAS'
when Ownerid =	'005G0000003N0JjIAK'	then	'005F0000004EcvQIAS'
when Ownerid =	'005G0000003N0JjIAK'	then	'005F0000004EcvQIAS'
when Ownerid =	'005G0000003N0JjIAK'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A00000016EtmIAE'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A00000016EtmIAE'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A00000016EtmIAE'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A00000016EtmIAE'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A00000016EtmIAE'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A00000016EtmIAE'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A00000016EtmIAE'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A00000016EtmIAE'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A00000016EtmIAE'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A00000016EtmIAE'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A00000016EtmIAE'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A00000016EtmIAE'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A00000016EtmIAE'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A00000016EtmIAE'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A00000016EtmIAE'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A00000016EtmIAE'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A00000016EtmIAE'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A00000016EtmIAE'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A00000016EtmIAE'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A00000016EtmIAE'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A00000016EtmIAE'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A00000016EtmIAE'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A00000016EtmIAE'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A00000016EtmIAE'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A00000016EtmIAE'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A00000016EtmIAE'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A00000016EtmIAE'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A00000016EtmIAE'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A00000016EtmIAE'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A0000001JgzSIAS'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A0000001JgzSIAS'	then	'005F0000004EcvQIAS'
when Ownerid =	'005A0000001JgzSIAS'	then	'005F0000004EcvQIAS'
when Ownerid =	'005G0000002wUCoIAM'	then	'005F0000004EcvQIAS'
when Ownerid =	'005G0000001d9E6IAI'	then	'005F0000004EcvQIAS'
when Ownerid =	'005G0000001d9E6IAI'	then	'005F0000004EcvQIAS'
when Ownerid =	'005G0000001d9E6IAI'	then	'005F0000004EcvQIAS'
when Ownerid =	'005G0000001d9E6IAI'	then	'005F0000004EcvQIAS'
when Ownerid =	'005G0000001d9E6IAI'	then	'005F0000004EcvQIAS'
when Ownerid =	'005G0000001d9E6IAI'	then	'005F0000004EcvQIAS'
when Ownerid =	'005G0000001d9E6IAI'	then	'005F0000004EcvQIAS'
when Ownerid =	'005G0000001d9E6IAI'	then	'005F0000004EcvQIAS'
when Ownerid =	'005G0000001d9E6IAI'	then	'005F0000004EcvQIAS'
when Ownerid =	'005G0000001d9E6IAI'	then	'005F0000004EcvQIAS'
when Ownerid =	'005G0000001d9E6IAI'	then	'005F0000004EcvQIAS'
when Ownerid =	'005G0000001d9E6IAI'	then	'005F0000004EcvQIAS'
when Ownerid =	'005G0000001d9E6IAI'	then	'005F0000004EcvQIAS'
when Ownerid =	'005G0000001d9E6IAI'	then	'005F0000004EcvQIAS'
when Ownerid =	'005G00000025P8pIAE'	then	'005F0000003OPbNIAW'
when Ownerid =	'005G00000025P8pIAE'	then	'005F0000003OPbNIAW'
when Ownerid =	'005G00000025P8pIAE'	then	'005F0000003OPbNIAW'
when Ownerid =	'005G00000025P8pIAE'	then	'005F0000003OPbNIAW'
when Ownerid =	'005G00000025P8pIAE'	then	'005F0000003OPbNIAW'
when Ownerid =	'005G0000003N0JjIAK'	then	'005F0000003OPbNIAW'
when Ownerid =	'005G0000003N0JjIAK'	then	'005F0000003OPbNIAW'
when Ownerid =	'005G0000003N0JjIAK'	then	'005F0000003OPbNIAW'
when Ownerid =	'005G0000003N0JjIAK'	then	'005F0000003OPbNIAW'
when Ownerid =	'005G0000003N0JjIAK'	then	'005F0000003OPbNIAW'
when Ownerid =	'005G0000002wUCoIAM'	then	'005F0000003OPbNIAW'
when Ownerid =	'005G0000002wUCoIAM'	then	'005F0000003OPbNIAW'
when Ownerid =	'005G0000002wUCoIAM'	then	'005F0000003OPbNIAW'
when Ownerid =	'005G0000001d9ELIAY'	then	'005F0000003Lgn2IAC'
when Ownerid =	'005G0000001d9ELIAY'	then	'005F0000003Lgn2IAC'
when Ownerid =	'005G00000025P8pIAE'	then	'005F0000003Lgn2IAC'
when Ownerid =	'005G00000025P8pIAE'	then	'005F0000003Lgn2IAC'
when Ownerid =	'005G0000003N0JjIAK'	then	'005F0000003Lgn2IAC'
when Ownerid =	'005G0000003N0JjIAK'	then	'005F0000003Lgn2IAC'
when Ownerid =	'005G0000003N0JjIAK'	then	'005F0000003Lgn2IAC'
when Ownerid =	'005G0000003N0JjIAK'	then	'005F0000003Lgn2IAC'
when Ownerid =	'005A00000016EtmIAE'	then	'005F0000003Lgn2IAC'
when Ownerid =	'005A00000016EtmIAE'	then	'005F0000003Lgn2IAC'
when Ownerid =	'005A00000016EtmIAE'	then	'005F0000003Lgn2IAC'
when Ownerid =	'005G0000002wUCoIAM'	then	'005F0000003Lgn2IAC'
when Ownerid =	'005G0000002wUCoIAM'	then	'005F0000003Lgn2IAC'
when Ownerid =	'005G0000002wUCoIAM'	then	'005F0000003Lgn2IAC'
when Ownerid =	'005G0000002wUCoIAM'	then	'005F0000003Lgn2IAC'
when Ownerid =	'005G0000001d9E6IAI'	then	'005F0000003Lgn2IAC'
when Ownerid =	'005G0000001d9ELIAY'	then	'005F0000004EcvBIAS'
when Ownerid =	'005G0000001d9ELIAY'	then	'005F0000004EcvBIAS'
when Ownerid =	'005G0000003N0JjIAK'	then	'005F0000004EcvBIAS'
when Ownerid =	'005G0000002wUCoIAM'	then	'005F0000004EcvBIAS'
when Ownerid =	'005G0000002wUCoIAM'	then	'005F0000004EcvBIAS'
when Ownerid =	'005G0000002wUCoIAM'	then	'005F0000004EcvBIAS'
when Ownerid =	'005A0000000bur1IAA'	then	'005F0000004DwRIIA0'
when Ownerid =	'005A0000000bur1IAA'	then	'005F0000004DwRIIA0'
when Ownerid =	'005A0000000bur1IAA'	then	'005F0000004DwRIIA0'
when Ownerid =	'005A000000152N0IAI'	then	'005F0000004DwRIIA0'
when Ownerid =	'005A000000152N0IAI'	then	'005F0000004DwRIIA0'
when Ownerid =	'005A000000152N0IAI'	then	'005F0000004DwRIIA0'
when Ownerid =	'005A000000152N0IAI'	then	'005F0000004DwRIIA0'
when Ownerid =	'005A000000152N0IAI'	then	'005F0000004DwRIIA0'
when Ownerid =	'005A000000152N0IAI'	then	'005F0000004DwRIIA0'
when Ownerid =	'005A000000152N0IAI'	then	'005F0000004DwRIIA0'
when Ownerid =	'005A000000152N0IAI'	then	'005F0000004DwRIIA0'
when Ownerid =	'005A000000152N0IAI'	then	'005F0000004DwRIIA0'
when Ownerid =	'005A000000152N0IAI'	then	'005F0000004DwRIIA0'
when Ownerid =	'005A000000152N0IAI'	then	'005F0000004DwRIIA0'
when Ownerid =	'005A000000152N0IAI'	then	'005F0000004DwRIIA0'
when Ownerid =	'005A000000152N0IAI'	then	'005F0000004DwRIIA0'
when Ownerid =	'005A000000152N0IAI'	then	'005F0000004DwRIIA0'
when Ownerid =	'005A000000152N0IAI'	then	'005F0000004DwRIIA0'
when Ownerid =	'005A0000001b6fZIAQ'	then	'005F0000003OPbhIAG'
when Ownerid =	'005G0000002wUCoIAM'	then	'005F0000003OPbhIAG'
when Ownerid =	'005A0000000bur1IAA'	then	'005F0000003OPbhIAG'
when Ownerid =	'005G0000001d9E6IAI'	then	'005F0000003OPbhIAG'
when Ownerid =	'005G0000001d9E6IAI'	then	'005F0000003OPbhIAG' end as Ownerid
   31 july 2014 */
	into SF_Account				
 FROM [HABITAT_final].dbo.Account acc;
 ------------------------------------------------------------------------------------
 -----updating cv__Anonymous__c field accourding to source contact
 update SF_Account
 set SF_Account.Anonymous__c='true'
 from (select acc.id as accountid 
		from [HABITAT_final].dbo.Account acc 
		join [HABITAT_final].dbo.contact con 
			on con.AccountId=acc.id 
		where con.cv__Anonymous__c='1') as acc1
 where acc1.accountid=sf_Account.historic_id;
 -------------------------------------------------------------------------------------
 --added Postal_Mail_Opt_Out__c field into staging sf_account
 alter table sf_account
 add Postal_Mail_Opt_Out__c varchar(Max)

 -----updating Postal_Mail_Opt_Out__c field accourding to source contact
 update SF_Account
 set SF_Account.Postal_Mail_Opt_Out__c='true'
 from (select acc.id as accountid 
		from [HABITAT_final].dbo.Account acc 
		join [HABITAT_final].dbo.contact con 
			on con.AccountId=acc.id 
		where con.cv__Postal_Mail_Opt_Out__c='1') as acc1
 where acc1.accountid=sf_Account.historic_id

 alter table sf_account
 add ID varchar(20)


