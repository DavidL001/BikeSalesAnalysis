-- Cleaned FactInternetSales Table --
SELECT 
  [ProductKey], 
  [OrderDateKey], 
  [DueDateKey], 
  [ShipDateKey], 
  [CustomerKey], 
  --[PromotionKey]
  --[CurrencyKey]
  --[SalesTerritoryKey]
  [SalesOrderNumber], 
  --[SalesOrderLineNumber]
  --[RevisionNumber]
  --[OrderQuantity]
  --[UnitPrice]
  --[ExtendedAmount]
  --[UnitPriceDiscountPct]
  --[DiscountAmount]
  --[ProductStandardCost]
  --[TotalProductCost]
  [SalesAmount] --[TaxAmt]
  --[Freight]
  --[CarrierTrackingNumber]
  --[CustomerPONumber]
  --[OrderDate]
  --[DueDate]
  --[ShipDate]
FROM 
  [AdventureWorksDW2022].[dbo].[FactInternetSales] 
WHERE 
  LEFT(OrderDateKey, 4) >= YEAR(GETDATE()) -2 -- Extract only data from up to 2 years ago, in this case it would be since 2019
ORDER BY 
  OrderDateKey ASC 
  
-- Cleaned Dim.Products Table --
SELECT 
  prd.[ProductKey], 
  prd.[ProductAlternateKey] AS [Product_Item_Code], 
  --[ProductSubcategoryKey]
  --[WeightUnitMeasureCode]
  --[SizeUnitMeasureCode]
  prd.[EnglishProductName] AS [ProductName], 
  scat.EnglishProductSubcategoryName AS [Subcategory], 
  cat.EnglishProductCategoryName AS [Product_Category], 
  --[SpanishProductName]
  --   [FrenchProductName]
  --   [StandardCost]
  --   [FinishedGoodsFlag]
  prd.[Color] AS [Product_Color], 
  --[SafetyStockLevel]
  --[ReorderPoint]
  --[ListPrice]
  prd.[Size] AS [Product_Size], 
  --   [SizeRange]
  --   [Weight]
  --[DaysToManufacture]
  prd.[ProductLine], 
  --[DealerPrice]
  --[Class]
  --[Style]
  prd.[ModelName] AS [Product_Model_Name], 
  --[LargePhoto]
  prd.[EnglishDescription] AS [Product_Description], 
  --[FrenchDescription]
  --[ChineseDescription]
  --[ArabicDescription]
  --[HebrewDescription]
  --[ThaiDescription]
  --[GermanDescription]
  --[JapaneseDescription]
  --[TurkishDescription]
  --[StartDate]
  --[EndDate]
  ISNULL(prd.Status, 'Outdated') AS [Product_Status] 
FROM 
  [AdventureWorksDW2022].[dbo].[DimProduct] as prd 
  LEFT JOIN DimProductSubcategory AS scat 
  ON scat.ProductSubcategoryKey = prd.ProductSubcategoryKey 
  LEFT JOIN DimProductCategory AS cat 
  ON scat.ProductCategoryKey = cat.ProductCategoryKey 
ORDER BY 
  prd.ProductKey ASC 
 
-- Cleaning and Labeling of Dim.Date Table --
SELECT 
  [DateKey], 
  [FullDateAlternateKey] AS Date, 
  --[DayNumberOfWeek]
  [EnglishDayNameOfWeek] AS Day, 
  --[SpanishDayNameOfWeek]
  --[FrenchDayNameOfWeek]
  --[DayNumberOfMonth]
  --[DayNumberOfYear]
  [WeekNumberOfYear] AS WeekNr, 
  [EnglishMonthName] AS Month, 
  LEFT([EnglishMonthName], 3) AS MonthShort, 
  --[SpanishMonthName]
  --[FrenchMonthName]
  [MonthNumberOfYear] AS MonthNo, 
  [CalendarQuarter] AS Quarter, 
  [CalendarYear] AS Year --[CalendarSemester]
  --[FiscalQuarter]
  --[FiscalYear]
  --[FiscalSemester]
FROM 
  [AdventureWorksDW2022].[dbo].[DimDate] 
WHERE 
  CalendarYear >= 2019 -- Sales Manager analyzes data from up to 2 years back, from 2021
 
-- Cleaned Dim.Customers Table --
SELECT 
  cus.[CustomerKey] AS CustomerKey, 
  --[GeographyKey]
  --[CustomerAlternateKey]
  --[Title]
  cus.[FirstName], 
  --[MiddleName]
  cus.[LastName], 
  cus.[FirstName] + ' ' + cus.[LastName] AS [FullName], 
  -- Combining their First and Last Names
  --[NameStyle]
  --[BirthDate]
  --[MaritalStatus]
  --[Suffix]
  CASE cus.[Gender] WHEN 'M' THEN 'Male' WHEN 'F' THEN 'Female' END AS Gender, 
  --[EmailAddress]
  --[YearlyIncome]
  --[TotalChildren]
  --[NumberChildrenAtHome]
  --[EnglishEducation]
  --[SpanishEducation]
  --[FrenchEducation]
  --[EnglishOccupation]
  --[SpanishOccupation]
  --[FrenchOccupation]
  --[HouseOwnerFlag]
  --[NumberCarsOwned]
  --[AddressLine1]
  --[AddressLine2]
  --[Phone]
  cus.[DateFirstPurchase], 
  --[CommuteDistance]
  geo.[City] AS [CustomerCity] 
FROM 
  [AdventureWorksDW2022].[dbo].[DimCustomer] AS cus 
  LEFT JOIN [AdventureWorksDW2022].[dbo].[DimGeography] AS geo 
  ON geo.geographykey = cus.geographykey 
ORDER BY 
  CustomerKey ASC
