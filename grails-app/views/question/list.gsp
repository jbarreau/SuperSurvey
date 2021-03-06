
<%@ page import="supersurveys.Question" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'question.label', default: 'Question')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-question" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<shiro:hasRole name="ROLE_PROF">
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
				</shiro:hasRole>
			</ul>
		</div>
		<div id="list-question" class="content scaffold-list" role="main">
			<h1>Questions</h1>
			<h2>Professeur: ${userInstance.nom} ${userInstance.prenom}</h2>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			
			<g:if test="${questionInstanceTotal <= 0}">
				<div class="message">Aucune question à afficher</div>
			</g:if>
			
			<g:if test="${questionInstanceTotal > 0}">
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="text" title="${message(code: 'question.text.label', default: 'Text')}" />
					
						<g:sortableColumn property="dateCreation" title="${message(code: 'question.dateCreation.label', default: 'Date Creation')}" />
					
						<g:sortableColumn property="nbVotes" title="${message(code: 'question.nbVotes.label', default: 'Nb Votes')}" />
					
						<g:sortableColumn property="nbVotes" title="État" />
					
						<g:sortableColumn property="type" title="${message(code: 'question.type.label', default: 'Type')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${questionInstanceList}" status="i" var="questionInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${questionInstance.id}">${fieldValue(bean: questionInstance, field: "text")}</g:link></td>
					
						<td><g:formatDate date="${questionInstance.dateCreation}" format="dd / MM / yyyy 'à' hh'h'mm"/></td>
					
						<td>${fieldValue(bean: questionInstance, field: "nbVotes")}</td>
						
						<td>${fieldValue(bean: questionInstance, field: "etat")}</td>
					
						<td>${fieldValue(bean: questionInstance, field: "type")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${questionInstanceTotal}" />
			</div>
			</g:if>
		</div>
	</body>
</html>
