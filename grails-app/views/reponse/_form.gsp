<%@ page import="supersurveys.Reponse" %>



<div class="fieldcontain ${hasErrors(bean: reponseInstance, field: 'text', 'error')} required">
	<label for="text">
		<g:message code="reponse.text.label" default="Text" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="text" required="" value="${reponseInstance?.text}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: reponseInstance, field: 'visible', 'error')} ">
	<label for="visible">
		<g:message code="reponse.visible.label" default="Visible" />
		
	</label>
	<g:checkBox name="visible" value="${reponseInstance?.visible}" />
</div>

<div class="fieldcontain ${hasErrors(bean: reponseInstance, field: 'correcte', 'error')} ">
	<label for="correcte">
		<g:message code="reponse.correcte.label" default="Correcte" />
		
	</label>
	<g:checkBox name="correcte" value="${reponseInstance?.correcte}" />
</div>

<div class="fieldcontain ${hasErrors(bean: reponseInstance, field: 'commentaires', 'error')} ">
	<label for="commentaires">
		<g:message code="reponse.commentaires.label" default="Commentaires" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${reponseInstance?.commentaires?}" var="c">
    <li><g:link controller="commentaire" action="show" id="${c.id}">${c?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="commentaire" action="create" params="['reponse.id': reponseInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'commentaire.label', default: 'Commentaire')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: reponseInstance, field: 'question', 'error')} required">
	<label for="question">
		<g:message code="reponse.question.label" default="Question" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="question" name="question.id" from="${supersurveys.Question.list()}" optionKey="id" required="" value="${reponseInstance?.question?.id}" class="many-to-one"/>
</div>

