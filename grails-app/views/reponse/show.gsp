
<%@ page import="supersurveys.Reponse" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'reponse.label', default: 'Reponse')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-reponse" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-reponse" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list reponse">
			
				<g:if test="${reponseInstance?.text}">
				<li class="fieldcontain">
					<span id="text-label" class="property-label"><g:message code="reponse.text.label" default="Text" /></span>
					
						<span class="property-value" aria-labelledby="text-label"><g:fieldValue bean="${reponseInstance}" field="text"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${reponseInstance?.visible}">
				<li class="fieldcontain">
					<span id="visible-label" class="property-label"><g:message code="reponse.visible.label" default="Visible" /></span>
					
						<span class="property-value" aria-labelledby="visible-label"><g:formatBoolean boolean="${reponseInstance?.visible}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${reponseInstance?.correcte}">
				<li class="fieldcontain">
					<span id="correcte-label" class="property-label"><g:message code="reponse.correcte.label" default="Correcte" /></span>
					
						<span class="property-value" aria-labelledby="correcte-label"><g:formatBoolean boolean="${reponseInstance?.correcte}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${reponseInstance?.commentaires}">
				<li class="fieldcontain">
					<span id="commentaires-label" class="property-label"><g:message code="reponse.commentaires.label" default="Commentaires" /></span>
					
						<g:each in="${reponseInstance.commentaires}" var="c">
						<span class="property-value" aria-labelledby="commentaires-label"><g:link controller="commentaire" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${reponseInstance?.question}">
				<li class="fieldcontain">
					<span id="question-label" class="property-label"><g:message code="reponse.question.label" default="Question" /></span>
					
						<span class="property-value" aria-labelledby="question-label"><g:link controller="question" action="show" id="${reponseInstance?.question?.id}">${reponseInstance?.question?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${reponseInstance?.id}" />
					<g:link class="edit" action="edit" id="${reponseInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
