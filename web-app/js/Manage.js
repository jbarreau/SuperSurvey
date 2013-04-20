(function($){
	$(document).ready(function(){
		//save and update Reponse
		$(document).on("click", $(".add-reponse, .update-reponse"), function(e){
			if(!$(e.target).is('.add-reponse') && !$(e.target).is('.update-reponse')) return
			
			var url=$("#urlRep").val()
		
			var parentLigne = $(e.target).parents('.repLigne');
		
			var id = $(e.target).is('.update-reponse') ? $(parentLigne).find('.RepId').val() : -1;
			if (id==-1)
				var TypeAction = "create"
			else
				var TypeAction = "update"
			
			var corr = $(parentLigne).find('.RepCorrecte').is(':checked')
			var visible = $(parentLigne).find('.RepVisible').is(':checked')
			var txt = $(parentLigne).find('.RepTxt').val()
			var idQuest =  $("#idQuest").val()
			
			if(txt == '') return false;
			
			var dataToSend = {
				correcte : corr,
				visible : visible,
				text : txt,
				idQuest : idQuest,
				id: id
			}
				
			$.ajax({
				data : dataToSend,
				type:"POST",
				url :url,//"/SuperSurveys/reponse/saveAJAX",//Repajax,//""+ ${createLink(uri: '/reponse/saveAJAX')} ,
				success: function(data){
					//alert('Retour: ' + JSON.stringify(data))
					
					if(id < 0){
					
					parentLigne = $(	'<tr class="repLigne">'+
							'<td>'+data.id+'<input type="hidden" class="RepId" value="'+data.id+'"/></td>'+
							'<td><input type="text" class="RepTxt" value="'+data.text+'"/></td>'+
							'<td>'+data.nbVotes+'</td>'+
							'<td>'+
								'<input type="checkbox" class="RepVisible" '+(data.visible ? 'checked="checked"' : '')+' " />'+
							'</td>'+
							'<td>'+
								'<input type="checkbox" class="RepCorrecte" '+(data.correcte ? 'checked="checked"' : '')+' " />'+
							'</td>'+
							'<td>'+
								'<a href="#" class="update-reponse">Modifier</a><br />'+
								'<a href="#" class="delete-reponse">Supprimer</a><br />'+
								'<a href="#" class="voir-comm-reponse">Commentaires</a>'+
							'</td>'+
						'</tr>'+
						'<tr class="repCommLigne">'+
							'<td colspan="6">'+
								'<table>'+
									'<tr id="newCommLigne0" class="CommLigne">'+
									'<td><input type="text" class="ComTxt" /></td>'+
									'<td>Visible : <input type="checkbox" class="ComVisible" /></td>'+
									'<td><a href="#" class="add-Comm">Ajouter</a></td>'+
							'</tr>'+
								'</table>'+
							'</td>'+
						'</tr>' ).insertBefore($("#newRepLigne"))
					 }
					var parentLigne = $(e.target).parents('.repLigne');
					$(parentLigne).css('opacity', .1).animate({opacity: 1})
					
					 
					if (TypeAction == "create"){
						$(parentLigne).find('.RepCorrecte').removeAttr('checked')
						$(parentLigne).find('.RepVisible').removeAttr('checked')
						$(parentLigne).find('.RepTxt').val("")
					}else if(TypeAction == "update"){
						$(parentLigne).find('.RepCorrecte').prop("checked", data.correcte);
						$(parentLigne).find('.RepVisible').prop("checked", data.visible);
						$(parentLigne).find('.RepTxt').val(data.text)
					}
				},
				error: function (xhr, ajaxOptions, thrownError) {
					alert(xhr.status);
					alert(thrownError);
				}

			})
		return false
		})
		
		//save and update Commentaire
		$(document).on('click', $('.add-Comm .update-Comm'), function(e){
			if(!$(e.target).is('.add-Comm') && !$(e.target).is('.update-Comm')) return;
			
			var url = $("#urlCom").val()
			
			var Ligne = $(e.target).parents(".CommLigne");
			
			var idRep = $(e.target).parents(".repCommLigne").prev(".repLigne").find(".RepId").val()
			var txt = $(Ligne).find('.ComTxt').val()
			var visible = $(Ligne).find('.ComVisible').is(':checked')
			var id = $(e.target).is('.update-Comm') ? $(Ligne).find('.CommId').val() : -1;
			//alert (txt+ " "+ id + " "+ idRep)

			if(txt == '') return false;
			
			if (id==-1)
				var TypeAction = "create"
			else
				var TypeAction = "update"
			
			var dataToSend = {
				idRep: idRep,
				visible: visible,
				text: txt,
				id: id
			} 
			
			$.ajax({
				data : dataToSend,
				type:"POST",
				url :url,//"/SuperSurveys/commentaire/saveAJAX",//Commajax,//""+ ${createLink(uri: '/commentaire/saveAJAX')} ,
				success: function(data){
					//alert('Retour: ' + JSON.stringify(data))
					
					if(TypeAction == "create"){

					Ligne = $(	'<tr class="CommLigne">'+
							'<td><input type="hidden" class="CommId" value="'+data.id+'"/>'+
							'<input type="text" class="CommTxt" value="'+data.text+'"/></td>'+
							'<td>'+
								'visible : <input type="checkbox" class="ComVisible" '+(data.visible ? 'checked="checked"' : '')+' " />'+
							'</td>'+
							'<td>'+
								'<a href="#" class="update-Comm">Modifier</a><br />'+
								'<a href="#" class="delete-Comm">Supprimer</a><br />'+
							'</td>'+
						'</tr>').insertBefore($(e.target).parents('.CommLigne'))
						
						$(e.target).parents(".CommLigne").find('.ComTxt').val("")
						$(e.target).parents(".CommLigne").find('.ComVisible').removeAttr('checked')
					 }
					var parentLigne = $(e.target).parents('.CommLigne');
					$(parentLigne).css('opacity', .1).animate({opacity: 1})
					
					 
					/*if (TypeAction == "create"){
					}else if(TypeAction == "update"){
						$(parentLigne).find('.ComTxt').val(data.text)
					}*/
				},
				error: function (xhr, ajaxOptions, thrownError) {
					alert(xhr.status);
					alert(thrownError);
				}
			});
			return false;
		});
		
		
		//remove Comm
		$(document).on('click', $('.delete-Comm'), function(e){
			if(!$(e.target).is('.delete-Comm')) return;
			
			var Ligne = $(e.target).parents(".CommLigne");
		
			var idCom = $(Ligne).find(".CommId").val()
			
			$.ajax({
				data : {
					//id: idCom
				},
				type:"POST",
				url :"/SuperSurveys/commentaire/delete/"+idCom,//Repajax,//""+ ${createLink(uri: '/reponse/saveAJAX')} ,
				success: function(data){
					alert('success')
				},
				error: function (xhr, ajaxOptions, thrownError) {
					if (xhr.status != 404){
						alert(xhr.status);
						alert(thrownError);
					}else{
						//$(Ligne).slideUp()//.remove();
						$(Ligne).css('opacity', 1).animate({opacity: 0}, function(){ $(this).remove(); })
					}
				}
			});
			
			return false;
		});
		
		//remove Rep
		$(document).on('click', $('.delete-reponse'), function(e){
			if(!$(e.target).is('.delete-reponse')) return;
			
			var Ligne = $(e.target).parents(".repLigne");
		
			var idRep = $(Ligne).find(".RepId").val()
			
			$.ajax({
				data : {
					//id: idRep
				},
				type:"POST",
				url :"/SuperSurveys/reponse/delete/"+idRep,//Repajax,//""+ ${createLink(uri: '/reponse/saveAJAX')} ,
				success: function(data){
					alert('success')
				},
				error: function (xhr, ajaxOptions, thrownError) {
					if (xhr.status != 404){
						alert(xhr.status);
						alert(thrownError);
					}else{
						$(Ligne).css('opacity', 1).animate({opacity: 0}, function(){ 
							$(this).next().remove()
							$(this).remove(); })
						//$(Ligne).slideUp()//.remove();
					}
				}
			});
			
			return false;
		});
		
		//Show Com
		$(document).on('click', $('.voir-comm-reponse'), function(e){
			if(!$(e.target).is('.voir-comm-reponse')) return;
			
			// On affiche le tableau des commentaires
			$(e.target).parents('.repLigne').next('.repCommLigne').toggle()
			return false
		})
		
		$('#edit-reponse').on('keypress', $('input'), function(e){
			if(!$(e.target).is('input')) return
			var code = (e.keyCode ? e.keyCode : e.which);
				if(code == 13) { //Enter keycode
					return false;
				}
			});
			
	})			
})(jQuery);