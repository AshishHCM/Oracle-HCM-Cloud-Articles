-----------------------------------------------------------------------------------------------------------------------
--|File Name	: EmployeeMaster.sql	                                                                              |
--|SQL Purpose	: Get Employee Basic Assignment Details		                                                          |
--|Columns      : Person Number,Business Unit,Legal Employer,Department,Location,Position,Job,Grade,Assignment Status |																				  | Creation Date | Created By									| Supported Fusion Application Version
--|Creation Date: 14-FEB-2023                                                                                         |
--|Created By   : Ashish Harbhajanka (ashish1234u@gmail.com)                                                          |
--|Application  : Release 13 22D                                                                                      |
-----------------------------------------------------------------------------------------------------------------------
SELECT papf.person_number employeenumber,
       houft_bu.name  businessunit,
	   houft_lemp.name legalemployer,
       houft_dept.name department,
	   pldft.location_name locationname,
	   hapft.name   positionname,
	   pjft.name jobname,
	   pgft.name gradename,
	   pastt.user_status assignmentstatus 
FROM   per_all_people_f papf,
       per_all_assignments_m paam,
	   per_periods_of_service ppos, 
	   per_location_details_f pldf,
	   per_location_details_f_tl pldft,
	   hr_all_positions_f hapf,
	   hr_all_positions_f_tl hapft,
	   per_jobs_f pjf,
	   per_jobs_f_tl pjft,
	   per_grades_f pgf,
	   per_grades_f_tl pgft,
	   per_assignment_status_types past,
	   per_assignment_status_types_tl pastt,
	   hr_org_unit_classifications_f houcf_bu,
	   hr_org_unit_classifications_f houcf_lemp,
	   hr_org_unit_classifications_f houcf_dept,
	   hr_all_organization_units_f   haouf_bu,
	   hr_all_organization_units_f   haouf_lemp,
	   hr_all_organization_units_f   haouf_dept,
	   hr_organization_units_f_tl    houft_bu,
	   hr_organization_units_f_tl    houft_lemp,
	   hr_organization_units_f_tl    houft_dept
