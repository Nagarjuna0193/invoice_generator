SELECT DISTINCT
		 concat_ignore_null(x.`Air_Vendor`, x.`GST`, x."Transaction_Type", x."Mercury Inv No", DATE(x."DOT"), x."Ticket/PNR", x.`Workspace`, x.`Passenger Name`, x."PNR", x.`PNR No`, x.`Invoice Status`) as 'ID',
		 x."Type" as 'Type',
		 x."Customer Name" as 'Customer Name',
		 x."Party Site Name" as "Party Site Name",
		 x."Mercury Inv No" as 'Mercury Inv No',
		 x."Inv No" as "INV No",
		 x."Aginst CM" as "Aginst CM",
		 x."Inv Date" as "Inv Date",
		 x."Code" as "Code",
		 x."GST" as 'GST',
		 x."Arln Inv" as "Arln Inv"	,
		 x."Date" as "Date",
		 x."Arln GST" as "Arln GST"	,
		 x."Air_Vendor" as "Air_Vendor",
		 x."Passenger Name" as 'Passenger Name',
		 x."Ticket_Number" as 'Ticket_Number',
		 x."Arln Code" as "Arln Code",
		 x."Flg No" as "Flg No",
		 x."GL Code" as "GL Code",
		 x."Basic Fare" as "Basic Fare",
		 x."SGST" as "SGST",
		 x."CGST" as "CGST",
		 x."IGST" as "IGST",
		 x."Total" as "Total",
		 DATE(x."DOT") as 'DOT',
		 x."Class" as 'Class',
		 x."Sector" as 'Sector',
		 x."Cost Centre" as "Cost Centre",
		 x."Employee Code" as "Employee Code",
		 x."Project Code" as "Project Code",
		 x."Trip CC" as "Trip CC",
		 x."PNR No" as 'PNR No',
		 x."Airline Name" as "Airline Name",
		 x."Workspace" as 'Workspace',
		
		 x."PNR" as 'PNR',
		 
		 x."Ticket/PNR" as 'Ticket/PNR',
		 x."Invoice - Customer_GSTIN" as 'Invoice - Customer_GSTIN',
		 x."Invoice - Name as per GST portal" as 'Invoice - Name as per GST portal',
		 x."Supplier_GSTIN" as 'Supplier_GSTIN',
		 x."Invoice_Number" as 'Invoice_Number',
		 x."Invoice_Date" as 'Invoice_Date',
		 x."Invoice Taxable" as 'Invoice Taxable',
		 x."Invoice CGST" as 'Invoice CGST',
		 x."Invoice SGST" as 'Invoice SGST',
		 x."Invoice IGST" as 'Invoice IGST',
		 x."Invoice Total_GST" as 'Invoice Total_GST',
		 x."Invoice Total_Amount" as 'Invoice Total_Amount',
		 x."Transaction_Type" as 'Transaction_Type',
		 x."Document_Type" as 'Document_Type',
		 x."Invoice Status" AS 'Invoice Status',
		 GROUP_CONCAT(DISTINCT (x.`2A/2B Status`)) as '2A/2B Status',
		 IF(g.`city code`  IS NULL, 'GST applicable', 'GST exempted') as 'GST Exempted',
		 IF(t6.`code`  is NULL, 'SOTO', 'NON SOTO') as 'SOTO Status',
		 f.`Refund Type` as 'Full Refund Status',
		 MAX(y.`Retrieval Type`) as 'Retrieval Type',
		 MAX(b2c.`Comment`) as 'Airline Comment',
		 MAX(x.`From`) as 'From',
		 MAX(mm.`workspace_active`) as 'workspace_active',
		 MAX(l.`status`) as 'Scraper_Status',
		 MAX(l.`scraper_remark`) as 'Scraper_remark'
