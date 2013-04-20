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
			<h1>Statistiques d'une question</h1>
		
			<div id="vote-question-text">${questionInstance?.text}</div>
			<h2>Nombre de personnes ayant votés : <g:fieldValue bean="${questionInstance}" field="nbVotes"/> votes<h2>
				<table>
					<tr>
						<th>Réponse</th>
						<th>Nombre de vote</th>
						<th>Commentaires</th>
					</tr>
					<g:each in="${questionInstance?.reponses?}" var="r">
						<tr>
							<td>${r?.text }</td>
							<td>${r?.nbVotes }</td>
							<td>
							<g:if test="${r?.correcte}"><span style="color:#9C0;">REPONSE CORRECTE</span><br/>
							</g:if>
								<g:each in="${r?.commentaires}" var="c">
								<g:if test="${true||c?.visible == "1"}">
									${c?.text}
									<br />
								</g:if>
								</g:each>
							</td>
						</tr>
					</g:each>
				</table>		
		</div>
	</body>
</html>
