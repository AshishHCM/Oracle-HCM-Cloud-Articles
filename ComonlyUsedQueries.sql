/*
------ Get Employee Legal Employer --------------------------------------------
Created By: Ashish Harbhajanka (Oracle ACE)
Created On: 15-Apr-2023
Appln Vers: Release 13 23A
-------------------------------------------------------------------------------
*/
SELECT 	papf.person_number,
        hauft.NAME LegalEmployer
FROM   	HR_ORG_UNIT_CLASSIFICATIONS_F houcf, 
		HR_ALL_ORGANIZATION_UNITS_F haouf, 
		HR_ORGANIZATION_UNITS_F_TL hauft,
		per_all_assignments_m paam,
		per_all_people_f papf
WHERE   haouf.ORGANIZATION_ID = houcf.ORGANIZATION_ID 
AND 	haouf.ORGANIZATION_ID = hauft.ORGANIZATION_ID 
AND 	haouf.EFFECTIVE_START_DATE BETWEEN houcf.EFFECTIVE_START_DATE AND houcf.EFFECTIVE_END_DATE 
AND 	hauft.LANGUAGE = 'US'
AND 	hauft.EFFECTIVE_START_DATE = haouf.EFFECTIVE_START_DATE 
AND     hauft.EFFECTIVE_END_DATE = haouf.EFFECTIVE_END_DATE 
AND 	houcf.CLASSIFICATION_CODE = 'HCM_LEMP' 
AND     SYSDATE BETWEEN hauft.effective_start_date AND hauft.effective_end_date
AND     hauft.organization_id = paam.legal_entity_id
and     paam.person_id = papf.person_id
and     paam.primary_assignment_flag = 'Y'
and     paam.assignment_type = 'E'
and     paam.effective_latest_change = 'Y'
and     sysdate between paam.effective_start_date and paam.effective_end_date
and     sysdate between papf.effective_start_date and papf.effective_end_date
and     papf.person_number = nvl(:personnumber,papf.person_number) 
order by papf.person_number asc,hauft.name asc nulls first

/*
------ Get Employee Business Unit --------------------------------------------
Created By: Ashish Harbhajanka (Oracle ACE)
Created On: 15-Apr-2023
Appln Vers: Release 13 23A
-------------------------------------------------------------------------------
*/
SELECT 	papf.person_number,
        hauft.NAME BusinessUnit
FROM   	HR_ORG_UNIT_CLASSIFICATIONS_F houcf, 
		HR_ALL_ORGANIZATION_UNITS_F haouf, 
		HR_ORGANIZATION_UNITS_F_TL hauft,
		per_all_assignments_m paam,
		per_all_people_f papf
WHERE   haouf.ORGANIZATION_ID = houcf.ORGANIZATION_ID 
AND 	haouf.ORGANIZATION_ID = hauft.ORGANIZATION_ID 
AND 	haouf.EFFECTIVE_START_DATE BETWEEN houcf.EFFECTIVE_START_DATE AND houcf.EFFECTIVE_END_DATE 
AND 	hauft.LANGUAGE = 'US'
AND 	hauft.EFFECTIVE_START_DATE = haouf.EFFECTIVE_START_DATE 
AND     hauft.EFFECTIVE_END_DATE = haouf.EFFECTIVE_END_DATE 
AND 	houcf.CLASSIFICATION_CODE = 'FUN_BUSINESS_UNIT' 
AND     SYSDATE BETWEEN hauft.effective_start_date AND hauft.effective_end_date
AND     hauft.organization_id = paam.business_unit_id
and     paam.person_id = papf.person_id
and     paam.primary_assignment_flag = 'Y'
and     paam.assignment_type = 'E'
and     paam.effective_latest_change = 'Y'
and     sysdate between paam.effective_start_date and paam.effective_end_date
and     sysdate between papf.effective_start_date and papf.effective_end_date
and     papf.person_number = nvl(:personnumber,papf.person_number)
order by papf.person_number asc,hauft.name asc nulls first

/*
------ Get Employee Assignment Department --------------------------------------------
Created By: Ashish Harbhajanka (Oracle ACE)
Created On: 15-Apr-2023
Appln Vers: Release 13 23A
-------------------------------------------------------------------------------
*/
SELECT 	papf.person_number,
        hauft.NAME Department
FROM   	HR_ORG_UNIT_CLASSIFICATIONS_F houcf, 
		HR_ALL_ORGANIZATION_UNITS_F haouf, 
		HR_ORGANIZATION_UNITS_F_TL hauft,
		per_all_assignments_m paam,
		per_all_people_f papf
