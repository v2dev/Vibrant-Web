USE [V2Intranet]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetDetailOfEmployeeToAvailable2]    Script Date: 7/29/2016 5:50:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER  procedure [dbo].[sp_GetDetailOfEmployeeToAvailable2] --[sp_GetDetailOfEmployeeToAvailable2] 1008
@EmployeeId int  
as  
/*select * from tblCategoryMaster x,   
(  
select CategoryID,isAdmin  
 from tblHelpdeskEmployeeRoles  
 where EmployeeID=@SuperAdminEmployeeId AND IsAdmin =1  
) y            
 where x.isActive=1  
 and x.CategoryID = y.CategoryID*/  

create table #temp4 (CategoryID int,Category varchar(50) ,isActive bit,IsAdmin bit )


insert into #temp4
Select b.CategoryID,b.Category,b.isActive,a.IsAdmin  from tblHelpdeskEmployeeRoles a LEFT JOIN  (Select CategoryID,Category,isActive from tblCategoryMaster where CategoryID  in (  
select CategoryID from tblHelpdeskEmployeeRoles where IsAdmin =1  
) and isActive =1)b  ON b.CategoryID = a.CategoryID
where a.EmployeeID=@EmployeeId  
 and b.isActive =1  

 Select a.CategoryID,a.Category,a.isActive ,a.CategoryID ,b.IsAdmin  from #temp4 b right join  tblCategoryMaster a on (b.CategoryID=a.CategoryID) where a.isActive=1




 declare @testcategoryID1 int  
 declare getcategoryid cursor for   
 select distinct(x.CategoryId)   
         from tblCategoryMaster x,tblHelpdeskEmployeeRoles y  
    WHERE x.CategoryID= y.CategoryID  
AND  y.IsAdmin=1  
  and  IsActive=1   
 open getcategoryid  
 Fetch Next from getcategoryid into @testcategoryID1  
 while @@FETCH_STATUS=0  
 BEGIN   
 Select   
 distinct(b.Subcategory ), b.SubCategoryID  
 from   
 tblSubCategoryAssignment a,  
 tblSubCategoryMaster b   
 where --a.EmployeeID=@EmployeeId and  
  b.CategoryID = @testcategoryID1   
  and b.IsActive=1  
 and b.SubCategoryID    not in   
 (  
 Select   
 distinct(tblSubCategoryAssignment.SubcategoryId )  
 from   
 tblSubCategoryAssignment,  
 tblSubCategoryMaster    
 where tblSubCategoryAssignment.EmployeeID=@EmployeeId    
 and tblSubCategoryAssignment.SubCategoryID = tblSubCategoryMaster.SubCategoryID  
  and  tblSubCategoryMaster.CategoryID = @testcategoryID1  and tblSubCategoryMaster.IsActive=1  
                )  
 Fetch Next from getcategoryid into @testcategoryID1  
 end  
 close getcategoryid  
 deallocate getcategoryid  

  
  
  
  


