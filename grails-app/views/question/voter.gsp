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
				<shiro:hasRole name="ROLE_PROF">
					<li><g:link class="edit" action="manage" id="${questionInstance?.id }">Gérer cette question</g:link></li>
				</shiro:hasRole>
			</ul>
		</div>
		<div id="vote-question" class="content" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<h2>Répondre à une question posée</h2>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			
			
			<div id="vote-contenu-question">
			<g:form name="formvote" controller="question" action="voter" id="${questionInstance.id}">
				<input type="hidden" name="formSend" />
				<div id="vote-question-text">${questionInstance.text}</div>
				<div id="vote-reponses">
					<g:each var="reponse" in="${ questionInstance.reponses }">
						<div class="vote-reponse">
							<g:if test="${questionInstance.type == supersurveys.TypeQuestion.ChoixMultiple}">
								<g:checkBox name="reponseId" id="reponseWidget${reponse.id}" value="${reponse.id}" 
									checked="${false && defaultValues?.contains(questionInstance.id)}"
									disabled="${false && session['dejavote'+questionInstance.id] != null}"/>
							</g:if>
							<g:if test="${questionInstance.type == supersurveys.TypeQuestion.ChoixSimple}">
								<g:radio name="reponseradio" value="${reponse.id}" id="reponseWidget${reponse.id}" />
							</g:if>
							<label for="reponseWidget${reponse.id}">${reponse.text}</label>
							<div class="clearer"></div>
						</div>
					</g:each>
				</div>
				<div id="vote-submit" class="submit-section">
					<g:actionSubmit value="Voter"/>
				</div>
			</g:form>
			</div>
		</div>
	</body>
</html>
