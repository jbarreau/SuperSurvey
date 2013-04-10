<%@ page import="supersurveys.User" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#edit-user" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		
		<h1>Mon compte</h1>
		<h2>Gérez vos activités sur cette page</h2>
		<g:board>
			<g:boardSection titre="Questions">
				<ul>
					<li><g:link controller="question" action="create">Nouvelle question</g:link></li>
					<li>Voir mes questions</li>
					<li>Accéder à la question en cours de vote</li>
					<li>Accéder à la question suivante</li>
				</ul>
			</g:boardSection>
		
		</g:board>
		
	</body>
</html>
