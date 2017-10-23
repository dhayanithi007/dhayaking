<%--
Created By:        Sundara Kumaran V
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
<rpt:openStatement var="leave_query">

SELECT KU.FULL_NAME AS NAME,
KR.REQUEST_ID AS REQUEST_ID,
KRT.REQUEST_TYPE_NAME AS REQ_NAME,
(SELECT K.FULL_NAME FROM KNTA_USERS K WHERE K.USER_ID = KU.MANAGER_USER_ID) AS M_NAME,
KRD.PARAMETER1 AS LEAVE_DAYS,
KRD.VISIBLE_PARAMETER2 AS LEAVE_TYPE,
KRD.PARAMETER3 AS FROM_DATE,
KRD.PARAMETER4 AS TO_DATE,
KS.STATUS_NAME AS STATUS
FROM KCRT_REQUESTS KR,
KCRT_REQ_HEADER_DETAILS KRHD,
KCRT_REQUEST_DETAILS KRD,
KCRT_REQUEST_TYPES KRT,
KCRT_STATUSES KS,
KNTA_USERS KU
WHERE KRHD.PARAMETER1 = '<c:out value="${P_EMPLOYEE_NAME}"/>'
AND KR.REQUEST_ID = KRHD.REQUEST_ID
AND KR.REQUEST_ID = KRD.REQUEST_ID
AND KR.REQUEST_TYPE_ID = KRT.REQUEST_TYPE_ID
AND KR.STATUS_ID = KS.STATUS_ID
AND KU.full_name = '<c:out value="${P_EMPLOYEE_NAME}"/>'
ORDER BY KR.REQUEST_ID DESC
   
</rpt:openStatement>