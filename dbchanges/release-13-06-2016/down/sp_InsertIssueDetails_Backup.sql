USE [V2Intranet]
GO
/****** Object:  StoredProcedure [dbo].[sp_InsertIssueDetails]    Script Date: 6/13/2016 1:20:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_InsertIssueDetails]         
(        
        
 --@ReportIssueID int,         
 @Name varchar(100), --commented on july 17        
 @EmailID varchar(100),        
 @CCEmailID varchar(100),        
 @PhoneExtension varchar(100),        
 @SeatingLocation varchar(100),        
 @SubCategoryID int,        
 @SeverityID int,        
 ----@PriorityID int,        
 @UploadedFileName varchar(100),        
 @UploadedFileExtension varchar(50),        
 @Description varchar(1000),        
 @StatusID int,  
 @TypeID int,  
 --Added By Nikhil For PMS Category  
 --Start  
 @ProjectNameId int,  
 @ProjectRoleId int,  
 @WorkHours int,  
 @FromDate datetime = null,  
 @ToDate datetime = null,  
 @NumberOfResources int,  
 @ResourcePoolId int,  
 @ReportingToId int      
 --end  
 --Adding now on july 17 by puja        
 --@NameProvided varchar(100)        
)        
AS    
declare @ReportIssueID int  
  
 set @ReportIssueID = (select ISNUll(max(ReportIssueID),0) from tblReportIssue) + 1     
 INSERT INTO tblReportIssue        
-- --(ReportIssueID,Name, MailId, CCMailID, PhoneExt, SeatingLocation, SubCategoryID, ProblemSeverityID, ProblemPriorityID, Description, StatusID, ReportIssueDate)VALUES         
-- --(@ReportIssueID,@EmployeeID+' --- ' +@Name, @EmailID, @CCEmailID, @PhoneExtension, @SeatingLocation, @SubCategoryID, @SeverityID, @PriorityID, @Description, @StatusID, getdate())        
          
(Name,MailId, CCMailID, PhoneExt, SeatingLocation, SubCategoryID, ProblemSeverityID, Description,TypeID,  
 StatusID, ReportIssueDate,ProjectNameId,ProjectRoleId,WorkHours,FromDate,ToDate,NumberOfResources,ResourcePoolId,ReportingToId)VALUES         
 (@Name,@EmailID, @CCEmailID, @PhoneExtension, @SeatingLocation, @SubCategoryID, @SeverityID, @Description,@TypeID,  
  @StatusID, getdate(),@ProjectNameId,@ProjectRoleId,@WorkHours,@FromDate,@ToDate,@NumberOfResources,@ResourcePoolId,@ReportingToId)        
         
  --SELECT ReportIssueID FROM tblReportIssue WHERE ReportIssueID = @reportIssueID        
        
 --Update the uploaded file to the blReportIssueID, to the same record, which is added above        
  IF(@UploadedFileName != '0' AND @UploadedFileExtension != '0')        
  BEGIN        
   --UPDATE tblReportIssue SET FileName = @UploadedFileName+'_'+convert(varchar,@ReportIssueID)+@UploadedFileExtension WHERE ReportIssueID = @ReportIssueID   
   INSERT INTO [dbo].[tblFileInfo]  
(reportIssueID,FileName)values  
(@reportIssueID,@UploadedFileName+'_'+convert(varchar,@ReportIssueID)+@UploadedFileExtension)   
          
  END   
  if(@ReportIssueID = (select ISNUll(max(ReportIssueID),0) from tblReportIssue))   
  begin  
  select ISNUll(max(ReportIssueID ),0)as IssueId from tblReportIssue  
  end  
