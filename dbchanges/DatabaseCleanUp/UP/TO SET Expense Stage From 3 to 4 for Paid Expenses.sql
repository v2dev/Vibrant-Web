
--TO SET Expense Stage From 3 to 4 for Paid Expenses 

--select ExpenseID,StageID,* from tbl_HR_Expense where ExpenseID in
--( 
--44,
--41,
--45,
--107,
--1927,
--1937,
--1943,
--1372,
--1721,
--35,
--1431,
--1385,
--1547,
--1548,
--1730,
--1394,
--1641,
--1642,
--1644,
--1669,
--1839,
--1856,
--1900,
--50,
--102,
--230,
--243,
--1588,
--1589,
--1613,
--1551,
--1296,
--250,
--1397,
--1399,
--1401,
--8,
--1368,
--1377,
--1378,
--1297,
--1356,
--1301,
--1346,
--1318,
--1803,
--1713,
--1604,
--1830
--)

--Update tbl_HR_Expense 
--SET StageID=4
--where ExpenseID in
--( 
--44,
--41,
--45,
--107,
--1927,
--1937,
--1943,
--1372,
--1721,
--35,
--1431,
--1385,
--1547,
--1548,
--1730,
--1394,
--1641,
--1642,
--1644,
--1669,
--1839,
--1856,
--1900,
--50,
--102,
--230,
--243,
--1588,
--1589,
--1613,
--1551,
--1296,
--250,
--1397,
--1399,
--1401,
--8,
--1368,
--1377,
--1378,
--1297,
--1356,
--1301,
--1346,
--1318,
--1803,
--1713,
--1604,
--1830
--) 


--select * from Tbl_HR_ExpenseStageEvent

--INSERT into Tbl_HR_ExpenseStageEvent(ExpenseID,EventDatatime,Action,FromStageId,ToStageId,UserId,Comments)
--Values(ExpenseID,GETDATE(),'Approved',3,4,'Closed as per discussion with Finance team')