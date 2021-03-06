USE [V2Intranet]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetSLAReport]    Script Date: 6/13/2016 1:21:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC sp_GetResolutionTimeDetails 0, -1,'1 January 2013','1 March 2008',2006

ALTER PROCEDURE [dbo].[sp_GetSLAReport] 

@DepartmentID int,  
@FromDate datetime,  
@ToDate datetime 
as
 
begin	

	select distinct r.ReportIssueID as IssueID, R.Description as HelpDeskName,st.SubCategory as Category,
	r.Name as Requester,Category Department,StatusDesc as Status,
	
	 case when r.typeid = '1' then 'Request'
	 when r.typeid = '2' then 'Issue'
	 else 'Not Set' end as Type,
	
	c.ProblemSeverity as ProblemSeverity,isnull(b.EmployeeName,'') as AssignedTo,
	r.ReportIssueDate as SubmittedDate,
	
	case when a.IssueResolvedDate='1900-01-01 00:00:00.000' then '' else a.IssueResolvedDate end as ResolvedOn,
	case when (PK_Statusid=3 or PK_Statusid=8 or PK_Statusid=9) then (case when a.IssueHealth=1 then 'MET' else 'Not MET' end)
	 when (PK_Statusid=2 or PK_Statusid=4 or PK_Statusid=5 or PK_Statusid=6 or PK_Statusid=7 )
	 then 'Not Occurred ' when (PK_Statusid=1) then 'Not Acknowledged' end as ResolutionHealth,
	
	 
	 datename(month,r.ReportIssueDate) as [Month],datename(Year,r.ReportIssueDate) as [Year] 
	 from tblReportIssue r 
	 left join vwResolutionsTimeDetailsNew a on  r.ReportIssueId = a.ReportIssueId  
	 left join tblHelpdeskEmployee b on  b.EmployeeID = a.AssignEmployeeID 
	 left join tblProblemSeverityMaster c on  r.ProblemSeverityID =  c.ProblemSeverityID 
	 left join helpdeskStatus s on s.pk_StatusId=r.Statusid 
	 left join tblSubCategoryMaster st on R.Subcategoryid = st.Subcategoryid 
	 left join tblCategoryMaster t on t.CategoryId= st.Categoryid  
	  
--	 comparing only date not time 
	 where t.Categoryid = @DepartmentID and (DATEADD(dd, 0, DATEDIFF(dd, 0, r.ReportIssueDate)) between 
       		DATEADD(dd, 0, DATEDIFF(dd, 0,@FromDate)) and  DATEADD(dd, 0, DATEDIFF(dd, 0, @ToDate)))
       		
       		order by r.ReportIssueID desc
       		

end

