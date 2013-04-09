<%@ page import="supersurveys.Commentaire" %>



<div class="fieldcontain ${hasErrors(bean: commentaireInstance, field: 'text', 'error')} required">
	<label for="text">
		<g:message code="commentaire.text.label" default="Text" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="text" required="" value="${commentaireInstance?.text}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: commentaireInstance, field: 'reponse', 'error')} required">
	<label for="reponse">
		<g:message code="commentaire.reponse.label" default="Reponse" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="reponse" name="reponse.id" from="${supersurveys.Reponse.list()}" optionKey="id" required="" value="${commentaireInstance?.reponse?.id}" class="many-to-one"/>
</div>

