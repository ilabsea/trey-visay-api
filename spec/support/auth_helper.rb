module AuthHelper
  def http_login
    ApiController.any_instance.stub(:http_basic_authentication).and_return(true)
  end  
end
