module HttpResponseSpecHelper
  def body_is_array?(body)
    body.respond_to?('bsearch')
  end

end
