  <!---  THis report done by EG.Zainab  Nadeem --->
  
  <cfparam name="attributes.POSITION_CODE" default="">	
   <cfset dec_sal_sum=0> 
   <cfset t_dec_sum=0>
    <cfset t_15_sum=0> 
	<cfset t_withour_sum=0>
     <cfset t_col10_sum=0>
      <cfset t_col9_sum=0>

	
<cfparam name="attributes.emp_id" default="">
<cfparam name="attributes.emp_name" default="">
<cfparam name="attributes.branch_id" default="">
<cfparam name="attributes.sal_mon" default="#MONTH(NOW())#">
<cfparam name="attributes.sal_year" default="#session.ep.period_year#">
<cfparam name="attributes.DEPARTMENT_ID" default="">
<cfparam name="attributes.Type_id" default="5">
<cfparam name="attributes.with_color" default="">
<cfparam name="attributes.new_staff" default="">
<cfparam name="attributes.changed_staff" default="">
<cfparam name="attributes.FUNC" default="">
<cfparam name="attributes.Grant_option" default="1,2,3">
<cfparam name="attributes.Grant" default="">
<cfparam name="attributes.col_option" default="">
<cfparam name="attributes.DepartmentXX" default="">
<cfparam name="attributes.Position" default="">
<cfparam name="attributes.Staff_ID" default="">
<cfparam name="attributes.Accounts" default="">
<cfparam name="attributes.Other_Accounts" default="">
<cfparam name="attributes.Table" default="1">

<cfparam name="attributes.REVIEWER1_id" default="">
<cfparam name="attributes.REVIEWER1_name" default="">

<cfparam name="attributes.REVIEWER2_id" default="">
<cfparam name="attributes.REVIEWER2_name" default="">
<cfparam name="attributes.APPROVAL1_id" default="">
<cfparam name="attributes.APPROVAL1_name" default="">

<cfparam name="attributes.APPROVAL2_id" default="">
<cfparam name="attributes.APPROVAL2_name" default="">

<cfsavecontent variable="ay1"><cf_get_lang_main no='180.Ocak'></cfsavecontent>
<cfsavecontent variable="ay2"><cf_get_lang_main no='181.Şubat'></cfsavecontent>
<cfsavecontent variable="ay3"><cf_get_lang_main no='182.Mart'></cfsavecontent>
<cfsavecontent variable="ay4"><cf_get_lang_main no='183.Nisan'></cfsavecontent>
<cfsavecontent variable="ay5"><cf_get_lang_main no='184.Mayıs'></cfsavecontent>
<cfsavecontent variable="ay6"><cf_get_lang_main no='185.Haziran'></cfsavecontent>
<cfsavecontent variable="ay7"><cf_get_lang_main no='186.Temmuz'></cfsavecontent>
<cfsavecontent variable="ay8"><cf_get_lang_main no='187.Ağustos'></cfsavecontent>
<cfsavecontent variable="ay9"><cf_get_lang_main no='188.Eylül'></cfsavecontent>
<cfsavecontent variable="ay10"><cf_get_lang_main no='189.Ekim'></cfsavecontent>
<cfsavecontent variable="ay11"><cf_get_lang_main no='190.Kasım'></cfsavecontent>
<cfsavecontent variable="ay12"><cf_get_lang_main no='191.Aralık'></cfsavecontent>
<cfset ay_list = "#ay1#,#ay2#,#ay3#,#ay4#,#ay5#,#ay6#,#ay7#,#ay8#,#ay9#,#ay10#,#ay11#,#ay12#">
<cfset attributes.sal_year_end=attributes.SAL_YEAR>
<cfset attributes.sal_mon_end=attributes.sal_mon>

<cfif len(attributes.Other_Accounts)><cfset attributes.col_option =""></cfif>
<cfif attributes.sal_mon eq 1>
				<cfset Prev_MON=12>
                <cfset Prev_YEAR=attributes.SAL_YEAR-1>
                <cfelse>
                <cfset Prev_MON=attributes.sal_mon-1>
                <cfset Prev_YEAR=attributes.SAL_YEAR>
                </cfif>

   <cfif attributes.Table eq 2>
<cfset coloption=2>
<cfelse>
<cfset coloption=3>
</cfif>
 <cfif len(attributes.Grant_option) and  attributes.Table neq 2> 
  <cfset coloption=listlen(attributes.Grant_option)>
 </cfif>

<cfquery name="get_possition" datasource="#DSN#">
SELECT DISTINCT 
EMPLOYEES_PUANTAJ_ROWS.POSITION_NAME 
FROM 
EMPLOYEES_PUANTAJ_ROWS,
EMPLOYEES_IN_OUT,
EMPLOYEES_PUANTAJ
WHERE EMPLOYEES_PUANTAJ_ROWS.IN_OUT_ID=EMPLOYEES_IN_OUT.IN_OUT_ID
AND EMPLOYEES_PUANTAJ_ROWS.PUANTAJ_ID=EMPLOYEES_PUANTAJ.PUANTAJ_ID
AND
<cfif isdefined("attributes.is_form_submitted")>
                  MONTH(FINISH_DATE)=#attributes.sal_mon# AND 
                  YEAR(FINISH_DATE)=#attributes.sal_year# AND
                  SAL_MON=#attributes.sal_mon# AND 
                  SAL_YEAR=#attributes.sal_year#
                  <cfelse>
                  1=0</cfif>
                  ORDER by  EMPLOYEES_PUANTAJ_ROWS.POSITION_NAME
</cfquery>
<cfquery name="getdepartment" datasource="#DSN#">
	SELECT distinct DEPARTMENT_HEAD FROM DEPARTMENT 
    
   <cfif isdefined("attributes.is_form_submitted")>
   WHERE DEPARTMENT_ID IN (SELECT DISTINCT 
                            EMPLOYEES_PUANTAJ_ROWS.DEPARTMENT_ID 
                            FROM 
                            EMPLOYEES_PUANTAJ_ROWS,
                            EMPLOYEES_IN_OUT,
                            EMPLOYEES_PUANTAJ
                            WHERE EMPLOYEES_PUANTAJ_ROWS.IN_OUT_ID=EMPLOYEES_IN_OUT.IN_OUT_ID
                            AND EMPLOYEES_PUANTAJ_ROWS.PUANTAJ_ID=EMPLOYEES_PUANTAJ.PUANTAJ_ID
                            AND MONTH(FINISH_DATE)=#attributes.sal_mon# AND 
                            YEAR(FINISH_DATE)=#attributes.sal_year# AND
                            SAL_MON=#attributes.sal_mon# AND 
                            SAL_YEAR=#attributes.sal_year#
                            )
    </cfif>
    ORDER BY DEPARTMENT_HEAD
</cfquery>  
<cfform name="form" method="post" action="#request.self#?fuseaction=report.detail_report&report_id=#attributes.report_id#">
<input name="is_form_submitted" id="is_form_submitted" type="hidden" value="1">
<cfif len(attributes.Type_id) and attributes.Type_id eq 5>
<input name="Final_Payment" id="Final_Payment" type="hidden" value="1">
</cfif>
<cf_basket_form id="gizli">
<div style="text-align:left">
<select name="sal_mon" id="sal_mon" style="width:75px;">
						<cfloop from="1" to="12" index="i">
						  <cfoutput><option value="#i#" <cfif attributes.sal_mon is i>selected</cfif> >#listgetat(ay_list,i,',')#</option></cfoutput>
						</cfloop>
					</select>
					<select name="sal_year" id="sal_year">
						<cfloop from="#session.ep.period_year#" to="#session.ep.period_year-3#" step="-1" index="i">
							<cfoutput><option value="#i#"<cfif attributes.sal_year eq i> selected</cfif>>#i#</option></cfoutput>
						</cfloop>
					</select>  <cf_wrk_search_button>
       <BR /><BR />
          
<strong>
مكتب الفرعي
</strong>   
<cfquery name="get_branch" datasource="#dsn#">
SELECT * FROM BRANCH WHERE BRANCH_STATUS = 1 ORDER BY BRANCH_ID
</cfquery>                        .
<cfset OZEL_KOD='#get_branch.OZEL_KOD#'>
<select name="branch_id" id="branch_id" style="width:160px;" onChange="">
<option value="" selected>الكل</option>
                    <cfoutput query="get_branch">
					<option value="#branch_id#" <cfif len(attributes.branch_id) and attributes.branch_id eq branch_id>selected<cfset OZEL_KOD='#OZEL_KOD#'></cfif>>#branch_id# - #branch_name#</option>
					</cfoutput>
                </select>
                        
  <br />  <br />
