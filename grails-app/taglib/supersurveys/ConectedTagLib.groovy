package supersurveys
import org.apache.shiro.SecurityUtils;

class ConectedTagLib {
	def logged = { attrs, body ->
		def u = SecurityUtils.getSubject().getPrincipal()
		
		if (!u){
			out << "<p style='display: inline-block;text-align: right;margin: 1em;'>non connect&eacute; </p><br/> <a href = \"${createLink(uri: '/auth/login')}\">connexion professeur</a>" 
		}else{
			out << "<p style='display: inline-block;text-align: right;margin: 1em;'>connect&eacute; en tant que " << User.findByUsername(u) << "<br/>" <<
			"</p><a href = \"${createLink(uri: '/auth/signOut')}\">deconnexion</a>"
		}
	}//
}
