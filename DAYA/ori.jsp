<%--
Created By:        dhayanithi
Parameters:
  - START_DATE
  - END_DATE


--%>
<%@ page import="com.kintana.core.server.AppException" %>
<%@ page import="com.kintana.core.db.DBConstants" %>
<%@ page import="com.kintana.core.web.util.URLHelper" %>
<%@ taglib uri="/Kintanareporttld" prefix="rpt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%-- -- report initialization: load bundle, get JDBC connection, Load report parameters -- --%>
<rpt:initReport bundleName="KEXP_Resources" />
<rpt:getJDBCConnection />
<rpt:loadReportParameters />

<%-- -- SQL Statements -- --%>
<rpt:openStatement var="project_details">
SELECT PM.PROJECT_ID,
PM.PROJECT_NAME,
PM.PROJECT_TYPE_ID,
PM.STATUS,
US.USER_ID,
US.USERNAME,
US.START_DATE,
US.END_DATE,
US.REGION_ID FROM PM_PROJECTS PM,
KNTA_USERS US 
WHERE PM.REGION_ID=US.REGION_ID ORDER BY PM.PROJECT_NAME
</rpt:openStatement>

<%-- SQL Query --%>
<rpt:runStatement stmtName="project_details" var="query_result" />
<c:set var="totalRowCount" value="${query_result.rowCount}" />
<html>
<head>

