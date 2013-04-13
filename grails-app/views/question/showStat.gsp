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
			<span class="property-value" aria-labelledby="text-label"><g:fieldValue bean="${questionInstance}" field="text"/></span><br>
			<p>il y a eu <g:fieldValue bean="${questionInstance}" field="nbVotes"/> votes,
				<table>
					<tr>
						<th>reponse</th>
						<th>nombre de vote</th>
						<th>commentaire</th>
					</tr>
					<g:each in="${questionInstance?.reponses?}" var="r">
						<tr>
							<td>${r?.text }</td>
							<td>${r?.nbVotes }</td>
							<td>
							<g:if test="${r?.correcte}">REPONSE CORRECTE<br/>
							</g:if>
								<g:each in="${r?.commentaires?}" var="c">
								${c?.text }
								</g:each>
							</td>
						</tr>
					</g:each>
				</table>		
		</div>
	</body>
</html>
