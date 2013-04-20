<%@ page import="supersurveys.User" %>



<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'nom', 'error')} required">
	<label for="nom">
		<g:message code="user.nom.label" default="Nom" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="nom" required="" value="${userInstance?.nom}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'prenom', 'error')} ">
	<label for="prenom">
		<g:message code="user.prenom.label" default="Prenom" />
		
	</label>
	<g:textField name="prenom" value="${userInstance?.prenom}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'email', 'error')} required">
	<label for="email">
		<g:message code="user.email.label" default="Email" />
		<span class="required-indicator">*</span>
	</label>
	<g:field type="email" name="email" required="" value="${userInstance?.email}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'username', 'error')} required">
	<label for="username">
		<g:message code="user.username.label" default="Login" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="username" required="" value="${userInstance?.username}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'password', 'error')} required">
	<label for="password">
		<g:message code="user.password.label" default="Password" />
		<span class="required-indicator">*</span>
		
	</label>
	<g:passwordField name="password" required="" value="" />
</div>