WHERE   haouf.ORGANIZATION_ID = houcf.ORGANIZATION_ID 
AND 	haouf.ORGANIZATION_ID = hauft.ORGANIZATION_ID 
AND 	haouf.EFFECTIVE_START_DATE BETWEEN houcf.EFFECTIVE_START_DATE AND houcf.EFFECTIVE_END_DATE 
AND 	hauft.LANGUAGE = 'US'
AND 	hauft.EFFECTIVE_START_DATE = haouf.EFFECTIVE_START_DATE 
AND     hauft.EFFECTIVE_END_DATE = haouf.EFFECTIVE_END_DATE 
AND 	houcf.CLASSIFICATION_CODE = 'DEPARTMENT' 
AND     SYSDATE BETWEEN hauft.effective_start_date AND hauft.effective_end_date
AND     hauft.organization_id = paam.organization_id
and     paam.person_id = papf.person_id
and     paam.primary_assignment_flag = 'Y'
and     paam.assignment_type = 'E'
and     paam.effective_latest_change = 'Y'
and     sysdate between paam.effective_start_date and paam.effective_end_date
and     sysdate between papf.effective_start_date and papf.effective_end_date
and     papf.person_number = nvl(:personnumber,papf.person_number) 
order by papf.person_number asc,hauft.name asc nulls first

/*
------ Get Employee Assignment Job --------------------------------------------
Created By: Ashish Harbhajanka (Oracle ACE)
Created On: 15-Apr-2023
Appln Vers: Release 13 23A
-------------------------------------------------------------------------------
*/
SELECT papf.person_number,
	   pjft.name    jobname
FROM   per_all_people_f papf,
       per_all_assignments_m paam,
       per_jobs_f pjf,
	   per_jobs_f_tl pjft
WHERE  papf.person_id = paam.person_id
AND    TRUNC(SYSDATE) BETWEEN papf.effective_start_date AND papf.effective_end_date
AND    paam.primary_assignment_flag = 'Y'
AND    paam.assignment_type = 'E' 
and    paam.effective_latest_change = 'Y'
AND    TRUNC(SYSDATE) BETWEEN paam.effective_start_date AND paam.effective_end_date
AND    paam.job_id = pjf.job_id
AND    TRUNC(SYSDATE) BETWEEN pjf.effective_start_date AND pjf.effective_end_date
AND    pjf.job_id = pjft.job_id
AND    pjft.language = 'US'
AND    TRUNC(SYSDATE) BETWEEN pjft.effective_start_date AND pjft.effective_end_date
and    papf.person_number = nvl(:personnumber,papf.person_number)
order by papf.person_number asc,pjft.name asc nulls first

/*
------ Get Employee Assignment Grade --------------------------------------------
Created By: Ashish Harbhajanka (Oracle ACE)
Created On: 15-Apr-2023
Appln Vers: Release 13 23A
-------------------------------------------------------------------------------
*/
SELECT papf.person_number,
	   pgft.name    gradename
FROM   per_all_people_f papf,
       per_all_assignments_m paam,
       per_grades_f pgf,
	   per_grades_f_tl pgft
WHERE  papf.person_id = paam.person_id
AND    TRUNC(SYSDATE) BETWEEN papf.effective_start_date AND papf.effective_end_date
AND    paam.primary_assignment_flag = 'Y'
AND    paam.assignment_type = 'E'
AND    paam.effective_latest_change = 'Y' 
AND    TRUNC(SYSDATE) BETWEEN paam.effective_start_date AND paam.effective_end_date
AND    paam.grade_id = pgf.grade_id
AND    TRUNC(SYSDATE) BETWEEN pgf.effective_start_date AND pgf.effective_end_date
AND    pgf.grade_id = pgft.grade_id
AND    pgft.language = 'US'
AND    TRUNC(SYSDATE) BETWEEN pgft.effective_start_date AND pgft.effective_end_date
and    papf.person_number = nvl(:personnumber,papf.person_number)
order by papf.person_number asc,pgft.name asc nulls first

/*
------ Get Employee Assignment Position --------------------------------------------
Created By: Ashish Harbhajanka (Oracle ACE)
Created On: 15-Apr-2023
Appln Vers: Release 13 23A
-------------------------------------------------------------------------------
*/
SELECT papf.person_number,
	   hapft.name    positionname
FROM   per_all_people_f papf,
       per_all_assignments_m paam,
       hr_all_positions_f hapf,
	   hr_all_positions_f_tl hapft
WHERE  papf.person_id = paam.person_id
AND    TRUNC(SYSDATE) BETWEEN papf.effective_start_date AND papf.effective_end_date
AND    paam.primary_assignment_flag = 'Y'
AND    paam.assignment_type = 'E' 
AND    paam.effective_latest_change = 'Y'
AND    TRUNC(SYSDATE) BETWEEN paam.effective_start_date AND paam.effective_end_date
AND    paam.position_id = hapf.position_id
AND    TRUNC(SYSDATE) BETWEEN hapf.effective_start_date AND hapf.effective_end_date
AND    hapf.position_id = hapft.position_id
AND    hapft.language = 'US'
AND    TRUNC(SYSDATE) BETWEEN hapft.effective_start_date AND hapft.effective_end_date
and    papf.person_number = nvl(:personnumber,papf.person_number)
order by papf.person_number asc,hapft.name asc nulls first

