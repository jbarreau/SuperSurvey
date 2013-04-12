<%@ page import="supersurveys.Question" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'question.label', default: 'Question')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#edit-question" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
			</ul>
		</div>
		<div id="edit-question" class="content scaffold-edit" role="main">
			<h1>Proposition de réponse</h1>
			<h2>Proposer une réponse possible à cette question</h2>
			
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			
			<g:form action="proposer" method="post">
				<g:hiddenField name="id" value="${questionInstance?.id}" />
				<g:hiddenField name="version" value="${questionInstance?.version}" />
				<fieldset class="form">
					<label for="reponse">Votre éponse: </label>
					<g:field type="text" name="reponse" id="reponse" />
				</fieldset>
				
				<fieldset class="buttons">
					<g:actionSubmit class="save" action="proposer" value="Proposer" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