<input name="with_color" type="hidden" id="with_color" value="1"/> 

<table>
    	
      <tr>
        	<td colspan="5"><strong>خيارات البحث</strong></td></tr>
    	<tr>
            <td style="width:120px">رقم الموظف
              <input type="text" name="Staff_ID" id="Staff_ID" value="<cfif isdefined("attributes.Staff_ID") and len(attributes.Staff_ID)><cfoutput>#attributes.Staff_ID#</cfoutput></cfif>"></td>
            <cfif get_possition.RECORDCOUNT>
            <td colspan="2">المنصب
              <select name="Position" id="Position" multiple="multiple" style="width:260px">
                    <cfoutput query="get_possition">
					<option value="#POSITION_NAME#" <cfif ListFind(attributes.Position,POSITION_NAME,',')> selected</cfif>>#POSITION_NAME#</option>
					</cfoutput>
                </select></td>
            <cfelse>
             <td style="width:120px">المنصب
               <input type="text" name="Position" id="Position" value="<cfif isdefined("attributes.Position") and len(attributes.Position)><cfoutput>#attributes.Position#</cfoutput></cfif>"></td>
             </cfif>
             <td style="width:120px">الأقسام
             <select name="DepartmentXX" id="DepartmentXX" onChange="">
<option value="" selected>الكل</option>
                    <cfoutput query="getdepartment">
					<option value="#DEPARTMENT_HEAD#" <cfif len(attributes.DepartmentXX) and attributes.DepartmentXX eq DEPARTMENT_HEAD>selected</cfif>>#DEPARTMENT_HEAD#</option>
					</cfoutput>
                </select>
            </td>

        </tr>
    </table>    
            
     
                          </div>
                <br /></div>
         <cf_basket_form_button> 
        <cf_wrk_search_button button_type='1' is_excel='0'>
    </cf_basket_form_button>
</cf_basket_form>                     
</cfform>
<div id="detail_report_divxx">
<cfif isdefined("attributes.is_form_submitted")>


