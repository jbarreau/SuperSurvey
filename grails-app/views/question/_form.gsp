<%@ page import="supersurveys.Question" %>



<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'text', 'error')} required">
	<label for="text">
		<g:message code="question.text.label" default="Text" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="text" required="" value="${questionInstance?.text}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'type', 'error')} required">
	<label for="type">
		<g:message code="question.type.label" default="Type" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="type" from="${supersurveys.TypeQuestion?.values()}" keys="${supersurveys.TypeQuestion.values()*.name()}" required="" value="${questionInstance?.type?.name()}"/>
</div>