WHERE  papf.person_id = paam.person_id 
AND    ppos.person_id = papf.person_id
AND    ppos.period_of_service_id = paam.period_of_service_id 
AND    paam.primary_flag = 'Y'
AND    paam.assignment_type = 'E' 
AND    paam.effective_latest_change = 'Y'
AND    ppos.primary_flag = 'Y' 
AND    paam.assignment_status_type_id = past.assignment_status_type_id
AND    past.assignment_status_type_id = pastt.assignment_status_type_id 
AND    pastt.source_lang = 'US'
AND    paam.location_id = pldf.location_id
AND    pldf.location_details_id = pldft.location_details_id 
AND    pldft.language = 'US'
AND    paam.position_id = hapf.position_id 
AND    hapf.position_id = hapft.position_id
AND    hapft.language = 'US' 
AND    paam.job_id = pjf.job_id
AND    pjf.job_id = pjft.job_id 
AND    pjft.language = 'US'
AND    paam.grade_id = pgf.grade_id 
AND    pgf.grade_id = pgft.grade_id
AND    pgft.language = 'US' 
AND    haouf_bu.ORGANIZATION_ID = houcf_bu.ORGANIZATION_ID 
AND    haouf_bu.ORGANIZATION_ID = houft_bu.ORGANIZATION_ID
AND    houft_bu.EFFECTIVE_START_DATE = haouf_bu.EFFECTIVE_START_DATE 
AND    houft_bu.EFFECTIVE_END_DATE = haouf_bu.EFFECTIVE_END_DATE 
AND    houcf_bu.CLASSIFICATION_CODE = 'FUN_BUSINESS_UNIT' 
AND    houft_bu.organization_id = paam.business_unit_id
AND    houft_bu.LANGUAGE = 'US' 
AND    haouf_lemp.ORGANIZATION_ID = houcf_lemp.ORGANIZATION_ID 
AND    haouf_lemp.ORGANIZATION_ID = houft_lemp.ORGANIZATION_ID 
AND    houft_lemp.EFFECTIVE_START_DATE = haouf_lemp.EFFECTIVE_START_DATE 
AND    houft_lemp.EFFECTIVE_END_DATE = haouf_lemp.EFFECTIVE_END_DATE 
AND    houcf_lemp.CLASSIFICATION_CODE = 'HCM_LEMP'
AND    houft_lemp.organization_id = paam.legal_entity_id 
AND    houft_lemp.LANGUAGE = 'US'
AND    haouf_dept.ORGANIZATION_ID = houcf_dept.ORGANIZATION_ID 
AND    haouf_dept.ORGANIZATION_ID = houft_dept.ORGANIZATION_ID
AND    houft_dept.EFFECTIVE_START_DATE = haouf_dept.EFFECTIVE_START_DATE 
AND    houft_dept.EFFECTIVE_END_DATE = haouf_dept.EFFECTIVE_END_DATE 
AND    houcf_dept.CLASSIFICATION_CODE = 'DEPARTMENT' 
AND    houft_dept.organization_id = paam.organization_id
AND    houft_dept.LANGUAGE = 'US' 
AND    TRUNC(SYSDATE) BETWEEN papf.effective_start_date AND papf.effective_end_date
AND    TRUNC(SYSDATE) BETWEEN paam.effective_start_date AND paam.effective_end_date 
AND    TRUNC(SYSDATE) BETWEEN pldf.effective_start_date AND pldf.effective_end_date
AND    TRUNC(SYSDATE) BETWEEN pldft.effective_start_date AND pldft.effective_end_date 
AND    TRUNC(SYSDATE) BETWEEN hapf.effective_start_date AND hapf.effective_end_date
AND    TRUNC(SYSDATE) BETWEEN hapft.effective_start_date AND hapft.effective_end_date 
AND    TRUNC(SYSDATE) BETWEEN pjf.effective_start_date AND pjf.effective_end_date
AND    TRUNC(SYSDATE) BETWEEN pjft.effective_start_date AND pjft.effective_end_date 
AND    TRUNC(SYSDATE) BETWEEN pgf.effective_start_date AND pgf.effective_end_date
AND    TRUNC(SYSDATE) BETWEEN pgft.effective_start_date AND pgft.effective_end_date 
AND    TRUNC(SYSDATE) BETWEEN houcf_bu.EFFECTIVE_START_DATE AND houcf_bu.EFFECTIVE_END_DATE 
AND    TRUNC(SYSDATE) BETWEEN houft_bu.effective_start_date AND houft_bu.effective_end_date 
AND    TRUNC(SYSDATE) BETWEEN houcf_lemp.EFFECTIVE_START_DATE AND houcf_lemp.EFFECTIVE_END_DATE 
AND    TRUNC(SYSDATE) BETWEEN houft_lemp.effective_start_date AND houft_lemp.effective_end_date 
AND    TRUNC(SYSDATE) BETWEEN houcf_dept.EFFECTIVE_START_DATE AND houcf_dept.EFFECTIVE_END_DATE
AND    houft_bu.name               = nvl(:p_business_unit,houft_bu.name)
AND    houft_lemp.name             = nvl(:p_legalemployer,houft_lemp.name)
AND    houft_dept.name             = nvl(:p_department, houft_dept.name)
AND    pldft.location_name         = nvl(:p_location, pldft.location_name)
AND    pjft.name                   = nvl(:p_job, pjft.name)
AND    pgft.name                   = nvl(:p_grade, pgft.name)
AND    hapft.name                  = nvl(:p_position, hapft.name)
AND    pastt.user_status           = nvl(:p_assignmentstatus,pastt.user_status)
AND    papf.person_number          = nvl(:p_person_number,papf.person_number)