/*
------ Get Employee Assignment Location --------------------------------------------
Created By: Ashish Harbhajanka (Oracle ACE)
Created On: 15-Apr-2023
Appln Vers: Release 13 23A
-------------------------------------------------------------------------------
*/

SELECT papf.person_number,
	   pldft.location_name  locationname  
FROM   per_all_people_f papf,
       per_all_assignments_m paam,
       per_location_details_f pldf,
	   per_location_details_f_tl pldft
WHERE  papf.person_id = paam.person_id
AND    TRUNC(SYSDATE) BETWEEN papf.effective_start_date AND papf.effective_end_date
AND    paam.primary_assignment_flag = 'Y'
AND    paam.assignment_type = 'E' 
AND    paam.effective_latest_change = 'Y'
AND    TRUNC(SYSDATE) BETWEEN paam.effective_start_date AND paam.effective_end_date
AND    paam.location_id = pldf.location_id
AND    TRUNC(SYSDATE) BETWEEN pldf.effective_start_date AND pldf.effective_end_date
AND    pldf.location_details_id = pldft.location_details_id
AND    pldft.language = 'US'
AND    TRUNC(SYSDATE) BETWEEN pldft.effective_start_date AND pldft.effective_end_date
and    papf.person_number = nvl(:personnumber,papf.person_number)
order by papf.person_number asc,pldft.location_name asc nulls first

/*
------ Get Employee Assignment Status --------------------------------------------
Created By: Ashish Harbhajanka (Oracle ACE)
Created On: 15-Apr-2023
Appln Vers: Release 13 23A
-------------------------------------------------------------------------------
*/
SELECT papf.person_number,
       pastt.user_status assignmentstatus
FROM   per_all_people_f papf,
       per_all_assignments_m paam,
	   per_assignment_status_types past,
	   per_assignment_status_types_tl pastt
WHERE  papf.person_id = paam.person_id
AND    paam.assignment_status_type_id = past.assignment_status_type_id
AND    past.assignment_status_type_id = pastt.assignment_status_type_id
AND    pastt.source_lang = 'US'
AND    TRUNC(SYSDATE) BETWEEN papf.effective_start_date AND papf.effective_end_date
AND    paam.primary_assignment_flag = 'Y'
AND    paam.assignment_type = 'E' 
and    paam.effective_latest_change = 'Y'
AND    TRUNC(SYSDATE) BETWEEN paam.effective_start_date AND paam.effective_end_date
AND    TRUNC(SYSDATE) BETWEEN past.start_date AND NVL(past.end_date,SYSDATE)
AND    papf.person_number = nvl(:personnumber,papf.person_number)
order  by papf.person_number asc,pastt.user_status asc nulls first

/*
------ Get Employee User Name --------------------------------------------
Created By: Ashish Harbhajanka (Oracle ACE)
Created On: 15-Apr-2023
Appln Vers: Release 13 23A
-------------------------------------------------------------------------------
*/
select papf.person_number,
       pu.username
from   per_all_people_f papf,
       per_users pu
WHERE  papf.person_id = pu.person_id
AND    TRUNC(SYSDATE) BETWEEN papf.effective_start_date AND papf.effective_end_date
and    papf.person_number = nvl(:personnumber,papf.person_number)
order by papf.person_number asc,pu.username asc nulls first


/*
------ Get Employee User Name --------------------------------------------
Created By: Ashish Harbhajanka (Oracle ACE)
Created On: 15-Apr-2023
Appln Vers: Release 13 23A
----------------------------------------------------------------------------
*/
SELECT papf.person_number,
       ppnf.full_name supervisorname
FROM   per_all_people_f papf,
       per_all_assignments_m paam,
       per_assignment_supervisors_f pasf,
	   per_person_names_f ppnf
WHERE  papf.person_id = paam.person_id
AND    paam.primary_assignment_flag = 'Y'
AND    paam.assignment_type = 'E' 
and    paam.effective_latest_change = 'Y'
AND    TRUNC(SYSDATE) BETWEEN paam.effective_start_date AND paam.effective_end_date
AND    TRUNC(SYSDATE) BETWEEN paam.effective_start_date AND paam.effective_end_date
AND    papf.person_id = pasf.person_id
AND    pasf.manager_type = 'LINE_MANAGER'
AND    ppnf.person_id = pasf.manager_id
AND    ppnf.name_type = 'GLOBAL'
AND    TRUNC(SYSDATE) BETWEEN pasf.effective_start_date AND pasf.effective_end_date
AND    TRUNC(SYSDATE) BETWEEN ppnf.effective_start_date AND ppnf.effective_end_date
and    papf.person_number = nvl(:personnumber,papf.person_number)
order by papf.person_number asc,ppnf.full_name asc nulls first