<%-- -- css style sheet -- --%>
  <style type="text/css">
    .pageWidth   {width: 900px; }
    .titleWidth  {width: 450px; }
    .hdrSigWidth {width: 450px; }
    .footerIndent{margin-left:450px;}
    .footerWidth {width: 450px; }
    .pagetitlelocal {font-family:Verdana; font-size:13pt; font-weight:bold; color:#3B5182; padding-bottom: 5px;}
    .txtbody2a {font-family:Verdana; font-size:8pt; color:#000000; text-decoration:none}
    .txtbodybold2a {font-family:Verdana; font-size:8pt; font-weight:bold; color:#000000; text-decoration:none}
    .txtbodyitalic2a {font-family:Verdana; font-size:8pt; font-style:italic; color:#000000; text-decoration:none}
    .fieldprompt {font-family:Verdana; font-size:8pt; font-weight:bold; color:#000000;}
    .fieldvalue {font-family:Verdana; font-size:8pt; font-weight:normal; color:#000000;}
    .pagesubheader {font-family:Verdana; font-size:9pt; font-weight:bold; color:#000000; background-color:#D0CFCD;text-decoration:none;border-top: #0066ff 4px solid; color: #45423D;}
    .columnheader {font-family:Verdana; font-size:8pt; font-weight:bold; color:#000000; text-decoration:none; background-color:#FFFFFF}
    .healthred {font-family:Verdana; font-size:8pt; color:#000000; background-color:#FF0000}
    .healthyellow {font-family:Verdana; font-size:8pt; color:#000000; background-color:#FFCC00}
    .healthgreen {font-family:Verdana; font-size:8pt; color:#000000; background-color:#99CC99}
    .healthnone {font-family:Verdana; font-size:8pt; color:#000000; background-color:#003366}
    .healthoff {font-family:Verdana; font-size:8pt; color:#000000; background-color:#AFAFAF}
    .pagesub2header {font-family:Verdana; font-size:8pt; font-weight:bold; color:#000000; background-color:#E4E0D8;text-decoration:none;border-top: #0066ff 1px solid; color: #45423D;}
  </style>
</head>
<body>

<%
		 String flag = request.getParameter("FLAG");
		 if(flag != null)
		 {  
			response.setContentType("application/vnd.ms-excel");
			response.addHeader("content-disposition", "inline; filename=project_details.xlsx");  
		 }
		%>
<%-- -- include Header File -- --%>
<%@include file="../../rpt/ReportHeader.jspf" %>


<%-- Defining report header and MS Excel Link--%>
<table cellspacing="0" border='0' cellpadding='3' width='100%'>
  <tr>
    <td class='pagetitlelocal' valign='bottom'>
      <c:out value="${COMPANY_NAME}"/>
    </td>
  </tr>
  <tr>
    <td align='right'>
        <% 
				if ( flag == null) { %>
				<table cellspacing='0' cellpadding='5' border='0' bordercolor='#CCCCCC' align='right' class=sghNormal>
					<tr><td><a href='/itg/web/knta/drv/rpt/project_details.jsp?FLAG=TRUE&USER_ID=<c:out value="${USER_ID}"/>&REPORT_ID=<c:out value="${REPORT_ID}"/>'>Export to Excel</a></td></tr>
				</table>
				<% } 
				%>
    </td>
  </tr>
  <tr><td>&nbsp;</td>
      <td>&nbsp;</td>
  </tr>
</table>


<%-- -- report Parameters section -- --%>
<div class="pageWidth txtNormal">
    <span class="txtHeading"><rpt:resource name="REPORT_PARAMETERS.TXT" />
      <rpt:resource name="FOR.TXT" bundleName="KPMX_Resources" /> 
      <rpt:resource name="REPORT_NO.TXT" /><c:out value="${REPORT_ID}" />
    </span>
    <br><span class="txtLabel"><rpt:resource name="FILTER_BY.TXT" />:</span>
    <c:if test="${not empty VP_EMPLOYEE_NAME}"><b><rpt:out value="Name" /> : </b> <c:out value="${VP_EMPLOYEE_NAME}" />; </c:if>


</div>
<%-- -- end of report Parameters section -- --%>
</br>


<table>
<tr><td>

<table cellspacing='0' cellpadding='5' border='0' bordercolor='#c2c2c2' width='100%'>
    <tr><td>&nbsp;</td></tr>
    <tr><td class='pagesubheader' align='left'>project_details</td></tr>
</table>
</td></tr>

<tr><td>
<table cellspacing='0' cellpadding='6' border='1' bordercolor='#c2c2c2' width='100%'>
    <tr>
        <td width='30%' class='columnheader' align='center'>Project_Id</td> 
        <td width='30%' class='columnheader' align='center'>Project_Name</td> 
        <td width='30%' class='columnheader' align='center'>Project_Type</td> 
        <td width='10%' class='columnheader' align='center'> Status</td> 
        <td width='10%' class='columnheader' align='center'> User_Id</td>  
        <td width='20%' class='columnheader' align='center'> Username</td> 
        <td width='20%' class='columnheader' align='center'> Start_date</td> 
        <td width='20%' class='columnheader' align='center'> End_date</td> 
        <td width='20%' class='columnheader' align='center'> Region_Id</td>  
    </tr>


  <c:forEach items="${query_result.rowsByIndex}" var="qrow" varStatus="dataLoopStatus2">
  <c:set var="dummyflag" value="true"/>

    <tr>
        <td width='30%' class='fieldvalue' align='center' nowrap> <c:out value="${qrow[0]}"/><c:if test="${empty qrow[0]}">&nbsp;</c:if> </td>
        <td width='30%' class='fieldvalue' align='center' nowrap> <c:out value="${qrow[1]}"/><c:if test="${empty qrow[1]}">&nbsp;</c:if> </td>
        <td width='30%' class='fieldvalue' align='center' nowrap> <c:out value="${qrow[2]}"/><c:if test="${empty qrow[2]}">&nbsp;</c:if> </td>
        <td width='10%' class='fieldvalue' align='center' nowrap> <c:out value="${qrow[3]}"/><c:if test="${empty qrow[3]}">&nbsp;</c:if> </td>
        <td width='30%' class='fieldvalue' align='center' nowrap> <c:out value="${qrow[4]}"/><c:if test="${empty qrow[4]}">&nbsp;</c:if> </td>
        <td width='20%' class='fieldvalue' align='center' nowrap> <c:out value="${qrow[5]}"/><c:if test="${empty qrow[5]}">&nbsp;</c:if> </td>
        <td width='10%' class='fieldvalue' align='center' nowrap> <c:out value="${qrow[6]}"/><c:if test="${empty qrow[6]}">&nbsp;</c:if> </td>
        <td width='20%' class='fieldvalue' align='center' nowrap> <c:out value="${qrow[7]}"/><c:if test="${empty qrow[7]}">&nbsp;</c:if> </td>
        <td width='20%' class='fieldvalue' align='center' nowrap> <c:out value="${qrow[8]}"/><c:if test="${empty qrow[8]}">&nbsp;</c:if> </td>
        <td width='20%' class='fieldvalue' align='center' nowrap> <c:out value="${qrow[9]}"/><c:if test="${empty qrow[9]}">&nbsp;</c:if> </td>
        
     </tr>

    </c:forEach>

    
    <c:if test="${dummyflag!='true'}">
    <tr>
        <td class='columnheader' colspan='18'>****** NO ROWS RETURNED ******</td>
    </tr>
    </c:if>
</table>
              </td></tr></table>

 <font font face="Arial" size=1>
  <%-- -- Fetch User Data -- --%>
  
  <hr class="pageWidth hDivider" />
  
  <%-- -- Render User Data -- --%>
  
 

<%-- -- end of Row for each request -- --%>


<%-- -- include Footer File -- --%>
<%@ include file="../../rpt/ReportFooter.jspf" %>

</font>
<rpt:returnJDBCConnection/>

</body>
</html>









