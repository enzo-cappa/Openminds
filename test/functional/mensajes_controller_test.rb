require File.dirname(__FILE__) + '/../test_helper'
require 'mensajes_controller'

# Re-raise errors caught by the controller.
class MensajesController; def rescue_action(e) raise e end; end

class MensajesControllerTest < Test::Unit::TestCase
  def setup
    @controller = MensajesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
