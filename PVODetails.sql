--XXEmpMasterESSBusinessUnitPVO
--Custom Parameter View Object Created for "Business Unit" Parameter of Custom ESS Job "Get Employee Details"
-----BusinessUnitLOVSQL-------------------------------------------------------------------
---------------START----------------------------------------------------------------------
select houft.name
from   hr_organization_units_f_tl houft,
       hr_org_unit_classifications_f houcf,
	   hr_all_organization_units_f haouf
where  houft.language = 'US'
and    trunc(sysdate) between houft.effective_start_date and houft.effective_end_date
and    houft.organization_id = houcf.organization_id
and    houcf.classification_code = 'FUN_BUSINESS_UNIT'
and    trunc(sysdate) between houcf.effective_start_date and houcf.effective_end_date 
and    haouf.organization_id = houft.organization_id 
and    haouf.organization_id = houcf.organization_id 
and    trunc(sysdate) between haouf.effective_start_date and haouf.effective_end_date
----------END-----------------------------------------------------------------------------

--XXEmpMasterESSLegalEmployerPVO
--Custom Parameter View Object Created for "Legal Employer" Parameter of Custom ESS Job "Get Employee Details"
-----LegalEmployerLOVSQL-------------------------------------------------------------------
---------------START----------------------------------------------------------------------
select houft.name
from   hr_organization_units_f_tl houft,
       hr_org_unit_classifications_f houcf,
	   hr_all_organization_units_f haouf
where  houft.language = 'US'
and    trunc(sysdate) between houft.effective_start_date and houft.effective_end_date
and    houft.organization_id = houcf.organization_id
and    houcf.classification_code = 'HCM_LEMP'
and    trunc(sysdate) between houcf.effective_start_date and houcf.effective_end_date 
and    haouf.organization_id = houft.organization_id 
and    haouf.organization_id = houcf.organization_id 
and    trunc(sysdate) between haouf.effective_start_date and haouf.effective_end_date
----------END-----------------------------------------------------------------------------

--XXEmpMasterESSDepartmentPVO
--Custom Parameter View Object Created for "Department" Parameter of Custom ESS Job "Get Employee Details"
-----DepartmentLOVSQL-------------------------------------------------------------------
---------------START----------------------------------------------------------------------
select houft.name
from   hr_organization_units_f_tl houft,
       hr_org_unit_classifications_f houcf,
	   hr_all_organization_units_f haouf
where  houft.language = 'US'
and    trunc(sysdate) between houft.effective_start_date and houft.effective_end_date
and    houft.organization_id = houcf.organization_id
and    houcf.classification_code = 'DEPARTMENT'
and    trunc(sysdate) between houcf.effective_start_date and houcf.effective_end_date 
and    haouf.organization_id = houft.organization_id 
and    haouf.organization_id = houcf.organization_id 
and    trunc(sysdate) between haouf.effective_start_date and haouf.effective_end_date
----------END-----------------------------------------------------------------------------

--XXEmpMasterESSLocationPVO
--Custom Parameter View Object Created for "Location" Parameter of Custom ESS Job "Get Employee Details"
-----LocationLOVSQL-------------------------------------------------------------------
---------------START----------------------------------------------------------------------
select pldft.location_name
from   per_location_details_f pldf,
       per_location_details_f_tl pldft
where  pldf.location_details_id = pldft.location_details_id 
and    pldft.language = 'US'
and    trunc(sysdate) between pldf.effective_start_date and pldf.effective_end_date
and    trunc(sysdate) between pldft.effective_start_date and pldft.effective_end_date

----------END-----------------------------------------------------------------------------
--XXEmpMasterESSJobPVO
--Custom Parameter View Object Created for "Job" Parameter of Custom ESS Job "Get Employee Details"
-----JobLOVSQL-------------------------------------------------------------------
---------------START----------------------------------------------------------------------
select pjft.name
from   per_jobs_f pjf,
       per_jobs_f_tl pjft
where  pjf.job_id = pjft.job_id
and    pjft.language = 'US'
and    trunc(sysdate) between pjf.effective_start_date and pjf.effective_end_date
and    trunc(sysdate) between pjft.effective_start_date and pjft.effective_end_date
----------END-----------------------------------------------------------------------------

--XXEmpMasterESSGradePVO
--Custom Parameter View Object Created for "Grade" Parameter of Custom ESS Job "Get Employee Details"
-----GradeLOVSQL-------------------------------------------------------------------
---------------START----------------------------------------------------------------------
select pgft.name
from   per_grades_f pgf,
       per_grades_f_tl pgft
where  pgf.grade_id = pgft.grade_id 
and    pgft.language = 'US'
and    trunc(sysdate) between pgf.effective_start_date and pgf.effective_end_date 
and    trunc(sysdate) between pgft.effective_start_date and pgft.effective_end_date
----------END-----------------------------------------------------------------------------

--XXEmpMasterESSPositionPVO
--Custom Parameter View Object Created for "Position" Parameter of Custom ESS Job "Get Employee Details"
-----PositionLOVSQL-------------------------------------------------------------------
---------------START----------------------------------------------------------------------
select hapft.name
from   hr_all_positions_f hapf,
	   hr_all_positions_f_tl hapft
where  hapf.position_id = hapft.position_id
and    hapft.language = 'US'
and    trunc(sysdate) between hapf.effective_start_date and hapf.effective_end_date
and    trunc(sysdate) between hapft.effective_start_date and hapft.effective_end_date
----------END-----------------------------------------------------------------------------

--XXEmpMasterESSAssignmentStatusPVO
--Custom Parameter View Object Created for "Assignment Status" Parameter of Custom ESS Job "Get Employee Details"
-----AssignmentStatusLOVSQL-------------------------------------------------------------------
---------------START----------------------------------------------------------------------
select pastt.user_status
from   per_assignment_status_types past,
       per_assignment_status_types_tl pastt
where  past.assignment_status_type_id = pastt.assignment_status_type_id 
and    pastt.language = 'US'
and    pastt.source_lang = 'US'
----------END-----------------------------------------------------------------------------

--XXEmpMasterESSPersonNumberPVO
--Custom Parameter View Object Created for "Person Number" Parameter of Custom ESS Job "Get Employee Details"
-----PersonNumberLOVSQL-------------------------------------------------------------------
---------------START----------------------------------------------------------------------
select papf.person_number
from   per_all_people_f papf,
       per_all_assignments_m paam 
where  papf.person_id = paam.person_id 
and    paam.assignment_type = 'E'
and    paam.primary_flag = 'Y'
and    trunc(sysdate) between papf.effective_start_date and papf.effective_end_date
and    trunc(sysdate) between paam.effective_start_date and paam.effective_end_date	   

----------END-----------------------------------------------------------------------------