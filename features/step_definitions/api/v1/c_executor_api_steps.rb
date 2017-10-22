require "base64"

Given("I am a valid API user") do
  header 'Authorization', "Token token=a47a8e54b11c4de5a4a351734c80a14a"
end

When("I send a valid C code to {string}") do |path|
  function = <<FUNCTION
      long factorial(int max) {
        int i=max, result=1;
        while (i >= 2) { result *= i--; }
        return result;
      }
FUNCTION

  params = {
      :function => Base64.encode64(function),
      :function_name => 'factorial',
      :params => 5
  }

  post  path, params
end


Then("the response should have result {string}") do |string|
  last_response.body.should have_content string
end