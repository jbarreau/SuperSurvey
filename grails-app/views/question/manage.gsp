<%@ page import="supersurveys.Question" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'question.label', default: 'Question')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
		<g:javascript src="jquery.form.js"></g:javascript>
		<g:javascript>
			(function($){
				$(document).ready(function(){
					var uptRep = $(".add-reponse")
						.click(function(){
							var corr = $("#newRepCorrecte").is(":checked")
							var visible = $("#newRepVisible").is(":checked")
							var txt= $("#newRepTxt").val()
						alert(txt)
							
							var idQuest =  $("#idQuest").val()
							$.ajax({
								data : {
									correcte : corr,
									visible : visible,
									text : txt,
									idQuest : idQuest
								},
								type:"POST",
								url :" ${createLink(uri: '/reponse/saveAJAX')}" ,
								success: function(data){
									alert(data)
									/*$(".edit-reponse").append(
										'<tr>'+
											'<td>'+data+'</td>'+
											'<td><input type="text" id="RepTxt" value=""/></td>'+
											'<td></td>'+
											'<td></td>'+
											'<td></td>'+
									    	'<td>'+
									    		'<a href="#" class="update-reponse">update</a><br>'+
									    		'<a href="#" class="delete-reponse">delete</a><br>'+
									    	'</td>'+
										'</tr>'
									)*/
								}
							})
						return false
						})
					
					/* $(formElement).ajaxForm({ //return;
					
						beforeSubmit: function(formData, jqForm, options) { 
    						var queryString = $.param(formData); 

    						//var formElement = jqForm[0]; 
 							//alert("form elmt: \n" + formElement);
 							
 	 						//alert('About to submit: \n\n' + JSON.stringify(formData));
 	 						$(formElement).animate({opacity:0.4})
						 },
						success: function(){ $(formElement).animate({opacity:1}) },
						error: function(){ $(formElement).animate({opacity:1}) }
					}); */
				});
			})(jQuery);
		</g:javascript>
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
			<g:form method="post" >
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
							<tr>
								<td></td>
								<td><input type="text" id="newRepTxt"/></td>
								<td></td>
								<td><input type="checkbox" id="newRepVisible"></td>
								<td><input type="checkbox" id="newRepCorrecte"></td>
						    	<td><a href="#" class="add-reponse">Ajouter</a></td>
							</tr>
							<g:each in="${questionInstance?.reponses?}" var="r">
								<tr>
									<td>${r.id}</td>
									<td><input type="text" id="RepTxt" value="${r?.text}"/></td>
									<td>${r?.nbVotes}</td>
									<td>${r?.visible}</td>
									<td>${r?.correcte}</td>
							    	<td>
							    		<a href="#" class="update-reponse">update</a><br>
							    		<a href="#" class="delete-reponse">delete</a><br>
							    	</td>
								</tr>
								<tr >
									<td colspan="6">
										<table>
											<g:each in="${r?.commentaires }" var ="c">
												<tr>
													<td><input type="text" id="ComTxt" value="${c?.text}"/></td>
													<td><a href="#" class="update-Comm">update</a><br>
											    		<a href="#" class="delete-Comm">delete</a><br></td>
												</tr>
											</g:each>
												<tr>
													<td><input type="text" id="newComTxt" /></td>
													<td><a href="#" class="add-Comm">Ajouter</a></td>
												</tr>
										</table>
									</td>
								</tr>
							</g:each>
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
