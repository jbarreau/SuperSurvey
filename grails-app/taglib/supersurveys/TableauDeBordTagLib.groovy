package supersurveys

class TableauDeBordTagLib {

	def board = { attrs, body ->
		out << "<div class=\"board\">"
		out << body() 
		out << "<div class=\"clearer\"></div>"
		out << "</div>"
	}
	
	def boardSection = { attrs, body ->
		out << "<div class=\"board-section\">"
		out << "<div class=\"board-section-titre\">${attrs.titre}</div>"
		out << "<div class=\"board-section-contenu\">"
		out << body()
		out << "</div>"
		out << "</div>"
	}
}