FROM (	SELECT DISTINCT
			 t1."Ticket Number" as "Ticket_Number",
			 t1."PNR" as "PNR",
			 t1."Ticket/PNR" as "Ticket/PNR",
			 t1."Type" as "Type",
			 t1."Customer Name" as "Customer Name",
			 t1."Party Site Name" as "Party Site Name",
			 t1."Mercury Inv No" as "Mercury Inv No",
			 t1."Inv No" as "Inv No",
			 t1."Aginst CM" as "Aginst CM",
			 t1."Inv Date" as "Inv Date",
			 t1."Code" as "Code",
			 t1."GST" as "GST",

			 IF(t1.`Workspace Name`  IS NULL, 'Unknown', t1.`Workspace Name`) as 'Workspace',
			 t1."Arln Inv" as "Arln Inv",
			 t1."Date" as "Date",
			 t1."Arln GST" as "Arln GST",
			 t1."Air_Vendor" as "Air_Vendor",
			 t1."Passenger Name" as "Passenger Name",
			 t1."Arln Code" as "Arln Code",
			 t1."Flg No" as "Flg No",
			 t1."GL Code" as "GL Code",
			 t1."Basic Fare" as "Basic Fare",
			 t1."SGST" as "SGST",
			 t1."CGST" as "CGST",
			 t1."IGST" as "IGST",
			 Round(ABS(t1."Total"),0) as "Total",


			 ABS(IF(t2.`ticket/pnr`  IS NOT NULL, t1."Total" / b2.`Count of Invoices`, t1."Total")) as 'Calculated Transaction_Amount',
			t1."DOT" as "DOT",
			t1."Class" as "Class",
			t1."Sector" as "Sector",
			t1."Cost Centre" as "Cost Centre",
			t1."Employee Code" as "Employee Code",
			t1."Project Code" as "Project Code",
			t1."Trip CC" as "Trip CC",
			t1."PNR No" as "PNR No",
			t1."AIRLINE NAME" as "AIRLINE NAME",

			 t1.`Origin` as 'Origin',
			 ROUND(ABS(t1."K3"), 0) as 'Booking_GST',
			 ABS(IF(t2.`ticket/pnr`  IS NOT NULL, t1."K3" / b2.`Count of Invoices`, t1."K3")) as 'Calculated Booking_GST',
			 ROUND(ABS(t1.`K3`), 0) as 'K3',
			 ABS(IF(t2.`ticket/pnr`  IS NOT NULL, t1.`K3` / b2.`Count of Invoices`, t1.`K3`)) as 'Calculated K3',
			 t2.`Customer_GSTIN` as 'Invoice - Customer_GSTIN',
			 t2.`Name as per GST portal` as 'Invoice - Name as per GST portal',
			 t2.`Supplier_GSTIN` as 'Supplier_GSTIN',
			 t2.`Invoice Ref` as 'Invoice_Number',
			 convert_to_datetime(LEFT(t2.`Date Ref`, 10), 'yyyy-MM-dd') as 'Invoice_Date',
			 ABS(t2.`Taxable`) as 'Invoice Taxable',
			 ABS(t2.`CGST`) as 'Invoice CGST',
			 ABS(t2.`SGST`) as 'Invoice SGST',
			 ABS(t2.`IGST`) as 'Invoice IGST',
			 ABS(t2.`Total_GST`) as 'Invoice Total_GST',
			 ABS(t2.`Total_Amount`) as 'Invoice Total_Amount',
			 t1.`Transaction Type` as 'Transaction_Type',
			 t2.`Document_Type` as 'Document_Type',
			 IF(t2.`ticket/pnr`  IS NULL, 'Invoice Not Received', 'Invoice Received') AS 'Invoice Status',
			 IF(IF_NULL(t4.`Invoice_Number`, t5.`Note_Number`)  IS NULL, 'Not In 2A/2B', CONCAT('In ', IF_NULL(t4.`Source`, t5.`Source`))) as '2A/2B Status',
			 t2.`from` as 'From'
	FROM  "Qt1b. Ebix Cash" t1
LEFT JOIN `QT2. Invoice_Ticket With Link v1.0 - Duplicates removed - INV/DB/BOS` t2 ON concat_ignore_null(t2.`Ticket/PNR`, t2.`Vendor`)  = concat_ignore_null(t1.`Ticket/PNR`, t1.`Air_Vendor`)
		 AND	t2.`Ticket/PNR`  IS NOT NULL
		 AND	t2.`Vendor`  IS NOT NULL 
LEFT JOIN "QT3. Invoice_Amount" t3 ON t2.`Invoice Ref`  = t3.`Invoice Ref` 
LEFT JOIN "QT4. 2A_Invoice" t4 ON t4.`Invoice_Number`  = t2.`Invoice Ref` 
LEFT JOIN "QT5. 2A_Refund" t5 ON t5.`Note_Number`  = t2.`Credit/Debit Note Number` 
LEFT JOIN `QT1. Booking - Sum of Amounts` s ON concat_ignore_null(s.`Ticket/PNR`, s.`Vendor`, s.`Transaction_Type`)  = concat_ignore_null(t1.`Ticket/PNR`, t1.`Air_Vendor`, t1.`Transaction Type`) 
LEFT JOIN `QT2. Invoice_Ticket With Link v1.0 - Duplicates removed - Sum of Amounts` b2 ON concat_ignore_null(s.`Ticket/PNR`, s.`Vendor`, s.`Transaction_Type`)  = concat_ignore_null(b2.`Ticket/PNR`, b2.`Vendor`, b2.`Transaction_Type`)  
	WHERE	 t1.`DOT`  >= '2021-04-01'
	 AND	t1.`Transaction Type`  = 'Invoice'
	 AND	t1.`Air_Vendor`  IS NOT NULL
	 AND	t1.`Air_Vendor`  NOT IN ( 'Indigo'  , 'Go Air'  , 'Air Asia'  , 'Akasa Air'  )
	UNION
 	SELECT DISTINCT
			 t1."Ticket Number" as "Ticket_Number",
			 t1."PNR" as "PNR",
			 t1."Ticket/PNR" as "Ticket/PNR",
			 t1."Type" as "Type",
			 t1."Customer Name" as "Customer Name",
			 t1."Party Site Name" as "Party Site Name",
			 t1."Mercury Inv No" as "Mercury Inv No",
			 t1."Inv No" as "Inv No",
			 t1."Aginst CM" as "Aginst CM",
			 t1."Inv Date" as "Inv Date",
			 t1."Code" as "Code",
			 t1."GST" as "GST",
			 IF(t1.`Workspace Name`  IS NULL, 'Unknown', t1.`Workspace Name`) as 'Workspace',
			
			 t1."Arln Inv" as "Arln Inv",
			 t1."Date" as "Date",
			 t1."Arln GST" as "Arln GST",
			 t1."Air_Vendor" as "Air_Vendor",
			 t1."Passenger Name" as "Passenger Name",
			 t1."Arln Code" as "Arln Code",
			 t1."Flg No" as "Flg No",
			 t1."GL Code" as "GL Code",
			 t1."Basic Fare" as "Basic Fare",
			 t1."SGST" as "SGST",
			 t1."CGST" as "CGST",
			 t1."IGST" as "IGST",
			 Round(ABS(t1."Total"),0) as "Total",
			 -ABS(IF(t2.`ticket/pnr`  IS NOT NULL, t1."Total" / b2.`Count of Invoices`, t1."Total")) as 'Calculated Transaction_Amount',
			t1."DOT" as "DOT",
			t1."Class" as "Class",
			t1."Sector" as "Sector",
			t1."Cost Centre" as "Cost Centre",
			t1."Employee Code" as "Employee Code",
			t1."Project Code" as "Project Code",
			t1."Trip CC" as "Trip CC",
			t1."PNR No" as "PNR No",
			t1."AIRLINE NAME" as "AIRLINE NAME",

			
			 t1.`Origin` as 'Origin',
			 ROUND(-ABS(t1."K3"), 0) as 'Booking_GST',
			 -ABS(IF(t2.`ticket/pnr`  IS NOT NULL, t1."K3" / b2.`Count of Invoices`, t1."K3")) as 'Calculated Booking_GST',
			 ROUND(-ABS(t1.`K3`), 0) as 'K3',
			 -ABS(IF(t2.`ticket/pnr`  IS NOT NULL, t1.`K3` / b2.`Count of Invoices`, t1.`K3`)) as 'Calculated K3',
			 t2.`Customer_GSTIN` as 'Invoice - Customer_GSTIN',
			 t2.`Name as per GST portal` as 'Invoice - Name as per GST portal',
			 t2.`Supplier_GSTIN` as 'Supplier_GSTIN',
			 IFNULL(t2.`Invoice Ref`, t2.`Credit/Debit Note Number`) as 'Invoice_Number',
			 convert_to_datetime(LEFT(IFNULL(t2.`Date Ref`, t2.`Credit/Debit Note Date`), 10), 'yyyy-MM-dd') as 'Invoice_Date',
			 -ABS(t2.`Taxable`) as 'Invoice Taxable',
			 -ABS(t2.`CGST`) as 'Invoice CGST',
			 -ABS(t2.`SGST`) as 'Invoice SGST',
			 -ABS(t2.`IGST`) as 'Invoice IGST',
			 -ABS(t2.`Total_GST`) as 'Invoice Total_GST',
			 -ABS(t2.`Total_Amount`) as 'Invoice Total_Amount',
			 t1.`Transaction Type` as 'Transaction_Type',
			 t2.`Document_Type` as 'Document_Type',
			 IF(t2.`ticket/pnr`  IS NULL, 'Invoice Not Received', 'Invoice Received') AS 'Invoice Status',
			 IF(t5.`Note_Number`  IS NULL, 'Not In 2A/2B', CONCAT('In ', t5.`Source`)) as '2A/2B Status',
			 t2.`from` as 'From'
	FROM  "QT1b. Ebix cash" t1
LEFT JOIN `QT2. Invoice_Ticket With Link v1.0 - Duplicates removed - CR` t2 ON concat_ignore_null(t2.`Ticket/PNR`, t2.`Vendor`)  = concat_ignore_null(t1.`Ticket/PNR`, t1.`Air_Vendor`)
		 AND	t2.`Ticket/PNR`  IS NOT NULL
		 AND	t2.`Vendor`  IS NOT NULL 
LEFT JOIN "QT5. 2A_Refund" t5 ON t5.`Note_Number`  = t2.`Credit/Debit Note Number` 
LEFT JOIN `QT1. Booking - Sum of Amounts` s ON concat_ignore_null(s.`Ticket/PNR`, s.`Vendor`, s.`Transaction_Type`)  = concat_ignore_null(t1.`Ticket/PNR`, t1.`Air_Vendor`, t1.`Transaction Type`) 
LEFT JOIN `QT2. Invoice_Ticket With Link v1.0 - Duplicates removed - Sum of Amounts` b2 ON concat_ignore_null(s.`Ticket/PNR`, s.`Vendor`, s.`Transaction_Type`)  = concat_ignore_null(b2.`Ticket/PNR`, b2.`Vendor`, b2.`Transaction_Type`)  
	WHERE	 t1.`DOT`  >= '2021-04-01'
	 AND	t1.`Transaction Type`  = 'Refund'
	 AND	t1.`Air_Vendor`  IS NOT NULL
	 AND	t1.`Air_Vendor`  NOT IN ( 'Indigo'  , 'Go Air'  , 'Air Asia'  , 'Akasa Air'  ) /*LCC airlines code below*/ /*LCC airlines code below*/
	UNION
 	SELECT DISTINCT
			 t1."Ticket Number" as "Ticket_Number",
			 t1."PNR" as "PNR",
			 t1."Ticket/PNR" as "Ticket/PNR",
			 t1."Type" as "Type",
			 t1."Customer Name" as "Customer Name",
			 t1."Party Site Name" as "Party Site Name",
			 t1."Mercury Inv No" as "Mercury Inv No",
			 t1."Inv No" as "Inv No",
			 t1."Aginst CM" as "Aginst CM",
			 t1."Inv Date" as "Inv Date",
			 t1."Code" as "Code",
			 t1."GST" as "GST",
			 IF(t1.`Workspace Name`  IS NULL, 'Unknown', t1.`Workspace Name`) as 'Workspace',
			 
			 t1."Arln Inv" as "Arln Inv",
			 t1."Date" as "Date",
			 t1."Arln GST" as "Arln GST",
			 t1."Air_Vendor" as "Air_Vendor",
			 t1."Passenger Name" as "Passenger Name",
			 t1."Arln Code" as "Arln Code",
			 t1."Flg No" as "Flg No",
			 t1."GL Code" as "GL Code",
			 t1."Basic Fare" as "Basic Fare",
			 t1."SGST" as "SGST",
			 t1."CGST" as "CGST",
			 t1."IGST" as "IGST",
			 Round(ABS(t1."Total"),0) as "Total",
			 
			 ABS(IF(t2.`ticket/pnr`  IS NOT NULL, t1."Total" / b2.`Count of Invoices`, t1."Total")) as 'Calculated Transaction_Amount',
			t1."DOT" as "DOT",
			t1."Class" as "Class",
			t1."Sector" as "Sector",
			t1."Cost Centre" as "Cost Centre",
			t1."Employee Code" as "Employee Code",
			t1."Project Code" as "Project Code",
			t1."Trip CC" as "Trip CC",
			t1."PNR No" as "PNR No",
			t1."AIRLINE NAME" as "AIRLINE NAME",

			 
			 t1.`Origin` as 'Origin',
			 ROUND(ABS(t1."K3"), 0) as 'Booking_GST',
			 ABS(IF(t2.`ticket/pnr`  IS NOT NULL, t1."K3" / b2.`Count of Invoices`, t1."K3")) as 'Calculated Booking_GST',
			 ROUND(ABS(t1.`K3`), 0) as 'K3',
			 ABS(IF(t2.`ticket/pnr`  IS NOT NULL, t1.`K3` / b2.`Count of Invoices`, t1.`K3`)) as 'Calculated K3',
			 t2.`Customer_GSTIN` as 'Invoice - Customer_GSTIN',
			 t2.`Name as per GST portal` as 'Invoice - Name as per GST portal',
			 t2.`Supplier_GSTIN` as 'Supplier_GSTIN',
			 t2.`Invoice Ref` as 'Invoice_Number',
			 convert_to_datetime(LEFT(t2.`Date Ref`, 10), 'yyyy-MM-dd') as 'Invoice_Date',
			 ABS(t2.`Taxable`) as 'Invoice Taxable',
			 ABS(t2.`CGST`) as 'Invoice CGST',
			 ABS(t2.`SGST`) as 'Invoice SGST',
			 ABS(t2.`IGST`) as 'Invoice IGST',
			 ABS(t2.`Total_GST`) as 'Invoice Total_GST',
			 
			 ABS(t2.`Total_Amount`) as 'Invoice Total_Amount',
			 t1.`Transaction Type` as 'Transaction_Type',
			 t2.`Document_Type` as 'Document_Type',
			 IF(t2.`ticket/pnr`  IS NULL, 'Invoice Not Received', 'Invoice Received') AS 'Invoice Status',
			 IF(IF_NULL(t4.`Invoice_Number`, t5.`Note_Number`)  IS NULL, 'Not In 2A/2B', CONCAT('In ', IF_NULL(t4.`Source`, t5.`Source`))) as '2A/2B Status',
			 t2.`from` as 'From'
	FROM  "QT1b. Ebix cash" t1
LEFT JOIN `QT2. Invoice_Ticket With Link v1.0 - Duplicates removed - INV/DB/BOS` t2 ON concat_ignore_null(t2.`Ticket/PNR`, t2.`Vendor`, t2.`Origin`)  = concat_ignore_null(t1.`Ticket/PNR`, t1.`Air_Vendor`, t1.`Origin`)
		 AND	t2.`Ticket/PNR`  IS NOT NULL
		 AND	t2.`Vendor`  IS NOT NULL
		 AND	t2.`Origin`  IS NOT NULL 
LEFT JOIN "QT3. Invoice_Amount" t3 ON t2.`Invoice Ref`  = t3.`Invoice Ref` 
LEFT JOIN "QT4. 2A_Invoice" t4 ON t4.`Invoice_Number`  = t2.`Invoice Ref` 
LEFT JOIN "QT5. 2A_Refund" t5 ON t5.`Note_Number`  = t2.`Credit/Debit Note Number` 
LEFT JOIN `QT1. Booking - Sum of Amounts - Origin` s ON concat_ignore_null(s.`Ticket/PNR`, s.`Vendor`, s.`Transaction_Type`, s.`Origin`)  = concat_ignore_null(t1.`Ticket/PNR`, t1.`Air_Vendor`, t1.`Transaction Type`, t1.`Origin`) 
LEFT JOIN `QT2. Invoice_Ticket With Link v1.0 - Duplicates removed - Sum of Amounts - Origin` b2 ON concat_ignore_null(s.`Ticket/PNR`, s.`Vendor`, s.`Transaction_Type`, s.`Origin`)  = concat_ignore_null(b2.`Ticket/PNR`, b2.`Vendor`, b2.`Transaction_Type`, b2.`Origin`)  
	WHERE	 t1.`DOT`  >= '2021-04-01'
	 AND	t1.`Transaction Type`  = 'Invoice'
	 AND	t1.`Air_Vendor`  IS NOT NULL
	 AND	t1.`Air_Vendor`  IN ( 'Go Air'  , 'Air Asia'  , 'Akasa Air'  )
	UNION
 	SELECT DISTINCT
			 t1."Ticket Number" as "Ticket_Number",
			 t1."PNR" as "PNR",
			 t1."Ticket/PNR" as "Ticket/PNR",
			 t1."Type" as "Type",
			 t1."Customer Name" as "Customer Name",
			 t1."Party Site Name" as "Party Site Name",
			 t1."Mercury Inv No" as "Mercury Inv No",
			 t1."Inv No" as "Inv No",
			 t1."Aginst CM" as "Aginst CM",
			 t1."Inv Date" as "Inv Date",
			 t1."Code" as "Code",
			 t1."GST" as "GST",
			 IF(t1.`Workspace Name`  IS NULL, 'Unknown', t1.`Workspace Name`) as 'Workspace',
			 
			 t1."Arln Inv" as "Arln Inv",
			 t1."Date" as "Date",
			 t1."Arln GST" as "Arln GST",
			 t1."Air_Vendor" as "Air_Vendor",
			 t1."Passenger Name" as "Passenger Name",
			 t1."Arln Code" as "Arln Code",
			 t1."Flg No" as "Flg No",
			 t1."GL Code" as "GL Code",
			 t1."Basic Fare" as "Basic Fare",
			 t1."SGST" as "SGST",
			 t1."CGST" as "CGST",
			 t1."IGST" as "IGST",
			 Round(ABS(t1."Total"),0) as "Total",
			 
			 -ABS(IF(t2.`ticket/pnr`  IS NOT NULL, t1."Total" / b2.`Count of Invoices`, t1."Total")) as 'Calculated Transaction_Amount',
			t1."DOT" as "DOT",
			t1."Class" as "Class",
			t1."Sector" as "Sector",
			t1."Cost Centre" as "Cost Centre",
			t1."Employee Code" as "Employee Code",
			t1."Project Code" as "Project Code",
			t1."Trip CC" as "Trip CC",
			t1."PNR No" as "PNR No",
			t1."AIRLINE NAME" as "AIRLINE NAME",

			 
			 t1.`Origin` as 'Origin',
			 ROUND(-ABS(t1."K3"), 0) as 'Booking_GST',
			 -ABS(IF(t2.`ticket/pnr`  IS NOT NULL, t1."K3" / b2.`Count of Invoices`, t1."K3")) as 'Calculated Booking_GST',
			 ROUND(-ABS(t1.`K3`), 0) as 'K3',
			 -ABS(IF(t2.`ticket/pnr`  IS NOT NULL, t1.`K3` / b2.`Count of Invoices`, t1.`K3`)) as 'Calculated K3',
			 t2.`Customer_GSTIN` as 'Invoice - Customer_GSTIN',
			 t2.`Name as per GST portal` as 'Invoice - Name as per GST portal',
			 t2.`Supplier_GSTIN` as 'Supplier_GSTIN',
			 IFNULL(t2.`Invoice Ref`, t2.`Credit/Debit Note Number`) as 'Invoice_Number',
			 convert_to_datetime(LEFT(IFNULL(t2.`Date Ref`, t2.`Credit/Debit Note Date`), 10), 'yyyy-MM-dd') as 'Invoice_Date',
			 -ABS(t2.`Taxable`) as 'Invoice Taxable',
			 -ABS(t2.`CGST`) as 'Invoice CGST',
			 -ABS(t2.`SGST`) as 'Invoice SGST',
			 -ABS(t2.`IGST`) as 'Invoice IGST',
			 -ABS(t2.`Total_GST`) as 'Invoice Total_GST',
			 
			 -ABS(t2.`Total_Amount`) as 'Invoice Total_Amount',
			 t1.`Transaction Type` as 'Transaction_Type',
			 t2.`Document_Type` as 'Document_Type',
			 IF(t2.`ticket/pnr`  IS NULL, 'Invoice Not Received', 'Invoice Received') AS 'Invoice Status',
			 IF(t5.`Note_Number`  IS NULL, 'Not In 2A/2B', CONCAT('In ', t5.`Source`)) as '2A/2B Status',
			 t2.`from` as 'From'
	FROM  "QT1b. Ebix cash" t1
LEFT JOIN `QT2. Invoice_Ticket With Link v1.0 - Duplicates removed - CR` t2 ON concat_ignore_null(t2.`Ticket/PNR`, t2.`Vendor`, t2.`Origin`)  = concat_ignore_null(t1.`Ticket/PNR`, t1.`Air_Vendor`, t1.`Origin`)
		 AND	t2.`Ticket/PNR`  IS NOT NULL
		 AND	t2.`Vendor`  IS NOT NULL
		 AND	t2.`Origin`  IS NOT NULL 
LEFT JOIN "QT5. 2A_Refund" t5 ON t5.`Note_Number`  = t2.`Credit/Debit Note Number` 
LEFT JOIN `QT1. Booking - Sum of Amounts - Origin` s ON concat_ignore_null(s.`Ticket/PNR`, s.`Vendor`, s.`Transaction_Type`, s.`Origin`)  = concat_ignore_null(t1.`Ticket/PNR`, t1.`Air_Vendor`, t1.`Transaction Type`, t1.`Origin`) 
LEFT JOIN `QT2. Invoice_Ticket With Link v1.0 - Duplicates removed - Sum of Amounts - Origin` b2 ON concat_ignore_null(s.`Ticket/PNR`, s.`Vendor`, s.`Transaction_Type`, s.`Origin`)  = concat_ignore_null(b2.`Ticket/PNR`, b2.`Vendor`, b2.`Transaction_Type`, b2.`Origin`)  
	WHERE	 t1.`DOT`  >= '2021-04-01'
	 AND	t1.`Transaction Type`  = 'Refund'
	 AND	t1.`Air_Vendor`  IS NOT NULL
	 AND	t1.`Air_Vendor`  IN ( 'Go Air'  , 'Air Asia'  , 'Akasa Air'  ) /*Indigo code for Origin - Single trip*/ /*Indigo code for Origin - Single trip*/
	UNION
 	SELECT DISTINCT
			 t1."Ticket Number" as "Ticket_Number",
			 t1."PNR" as "PNR",
			 t1."Ticket/PNR" as "Ticket/PNR",
			 t1."Type" as "Type",
			 t1."Customer Name" as "Customer Name",
			 t1."Party Site Name" as "Party Site Name",
			 t1."Mercury Inv No" as "Mercury Inv No",
			 t1."Inv No" as "Inv No",
			 t1."Aginst CM" as "Aginst CM",
			 t1."Inv Date" as "Inv Date",
			 t1."Code" as "Code",
			 t1."GST" as "GST",
			 IF(t1.`Workspace Name`  IS NULL, 'Unknown', t1.`Workspace Name`) as 'Workspace',
			 
			 t1."Arln Inv" as "Arln Inv",
			 t1."Date" as "Date",
			 t1."Arln GST" as "Arln GST",
			 t1."Air_Vendor" as "Air_Vendor",
			 t1."Passenger Name" as "Passenger Name",
			 t1."Arln Code" as "Arln Code",
			 t1."Flg No" as "Flg No",
			 t1."GL Code" as "GL Code",
			 t1."Basic Fare" as "Basic Fare",
			 t1."SGST" as "SGST",
			 t1."CGST" as "CGST",
			 t1."IGST" as "IGST",
			 Round(ABS(t1."Total"),0) as "Total",
			 
			 ABS(IF(t2.`ticket/pnr`  IS NOT NULL, t1."Total" / b2.`Count of Invoices`, t1."Total")) as 'Calculated Transaction_Amount',
			t1."DOT" as "DOT",
			t1."Class" as "Class",
			t1."Sector" as "Sector",
			t1."Cost Centre" as "Cost Centre",
			t1."Employee Code" as "Employee Code",
			t1."Project Code" as "Project Code",
			t1."Trip CC" as "Trip CC",
			t1."PNR No" as "PNR No",
			t1."AIRLINE NAME" as "AIRLINE NAME",

			 
			 t1.`Origin` as 'Origin',
			 ROUND(ABS(t1."K3"), 0) as 'Booking_GST',
			 ABS(IF(t2.`ticket/pnr`  IS NOT NULL, t1."K3" / b2.`Count of Invoices`, t1."K3")) as 'Calculated Booking_GST',
			 ROUND(ABS(t1.`K3`), 0) as 'K3',
			 ABS(IF(t2.`ticket/pnr`  IS NOT NULL, t1.`K3` / b2.`Count of Invoices`, t1.`K3`)) as 'Calculated K3',
			 t2.`Customer_GSTIN` as 'Invoice - Customer_GSTIN',
			 t2.`Name as per GST portal` as 'Invoice - Name as per GST portal',
			 t2.`Supplier_GSTIN` as 'Supplier_GSTIN',
			 t2.`Invoice Ref` as 'Invoice_Number',
			 convert_to_datetime(LEFT(t2.`Date Ref`, 10), 'yyyy-MM-dd') as 'Invoice_Date',
			 ABS(t2.`Taxable`) as 'Invoice Taxable',
			 ABS(t2.`CGST`) as 'Invoice CGST',
			 ABS(t2.`SGST`) as 'Invoice SGST',
			 ABS(t2.`IGST`) as 'Invoice IGST',
			 ABS(t2.`Total_GST`) as 'Invoice Total_GST',
			 
			 ABS(t2.`Total_Amount`) as 'Invoice Total_Amount',
			 t1.`Transaction Type` as 'Transaction_Type',
			 t2.`Document_Type` as 'Document_Type',
			 IF(t2.`ticket/pnr`  IS NULL, 'Invoice Not Received', 'Invoice Received') AS 'Invoice Status',
			 IF(IF_NULL(t4.`Invoice_Number`, t5.`Note_Number`)  IS NULL, 'Not In 2A/2B', CONCAT('In ', IF_NULL(t4.`Source`, t5.`Source`))) as '2A/2B Status',
			 t2.`from` as 'From'
	FROM  "QT1b. Ebix cash" t1
LEFT JOIN `QT2. Invoice_Ticket With Link v1.0 - Duplicates removed - INV/DB/BOS` t2 ON concat_ignore_null(t2.`Ticket/PNR`, t2.`Vendor`, t2.`Origin`)  = concat_ignore_null(t1.`Ticket/PNR`, t1.`Air_Vendor`, t1.`Origin`)
		 AND	t2.`Ticket/PNR`  IS NOT NULL
		 AND	t2.`Vendor`  IS NOT NULL
		 AND	t2.`Origin`  IS NOT NULL 
LEFT JOIN "QT3. Invoice_Amount" t3 ON t2.`Invoice Ref`  = t3.`Invoice Ref` 
LEFT JOIN "QT4. 2A_Invoice" t4 ON t4.`Invoice_Number`  = t2.`Invoice Ref` 
LEFT JOIN "QT5. 2A_Refund" t5 ON t5.`Note_Number`  = t2.`Credit/Debit Note Number` 
LEFT JOIN `QT1. Booking - Sum of Amounts - Origin` s ON concat_ignore_null(s.`Ticket/PNR`, s.`Vendor`, s.`Transaction_Type`, s.`Origin`)  = concat_ignore_null(t1.`Ticket/PNR`, t1.`Air_Vendor`, t1.`Transaction Type`, t1.`Origin`) 
LEFT JOIN `QT2. Invoice_Ticket With Link v1.0 - Duplicates removed - Sum of Amounts - Origin` b2 ON concat_ignore_null(s.`Ticket/PNR`, s.`Vendor`, s.`Transaction_Type`, s.`Origin`)  = concat_ignore_null(b2.`Ticket/PNR`, b2.`Vendor`, b2.`Transaction_Type`, b2.`Origin`)  
	WHERE	 t1.`DOT`  >= '2021-04-01'
	 AND	t1.`Transaction Type`  = 'Invoice'
	 AND	t1.`Air_Vendor`  IS NOT NULL
	 AND	t1.`Air_Vendor`  = 'Indigo'
	 AND	t1.`Length of Location`  < 9
	UNION
 	SELECT DISTINCT
			 t1."Ticket Number" as "Ticket_Number",
			 t1."PNR" as "PNR",
			 t1."Ticket/PNR" as "Ticket/PNR",
			 t1."Type" as "Type",
			 t1."Customer Name" as "Customer Name",
			 t1."Party Site Name" as "Party Site Name",
			 t1."Mercury Inv No" as "Mercury Inv No",
			 t1."Inv No" as "Inv No",
			 t1."Aginst CM" as "Aginst CM",
			 t1."Inv Date" as "Inv Date",
			 t1."Code" as "Code",
			 t1."GST" as "GST",
			 IF(t1.`Workspace Name`  IS NULL, 'Unknown', t1.`Workspace Name`) as 'Workspace',
			 
			 t1."Arln Inv" as "Arln Inv",
			 t1."Date" as "Date",
			 t1."Arln GST" as "Arln GST",
			 t1."Air_Vendor" as "Air_Vendor",
			 t1."Passenger Name" as "Passenger Name",
			 t1."Arln Code" as "Arln Code",
			 t1."Flg No" as "Flg No",
			 t1."GL Code" as "GL Code",
			 t1."Basic Fare" as "Basic Fare",
			 t1."SGST" as "SGST",
			 t1."CGST" as "CGST",
			 t1."IGST" as "IGST",
			 Round(ABS(t1."Total"),0) as "Total",
			 
			 -ABS(IF(t2.`ticket/pnr`  IS NOT NULL, t1."Total" / b2.`Count of Invoices`, t1."Total")) as 'Calculated Transaction_Amount',
			t1."DOT" as "DOT",
			t1."Class" as "Class",
			t1."Sector" as "Sector",
			t1."Cost Centre" as "Cost Centre",
			t1."Employee Code" as "Employee Code",
			t1."Project Code" as "Project Code",
			t1."Trip CC" as "Trip CC",
			t1."PNR No" as "PNR No",
			t1."AIRLINE NAME" as "AIRLINE NAME",

			 
			 t1.`Origin` as 'Origin',
			 ROUND(-ABS(t1."K3"), 0) as 'Booking_GST',
			 -ABS(IF(t2.`ticket/pnr`  IS NOT NULL, t1."K3" / b2.`Count of Invoices`, t1."K3")) as 'Calculated Booking_GST',
			 ROUND(-ABS(t1.`K3`), 0) as 'K3',
			 -ABS(IF(t2.`ticket/pnr`  IS NOT NULL, t1.`K3` / b2.`Count of Invoices`, t1.`K3`)) as 'Calculated K3',
			 t2.`Customer_GSTIN` as 'Invoice - Customer_GSTIN',
			 t2.`Name as per GST portal` as 'Invoice - Name as per GST portal',
			 t2.`Supplier_GSTIN` as 'Supplier_GSTIN',
			 IFNULL(t2.`Invoice Ref`, t2.`Credit/Debit Note Number`) as 'Invoice_Number',
			 convert_to_datetime(LEFT(IFNULL(t2.`Date Ref`, t2.`Credit/Debit Note Date`), 10), 'yyyy-MM-dd') as 'Invoice_Date',
			 -ABS(t2.`Taxable`) as 'Invoice Taxable',
			 -ABS(t2.`CGST`) as 'Invoice CGST',
			 -ABS(t2.`SGST`) as 'Invoice SGST',
			 -ABS(t2.`IGST`) as 'Invoice IGST',
			 -ABS(t2.`Total_GST`) as 'Invoice Total_GST',
			 
			 -ABS(t2.`Total_Amount`) as 'Invoice Total_Amount',
			 t1.`Transaction Type` as 'Transaction_Type',
			 t2.`Document_Type` as 'Document_Type',
			 IF(t2.`ticket/pnr`  IS NULL, 'Invoice Not Received', 'Invoice Received') AS 'Invoice Status',
			 IF(t5.`Note_Number`  IS NULL, 'Not In 2A/2B', CONCAT('In ', t5.`Source`)) as '2A/2B Status',
			 t2.`from` as 'From'
	FROM  "QT1b. Ebix cash" t1
LEFT JOIN `QT2. Invoice_Ticket With Link v1.0 - Duplicates removed - CR` t2 ON concat_ignore_null(t2.`Ticket/PNR`, t2.`Vendor`, t2.`Origin`)  = concat_ignore_null(t1.`Ticket/PNR`, t1.`Air_Vendor`, t1.`Origin`)
		 AND	t2.`Ticket/PNR`  IS NOT NULL
		 AND	t2.`Vendor`  IS NOT NULL
		 AND	t2.`Origin`  IS NOT NULL 
LEFT JOIN "QT5. 2A_Refund" t5 ON t5.`Note_Number`  = t2.`Credit/Debit Note Number` 
LEFT JOIN `QT1. Booking - Sum of Amounts - Origin` s ON concat_ignore_null(s.`Ticket/PNR`, s.`Vendor`, s.`Transaction_Type`, s.`Origin`)  = concat_ignore_null(t1.`Ticket/PNR`, t1.`Air_Vendor`, t1.`Transaction Type`, t1.`Origin`) 
LEFT JOIN `QT2. Invoice_Ticket With Link v1.0 - Duplicates removed - Sum of Amounts - Origin` b2 ON concat_ignore_null(s.`Ticket/PNR`, s.`Vendor`, s.`Transaction_Type`, s.`Origin`)  = concat_ignore_null(b2.`Ticket/PNR`, b2.`Vendor`, b2.`Transaction_Type`, b2.`Origin`)  
	WHERE	 t1.`DOT`  >= '2021-04-01'
	 AND	t1.`Transaction Type`  = 'Refund'
	 AND	t1.`Air_Vendor`  IS NOT NULL
	 AND	t1.`Air_Vendor`  = 'Indigo'
	 AND	t1.`Length of Location`  < 9 /*Indigo code for Round trip or Double trips */

	UNION
 	SELECT DISTINCT
			 t1."Ticket Number" as "Ticket_Number",
			 t1."PNR" as "PNR",
			 t1."Ticket/PNR" as "Ticket/PNR",
			 t1."Type" as "Type",
			 t1."Customer Name" as "Customer Name",
			 t1."Party Site Name" as "Party Site Name",
			 t1."Mercury Inv No" as "Mercury Inv No",
			 t1."Inv No" as "Inv No",
			 t1."Aginst CM" as "Aginst CM",
			 t1."Inv Date" as "Inv Date",
			 t1."Code" as "Code",
			 t1."GST" as "GST",
			 
			 IF(t1.`Workspace Name`  IS NULL, 'Unknown', t1.`Workspace Name`) as 'Workspace',
			 t1."Arln Inv" as "Arln Inv",
			 t1."Date" as "Date",
			 t1."Arln GST" as "Arln GST",
			 t1."Air_Vendor" as "Air_Vendor",
			 t1."Passenger Name" as "Passenger Name",
			 t1."Arln Code" as "Arln Code",
			 t1."Flg No" as "Flg No",
			 t1."GL Code" as "GL Code",
			 t1."Basic Fare" as "Basic Fare",
			 t1."SGST" as "SGST",
			 t1."CGST" as "CGST",
			 t1."IGST" as "IGST",
			 Round(ABS(t1."Total"),0) as "Total",
			 
			 ABS(IF(t2.`ticket/pnr`  IS NOT NULL, t1."Total" / b2.`Count of Invoices`, t1."Total")) as 'Calculated Transaction_Amount',
			t1."DOT" as "DOT",
			t1."Class" as "Class",
			t1."Sector" as "Sector",
			t1."Cost Centre" as "Cost Centre",
			t1."Employee Code" as "Employee Code",
			t1."Project Code" as "Project Code",
			t1."Trip CC" as "Trip CC",
			t1."PNR No" as "PNR No",
			t1."AIRLINE NAME" as "AIRLINE NAME",

			 
			 t1.`Origin` as 'Origin',
			 ROUND(ABS(t1."K3"), 0) as 'Booking_GST',
			 ABS(IF(t2.`ticket/pnr`  IS NOT NULL, t1."K3" / b2.`Count of Invoices`, t1."K3")) as 'Calculated Booking_GST',
			 ROUND(ABS(t1.`K3`), 0) as 'K3',
			 ABS(IF(t2.`ticket/pnr`  IS NOT NULL, t1.`K3` / b2.`Count of Invoices`, t1.`K3`)) as 'Calculated K3',
			 t2.`Customer_GSTIN` as 'Invoice - Customer_GSTIN',
			 t2.`Name as per GST portal` as 'Invoice - Name as per GST portal',
			 t2.`Supplier_GSTIN` as 'Supplier_GSTIN',
			 t2.`Invoice Ref` as 'Invoice_Number',
			 convert_to_datetime(LEFT(t2.`Date Ref`, 10), 'yyyy-MM-dd') as 'Invoice_Date',
			 ABS(t2.`Taxable`) as 'Invoice Taxable',
			 ABS(t2.`CGST`) as 'Invoice CGST',
			 ABS(t2.`SGST`) as 'Invoice SGST',
			 ABS(t2.`IGST`) as 'Invoice IGST',
			 ABS(t2.`Total_GST`) as 'Invoice Total_GST',
			 
			 ABS(t2.`Total_Amount`) as 'Invoice Total_Amount',
			 t1.`Transaction Type` as 'Transaction_Type',
			 t2.`Document_Type` as 'Document_Type',
			 IF(t2.`ticket/pnr`  IS NULL, 'Invoice Not Received', 'Invoice Received') AS 'Invoice Status',
			 IF(IF_NULL(t4.`Invoice_Number`, t5.`Note_Number`)  IS NULL, 'Not In 2A/2B', CONCAT('In ', IF_NULL(t4.`Source`, t5.`Source`))) as '2A/2B Status',
			 t2.`from` as 'From'
	FROM  "QT1b. Ebix cash" t1
LEFT JOIN `QT2. Invoice_Ticket With Link v1.0 - Duplicates removed - INV/DB/BOS` t2 ON concat_ignore_null(t2.`Ticket/PNR`, t2.`Vendor`)  = concat_ignore_null(t1.`Ticket/PNR`, t1.`Air_Vendor`)
		 AND	t2.`Ticket/PNR`  IS NOT NULL
		 AND	t2.`Vendor`  IS NOT NULL 
LEFT JOIN "QT3. Invoice_Amount" t3 ON t2.`Invoice Ref`  = t3.`Invoice Ref` 
LEFT JOIN "QT4. 2A_Invoice" t4 ON t4.`Invoice_Number`  = t2.`Invoice Ref` 
LEFT JOIN "QT5. 2A_Refund" t5 ON t5.`Note_Number`  = t2.`Credit/Debit Note Number` 
LEFT JOIN `QT1. Booking - Sum of Amounts` s ON concat_ignore_null(s.`Ticket/PNR`, s.`Vendor`, s.`Transaction_Type`)  = concat_ignore_null(t1.`Ticket/PNR`, t1.`Air_Vendor`, t1.`Transaction Type`) 
LEFT JOIN `QT2. Invoice_Ticket With Link v1.0 - Duplicates removed - Sum of Amounts` b2 ON concat_ignore_null(s.`Ticket/PNR`, s.`Vendor`, s.`Transaction_Type`)  = concat_ignore_null(b2.`Ticket/PNR`, b2.`Vendor`, b2.`Transaction_Type`)  
	WHERE	 t1.`DOT`  >= '2021-04-01'
	 AND	t1.`Transaction Type`  = 'Invoice'
	 AND	t1.`Air_Vendor`  IS NOT NULL
	 AND	t1.`Air_Vendor`  = 'Indigo'
	 AND	t1.`Length of Location`  >= 9
	UNION
 	SELECT DISTINCT
			 t1."Ticket Number" as "Ticket_Number",
			 t1."PNR" as "PNR",
			 t1."Ticket/PNR" as "Ticket/PNR",
			 t1."Type" as "Type",
			 t1."Customer Name" as "Customer Name",
			 t1."Party Site Name" as "Party Site Name",
			 t1."Mercury Inv No" as "Mercury Inv No",
			 t1."Inv No" as "Inv No",
			 t1."Aginst CM" as "Aginst CM",
			 t1."Inv Date" as "Inv Date",
			 t1."Code" as "Code",
			 t1."GST" as "GST",
			 
			 IF(t1.`Workspace Name`  IS NULL, 'Unknown', t1.`Workspace Name`) as 'Workspace',
			 
			 t1."Arln Inv" as "Arln Inv",
			 t1."Date" as "Date",
			 t1."Arln GST" as "Arln GST",
			 t1."Air_Vendor" as "Air_Vendor",
			 t1."Passenger Name" as "Passenger Name",
			 t1."Arln Code" as "Arln Code",
			 t1."Flg No" as "Flg No",
			 t1."GL Code" as "GL Code",
			 t1."Basic Fare" as "Basic Fare",
			 t1."SGST" as "SGST",
			 t1."CGST" as "CGST",
			 t1."IGST" as "IGST",
			 Round(ABS(t1."Total"),0) as "Total",
			 
			 -ABS(IF(t2.`ticket/pnr`  IS NOT NULL, t1."Total" / b2.`Count of Invoices`, t1."Total")) as 'Calculated Transaction_Amount',
			t1."DOT" as "DOT",
			t1."Class" as "Class",
			t1."Sector" as "Sector",
			t1."Cost Centre" as "Cost Centre",
			t1."Employee Code" as "Employee Code",
			t1."Project Code" as "Project Code",
			t1."Trip CC" as "Trip CC",
			t1."PNR No" as "PNR No",
			t1."AIRLINE NAME" as "AIRLINE NAME",

			 
			 t1.`Origin` as 'Origin',
			 ROUND(-ABS(t1."K3"), 0) as 'Booking_GST',
			 -ABS(IF(t2.`ticket/pnr`  IS NOT NULL, t1."K3" / b2.`Count of Invoices`, t1."K3")) as 'Calculated Booking_GST',
			 ROUND(-ABS(t1.`K3`), 0) as 'K3',
			 -ABS(IF(t2.`ticket/pnr`  IS NOT NULL, t1.`K3` / b2.`Count of Invoices`, t1.`K3`)) as 'Calculated K3',
			 t2.`Customer_GSTIN` as 'Invoice - Customer_GSTIN',
			 t2.`Name as per GST portal` as 'Invoice - Name as per GST portal',
			 t2.`Supplier_GSTIN` as 'Supplier_GSTIN',
			 IFNULL(t2.`Invoice Ref`, t2.`Credit/Debit Note Number`) as 'Invoice_Number',
			 convert_to_datetime(LEFT(IFNULL(t2.`Date Ref`, t2.`Credit/Debit Note Date`), 10), 'yyyy-MM-dd') as 'Invoice_Date',
			 -ABS(t2.`Taxable`) as 'Invoice Taxable',
			 -ABS(t2.`CGST`) as 'Invoice CGST',
			 -ABS(t2.`SGST`) as 'Invoice SGST',
			 -ABS(t2.`IGST`) as 'Invoice IGST',
			 -ABS(t2.`Total_GST`) as 'Invoice Total_GST',
			 
			 -ABS(t2.`Total_Amount`) as 'Invoice Total_Amount',
			 t1.`Transaction Type` as 'Transaction_Type',
			 t2.`Document_Type` as 'Document_Type',
			 IF(t2.`ticket/pnr`  IS NULL, 'Invoice Not Received', 'Invoice Received') AS 'Invoice Status',
			 IF(t5.`Note_Number`  IS NULL, 'Not In 2A/2B', CONCAT('In ', t5.`Source`)) as '2A/2B Status',
			 t2.`from` as 'From'
	FROM  "QT1b. Ebix cash" t1
LEFT JOIN `QT2. Invoice_Ticket With Link v1.0 - Duplicates removed - CR` t2 ON concat_ignore_null(t2.`Ticket/PNR`, t2.`Vendor`)  = concat_ignore_null(t1.`Ticket/PNR`, t1.`Air_Vendor`)
		 AND	t2.`Ticket/PNR`  IS NOT NULL
		 AND	t2.`Vendor`  IS NOT NULL 
LEFT JOIN "QT5. 2A_Refund" t5 ON t5.`Note_Number`  = t2.`Credit/Debit Note Number` 
LEFT JOIN `QT1. Booking - Sum of Amounts` s ON concat_ignore_null(s.`Ticket/PNR`, s.`Vendor`, s.`Transaction_Type`)  = concat_ignore_null(t1.`Ticket/PNR`, t1.`Air_Vendor`, t1.`Transaction Type`) 
LEFT JOIN `QT2. Invoice_Ticket With Link v1.0 - Duplicates removed - Sum of Amounts` b2 ON concat_ignore_null(s.`Ticket/PNR`, s.`Vendor`, s.`Transaction_Type`)  = concat_ignore_null(b2.`Ticket/PNR`, b2.`Vendor`, b2.`Transaction_Type`)  
	WHERE	 t1.`DOT`  >= '2021-04-01'
	 AND	t1.`Transaction Type`  = 'Refund'
	 AND	t1.`Air_Vendor`  IS NOT NULL
	 AND	t1.`Air_Vendor`  = 'Indigo'
	 AND	t1.`Length of Location`  >= 9
 
 
 
 
 
 
 
) x
LEFT JOIN(	SELECT DISTINCT
			 `AIrline`,
			 `Retrieval Type`
	FROM  `T7. Similar Airlines` 
) y ON y.`Airline`  = x.`Air_Vendor` 
LEFT JOIN `GST exempted Cities` g ON g.`City code`  = x.`Origin` 
LEFT JOIN "T6. Airport_Code" t6 ON x.`Origin`  = t6.`code` 
LEFT JOIN(	SELECT DISTINCT
			 f1.`Vendor` as 'Vendor',
			 f1.`Ticket/PNR` as 'Ticket/PNR',
			 f1.`Refund Type` as 'Refund Type'
	FROM  `Full Refund Cases` f1 
	WHERE	 f1.`Refund Type`  = 'Full Refund'
) f ON CONCAT(f.`Vendor`, f.`Ticket/PNR`)  = CONCAT(x.`Air_Vendor`, x.`Ticket/PNR`) 
LEFT JOIN `Clients - Airline details Query` st ON upper(CONCAT(st.`Workspace`, st.`airline`))  = upper(CONCAT(x.`Workspace`, x.`Air_Vendor`)) 
LEFT JOIN(	SELECT DISTINCT
			 stz.`Workspace` as 'Workspace',
			 stz.`SSR Status` as 'SSR Status'
	FROM  `Clients - Airline details Query` stz 
) st1 ON upper(st1.`Workspace`)  = upper(x.`Workspace`) 
LEFT JOIN `Gmail_Login_Email_Reading` m ON m.`Workspace`  = x.`Workspace` 
LEFT JOIN `B2C_Transactions_confirmation_email_by_Airline` b2c ON concat_ignore_null(b2c.`Ticket_Number`, b2c.`Workspace`, b2c.`Transaction_Type`)  = concat_ignore_null(x.`Ticket/PNR`, x.`Workspace`, x.`Transaction_Type`) 
LEFT JOIN(	SELECT DISTINCT
			 `workspace`,
			 `workspace_active`
	FROM  `T8. Company_GST_Number` 
) mm ON mm.`workspace`  = x.`workspace` 
LEFT JOIN(	SELECT DISTINCT
			 `za_id`,
			 `scraper_remark`,
			 'FAILED' as 'status'
	FROM  `live-connect-airline_engine_booking` 
) l ON concat_ignore_null(x.`Air_Vendor`, x.`GST`, x."Transaction_Type", x."Mercury Inv No", DATE(x."DOT"), x."Ticket/PNR", x.`Workspace`, x.`Passenger Name`, x."PNR", x.`PNR No`, x.`Invoice Status`)  = l.`za_id`  
GROUP BY mm.`workspace`,
	 x."Type" ,
		 x."Customer Name" ,
		 x."Party Site Name" ,
		 x."Mercury Inv No" ,
		 x."Inv No" ,
		 x."Aginst CM" ,
		 x."Inv Date" ,
		 x."Code" ,
		 x."GST" ,
		 x."Arln Inv" 	,
		 x."Date" ,
		 x."Arln GST" ,
		 x."Air_Vendor" ,
		 x."Passenger Name" ,
		 x."Ticket_Number",
		 x."Arln Code" ,
		 x."Flg No" ,
		 x."GL Code" ,
		 x."Basic Fare" ,
		 x."SGST" ,
		 x."CGST" ,
		 x."IGST" ,
		 x."Total" ,
		 x."Class" ,
		 x."Sector" ,
		 x."Cost Centre",
		 x."Employee Code",
		 x."Project Code",
		 x."Trip CC",
		 x."PNR No",
		 x."Airline Name" ,
		 x."Workspace",
		
		 x."PNR",
		 
		 x."Ticket/PNR",
		 x."Invoice - Customer_GSTIN",
		 x."Invoice - Name as per GST portal",
		 x."Supplier_GSTIN",
		 x."Invoice_Number",
		 x."Invoice_Date",
		 x."Invoice Taxable",
		 x."Invoice CGST" ,
		 x."Invoice SGST" ,
		 x."Invoice IGST",
		 x."Invoice Total_GST" ,
		 x."Invoice Total_Amount" ,
		 x."Transaction_Type" ,
		 x."Document_Type",
		 x."Invoice Status",
	 g.`city code`,
	 t6.`code`,
	 f.`Refund Type`,
	 st.`Login Status`,
	 st1.`SSR Status`,
	 x.`PNR No`,
	  x.`From` 
