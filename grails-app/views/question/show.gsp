
<%@ page import="supersurveys.Question" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'question.label', default: 'Question')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-question" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-question" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list question">
			
				<g:if test="${questionInstance?.text}">
				<li class="fieldcontain">
					<span id="text-label" class="property-label"><g:message code="question.text.label" default="Text" /></span>
					
						<span class="property-value" aria-labelledby="text-label"><g:fieldValue bean="${questionInstance}" field="text"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${questionInstance?.dateCreation}">
				<li class="fieldcontain">
					<span id="dateCreation-label" class="property-label"><g:message code="question.dateCreation.label" default="Date Creation" /></span>
					
						<span class="property-value" aria-labelledby="dateCreation-label"><g:formatDate date="${questionInstance?.dateCreation}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${questionInstance?.temps}">
				<li class="fieldcontain">
					<span id="temps-label" class="property-label"><g:message code="question.temps.label" default="Temps" /></span>
					
						<span class="property-value" aria-labelledby="temps-label"><g:fieldValue bean="${questionInstance}" field="temps"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${questionInstance?.nbVotes}">
				<li class="fieldcontain">
					<span id="nbVotes-label" class="property-label"><g:message code="question.nbVotes.label" default="Nb Votes" /></span>
					
						<span class="property-value" aria-labelledby="nbVotes-label"><g:fieldValue bean="${questionInstance}" field="nbVotes"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${questionInstance?.type}">
				<li class="fieldcontain">
					<span id="type-label" class="property-label"><g:message code="question.type.label" default="Type" /></span>
					
						<span class="property-value" aria-labelledby="type-label"><g:fieldValue bean="${questionInstance}" field="type"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${questionInstance?.reponses}">
				<li class="fieldcontain">
					<span id="reponses-label" class="property-label"><g:message code="question.reponses.label" default="Reponses" /></span>
					
						<g:each in="${questionInstance.reponses}" var="r">
						<span class="property-value" aria-labelledby="reponses-label"><g:link controller="reponse" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${questionInstance?.id}" />
					<g:link class="edit" action="edit" id="${questionInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
