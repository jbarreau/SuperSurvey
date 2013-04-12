<%@ page import="supersurveys.Question" %>



<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'text', 'error')} required">
	<label for="text">
		<g:message code="question.text.label" default="Text" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="text" required="" value="${questionInstance?.text}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'dateCreation', 'error')} required">
	<label for="dateCreation">
		<g:message code="question.dateCreation.label" default="Date Creation" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="dateCreation" precision="day"  value="${questionInstance?.dateCreation}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'temps', 'error')} required">
	<label for="temps">
		<g:message code="question.temps.label" default="Temps" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="temps" type="number" min="5" value="${questionInstance.temps}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'nbVotes', 'error')} required">
	<label for="nbVotes">
		<g:message code="question.nbVotes.label" default="Nb Votes" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="nbVotes" type="number" value="${questionInstance.nbVotes}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'type', 'error')} required">
	<label for="type">
		<g:message code="question.type.label" default="Type" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="type" from="${supersurveys.TypeQuestion?.values()}" keys="${supersurveys.TypeQuestion.values()*.name()}" required="" value="${questionInstance?.type?.name()}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: questionInstance, field: 'reponses', 'error')} ">
	<label for="reponses">
		<g:message code="question.reponses.label" default="Reponses" />
		
	</label>
	

<li class="add">
<g:link controller="reponse" action="create" params="['question.id': questionInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'reponse.label', default: 'Reponse')])}</g:link>
</li>
</ul>

</div>

