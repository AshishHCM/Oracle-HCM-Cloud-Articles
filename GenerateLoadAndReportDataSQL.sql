----------------------------------------------------------------------------------------------------------------------------------------------
--SQL File Desc: Contains SQL for the queries used in "Generate Load and Report Date" Article                                                  |
--Created  By  : Ashish Harbhajanka (Oracle ACE)                                                                                               |                                                
--Comments     : For more such information, erp implementation, HR Digital Transformation, Training and support contact ashish1234u@gmail.com  | 
--               Copyrights reserved. Do Not Copy without written permission. Can be used for reference purposes.                              |
-----------------------------------------------------------------------------------------------------------------------------------------------|
----TaskFlow_ds SQL (Master Data Set SQL)-----------------------------------------------
select r.call_id 
from pay_flow_task_instances fti,pay_flow_tasks_vl ft,pay_requests r 
where ft.flow_task_name = 'Generate Data' 
and ft.base_flow_task_id = fti.base_flow_task_id 
and fti.flow_task_instance_id = r.flow_task_instance_id 
and r.call_type= 'ESS' 
and  fti.flow_task_instance_id = :TASK_INSTANCE_ID
union 
select 1234 from dual where :TASK_INSTANCE_ID is null 
----GenerateData_ds SQL (Actual SQL which generates data)-----------------------------------------------
select  'ADJOTH' ACCRUALTYPE,'SICK_ADJ' ADJUSTMENTREASON,papf.person_number PERSONNUMBER,aapft.name PLANNAME,7 VALUE,
		 (
		  select distinct paam1.assignment_number from   per_all_assignments_m paam1
		  where  paam1.assignment_type = 'ET' and paam1.primary_flag = 'N'  and trunc(ppos.date_start) between paam1.effective_start_date and paam1.effective_end_date
		  and    paam1.period_of_service_id = ppos.period_of_service_id and paam1.person_id = papf.person_id and rownum = 1 ) WORKTERMSNUMBER,
		  to_char(SYSDATE,'YYYY/MM/DD') PROCDDATE,'HRC_LEGACY' SOURCESYSTEMOWNER,papf.person_number || '_' || upper(aapft.name) || '_' || 'SICK_ADJ' || '_' || TO_CHAR(SYSDATE,'YYYYMMDD'
		  ) SOURCESYSTEMID
from   per_all_people_f papf,per_periods_of_service ppos,anc_absence_plans_f_tl aapft,per_all_assignments_m paam,anc_per_plan_enrollment appe
where  papf.person_id = paam.person_id and papf.person_id = ppos.person_id and ppos.period_of_service_id = paam.period_of_service_id and appe.prd_of_svc_id = paam.period_of_service_id 
and    papf.person_id = appe.person_id and appe.plan_id = aapft.absence_plan_id and paam.primary_flag = 'Y' and paam.assignment_type IN ('E', 'C', 'N', 'P')
and aapft.language = 'US' and aapft.name = 'Sick' 
and trunc(ppos.date_start) between papf.effective_start_date and papf.effective_end_date and trunc(ppos.date_start) between paam.effective_start_date and paam.effective_end_date
and trunc(ppos.date_start) between aapft.effective_start_date and aapft.effective_end_date and not exists
(
select 1 from   anc_per_acrl_entry_dtls apaed,anc_absence_plans_f_tl aapft
where apaed.type = 'ADJOTH' and   apaed.adjustment_reason = 'SICK_ADJ' and apaed.pl_id = aapft.absence_plan_id and aapft.language = 'US' and aapft.name = 'Sick' 
and apaed.person_id = papf.person_id
)
---- BurstToUCM_ds SQL (BURSTING SQL)-------------------------------------------------------------------------------------------------------
select to_char(call_id) as "KEY",'PersonAccrualDetail' TEMPLATE,'en-US' LOCALE,'TEXT' OUTPUT_FORMAT,'WCC' DEL_CHANNEL,
       'FA_UCM_PROVISIONED' PARAMETER1, 								/* Server Name */
       'FAFusionImportExport' PARAMETER2, 								/* Security Group */
       :xdo_user_name PARAMETER3, 										/* Author of the File */
       'PersonAccrualDetail'||to_char(call_id) PARAMETER5, 		        /* Title */
       'PersonAccrualDetail.dat' PARAMETER6, 	                        /* Output File Name */
       :TASK_INSTANCE_ID PARAMETER7, 			                        /* Comments (Optional) */
       'PersonAccrualDetail'||to_char(call_id) PARAMETER8,  			/* Content ID (Optional) If you specify the ID, it must be unique. If you don't specify the ID, the system generates a unique one. */
       'FALSE' PARAMETER9 												/* Custom metadata (true/false). Specify ‘false’. */
from 
(select 	r.call_id
 from 		pay_flow_task_instances fti,pay_flow_tasks_vl ft,pay_requests r
 where 		ft.flow_task_name = 'Generate Data' and ft.base_flow_task_id = fti.base_flow_task_id 
 and 		fti.flow_task_instance_id = r.flow_task_instance_id and r.call_type= 'ESS' and  fti.flow_task_instance_id = :TASK_INSTANCE_ID
 union
 select 	1234 from dual where :TASK_INSTANCE_ID is null)
