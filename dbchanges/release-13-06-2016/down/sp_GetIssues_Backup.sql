USE [V2Intranet]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetIssues]    Script Date: 6/13/2016 1:19:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--[dbo].[sp_GetIssues] 1878

ALTER PROCEDURE [dbo].[sp_GetIssues] 





(

	@LoginID int

	--@Password varchar(100)

	

)

AS

Declare @EmailID varchar(100)

if exists (select Emp_Email from vwPMSEmployee where Emp_User_Name = @LoginID )

--and Emp_Password =@Password)

	

select @EmailID=Emp_Email from vwPMSEmployee where Emp_User_Name = @LoginID 

--and Emp_Password =@Password



PRINT @EmailID

IF(@EmailID !='')



  BEGIN

	select Emp_User_Name,Emp_Email from  vwPMSEmployee where Emp_User_Name = @LoginID

	-- and Emp_Password =@Password

   --SELECT DISTINCT ri.ReportIssueID, 

   --(select top 1 v.Emp_Name from tblIssueAssignment a ,vwPMSEmployee v   where a.ReportIssueID = ri.ReportIssueID and v.Emp_User_Name = a.EmployeeID order by

   --  a.IssueAssignmentID desc) AS EmployeeName,

     

   --  (select top 1 v.Emp_Email from tblIssueAssignment a ,vwPMSEmployee v   where a.ReportIssueID = ri.ReportIssueID and v.Emp_User_Name = a.EmployeeID order by

   --  a.IssueAssignmentID desc) AS AssignedToEmailId,

   --  ri.StatusID,s.[StatusDesc], CONVERT(varchar, ReportIssueDate, 101) as ReportIssueDate ,ri.description ,ri.SubcategoryId, rt.ResolutionForGreen as SLA, 

   --  isnull((rt.ResolutionForAmber*60)- (dbo.timetaken(ReportIssueDate,getdate())),0) as RemainingTimeToGoTOAmberOrRed

     

	  --From tblReportIssue ri , status s

	  --left join tblResolutionTimeMaster rt on (SubCategoryID=rt.SubCategoryID And ProblemSeverityID=rt.ProblemSeverityID)

	  

	  --WHERE MailID = @EmailID and s.[PK_StatusId] = ri.StatusID 

	  --ORDER BY ReportIssueID DESC

	 SELECT DISTINCT ri.ReportIssueID, 

   (select top 1 v.Emp_Name from tblIssueAssignment a ,vwPMSEmployee v   where a.ReportIssueID = ri.ReportIssueID and v.Emp_User_Name = a.EmployeeID and (a.StatusID = 3 or a.StatusID = 5)
    order by

     a.IssueAssignmentID desc) AS EmployeeName,

     

     (select top 1 v.Emp_Email from tblIssueAssignment a ,vwPMSEmployee v   where a.ReportIssueID = ri.ReportIssueID and v.Emp_User_Name = a.EmployeeID order by

     a.IssueAssignmentID desc) AS AssignedToEmailId,

     ri.StatusID,s.[StatusDesc], CONVERT(varchar, ReportIssueDate, 101) as ReportIssueDate ,ri.description ,ri.SubcategoryId, rt.ResolutionForGreen as SLA, 

     isnull((rt.ResolutionForAmber*60)- (dbo.timetaken(ReportIssueDate,getdate())),0) as RemainingTimeToGoTOAmberOrRed

     

	  From tblReportIssue ri left join HelpDeskStatus s on ri.statusid= s.[PK_StatusId]

	  left join tblResolutionTimeMaster rt on (ri.SubCategoryID=rt.SubCategoryID And ri.ProblemSeverityID=rt.ProblemSeverityID)

	  

	  WHERE MailID = @EmailID

	  ORDER BY ReportIssueID DESC

	

	

	  

  END

else

begin



select Emp_User_Name from  vwPMSEmployee where Emp_User_Name = @LoginID 



end



select EmailID,UserName from HRMS_tbl_pm_Employee where EmployeeCode = @LoginID

--and Emp_Password =@Password

/*

IF(@EmailID !='')

  BEGIN

   SELECT DISTINCT ri.ReportIssueID, 

   (select top 1 v.Emp_Name from tblIssueAssignment a ,vwPMSEmployee v   where a.ReportIssueID = ri.ReportIssueID and v.Emp_User_Name = a.EmployeeID order by a.IssueAssignmentID desc) AS EmployeeName,

  

 ri.StatusID, 





  CONVERT(varchar, ReportIssueDate, 101) as ReportIssueDate 

  From tblReportIssue ri 

  WHERE MailID = @EmailID

  ORDER BY ReportIssueID DESC

END

*/


