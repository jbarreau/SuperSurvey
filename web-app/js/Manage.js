(function($){
	$(document).ready(function(){
		//save and update Reponse
		$(document).on("click", $(".add-reponse, .update-reponse"), function(e){
			if(!$(e.target).is('.add-reponse') && !$(e.target).is('.update-reponse')) return
		
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
				url :"/SuperSurveys/reponse/saveAJAX",//Repajax,//""+ ${createLink(uri: '/reponse/saveAJAX')} ,
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
								'<a href="#" class="update-reponse">update</a><br />'+
								'<a href="#" class="delete-reponse">delete</a><br />'+
								'<a href="#" class="voir-comm-reponse">Comm</a>'+
							'</td>'+
						'</tr>'+
						'<tr class="repCommLigne">'+
							'<td colspan="7">'+
								'<table>'+
									'<tr>'+
										'<td><input type="text" class="newComTxt" /></td>'+
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
			
			var Ligne = $(e.target).parents(".CommLigne");
			
			var idRep = $(e.target).parents(".repCommLigne").prev(".repLigne").find(".RepId").val()
			var txt = $(Ligne).find('.ComTxt').val()
			var id = $(e.target).is('.update-Comm') ? $(Ligne).find('.CommId').val() : -1;
			//alert (txt+ " "+ id + " "+ idRep)
			
			if (id==-1)
				var TypeAction = "create"
			else
				var TypeAction = "update"
			
			var dataToSend = {
				idRep: idRep,
				text: txt,
				id: id
			}
			
			$.ajax({
				data : dataToSend,
				type:"POST",
				url :"/SuperSurveys/commentaire/saveAJAX",//Commajax,//""+ ${createLink(uri: '/commentaire/saveAJAX')} ,
				success: function(data){
					//alert('Retour: ' + JSON.stringify(data))
					
					if(TypeAction == "create"){

					Ligne = $(	'<tr class="CommLigne">'+
							'<td><input type="hidden" class="CommId" value="'+data.id+'"/>'+
							'<input type="text" class="CommTxt" value="'+data.text+'"/></td>'+/*
							'<td>'+
								'<input type="checkbox" class="CommVisible" '+(data.visible ? 'checked="checked"' : '')+' " />'+
							'</td>'+*/
							'<td>'+
								'<a href="#" class="update-Comm">update</a><br />'+
								'<a href="#" class="delete-Comm">delete</a><br />'+
							'</td>'+
						'</tr>').insertBefore($("#newCommLigne"+idRep))
						var parentLigne = $(e.target).parents('.CommLigne');
						$(parentLigne).css('opacity', .1).animate({opacity: 1})
						
						$(e.target).parents(".CommLigne").find('.ComTxt').val("")
					 }
					
					 
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
						$(Ligne).css('opacity', 1).animate({opacity: 0}, function(){ $(this).remove(); })
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
			
	})			
})(jQuery);