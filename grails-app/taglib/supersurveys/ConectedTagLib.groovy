package supersurveys
import org.apache.shiro.SecurityUtils;

class ConectedTagLib {
	def logged = { attrs, body ->
		def u = SecurityUtils.getSubject().getPrincipal()
		
		if (!u){
			out << "Non connecté"
			out << "<br/> <a href = \"${createLink(uri: '/auth/login')}\">Connexion professeur</a>" 
		}else{
			out << "Connecté en tant que <br />" 
			out << "<strong>" << User.findByUsername(u) << "</strong><br/>"
			out << '<a href="'
			out << createLink(controller:"question", action:"list")
			out << '">Mes questions</a>'
			out << ' - '
			out << "<a href = \"${createLink(uri: '/auth/signOut')}\">Déconnexion</a>"
		}
	}//
}
