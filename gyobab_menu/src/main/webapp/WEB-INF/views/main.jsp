<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>

<div id="main">
	<security:authentication property="principal.member_email" var="loginEmail"/>${loginEmail } 
</div>
