package supersurveys
import org.apache.shiro.SecurityUtils;

class ConectedTagLib {
	def logged = { attrs, body ->
		def u = SecurityUtils.getSubject.getPrincipal

		if (!u){
			out << "non connect&eacute; <br/> <a href = \"${createLink(uri: '/auth/login')}\">connection</a>" 
		}else{
			out << "connect&eacute; en tant que " << User.findByUsername(u) << "<br/>"
		}
	}//
}
