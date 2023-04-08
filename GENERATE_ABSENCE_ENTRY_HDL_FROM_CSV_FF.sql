/**********************************************************                                                                                                                                                          *
* FORMULA NAME: GENERATE_ABSENCE_ENTRY_HDL_FROM_CSV        
* FORMULA TYPE: HCM Data Loader                                       
* DESCRIPTION: This formula will create PersonAbsenceEntry HDL File from CSV File
* CHANGE HISTORY:
*****************************************************************
Version              Date          Created By            Comments
-----------------------------------------------------------------------
1.0                  09-Jun-2020   Ashish Harbhajanka    Initial Version
******************************************************************/
/* Inputs  */
INPUTS ARE  OPERATION (text), LINENO (number),  LINEREPEATNO (number),POSITION1 (text), POSITION2 (text), POSITION3 (text), POSITION4 (text), 
POSITION5 (text), POSITION6 (text), POSITION7 (text), POSITION8 (text), POSITION9 (text), POSITION10 (text), POSITION11 (text)
 
DEFAULT FOR POSITION1 IS 'NO DATA'
DEFAULT FOR POSITION2 IS 'NO DATA'
DEFAULT FOR POSITION3 IS 'NO DATA'
DEFAULT FOR POSITION4 IS 'NO DATA'
DEFAULT FOR POSITION5 IS 'NO DATA'
DEFAULT FOR POSITION6 IS 'NO DATA'
DEFAULT FOR POSITION7 IS 'NO DATA'
DEFAULT FOR POSITION8 IS 'NO DATA'
DEFAULT FOR POSITION9 IS 'NO DATA'
DEFAULT FOR POSITION10 IS 'NO DATA'
DEFAULT FOR POSITION11 IS 'NO DATA'
DEFAULT FOR LINEREPEATNO IS 1
 
IF OPERATION='FILETYPE' THEN 
   OUTPUTVALUE='DELIMITED' 
ELSE IF OPERATION='DELIMITER' THEN 
   OUTPUTVALUE=',' 
ELSE IF OPERATION='READ' THEN 
   OUTPUTVALUE='NONE'
ELSE IF OPERATION = 'NUMBEROFBUSINESSOBJECTS' THEN
   (
   OUTPUTVALUE = '1'
   RETURN OUTPUTVALUE
   )
ELSE IF OPERATION = 'METADATALINEINFORMATION' THEN
    (   
		METADATA1[1]  = 'PersonAbsenceEntry' /*FileName*/ /*Reserved*/
		METADATA1[2]  = 'PersonAbsenceEntry' /*FileDiscriminator*/ /*Reserved*/
		METADATA1[3]  = 'PersonNumber'
		METADATA1[4]  = 'Employer'
		METADATA1[5]  = 'AbsenceType'
		METADATA1[6]  = 'AbsenceReason'
		METADATA1[7]  = 'AbsenceStatus'
		METADATA1[8]  = 'ApprovalStatus'
		METADATA1[9]  = 'StartDate'
		METADATA1[10] = 'StartTime'
		METADATA1[11] = 'EndDate'
		METADATA1[12] = 'EndTime'
		METADATA1[13] = 'Comments'

RETURN METADATA1
)
   
ELSE IF OPERATION='MAP' THEN 
    /*HDL Related Outputs*/
   (
		IF LINEREPEATNO = 1 THEN
		( 
			IF POSITION1 <> 'PersonNumber' THEN
			(  
				LINEREPEAT = 'Y'
				FileName = 'PersonAbsenceEntry'
				BusinessOperation = 'MERGE'
				FileDiscriminator = 'PersonAbsenceEntry'
				PersonNumber = trim(POSITION1)
				Employer = trim(POSITION2)
				AbsenceType = trim(POSITION3)
				AbsenceReason = trim(POSITION4)
				AbsenceStatus = trim(POSITION5)
				ApprovalStatus = trim(POSITION6)
				/*
				StartDate = TO_CHAR(TO_DATE(POSITION7,'YYYY/MM/DD'))
				*/
				StartDate = trim(POSITION7)
				StartTime = trim(POSITION8)
				EndDate   = trim(POSITION9)
				/*
				EndDate   = TO_CHAR(TO_DATE(POSITION9,'YYYY/MM/DD'))
				*/
				EndTime   = trim(POSITION10)
				Comments  = trim(POSITION11)	
 
				RETURN BusinessOperation,FileName,FileDiscriminator,PersonNumber,Employer,AbsenceType,AbsenceReason,AbsenceStatus,ApprovalStatus,Comments,StartDate,StartTime,EndDate,EndTime,LINEREPEAT,LINEREPEATNO
			)
		)
	)

ELSE 
   OUTPUTVALUE='NONE'
RETURN OUTPUTVALUE
/* End Formula Text */