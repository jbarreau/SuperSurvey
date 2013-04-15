<%@ page import="supersurveys.User" %>

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main"/>
		<title>Welcome to Grails</title>
		<style type="text/css" media="screen">
			#status {
				background-color: #eee;
				border: .2em solid #fff;
				margin: 2em 2em 1em;
				padding: 1em;
				width: 12em;
				float: left;
				-moz-box-shadow: 0px 0px 1.25em #ccc;
				-webkit-box-shadow: 0px 0px 1.25em #ccc;
				box-shadow: 0px 0px 1.25em #ccc;
				-moz-border-radius: 0.6em;
				-webkit-border-radius: 0.6em;
				border-radius: 0.6em;
			}

			.ie6 #status {
				display: inline; /* float double margin fix http://www.positioniseverything.net/explorer/doubled-margin.html */
			}

			#status ul {
				font-size: 0.9em;
				list-style-type: none;
				margin-bottom: 0.6em;
				padding: 0;
			}

			#status li {
				line-height: 1.3;
			}

			#status h1 {
				text-transform: uppercase;
				font-size: 1.1em;
				margin: 0 0 0.3em;
			}

			#page-body {
				margin: 2em 1em 1.25em 1em;
			}

			h2 {
				margin-top: 1em;
				margin-bottom: 0.3em;
				font-size: 0.9em;
				color: #555;
				font-weight: normal;
			}

			p {
				line-height: 1.5;
				margin: 0.25em 0;
			}

			#controller-list ul {
				list-style-position: inside;
			}

			#controller-list li {
				line-height: 1.3;
				list-style-position: inside;
				margin: 0.25em 0;
			}

			@media screen and (max-width: 480px) {
				#status {
					display: none;
				}

				#page-body {
					margin: 0 1em 1em;
				}

				#page-body h1 {
					margin-top: 0;
				}
			}
		</style>
		<script type="text/javascript">
			(function ($){
				$(document).ready(function(){
					$('#allerQuestion').click(function(){
						var link="${createLink(controller:"Question", action:"show")}"
						var idQ= $('#questNum').val()
						link += "/"+idQ
						if (idQ != "")
							window.location=link
					})
				})
			})(jQuery)
		</script>
	</head>
	<body>
		<a href="#page-body" class="skip"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		
		<div id="page-body" role="main">
			<h1>Bienvenue sur SuperSurvey</h1>
			<h2>L'application qui va vous permettre de communiquer, enfin, avec vos profs ;)</h2>

			<g:conteneur>
				<g:section titre="Je suis un étudiant">
					<ul>
						<li>Voir la question n° <input type="number" id="questNum"/></li>
						<li><input type="button" id="allerQuestion" value="aller &agrave; la question"/></li>
					</ul>
				</g:section>
				<shiro:isLoggedIn>
					<g:section titre="Je suis un professeur">
						<ul>
							 <li><g:set var="profId" value="${User.findByUsername(org.apache.shiro.SecurityUtils.getSubject().getPrincipal()).id }" />
							<g:link controller="Question" action="list" 
							params="[profId]">voir mes questions</g:link></li>
						</ul>
					</g:section>
				</shiro:isLoggedIn>
			</g:conteneur>

<!-- div a supprimer pr la production -->
			<div id="controller-list" role="navigation">
				<h2>Available Controllers:</h2>
				<ul>
					<g:each var="c" in="${grailsApplication.controllerClasses.sort { it.fullName } }">
						<li class="controller"><g:link controller="${c.logicalPropertyName}">${c.fullName}</g:link></li>
					</g:each>
				</ul>
			</div>
		</div>
	</body>
</html>
