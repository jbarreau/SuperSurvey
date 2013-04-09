package supersurveys



import org.junit.*
import grails.test.mixin.*

@TestFor(CommentaireController)
@Mock(Commentaire)
class CommentaireControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/commentaire/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.commentaireInstanceList.size() == 0
        assert model.commentaireInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.commentaireInstance != null
    }

    void testSave() {
        controller.save()

        assert model.commentaireInstance != null
        assert view == '/commentaire/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/commentaire/show/1'
        assert controller.flash.message != null
        assert Commentaire.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/commentaire/list'

        populateValidParams(params)
        def commentaire = new Commentaire(params)

        assert commentaire.save() != null

        params.id = commentaire.id

        def model = controller.show()

        assert model.commentaireInstance == commentaire
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/commentaire/list'

        populateValidParams(params)
        def commentaire = new Commentaire(params)

        assert commentaire.save() != null

        params.id = commentaire.id

        def model = controller.edit()

        assert model.commentaireInstance == commentaire
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/commentaire/list'

        response.reset()

        populateValidParams(params)
        def commentaire = new Commentaire(params)

        assert commentaire.save() != null

        // test invalid parameters in update
        params.id = commentaire.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/commentaire/edit"
        assert model.commentaireInstance != null

        commentaire.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/commentaire/show/$commentaire.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        commentaire.clearErrors()

        populateValidParams(params)
        params.id = commentaire.id
        params.version = -1
        controller.update()

        assert view == "/commentaire/edit"
        assert model.commentaireInstance != null
        assert model.commentaireInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/commentaire/list'

        response.reset()

        populateValidParams(params)
        def commentaire = new Commentaire(params)

        assert commentaire.save() != null
        assert Commentaire.count() == 1

        params.id = commentaire.id

        controller.delete()

        assert Commentaire.count() == 0
        assert Commentaire.get(commentaire.id) == null
        assert response.redirectedUrl == '/commentaire/list'
    }
}
