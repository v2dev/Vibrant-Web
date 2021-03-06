USE [V2Intranet]
GO
/****** Object:  UserDefinedFunction [dbo].[GetEmployeeLeavebalance_1]    Script Date: 7/13/2016 12:41:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Rahul Ramachandran
-- Edited date: 2 Feb 2016
-- Description:	For Inclusion of location wise holidays
-- =============================================
ALTER FUNCTION [dbo].[GetEmployeeLeavebalance_1]
(
	-- Add the parameters for the function here
	@Employeecode int,
	@date datetime
)
RETURNS INT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @LEAVE_BALANCE decimal(10,1)
	DECLARE @officeLocation TINYINT

	select @officeLocation=OfficeLocation from V2Intranet.dbo.HRMS_tbl_PM_Employee where EmployeeCode=@Employeecode

	IF @officeLocation=2
	BEGIN
		select @LEAVE_BALANCE= sum(Quantity) from OrbitPhase2..LeaveTransaction
		where LeaveTransactionID not in (
		select LeaveTransactionID from  OrbitPhase2..LeaveTransaction t
		where (t.quantity <0 AND 
		convert(nvarchar(12),t.TransactionDate,101) in (select convert(nvarchar(12),signintime,101) from OrbitPhase2..SignInSignOut where UserID = t.UserID)
		and isnull(charindex('Manually Debited',t.description),0) <=0
		)
		union
		select LeaveTransactionID from  OrbitPhase2..LeaveTransaction t
		where (t.quantity <0 AND 
		convert(nvarchar(12),t.TransactionDate,101) in (select convert(nvarchar(12),HolidayDate,101) from OrbitPhase2..HolidayMaster where OfficeLocation in (2,9,11))
		and isnull(charindex('Manually Debited',t.description),0) <=0
		))
		AND Userid=@Employeecode and Transactiondate<=@date
	END
	ELSE IF @officeLocation=3		
	BEGIN
		select @LEAVE_BALANCE= sum(Quantity) from OrbitPhase2..LeaveTransaction
		where LeaveTransactionID not in (
		select LeaveTransactionID from  OrbitPhase2..LeaveTransaction t
		where (t.quantity <0 AND 
		convert(nvarchar(12),t.TransactionDate,101) in (select convert(nvarchar(12),signintime,101) from OrbitPhase2..SignInSignOut where UserID = t.UserID)
		and isnull(charindex('Manually Debited',t.description),0) <=0
		)
		union
		select LeaveTransactionID from  OrbitPhase2..LeaveTransaction t
		where (t.quantity <0 AND 
		convert(nvarchar(12),t.TransactionDate,101) in (select convert(nvarchar(12),HolidayDate,101) from OrbitPhase2..HolidayMaster where OfficeLocation in (3,9,11))
		and isnull(charindex('Manually Debited',t.description),0) <=0
		))
		AND Userid=@Employeecode and Transactiondate<=@date
	END
	ELSE
	BEGIN
		select @LEAVE_BALANCE= sum(Quantity) from OrbitPhase2..LeaveTransaction
		where LeaveTransactionID not in (
		select LeaveTransactionID from  OrbitPhase2..LeaveTransaction t
		where (t.quantity <0 AND 
		convert(nvarchar(12),t.TransactionDate,101) in (select convert(nvarchar(12),signintime,101) from OrbitPhase2..SignInSignOut where UserID = t.UserID)
		and isnull(charindex('Manually Debited',t.description),0) <=0
		)
		union
		select LeaveTransactionID from  OrbitPhase2..LeaveTransaction t
		where (t.quantity <0 AND 
		convert(nvarchar(12),t.TransactionDate,101) in (select convert(nvarchar(12),HolidayDate,101) from OrbitPhase2..HolidayMaster where OfficeLocation in (9,10))
		and isnull(charindex('Manually Debited',t.description),0) <=0
		))
		AND Userid=@Employeecode and Transactiondate<=@date
	END	
--		-- Add the T-SQL statements to compute the return value here
IF(@LEAVE_BALANCE<0  or @LEAVE_BALANCE is null)
		SET @LEAVE_BALANCE=0
	--IF(@LEAVE_BALANCE<0)
	--	SET @LEAVE_BALANCE=0
--	-- Return the result of the function
	RETURN @LEAVE_BALANCE

END


