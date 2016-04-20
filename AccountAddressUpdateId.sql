update [dbo].[sf_address]
set id = acaddr.id
from  [HELLER_ID_Database].[dbo].[HabitatAccountAddressId] acaddr
where acaddr.rC_Bios__External_ID__c = [sf_address].rC_Bios__external_id__c