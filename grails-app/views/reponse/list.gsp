
<%@ page import="supersurveys.Reponse" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'reponse.label', default: 'Reponse')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-reponse" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-reponse" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="text" title="${message(code: 'reponse.text.label', default: 'Text')}" />
					
						<g:sortableColumn property="visible" title="${message(code: 'reponse.visible.label', default: 'Visible')}" />
					
						<g:sortableColumn property="correcte" title="${message(code: 'reponse.correcte.label', default: 'Correcte')}" />
					
						<th><g:message code="reponse.question.label" default="Question" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${reponseInstanceList}" status="i" var="reponseInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${reponseInstance.id}">${fieldValue(bean: reponseInstance, field: "text")}</g:link></td>
					
						<td><g:formatBoolean boolean="${reponseInstance.visible}" /></td>
					
						<td><g:formatBoolean boolean="${reponseInstance.correcte}" /></td>
					
						<td>${fieldValue(bean: reponseInstance, field: "question")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${reponseInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
