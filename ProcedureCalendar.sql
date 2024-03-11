create or alter procedure dbo.uspGenerateCalendar
	@year INT,
	@Month INT
AS
Begin
Declare @StartDate Date = DATEFROMPARTS( @year,@month,1);
Declare @EndDate Date = EOMONTH(@startdate);
Declare @DaysInMonth INT = DAY(@enddate);
Declare @Day int=0
Declare @Calendar Table(day Date,DayofWeek nvarchar(30));

While @Day<@DaysInMonth
Begin
Insert into @Calendar(day)
values (dateadd(day,@day,@startdate));
Set @day +=1;
End;
Update @Calendar Set DayofWeek=DatePart(weekday,day);

Select day,Dayofweek from @Calendar
End
GO

exec dbo.uspGenerateCalendar @year = 2038,@month =12;