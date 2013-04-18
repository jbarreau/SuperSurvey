<%@ page import="supersurveys.Question" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'question.label', default: 'Question')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
		<g:javascript src="jquery.form.js" >
			var Repajax = "${createLink(controller:'reponse',action:'saveAJAX')}"
			var Comajax = "${createLink(controller:'commentaire',action:'saveAJAX')}"
		
		</g:javascript>
		<g:javascript src ="Manage.js"></g:javascript>
		<style type="text/css">
			.repCommLigne{
				display: none;
			}
		</style>
	</head>
	<body>
		<a href="#edit-question" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="edit-question" class="content scaffold-edit" role="main">
			<h1><g:message code="default.edit.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${questionInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${questionInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form method="post" action="update">
				<g:hiddenField name="id" id="idQuest" value="${questionInstance?.id}" />
				<g:hiddenField name="version" value="${questionInstance?.version}" />
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				 
						<table id="edit-reponse">
							<tr>
								<th>#id</th>
								<th>Réponse</th>
								<th>Count</th>
								<th>Visible</th>
								<th>Correct</th>
								<th>Actions</th>
							</tr>
							<g:each in="${questionInstance?.reponses?}" var="r">
								<tr class="repLigne" id="Rep${r.id}">
									<td>${r.id}<input type="hidden" class="RepId" value="${r.id}"/></td>
									<td><input type="text" id="RepTxt" value="${r?.text}" class="RepTxt"/></td>
									<td>${r?.nbVotes }</td>
									<td>
										<input type="checkbox" class="RepVisible" ${ r?.visible ? 'checked="checked"' : ''} />
									</td>
									<td>
										<input type="checkbox" class="RepCorrecte" ${ r?.correcte ? 'checked="checked"' : ''} />
									</td>
							    	<td>
							    		<a href="#" class="update-reponse">update</a><br />
							    		<a href="#" class="delete-reponse">delete</a><br />
							    		<a href="#" class="voir-comm-reponse">Comm</a>
							    	</td>
								</tr>
								<tr class="repCommLigne">
									<td colspan="7">
										<table>
											<g:each in="${r?.commentaires }" var ="c">
												<tr class="CommLigne" id="Com${c.id}">
													<td><input type="hidden" class="CommId" value="${c.id}"/>
													<input type="text" id="ComTxt" value="${c?.text}"/></td>
													<td><a href="#" class="update-Comm">update</a><br>
											    		<a href="#" class="delete-Comm">delete</a><br></td>
												</tr>
											</g:each>
												<tr id="newCommLigne" class="CommLigne">
													<td><input type="text" class="ComTxt" /></td>
													<td><a href="#" class="add-Comm">Ajouter</a></td>
												</tr>
										</table>
									</td>
								</tr>
							</g:each>
							<tr id="newRepLigne" class="repLigne">
								<td></td>
								<td><input type="text" id="newRepTxt" class="RepTxt"/></td>
								<td></td>
								<td><input type="checkbox" id="newRepVisible" class="RepVisible"></td>
								<td><input type="checkbox" id="newRepCorrecte" class="RepCorrecte"></td>
						    	<td><a href="#" class="add-reponse">Ajouter</a></td>
							</tr>
						</table>
				
				<fieldset class="buttons">
					<g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" formnovalidate="" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
					<g:link class="" action="startVote" id="${questionInstance.id}">d&eacute;marer le vote de la question</g:link>
					<g:link class="" action="cloture" id="${questionInstance.id}">terminer le vote</g:link>
					<g:link class="" action="showStat" id="${questionInstance.id}">voir statistiques</g:link>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