<cfset MONTH_DAYS=30>
<cfquery name="GET_MONTH_DAYS" datasource="#DSN#">
 SELECT datediff(day, CONCAT(#attributes.sal_mon#,'/','01', '/',#attributes.sal_year#), dateadd(month, 1, CONCAT(#attributes.sal_mon#,'/','01', '/',#attributes.sal_year#))) AS MONTH_DAYS
</cfquery>
<cfif GET_MONTH_DAYS.recordcount>
<cfif GET_MONTH_DAYS.MONTH_DAYS lte 30>
<cfset MONTH_DAYS=GET_MONTH_DAYS.MONTH_DAYS></cfif></cfif>


<cfscript>
		get_puantaj_ = createObject("component", "v16.hr.ehesap.cfc.get_dynamic_bordro");
		get_puantaj_.dsn = dsn;
		get_puantaj_.dsn_alias = dsn_alias;
		get_puantaj_rows = get_puantaj_.get_dynamic_bordro
		(
			sal_year : attributes.sal_year,
			sal_mon : attributes.sal_mon,
			sal_year_end : attributes.sal_year_end,
			sal_mon_end : attributes.sal_mon_end,
			puantaj_type : -1,
			branch_id: '#iif(isdefined("attributes.branch_id"),"attributes.branch_id",DE(""))#' ,
			comp_id: '#iif(isdefined("attributes.comp_id"),"attributes.comp_id",DE(""))#',
			department:'#iif(isdefined("attributes.department"),"attributes.department",DE(""))#',
			position_branch_id:'#iif(isdefined("attributes.position_branch_id"),"attributes.position_branch_id",DE(""))#',
			position_department:'#iif(isdefined("attributes.position_department"),"attributes.position_department",DE(""))#',
			is_all_dep:'#iif(isdefined("attributes.is_all_dep"),"attributes.is_all_dep",DE(""))#',
			is_dep_level:'#iif(isdefined("attributes.is_dep_level"),"attributes.is_dep_level",DE(""))#',
			ssk_statute:'#iif(isdefined("attributes.ssk_statute"),"attributes.ssk_statute",DE(""))#',
			duty_type:'#iif(isdefined("attributes.duty_type"),"attributes.duty_type",DE(""))#',
			main_payment_control:'#iif(isdefined("attributes.main_payment_control"),"attributes.main_payment_control",DE(""))#',
			department_level:'#iif(isdefined("attributes.is_dep_level"),"1","0")#',
			expense_center:'#iif(isdefined("attributes.expense_center"),"attributes.expense_center",DE(""))#'
		);
	</cfscript>
    
    <cfset get_puantaj_rows_old=get_puantaj_rows>
     <cfquery name="leave_STAFF" datasource="#dsn#">
                 SELECT EMPLOYEES.EMPLOYEE_ID,EMPLOYEES.EMPLOYEE_NO,IN_OUT_ID
                 FROM EMPLOYEES_IN_OUT ,EMPLOYEES
                 WHERE
                  EMPLOYEES.EMPLOYEE_ID=EMPLOYEES_IN_OUT.EMPLOYEE_ID AND
                  MONTH(FINISH_DATE)=#attributes.sal_mon# AND 
                  YEAR(FINISH_DATE)=#attributes.sal_year# 
                  AND SALARY_TYPE=2
                 </cfquery>
    <cfquery name="get_puantaj_rows1" dbtype="query">
        SELECT * FROM get_puantaj_rows
        WHERE 
        <cfif leave_STAFF.RECORDCOUNT>
       IN_OUT_ID IN (#VALUELIST(leave_STAFF.IN_OUT_ID)#)
       <cfelse> 1=0 </cfif>
        <cfif len(attributes.Type_id) and attributes.Type_id eq 5>
 <cfif isdefined("attributes.Staff_ID") and len(attributes.Staff_ID)>
 AND EMPLOYEE_NO LIKE '%#attributes.Staff_ID#%'
 </cfif>
  <cfif isdefined("attributes.Position") and len(attributes.Position)>
  AND (POSITION_NAME LIKE '%#listfirst(attributes.Position)#%' <cfloop from="2" to="#listlen(attributes.Position)#" index="i">
  <cfif len(listgetat(attributes.Position,i,','))>
  OR POSITION_NAME LIKE '%#listgetat(attributes.Position,i,',')#%'</cfif></cfloop>)
  </cfif>
  <cfif isdefined("attributes.DepartmentXX") and len(attributes.DepartmentXX)>
AND DEPARTMENT_HEAD LIKE '#attributes.DepartmentXX#'
</cfif>
<cfif LEN(attributes.Grant)>
   <cfif ISDEFINED('GET_ALLCTION') AND GET_ALLCTION.RECORDCOUNT>
   
   AND EMPLOYEE_ID IN(#VALUELIST(GET_ALLCTION.EMP_ID)#)
   <cfelse>
   AND 1=0
   </cfif>
</cfif>
<cfif LEN(attributes.Accounts)>
AND FUNC_ID IN (#attributes.Accounts#)
</cfif>
</cfif>
    </cfquery>
<cfset get_puantaj_rows=get_puantaj_rows1>
<cfquery name="getserv" dbtype="query">
   SELECT EMPLOYEE_ID,BRANCH_ID FROM get_puantaj_rows WHERE FUNC_ID=2
</cfquery>
<cfoutput query="getserv">
<cfquery name="GET_RATE_LEAVE" datasource="#dsn#">
   SELECT * FROM ALLOCATION_PLAN WHERE ALLOCATION_MONTH=#attributes.sal_mon# AND ALLOCATION_YEAR=#attributes.sal_year# AND EMP_ID=#EMPLOYEE_ID# AND RATE = 100 AND ALLOCATION_NAME LIKE 'YEM Service%'
   </cfquery>
   <cfif GET_RATE_LEAVE.RECORDCOUNT>
      <cfquery name="getserv1" dbtype="query">
     SELECT EMPLOYEE_ID FROM get_puantaj_rows_old WHERE BRANCH_ID=#BRANCH_ID# AND FUNC_ID=2 AND EMPLOYEE_ID NOT IN (#VALUELIST(leave_STAFF.EMPLOYEE_ID)#)
  </cfquery>
      <cfif getserv1.RECORDCOUNT>
  <cfquery datasource="#dsn#">
  UPDATE ALLOCATION_PLAN
  SET RATE=(SELECT AP.RATE FROM ALLOCATION_PLAN AP WHERE AP.ALLOCATION_MONTH=#attributes.sal_mon# AND AP.ALLOCATION_YEAR=#attributes.sal_year# AND AP.EMP_ID=#getserv1.EMPLOYEE_ID# AND AP.ALLOCATION_NAME=ALLOCATION_PLAN.ALLOCATION_NAME)
  WHERE ALLOCATION_MONTH=#attributes.sal_mon# AND ALLOCATION_YEAR=#attributes.sal_year#
  AND EMP_ID=#EMPLOYEE_ID#
   </cfquery>
  </cfif>
 </cfif>
</cfoutput>
    <cfquery name="GET_ALLOCATION_PROJECT" datasource="#DSN#">
SELECT DISTINCT ALLOCATION_NO,ALLOCATION_NAME,SUM(RATE)
FROM 
ALLOCATION_PLAN
WHERE
    ALLOCATION_MONTH=#attributes.sal_mon# AND
    ALLOCATION_YEAR=#attributes.sal_year#
    <cfif leave_STAFF.RECORDCOUNT>
    AND   EMP_ID IN (#VALUELIST(leave_STAFF.EMPLOYEE_ID)#)
       <cfelse> AND 1=0 </cfif>
     <cfif len(attributes.Type_id) and attributes.Type_id eq 5 AND LEN(attributes.Grant)>
     AND ( <cfloop from="1" to="#LISTLEN(attributes.Grant)#" index="I">
            ALLOCATION_NAME LIKE '#listgetat(attributes.Grant,I,',')#' 
            <cfif I NEQ LISTLEN(attributes.Grant)>
            OR </cfif>
            </cfloop>)
     </cfif>
GROUP BY ALLOCATION_NO,ALLOCATION_NAME
HAVING SUM(RATE)>0
order by ALLOCATION_NAME
</cfquery>
<cfset day_last = createodbcdatetime(createdate(attributes.sal_year_end,attributes.sal_mon_end,daysinmonth(createdate(attributes.sal_year_end,attributes.sal_mon_end,1))))>
<cfset sayfa_no = 0>

<cfquery name="GET_EXPENSES" datasource="#iif(fusebox.use_period,"dsn2","dsn")#">
	SELECT 
        EXPENSE, 
        HIERARCHY, 
        EXPENSE_CODE, 
        EXPENSE_ACTIVE 
    FROM 
        EXPENSE_CENTER 
    ORDER BY 
    	EXPENSE_CODE
</cfquery>
<cfset main_expense_list = valuelist(get_expenses.expense_code,';')>
<cfquery name="get_emp_branches" datasource="#DSN#">
	SELECT
		BRANCH_ID
	FROM
		EMPLOYEE_POSITION_BRANCHES
	WHERE
		EMPLOYEE_POSITION_BRANCHES.POSITION_CODE = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.ep.position_code#">
</cfquery>
<cfset emp_branch_list = valuelist(get_emp_branches.branch_id)>
<cfquery name="get_emp_puantaj_ids" datasource="#dsn#">
        SELECT DISTINCT
			EMPLOYEE_PUANTAJ_ID 
		FROM 
			EMPLOYEES_PUANTAJ_ROWS EPR
			INNER JOIN EMPLOYEES_PUANTAJ EP ON EPR.PUANTAJ_ID = EP.PUANTAJ_ID
			INNER JOIN BRANCH B ON EP.SSK_OFFICE = B.SSK_OFFICE AND EP.SSK_OFFICE_NO = B.SSK_NO
		WHERE 
			(
				(EP.SAL_YEAR > <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.sal_year#"> AND EP.SAL_YEAR < <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.sal_year_end#">)
				OR
				(
					EP.SAL_YEAR = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.sal_year#"> AND 
					EP.SAL_MON >= <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.sal_mon#"> AND
					(
						EP.SAL_YEAR < <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.sal_year_end#"> OR
						(EP.SAL_MON <= <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.sal_mon_end#"> AND EP.SAL_YEAR = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.sal_year_end#">)
					)
				)
				OR
				(
					EP.SAL_YEAR > <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.sal_year#"> AND 

					(
						EP.SAL_YEAR < <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.sal_year_end#"> OR
						(EP.SAL_MON <= <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.sal_mon_end#"> AND EP.SAL_YEAR = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.sal_year_end#">)
					)
				)
				OR
				(
					EP.SAL_YEAR = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.sal_year_end#"> AND 
					EP.SAL_YEAR = <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.sal_year_end#"> AND
					EP.SAL_MON >= <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.sal_mon#"> AND
					EP.SAL_MON <= <cfqueryparam cfsqltype="cf_sql_integer" value="#attributes.sal_mon_end#">
				)
			) 
			<cfif isdefined("attributes.branch_id") and len(attributes.branch_id)>
				AND B.BRANCH_ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="true" value="#attributes.branch_id#">)	
			</cfif>
            <cfif isdefined("attributes.comp_id") and len(attributes.comp_id)>
				AND B.COMPANY_ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="true" value="#attributes.comp_id#">)	
			</cfif>
			<cfif not session.ep.ehesap>AND B.BRANCH_ID IN (<cfqueryparam cfsqltype="cf_sql_integer" list="true" value="#emp_branch_list#">)</cfif>
</cfquery>
<cfset employee_puantaj_ids = valuelist(get_emp_puantaj_ids.employee_puantaj_id)>
<cfquery name="get_kesintis" datasource="#dsn#">
	SELECT 
		PUANTAJ_ID, 
		EMPLOYEE_PUANTAJ_ID, 
		COMMENT_PAY, 
		PAY_METHOD, 
		AMOUNT_2, 
		AMOUNT, 
		SSK, 
		TAX, 
		EXT_TYPE, 
		ACCOUNT_CODE, 
		AMOUNT_PAY
	FROM 
		EMPLOYEES_PUANTAJ_ROWS_EXT
	WHERE 
		<cfif listlen(employee_puantaj_ids)>EMPLOYEE_PUANTAJ_ID IN (#employee_puantaj_ids#)<cfelse>1=0</cfif> AND 
		EXT_TYPE = 1 
	ORDER BY 
		COMMENT_PAY
</cfquery>
<cfquery name="get_kesinti_adlar" dbtype="query">
	SELECT DISTINCT COMMENT_PAY FROM get_kesintis WHERE COMMENT_PAY <> 'Avans' ORDER BY COMMENT_PAY
</cfquery>
<cfset kesinti_names = listsort(valuelist(get_kesinti_adlar.comment_pay),"text","ASC")>
<cfset count_ = 0>
<cfloop list="#kesinti_names#" index="cc">
	<cfset count_ = count_ + 1>
	<cfset 't_kesinti_#count_#' = 0>
	<cfset 'd_t_kesinti_#count_#' = 0>
</cfloop>
<cfquery name="get_odeneks" datasource="#dsn#">
	SELECT 
		EMPLOYEES_PUANTAJ_ROWS_EXT.PUANTAJ_ID, 
		EMPLOYEES_PUANTAJ_ROWS_EXT.EMPLOYEE_PUANTAJ_ID, 
		EMPLOYEES_PUANTAJ_ROWS_EXT.COMMENT_PAY, 
		EMPLOYEES_PUANTAJ_ROWS_EXT.PAY_METHOD, 
		EMPLOYEES_PUANTAJ_ROWS_EXT.AMOUNT_2, 
		EMPLOYEES_PUANTAJ_ROWS_EXT.AMOUNT, 
		EMPLOYEES_PUANTAJ_ROWS_EXT.SSK, 
		EMPLOYEES_PUANTAJ_ROWS_EXT.TAX, 
		EMPLOYEES_PUANTAJ_ROWS_EXT.EXT_TYPE, 
		EMPLOYEES_PUANTAJ_ROWS_EXT.ACCOUNT_CODE, 
		EMPLOYEES_PUANTAJ_ROWS_EXT.AMOUNT_PAY,
		SETUP_PAYMENT_INTERRUPTION.FROM_SALARY,
		SETUP_PAYMENT_INTERRUPTION.CALC_DAYS
	FROM 
		EMPLOYEES_PUANTAJ_ROWS_EXT LEFT JOIN SETUP_PAYMENT_INTERRUPTION
		ON EMPLOYEES_PUANTAJ_ROWS_EXT.COMMENT_PAY_ID = SETUP_PAYMENT_INTERRUPTION.ODKES_ID
	WHERE 
		<cfif listlen(employee_puantaj_ids)>EMPLOYEE_PUANTAJ_ID IN (#employee_puantaj_ids#)<cfelse>1=0</cfif> AND 
		EXT_TYPE = 0 
	ORDER BY 
		COMMENT_PAY
</cfquery>
<cfquery name="get_odenek_adlar" dbtype="query">
	SELECT DISTINCT COMMENT_PAY FROM get_odeneks
</cfquery>
<cfset odenek_names = listsort(valuelist(get_odenek_adlar.comment_pay),"text","ASC")>
<cfset count_ = 0>
<cfloop list="#odenek_names#" index="cc">
	<cfset count_ = count_ + 1>
	<cfset 't_odenek_#count_#' = 0>
	<cfset 'd_t_odenek_#count_#' = 0>
	<cfset 't_odenek_net_#count_#' = 0>
	<cfset 'd_t_odenek_net_#count_#' = 0>
</cfloop>
<cfquery name="get_vergi_istisna" datasource="#dsn#">
	SELECT 
		VERGI_ISTISNA_AMOUNT,
		VERGI_ISTISNA_TOTAL,
		COMMENT_PAY,
		EMPLOYEE_PUANTAJ_ID
	FROM 
		EMPLOYEES_PUANTAJ_ROWS_EXT
	WHERE 
		<cfif listlen(employee_puantaj_ids)>EMPLOYEE_PUANTAJ_ID IN (#employee_puantaj_ids#)<cfelse>1=0</cfif> AND 
		EXT_TYPE = 2 
	ORDER BY 
		COMMENT_PAY
</cfquery>
<cfquery name="get_vergi_istisna_adlar" dbtype="query">
	SELECT DISTINCT COMMENT_PAY FROM get_vergi_istisna
</cfquery>
<cfset vergi_istisna_names = valuelist(get_vergi_istisna_adlar.comment_pay)>
<cfset count_ = 0>
<cfloop list="#vergi_istisna_names#" index="cc">
	<cfset count_ = count_ + 1>
	<cfset 't_vergi_#count_#' = 0>
	<cfset 'd_t_vergi_#count_#' = 0>
	<cfset 't_vergi_net_#count_#' = 0>
	<cfset 'd_t_vergi_net_#count_#' = 0>
</cfloop>
<cfquery name="get_definition" datasource="#DSN#">
	SELECT
		DEFINITION,
		PAYROLL_ID
	FROM
		SETUP_SALARY_PAYROLL_ACCOUNTS_DEFF
    ORDER BY 
    	PAYROLL_ID
</cfquery>
<cfset def_list = listsort(listdeleteduplicates(valuelist(get_definition.payroll_id,',')),'numeric','ASC',',')>
<cfquery name="get_pay_methods" datasource="#dsn#">
	SELECT 
		SP.PAYMETHOD_ID, 
        SP.PAYMETHOD
	FROM 
		SETUP_PAYMETHOD SP,
		SETUP_PAYMETHOD_OUR_COMPANY SPOC
	WHERE
		SP.PAYMETHOD_STATUS = 1
		AND SP.PAYMETHOD_ID = SPOC.PAYMETHOD_ID 
		AND SPOC.OUR_COMPANY_ID = <cfqueryparam cfsqltype="cf_sql_integer" value="#session.ep.company_id#">
</cfquery>
<cfset pay_list = listsort(listdeleteduplicates(valuelist(get_pay_methods.PAYMETHOD_ID,',')),'numeric','ASC',',')>
<cfquery name="get_units" datasource="#DSN#">
	SELECT 
    	UNIT_ID, 
        UNIT_NAME, 
        HIERARCHY 
    FROM 
	    SETUP_CV_UNIT 
    ORDER BY 
    	UNIT_ID
</cfquery>
<cfset fonsiyonel_list = listsort(listdeleteduplicates(valuelist(get_units.unit_id,',')),'numeric','ASC',',')>
<cfquery name="get_position_cats" datasource="#DSN#">
	SELECT 
    	POSITION_CAT_ID, 
        POSITION_CAT,
        HIERARCHY 
    FROM 
    	SETUP_POSITION_CAT 
    ORDER BY 
	    POSITION_CAT_ID
</cfquery>
<cfset position_cat_list = listsort(listdeleteduplicates(valuelist(get_position_cats.POSITION_CAT_ID,',')),'numeric','ASC',',')>
<cfquery name="get_titles" datasource="#DSN#">
	SELECT 
    	TITLE_ID, 
        TITLE 
    FROM 
	    SETUP_TITLE 
    ORDER BY 
    	TITLE_ID
</cfquery>
<cfset title_list = listsort(listdeleteduplicates(valuelist(get_titles.TITLE_ID,',')),'numeric','ASC',',')>
<cfquery name="get_branchs" datasource="#DSN#">
	SELECT BRANCH_ID,BRANCH_NAME FROM BRANCH ORDER BY BRANCH_ID
</cfquery>
<cfset branch_list = listsort(listdeleteduplicates(valuelist(get_branchs.BRANCH_ID,',')),'numeric','ASC',',')>
<cfquery name="get_departments" datasource="#DSN#">
	SELECT DEPARTMENT_ID,DEPARTMENT_HEAD FROM DEPARTMENT ORDER BY DEPARTMENT_ID
</cfquery>
<cfset department_list = listsort(listdeleteduplicates(valuelist(get_departments.DEPARTMENT_ID,',')),'numeric','ASC',',')>
<cfquery name="get_dep_lvl" datasource="#dsn#">
    SELECT DISTINCT LEVEL_NO FROM DEPARTMENT WHERE LEVEL_NO IS NOT NULL ORDER BY LEVEL_NO
</cfquery>
<cfset dep_level_list = listsort(valuelist(get_dep_lvl.level_no),"numeric" ,"ASC")>
<cfset type_ = "employee_puantaj_id">
<cfset sayfa_count_ = 0>
<cfparam name="attributes.totalrecords" default="#get_puantaj_rows.recordcount#">
</cfif>
<cfif isdefined("attributes.is_form_submitted") AND  attributes.Type_id EQ 3>
<cfif GET_ALLOCATION_PROJECT.RECORDCOUNT>
 <cfquery name="CLOSED_STATE" datasource="#dsn#">
   SELECT * FROM SAVED_REPORTS
   WHERE REPORT_NAME LIKE 'HR_REPORT_#attributes.sal_mon#_#attributes.sal_year#'
</cfquery>
 <cfset T_P_ROWG=0>
 <cfset T_P_ROW9=0>
  <cfset T_SP_ROWG=0>
 <cfset T_SP_ROW9=0>
  <cfset T_SR_ROWG=0>
 <cfset T_SR_ROW9=0>
 
  <cfset T_WO_ROWG=0>
 <cfset T_WO_ROW9=0>
 
  <cfset CNT_SP=0>

  <cfset EMP_ERR=''>
  
<cfoutput query="get_puantaj_rows">
   <cfset cont='0'>
   <cfset NET_=0>
<cfif CLOSED_STATE.recordcount>
<cftry>
   <cffile action="read" file="#upload_folder#report#dir_seperator#saved#dir_seperator##CLOSED_STATE.FILE_NAME#" variable="cont" charset="utf-8">
   <cfscript>
  start = findnocase('id="#EMPLOYEE_ID#">',cont,1);
  middle = findnocase('</td>',cont,start + len('</td>'));
		cont = removechars(cont,1,start);
		start = findnocase('</td>',cont,1);
		cont = removechars(cont,start,len(cont));
		cont=trim(replace(cont,'d="#EMPLOYEE_ID#">',''));
		cont=trim(replace(cont,'-','0'));
 </cfscript>
<cfcatch type="any"></cfcatch>
</cftry>
</cfif>
 <cfquery name="GET_ANNUAL_" datasource="#dsn#">
    SELECT
    	ISNULL(KULLANILMAYAN_IZIN_COUNT,0) ANNUAL_DAYS,
        ISNULL(KULLANILMAYAN_IZIN_AMOUNT,0) ANNUAL_AMONT
    FROM EMPLOYEES_IN_OUT
    WHERE
    	IN_OUT_ID = #IN_OUT_ID#
</cfquery>
<cfset NET_=GET_ANNUAL_.ANNUAL_AMONT+(DAMGA_VERGISI_MATRAH/MONTH_DAYS*TOTAL_DAYS)>
    <cfif cont neq '0' AND GET_ANNUAL_.ANNUAL_DAYS NEQ evaluate('#cont#')>
    <cfquery datasource="#DSN#">
      UPDATE EMPLOYEES_IN_OUT 
      SET KULLANILMAYAN_IZIN_COUNT = #evaluate('#cont#')#,
      KULLANILMAYAN_IZIN_AMOUNT=#evaluate('#cont#')/30*DAMGA_VERGISI_MATRAH#
      WHERE IN_OUT_ID=#IN_OUT_ID#
    </cfquery>
    <cfset NET_=(evaluate('#cont#')/30*DAMGA_VERGISI_MATRAH)+(DAMGA_VERGISI_MATRAH/MONTH_DAYS*TOTAL_DAYS)>
    <cfelseif cont eq '0'>
     <cfquery datasource="#DSN#">
      UPDATE EMPLOYEES_IN_OUT 
      SET KULLANILMAYAN_IZIN_COUNT = 0,
      KULLANILMAYAN_IZIN_AMOUNT=0
      WHERE IN_OUT_ID=#IN_OUT_ID#
    </cfquery>
     <cfset NET_=DAMGA_VERGISI_MATRAH/MONTH_DAYS*TOTAL_DAYS>
    </cfif>

  </cfoutput>
<cfquery name="GET_AGG_P_T" datasource="#DSN#">
    SELECT SUM(ISSIZLIK_ISVEREN_HISSESI) AS NINTH,
ISNULL(SUM(DAMGA_VERGISI_MATRAH*(TOTAL_DAYS/30))+SUM(KULLANILMAYAN_IZIN_AMOUNT),0) AS GROS 
FROM  EMPLOYEES_PUANTAJ_ROWS, EMPLOYEES_IN_OUT
    WHERE 
     EMPLOYEES_IN_OUT.IN_OUT_ID = EMPLOYEES_PUANTAJ_ROWS.IN_OUT_ID
    AND  EMPLOYEE_PUANTAJ_ID IN (<cfif Get_PROGRAM.recordcount>#VALUELIST(Get_PROGRAM.EMPLOYEE_PUANTAJ_ID)#<cfelse>-1</cfif>)
</cfquery>
<cfquery name="GET_AGG_SP_T"  datasource="#DSN#">
    SELECT SUM(ISSIZLIK_ISVEREN_HISSESI) AS NINTH,
ISNULL(SUM(DAMGA_VERGISI_MATRAH*(TOTAL_DAYS/30))+SUM(KULLANILMAYAN_IZIN_AMOUNT),0) AS GROS 
FROM  EMPLOYEES_PUANTAJ_ROWS, EMPLOYEES_IN_OUT
    WHERE 
     EMPLOYEES_IN_OUT.IN_OUT_ID = EMPLOYEES_PUANTAJ_ROWS.IN_OUT_ID
    AND  EMPLOYEE_PUANTAJ_ID IN (<cfif Get_SUPPORT.recordcount>#VALUELIST(Get_SUPPORT.EMPLOYEE_PUANTAJ_ID)#<cfelse>-1</cfif>)
</cfquery>
<cfquery name="GET_AGG_SR_T"  datasource="#DSN#">
     SELECT SUM(ISSIZLIK_ISVEREN_HISSESI) AS NINTH,
ISNULL(SUM(DAMGA_VERGISI_MATRAH*(TOTAL_DAYS/30))+SUM(KULLANILMAYAN_IZIN_AMOUNT),0) AS GROS 
FROM  EMPLOYEES_PUANTAJ_ROWS, EMPLOYEES_IN_OUT
    WHERE 
     EMPLOYEES_IN_OUT.IN_OUT_ID = EMPLOYEES_PUANTAJ_ROWS.IN_OUT_ID
    AND EMPLOYEE_PUANTAJ_ID IN (<cfif Get_SERVICE.recordcount>#VALUELIST(Get_SERVICE.EMPLOYEE_PUANTAJ_ID)#<cfelse>-1</cfif>)
</cfquery>
<cfset c_no=1>
   <cfif GET_ALLOCATION_PROJECT.recordcount>
   <cfset c_no=GET_ALLOCATION_PROJECT.recordcount+1>
   </cfif>


 </cfif>
<cfelseif isdefined("attributes.is_form_submitted")>
<cfif len(attributes.FUNC)>
  <cfquery name="GET_AGG_puantaj_rows" dbtype="query">
    SELECT * FROM get_puantaj_rows
    WHERE FUNC_ID = #attributes.FUNC#
</cfquery>
<cfset get_puantaj_rows =GET_AGG_puantaj_rows>
</cfif>
<cfquery name="check" datasource="#dsn#">
	SELECT
		COMPANY_NAME,
		TEL_CODE,
		TEL,
		TEL2,
		TEL3,
		TEL4,
		FAX,
		ADDRESS,
		WEB,
		EMAIL,
		ASSET_FILE_NAME3,
		ASSET_FILE_NAME3_SERVER_ID,
		TAX_OFFICE,
		TAX_NO
	FROM
		OUR_COMPANY
	WHERE
		<cfif isDefined("session.ep.company_id")>
			COMP_ID = #session.ep.company_id#
		<cfelseif isDefined("session.pp.company")>	
			COMP_ID = #session.pp.company_id#
		</cfif> 
</cfquery>
  <cfset c_no=1>
   <cfif GET_ALLOCATION_PROJECT.recordcount>
   <cfset c_no=GET_ALLOCATION_PROJECT.recordcount+1>
   </cfif>
   <cfset col_no=9>
	<cfif  attributes.Type_id eq 4>
    <cfset col_no=7+c_no>
    </cfif>
<table class="basket_list" width="99%">
<cfif isdefined("attributes.is_form_submitted")>
<cfset total_taxable=0>
    <cfset sayfa_count_ = sayfa_count_ + 1>
    <cfif (sayfa_count_ eq 1)>
        <cfset sayfa_no = sayfa_no + 1>
        <cfset cols_plus = 0>
        </cfif>
 <cfset Total_adjustment=0>
  <cfset Total_annual_amount=0>
  <cfset count_Balance_days=0>
    <cfset Total_Earned=0>
    <cfset Total_Annual_Leave_tax=0>
    <cfset Total_tax=0>
        <thead>
 
 <cfif not len(attributes.col_option) and not len(attributes.Other_Accounts)>    
  <tr>
    <td style="border:1px solid #000; text-align:center" colspan="9">   بيانات الموظف</td>
    <td style="border:1px solid #000; text-align:center" colspan="17">  المستحق لكم </td>
    <td style="border:1px solid #000; text-align:center" colspan="13">  المستحق عليكم  </td>
    <td style="border:1px solid #000; text-align:center" >  الاجمالي</td>
  </tr>            
  <tr>
  <!--- information about employees--->
    <th style="border:1px solid #000; text-align:center" rowspan="3">#</th>
    <th style="border:1px solid #000; text-align:center" rowspan="3">رقم الموظف</th>
    <th style="border:1px solid #000; text-align:center" rowspan="3">اسم الموظف</th>
    <th style="border:1px solid #000;text-align:center"  rowspan="3">الادارة</th>
     <th style="border:1px solid #000; text-align:center" rowspan="3">المسمئ الوظيفي </th>
    <th style="border:1px solid #000; text-align:center"  rowspan="3">تاريخ الالتحاق</th>
    <th style="border:1px solid #000; text-align:center"  rowspan="3">تاريخ انتهاء الخدمة</th> 
    <th style="border:1px solid #000; text-align:center" rowspan="3"> سبب نرك الخدمة</th>
    <th style="border:1px solid #000; text-align:center" rowspan="3">ايام الشغل</th>
    <!---<th style="border:1px solid #000; text-align:center" rowspan="3">الفرع</th> ---> 
    <!--- The employee receives--->
    <th style="border:1px solid #000; text-align:center" rowspan="3">إجمالي أخر راتب يتقاضاه </th>
    <th style="border:1px solid #000; text-align:center" rowspan="3">الراتب الاجمالي بناء على ايام الشغل</th>  
    <th style="border:1px solid #000; text-align:center" colspan="4">بدلات خارج الراتب </th> 
    <th style="border:1px solid #000; text-align:center" rowspan="3">حقوق نهاية الخدمة </th>
    <th style="border:1px solid #000; text-align:center" rowspan="3">مخصص بدل علاج</th>
    <th style="border:1px solid #000; text-align:center" rowspan="3">فارق عهدة</th>
    <th style="border:1px solid #000; text-align:center" colspan="3"rowspan="2" >التأمينات</th>
    <th style="border:1px solid #000; text-align:center" colspan="2" rowspan="2">الاجارات السنوية</th>
    <th style="border:1px solid #000; text-align:center" rowspan="3" >راتب شهر الإنذار </th>
    <th style="border:1px solid #000; text-align:center" rowspan="3" >مكافئة </th>  
    <th style="border:1px solid #000; text-align:center" rowspan="3" >إجمالي المستحق لكم </th> 
    <!------>
   <!--- The employee owed --->
    <th style="border:1px solid #000; text-align:center" colspan="12" >الخصميات</th>
    <th style="border:1px solid #000; text-align:center" rowspan="3" >إجمالي المستحق عليكم </th>

    <th style="border:1px solid #000; text-align:center" rowspan="3" >صافي المستحق الراتب </th>
   <!------>
    </tr>
    
  <tr>
   <th style="border:1px solid #000; text-align:center" rowspan="2">الموصلات</th>   
    <th style="border:1px solid #000; text-align:center" rowspan="2">مظهر </th>
    <th style="border:1px solid #000; text-align:center" rowspan="2">إجمالي بدلات الاخرى </th>
    <th style="border:1px solid #000; text-align:center" rowspan="2">اجمالي البدلات</th>
    <th style="border:1px solid #000; text-align:center" colspan="4">الضريبة</th>
    <th style="border:1px solid #000; text-align:center" colspan="7">الخصميات</th>
    <th style="border:1px solid #000; text-align:center" rowspan="2">أجمالي الخصميات</th>
  </tr>
  <tr>
    
    <th style="border:1px solid #000; text-align:center"rowspan="3">حصــة الموظف بتأمين الاجتماعي</th>    
    <th style="border:1px solid #000; text-align:center"rowspan="3">حصــة الشركة بتأمين الاجتماعي</th>
    <th style="border:1px solid #000; text-align:center"rowspan="3">تأمينات اجتماعية  ( ازدواج )</th>
    <th style="border:1px solid #000; text-align:center"rowspan="3">الايام</th>
    <th style="border:1px solid #000; text-align:center"rowspan="3">المبلغ</th>
    <th style="border:1px solid #000; text-align:center">الوعاء الضريبي</th>
    <th style="border:1px solid #000; text-align:center"> الضريبة</th> 
    <th style="border:1px solid #000; text-align:center">ضريبة الاجازة السنوية</th>
    <th style="border:1px solid #000; text-align:center">أجمالي الضريبة</th>

    <th style="border:1px solid #000; text-align:center">خصم تأخيرات </th>
    <th style="border:1px solid #000; text-align:center"> إجازة بدون راتب </th> 
    <th style="border:1px solid #000; text-align:center">تكافل اجتماعي عن عدد أيام </th>
    <th style="border:1px solid #000; text-align:center">سلف مؤقتة </th>
    <th style="border:1px solid #000; text-align:center">سلف مستديمة </th>
    <th style="border:1px solid #000; text-align:center"> قيمة عهد عينية  </th> 
    <th style="border:1px solid #000; text-align:center"> أستقطاعات اخرى</th>
    <br />   
  </tr>
  </cfif>

    <cfset Za_t_Basic_Salary = 0>
    <cfset Za_t_Trans = 0>
    <cfset Za_t_Rep = 0>
    <cfset Za_t_Total_Allowances = 0>
    <cfset Za_t_Gross_Salary = 0>
    <cfset Za_t_Gross_Salary_Days_Worked = 0>
    <cfset Za_t_Gross_salary_S_S = 0>
    <cfset Za_t_Employee_SS = 0>
    <cfset Za_t_IMC_SS= 0>
    <cfset Za_t_Day =0>
    <cfset Za_t_Amount = 0>

    <cfset Za_t_Total_Earned = 0>
    <cfset Za_t_Taxable_salary = 0>
    <cfset Za_t_Salary_Tax = 0>
    <cfset Za_t_Annual_Leave_Tax= 0>
    <cfset Za_t_Total_Tax = 0>
    <cfset Za_t_Total_Deductions = 0>
    <cfset Za_t_Net_Pay = 0>
  </thead>
    </cfif>
    <tbody>
    <cfif isdefined("attributes.is_form_submitted")>
    <cfquery name="CLOSED_STATE" datasource="#dsn#">
   SELECT * FROM SAVED_REPORTS
   WHERE REPORT_NAME LIKE 'HR_REPORT_#attributes.sal_mon#_#attributes.sal_year#'
</cfquery>
    <cfif listfind('1,2,4',attributes.Type_id) AND ((isdefined('attributes.new_staff') AND LEN(attributes.new_staff)) or (isdefined('attributes.changed_staff') AND LEN(attributes.changed_staff)))>
    <cfquery name="CHANGED_STAFF1" datasource="#dsn#">
                 SELECT EMPLOYEE_POSITIONS_CHANGE_HISTORY.EMPLOYEE_ID 
                 FROM EMPLOYEE_POSITIONS_CHANGE_HISTORY 
                 WHERE
                 (SELECT top(1) M#Prev_MON# FROM EMPLOYEES_SALARY WHERE EMPLOYEE_ID=EMPLOYEE_POSITIONS_CHANGE_HISTORY.EMPLOYEE_ID AND PERIOD_YEAR=#Prev_YEAR#) IS NOT NULL
                 AND
                 (SELECT top(1) M#Prev_MON# FROM EMPLOYEES_SALARY WHERE EMPLOYEES_SALARY.EMPLOYEE_ID=EMPLOYEE_POSITIONS_CHANGE_HISTORY.EMPLOYEE_ID AND PERIOD_YEAR=#Prev_YEAR#) <> (SELECT top(1) M#attributes.sal_mon# FROM EMPLOYEES_SALARY WHERE EMPLOYEES_SALARY.EMPLOYEE_ID=EMPLOYEE_POSITIONS_CHANGE_HISTORY.EMPLOYEE_ID AND PERIOD_YEAR=#attributes.sal_year#)
                 </cfquery>
                 <cfquery name="CHANGED_STAFF2" datasource="#dsn#">
                 SELECT EMPLOYEE_ID 
                 FROM EMPLOYEES_IN_OUT 
                 WHERE
                  MONTH(START_DATE)=#attributes.sal_mon# AND YEAR(START_DATE)=#attributes.sal_year# 
                 </cfquery>
      <cfset CHANGED_STAFF_LIST='0'>
      <cfset NEW_STAFF_LIST='0'>
      <cfif CHANGED_STAFF1.RECORDCOUNT>
      <cfset CHANGED_STAFF_LIST= VALUELIST(CHANGED_STAFF1.EMPLOYEE_ID)>
      </cfif>
      <cfif CHANGED_STAFF2.RECORDCOUNT>
      <cfset NEW_STAFF_LIST= VALUELIST(CHANGED_STAFF2.EMPLOYEE_ID)>
      </cfif>
      <cfquery name="GET_STAFF" dbtype="query">
        SELECT * FROM get_puantaj_rows
        WHERE 
        <cfif isdefined('attributes.new_staff') AND LEN(attributes.new_staff) AND isdefined('attributes.changed_staff') AND LEN(attributes.changed_staff)>
        (
         EMPLOYEE_ID IN (#CHANGED_STAFF_LIST#)
        )
        OR
        (
           EMPLOYEE_ID IN (#NEW_STAFF_LIST#)
        )
        <cfelseif isdefined('attributes.new_staff') AND LEN(attributes.new_staff)>

        EMPLOYEE_ID IN (#NEW_STAFF_LIST#)
        <cfelse>
        EMPLOYEE_ID IN (#CHANGED_STAFF_LIST#)
        </cfif>
      </cfquery>
     
      <cfset get_puantaj_rows=GET_STAFF>
    </cfif>
    
        <cfoutput query="get_puantaj_rows" group="#type_#">
            <cfoutput>
            
                <cfset attributes.employee_id = get_puantaj_rows.EMPLOYEE_ID>
                
                
                <cfquery name="get_this_istisna" dbtype="query">
                    SELECT SUM(VERGI_ISTISNA_AMOUNT) AS VERGI_ISTISNA_AMOUNT FROM get_vergi_istisna WHERE EMPLOYEE_PUANTAJ_ID = #EMPLOYEE_PUANTAJ_ID# AND VERGI_ISTISNA_AMOUNT IS NOT NULL
                </cfquery>
            
             <tr >
                <cfset row_color="border:1px solid ##000;">
                 <cfif len(attributes.Type_id) and attributes.Type_id neq 3 AND isdefined('attributes.with_color') and len(attributes.with_color)> 
                  <cfquery name="NEW_PERMOTION_salary" datasource="#dsn#">
                   SELECT M#Prev_MON# FROM EMPLOYEES_SALARY 
                   WHERE EMPLOYEE_ID=#EMPLOYEE_ID# AND 
                   IN_OUT_ID = #IN_OUT_ID# AND
                   PERIOD_YEAR=#Prev_YEAR# AND 
                   M#Prev_MON# IS NOT NULL AND 
                   M#Prev_MON#<>#SALARY#
                 </cfquery>
                 <cfif NEW_PERMOTION_salary.recordcount>
                 <cfset row_color="background:##FFC000;"&"border:1px solid ##000;">
                 <cfelseif len(start_date) and month(start_date) eq attributes.sal_mon and year(start_date) eq attributes.sal_YEAR>
                 <cfset row_color="background:##EBE600;"&"border:1px solid ##000;">
                 </cfif>
               </cfif>
               </tr>
                 
                 
                  <!---<cfloop list="#attributes.b_obj_hidden_new#" index="xlr">--->
      <cfif isDefined("attributes.is_title") or isDefined("attributes.is_position_cat_id") or isDefined("attributes.is_position") or isDefined("attributes.is_position_fonksiyon") or isDefined("attributes.is_p_branch_name") or isDefined("attributes.is_p_department_name")>
        <cfquery dbtype="query" name="position_info">
	SELECT * FROM get_position_info WHERE EMPLOYEE_ID = #EMPLOYEE_ID#
	</cfquery>
      </cfif>
      <cfquery name="bank_info" datasource="#dsn#">
    SELECT
    	BANK_ACCOUNT_NO,
        MONEY
    FROM EMPLOYEES_BANK_ACCOUNTS
    WHERE
    	EMPLOYEE_ID = #EMPLOYEE_ID#
</cfquery>
<cfscript>
		get_puantaj_1 = createObject("component", "v16.hr.ehesap.cfc.Ytech_Putan_in_out");
	
		
		epr = get_puantaj_1.emp_pun1
		(
			sal_year : attributes.sal_year,
			sal_mon : attributes.sal_mon,
			employee_id :#EMPLOYEE_ID#,
            INOUTID:#IN_OUT_ID#
			
		);
	</cfscript>


<!-------------------------------------------------------------------------->
<!----------zainab Add Code-------->
<!--------------------------------------------------------------------------> 
 <cfset Total_annual_amount=0>
  <cfset count_Balance_days=0>
    <cfset Total_Earned=0>
    <cfset Total_Annual_Leave_tax=0>
    <cfset Total_tax=0>
	<cfset ak_t_Day =0>
	<cfset ak_t_Amount = 0> 
<cfset cont='0'>
 <cfset NET_=0>
 <cfquery name="CLOSED_STATE" datasource="#dsn#">
   SELECT * FROM SAVED_REPORTS
   WHERE REPORT_NAME LIKE 'HR_REPORT_#attributes.sal_mon#_#attributes.sal_year#'
</cfquery>

<cftry>
   <cffile action="read" file="#upload_folder#report#dir_seperator#saved#dir_seperator##CLOSED_STATE.FILE_NAME#" variable="cont" charset="utf-8">
   <cfscript>
  start = findnocase('id="#EMPLOYEE_ID#">',cont,1);
  middle = findnocase('</td>',cont,start + len('</td>'));
		cont = removechars(cont,1,start);
		start = findnocase('</td>',cont,1);
		cont = removechars(cont,start,len(cont));
		cont=trim(replace(cont,'d="#EMPLOYEE_ID#">',''));
		if(cont eq '-') cont='0';
		cont=ltrim(cont);
 </cfscript>
<cfcatch type="any">
<cfset cont='0'>
</cfcatch>
</cftry>

<!------>
    <cfscript>
		get_puantaj_1 = createObject("component", "v16.hr.ehesap.cfc.Ytech_Putan");
	
		
		epr1 = get_puantaj_1.emp_pun1
		(
			sal_year : attributes.sal_year,
			sal_mon : attributes.sal_mon - 1 ,
			employee_id :#EMPLOYEE_ID#
			
		);
	</cfscript>
<cfquery name="FUNC_info" datasource="#dsn#">
 SELECT *   FROM [SETUP_CV_UNIT] where UNIT_ID = 
   (select FUNC_ID from [EMPLOYEE_POSITIONS] where 
  POSITION_ID = (select max (POSITION_ID) from [EMPLOYEE_POSITIONS] where EMPLOYEE_ID = #EMPLOYEE_ID#))
 </cfquery>
 <cfset cont='0'>
 <cfset NET_=0>



<cftry>
   <cffile action="read" file="#upload_folder#report#dir_seperator#saved#dir_seperator##CLOSED_STATE.FILE_NAME#" variable="cont" charset="utf-8">
   <cfscript>
  start = findnocase('id="#EMPLOYEE_ID#">',cont,1);
  middle = findnocase('</td>',cont,start + len('</td>'));
		cont = removechars(cont,1,start);
		start = findnocase('</td>',cont,1);
		cont = removechars(cont,start,len(cont));
		cont=trim(replace(cont,'d="#EMPLOYEE_ID#">',''));
		if(cont eq '-') cont='0';
		cont=ltrim(cont);
 </cfscript>
<cfcatch type="any">
<cfset cont='0'>

</cfcatch>
</cftry>

 <cfquery name="GET_ANNUAL_" datasource="#dsn#">
    SELECT
    	ISNULL(KULLANILMAYAN_IZIN_COUNT,0) ANNUAL_DAYS,
        ISNULL(KULLANILMAYAN_IZIN_AMOUNT,0) ANNUAL_AMONT
    FROM EMPLOYEES_IN_OUT
    WHERE
    	IN_OUT_ID = #IN_OUT_ID#
</cfquery>
<cfset ANNUAL_DAYS=GET_ANNUAL_.ANNUAL_DAYS>
<cfset ANNUAL_AMOUNT=GET_ANNUAL_.ANNUAL_AMONT>
<cfset NET_=ANNUAL_DAYS/30*DAMGA_VERGISI_MATRAH>
    <cfif ANNUAL_DAYS NEQ evaluate('#cont#') OR ANNUAL_AMOUNT NEQ (evaluate('#cont#')/30*DAMGA_VERGISI_MATRAH)>
    <cfquery datasource="#DSN#">
      UPDATE EMPLOYEES_IN_OUT 
      SET KULLANILMAYAN_IZIN_COUNT = #evaluate('#cont#')#,
      KULLANILMAYAN_IZIN_AMOUNT=#evaluate('#cont#')/30*DAMGA_VERGISI_MATRAH#
      WHERE IN_OUT_ID=#IN_OUT_ID#
    </cfquery>
    <cfset NET_=evaluate('#cont#')/30*DAMGA_VERGISI_MATRAH>
   <cfset count_Balance_days=evaluate('#cont#')+count_Balance_days>
    <cfelseif cont eq '0'>
     <cfquery datasource="#DSN#">
      UPDATE EMPLOYEES_IN_OUT 
      SET KULLANILMAYAN_IZIN_COUNT = 0,
      KULLANILMAYAN_IZIN_AMOUNT=0
      WHERE IN_OUT_ID=#IN_OUT_ID#
    </cfquery>
    <cfset ANNUAL_DAYS=0>
    <cfset NET_=0>
    </cfif>
    <cfquery name="get_rond" datasource="#DSN#">
      SELECT ROUND((NET_UCRET+ISNULL(KULLANILMAYAN_IZIN_AMOUNT,0)-ISNULL(KULLANILMAYAN_IZIN_AMOUNT,0)*15/100),2) AS NET_UCRET,
       ISSIZLIK_ISVEREN_HISSESI
       FROM EMPLOYEES_PUANTAJ_ROWS INNER JOIN EMPLOYEES_IN_OUT ON EMPLOYEES_IN_OUT.IN_OUT_ID= EMPLOYEES_PUANTAJ_ROWS.IN_OUT_ID
       WHERE EMPLOYEE_PUANTAJ_ID =#EMPLOYEE_PUANTAJ_ID#
    </cfquery>
    <cfset zISSIZLIK_ISVEREN_HISSESI=get_rond.ISSIZLIK_ISVEREN_HISSESI>
    <cfset z_NETSALARY=get_rond.NET_UCRET>
    <cfset count_Balance_days=count_Balance_days+ANNUAL_DAYS>
	<cfset Total_annual_amount=Total_annual_amount+NET_>
    <cfset Total_Annual_Leave_tax=Total_Annual_Leave_tax+(NET_*15/100)>
    <cfset Total_Earned=Total_Earned+NET_+ISSIZLIK_ISVEREN_HISSESI+(DAMGA_VERGISI_MATRAH / MONTH_DAYS * TOTAL_DAYS)>
    <cfset Total_tax=Total_tax+((NET_*15/100) +GELIR_VERGISI)>
    
  <cfscript>
		get_puantaj_1 = createObject("component", "v16.hr.ehesap.cfc.Ytech_Putan_in_out");
	
		
		epr = get_puantaj_1.emp_pun1
		(
			sal_year : attributes.sal_year,
			sal_mon : attributes.sal_mon,
			employee_id :#EMPLOYEE_ID#,
            INOUTID:#IN_OUT_ID#

			
		);
	</cfscript>
   <TR>
   
<tr>
    <td rowspan="#coloption#" style="#row_color#width:10;">#EMPLOYEE_PUANTAJ_ID#</td> 
    <td rowspan="#coloption#"  style="#row_color#width:10;" >#EMPLOYEE_NO#</td>
    <td rowspan="#coloption#"  style="#row_color#width:10;">#EMPLOYEE_NAME# #EMPLOYEE_SURNAME#</td>
    <td rowspan="#coloption#" style="#row_color#width:10;"  >#DEPARTMENT_HEAD#</td>
    <td rowspan="#coloption#"  style="#row_color#width:10;">#POSITION_NAME#</td>
    <td rowspan="#coloption#"  style="#row_color#width:10;">#dateformat(START_DATE,dateformat_style)#</td>
	<td rowspan="#coloption#"  style="#row_color#width:10;">#dateformat(FINISH_DATE,dateformat_style)#</td>
    <td rowspan="#coloption#"  style="#row_color#width:10;">
						<cfif not len(finish_date)>
							<cfif len(ex_in_out_id)><cf_get_lang dictionary_id='53317.Nakil'><!---herhangi bir cikis kaydindan nakil ile otomatik acilmis ise --->
							<cfelse><cf_get_lang dictionary_id='53318.Yeni Giriş'></cfif>
						<cfelse><!--- cikis gerekceleri--->
						#get_explanation_name(explanation_id)#
						</cfif>
	</td>
    <td rowspan="#coloption#"  style="#row_color#width:10;"  title="Total_Days">#TOTAL_DAYS#</td> 
    <td rowspan="#coloption#"  style="#row_color#width:10;"  title="Last_Salary_earn">#tlformat(epr1.za_salary)#</td>  
     <td rowspan="#coloption#"  style="#row_color#width:10;"  title="Salary_by_Days">#tlformat(epr.Total_payment_days)#</td>  
    <td rowspan="#coloption#"  style="#row_color#width:10;"  title="allowance_cell_out_salary" >#tlformat(epr.Call_allowance_Incentive)#</td> 
    <td rowspan="#coloption#"  style="#row_color#width:10;"  title="Allowance_Transportation" >#tlformat(epr.Transportation_allowances_Incentive)#</td>      
    <td rowspan="#coloption#"  style="#row_color#width:10;"   title="Other_allowance">#tlformat(-(epr.total_others - epr.Transportation_allowances_Incentive - epr.Call_allowance_Incentive ))#</td> 
    <td rowspan="#coloption#"  style="#row_color#width:10;"   title="Total_allowance">#tlformat(epr.total_others)#</td>   
    <td rowspan="#coloption#"  style="#row_color#width:10;"   title="End_of_service_rights">#tlformat(epr.End_of_service_rights)#</td> 
    <td rowspan="#coloption#"  style="#row_color#width:10;" title="treatment_allowance" >#tlformat(epr.treatment_allowance)#</td> 
    <td rowspan="#coloption#"  style="#row_color#width:10;" title="custody_difference" >#tlformat(epr.custody_difference)#</td> 
    
    <td rowspan="#coloption#"  style="#row_color#width:10;" title="SSK6_company">#tlformat(epr.SSK6_company)#</td>
    <td rowspan="#coloption#"  style="#row_color#; text-align:center" title="Gross SS9">#tlformat(epr.SSK9_company)#</td>
	  <td rowspan="#coloption#"  style="#row_color#; text-align:center" title="Total_ansurance">#tlformat(epr.genral_total)#</td>
    <!---
    <td rowspan="#coloption#"  style="#row_color#width:10;"> #BRANCH_NAME#</td>
    <td rowspan="#coloption#"  style="#row_color#width:10;">#bank_info.BANK_ACCOUNT_NO#</td>--->
           
    <!--- <cfset ak_t_Day = ak_t_Day + LSParseNumber(cont)>
       <th   style=" text-align:Right;color:dark"><cfif cont neq '0'>#cont#</cfif></th><cfif cont neq '0'></cfif>
		 <cfset ak_t_Amount = ( ak_t_Amount + numberFormat((numberFormat(NET_,'__.00')),'__.00')) >
       <th style=" text-align:Right;color:dark" > <cfif cont neq '0'>#tlformat(NET_)#</cfif>  </th>
---->
    <cfif not len(attributes.col_option) and not len(attributes.Other_Accounts)> 

    <cfset ak_t_Day = ak_t_Day + LSParseNumber(cont)>
    <td rowspan="#coloption#"  style="#row_color#; text-align:center" title="Annual leave">
	
	<cfif cont neq '0'>#cont#</cfif> 
    </td>
    <cfif cont neq '0'>
        <cfset ak_t_Amount = ( ak_t_Amount + numberFormat((numberFormat(NET_,'__.00')),'__.00')) >
    </cfif>
      <td rowspan="#coloption#"  style="background:##DA9694;#row_color#; text-align:center" title="Annual leave Amount">
	  
	<cfif cont neq '0'>#tlformat(NET_)#</cfif> 
  </cfif> 
    <td rowspan="#coloption#"  style="#row_color#width:10;" title="Warning_month_salary" >#tlformat(epr.Warning_month_salary)#</td> 
    <td rowspan="#coloption#"  style="#row_color#width:10;" title="Reward" >#tlformat(epr.Reward)#</td> 
    <td rowspan="#coloption#"  style="#row_color#width:10;" title="salary_SS15">#tlformat(epr.salary_SS15)#</td>

    <td rowspan="#coloption#"  style="#row_color#; text-align:center" title="tatal_income_taxable">#tlformat(epr.Taxable_income)#</td>
    <td rowspan="#coloption#"  style="#row_color#; text-align:center" title="Salary Tax">#tlformat(epr.Tax)#</td>
    <td rowspan="#coloption#"  style="#row_color#; text-align:center" title="Annual Leave tax">#tlformat(NET_*15/100)#</td>
    <td rowspan="#coloption#"  style="#row_color#; text-align:center" title="Total_Tax">#tlformat(epr.Total_dedect)#</td>


    <td rowspan="#coloption#"  style="#row_color#width:10;" title="Timelate" >#tlformat(epr.SSK01_company)#</td>
    <td rowspan="#coloption#"  style="#row_color#width:10;"  title="Absen_without_earn">#tlformat(epr.DIS_VACDAY)#</td> 

	  <td rowspan="#coloption#"  style="#row_color#width:10;" title="Social_solidarity">#tlformat(epr.SSK15c_company)#</td>
    <td rowspan="#coloption#"  style="#row_color#width:10;" title="temporary_advance">#tlformat(epr.advance_inn)#</td>
    <td rowspan="#coloption#"  style="#row_color#width:10;"  title="perment_advance">#tlformat(epr.te_aind)#</td>  
    <td rowspan="#coloption#"  style="#row_color#width:10;" title="The_value_of_the_covenant_in_kind">#tlformat(epr.The_value_of_the_covenant_in_kind)# </td>
	
	 
    
    <td rowspan="#coloption#"  style="#row_color#; text-align:center" title="Total_dedect_specail_employee">#tlformat(epr.Total_dedect_specail_employee)#</td>
    
    <td rowspan="#coloption#"  style="#row_color#; text-align:center" title="total_Deductions">#tlformat(epr.me)#</td>    
    
    <td rowspan="#coloption#"  style="#row_color#; text-align:center" title="Total_Tax">#tlformat(epr.Total_dedect)#</td>
    <td rowspan="#coloption#"  style="#row_color#; text-align:center" title="total_Deductions">#tlformat(epr.me)#</td>           
</tr>
</tr>
            </cfoutput>
            
            </cfoutput>
            </cfif>
    </tbody>	
   </table>
    </cfif>
	</div>
	
	<script>
	function re()
	{
     this.form.submit();
	}
	function state_color(typp)
	{
		if(typp != 3)
		  {
			  
              document.getElementById('collr').style.display='';
		  }
		  else
		  {
			 
			   document.getElementById('collr').style.display='none';
		  }
	}
	 <cfif len(attributes.Type_id) >
	   state_color(<cfoutput>#attributes.Type_id#</cfoutput>);
	 </cfif>
	document.getElementById('detail_report_div').id="detail_report_divyy";
	document.getElementById('detail_report_divxx').id="detail_report_div";
</script>