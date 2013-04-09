package supersurveys

class TableauDeBordTagLib {

	def conteneur = { attrs, body ->
		out << "<div class=\"tableau-de-bord\">"
		out << body() 
		out << "<div class=\"clearer\"></div>"
		out << "</div>"
	}
	
	def section = { attrs, body ->
		out << "<div class=\"section\">"
		out << "<div class=\"section-titre\">${attrs.titre}</div>"
		out << "<div class=\"section-contenu\">"
		out << body()
		out << "</div>"
		out << "</div>"
	}
}
