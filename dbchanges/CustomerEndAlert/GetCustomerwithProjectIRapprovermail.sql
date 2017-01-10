USE [V2Intranet]
GO
/****** Object:  StoredProcedure [dbo].[GetCustomerwithProjectIRapprovermail]    Script Date: 1/10/2017 5:23:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Mahesh Farad
-- Create date: 9th jan 2017 
-- Description:	To Get Project IR Approver Email for CustomerEndAlert
-- =============================================
ALTER PROCEDURE [dbo].[GetCustomerwithProjectIRapprovermail] 
	-- Add the parameters for the stored procedure here
@customerId int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select DISTINCT IR.ProjectId,IR.ApproverId,he.emailId from tbl_PM_IRApprovers IR
	left join tbl_pm_employee emp on emp.employeeid = IR.ApproverId
	left join HRMS_tbl_PM_Employee he on (he.EmployeeCode=emp.EmployeeCode)
	where ProjectId in (select p.ProjectID from tbl_PM_Customer c
join  tbl_pm_project p on (c.Customer=p.CustomerID)
where c.Customer=@customerId)
END
