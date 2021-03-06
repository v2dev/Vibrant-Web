USE [V2Intranet]
GO
/****** Object:  UserDefinedFunction [dbo].[GetEmployeeLeavebalance_2]    Script Date: 7/13/2016 12:41:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--select dbo.[GetEmployeeLeavebalance_2](3942, '1/6/2015')
-- =============================================
-- Author:		Rahul Ramachandran
-- Edited date: 2 Feb 2016
-- Description:	For inclusion of location wise holidays
-- =============================================
ALTER FUNCTION [dbo].[GetEmployeeLeavebalance_2]
(
	-- Add the parameters for the function here
	@Employeecode int,
	@date datetime
)
RETURNS INT
AS
BEGIN
	-- Declare the return variable here
	DECLARE @LEAVE_BALANCE int,@TmpLeave int =0, @Final_Leave int=0
	DECLARE @officeLocation tinyint

	SELECT @officeLocation=OfficeLocation FROM V2Intranet..HRMS_tbl_PM_Employee WHERE EmployeeCode=@Employeecode

	select @TmpLeave = case when DBO.GetEmployeeLeavebalance_1(@Employeecode,'12/31/2014 23:59:59:997') > 30 then 30 
	else DBO.GetEmployeeLeavebalance_1(@Employeecode,'12/31/2014 23:59:59:997') end

	if cast(@date as datetime) <= cast('12/31/2014 23:59:59:997' as datetime)
	 RETURN @TmpLeave

	IF @officeLocation=2
	BEGIN
		select @LEAVE_BALANCE= sum(Quantity) from OrbitPhase2..LeaveTransaction
		where cast(TransactionDate as datetime) between cast('01/01/2015 00:00:00.000' as datetime) and cast(@date as datetime)
		and LeaveTransactionID not in (
		select LeaveTransactionID from  OrbitPhase2..LeaveTransaction t
		where (t.quantity <0 AND 
		convert(nvarchar(12),t.TransactionDate,101) in (select convert(nvarchar(12),signintime,101) from OrbitPhase2..SignInSignOut where UserID = t.UserID)
		and isnull(charindex('Manually Debited',t.description),0) <=0
		)
		union
		select LeaveTransactionID from  OrbitPhase2..LeaveTransaction t
		where (t.quantity <0 AND 
		convert(nvarchar(12),t.TransactionDate,101) in (select convert(nvarchar(12),HolidayDate,101) from OrbitPhase2..HolidayMaster where OfficeLocation in ( 2,9,11))
		and isnull(charindex('Manually Debited',t.description),0) <=0
		))
		AND Userid=@Employeecode and Transactiondate<=@date
	END
	ELSE IF @officeLocation=3
	BEGIN
		select @LEAVE_BALANCE= sum(Quantity) from OrbitPhase2..LeaveTransaction
		where cast(TransactionDate as datetime) between cast('01/01/2015 00:00:00.000' as datetime) and cast(@date as datetime)
		and LeaveTransactionID not in (
		select LeaveTransactionID from  OrbitPhase2..LeaveTransaction t
		where (t.quantity <0 AND 
		convert(nvarchar(12),t.TransactionDate,101) in (select convert(nvarchar(12),signintime,101) from OrbitPhase2..SignInSignOut where UserID = t.UserID)
		and isnull(charindex('Manually Debited',t.description),0) <=0
		)
		union
		select LeaveTransactionID from  OrbitPhase2..LeaveTransaction t
		where (t.quantity <0 AND 
		convert(nvarchar(12),t.TransactionDate,101) in (select convert(nvarchar(12),HolidayDate,101) from OrbitPhase2..HolidayMaster where OfficeLocation in ( 3,9,11))
		and isnull(charindex('Manually Debited',t.description),0) <=0
		))
		AND Userid=@Employeecode and Transactiondate<=@date
	END
	ELSE
	BEGIN
		select @LEAVE_BALANCE= sum(Quantity) from OrbitPhase2..LeaveTransaction
		where cast(TransactionDate as datetime) between cast('01/01/2015 00:00:00.000' as datetime) and cast(@date as datetime)
		and LeaveTransactionID not in (
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
	IF(  @LEAVE_BALANCE is null)
	--IF(@LEAVE_BALANCE<0  or @LEAVE_BALANCE is null) --4372: Incorrect Leave Balance
		SET @LEAVE_BALANCE=0
	SET @Final_Leave = @TmpLeave + @LEAVE_BALANCE
--		-- Add the T-SQL statements to compute the return value here
	IF(@Final_Leave<0)
		SET @Final_Leave = 0
--	-- Return the result of the function
	RETURN @Final_Leave

END
