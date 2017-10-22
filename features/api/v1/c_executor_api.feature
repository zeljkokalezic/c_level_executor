Feature: C Executor API
  I want to be able to send C code to execute
  And receive execution response

  Scenario: Execute valid C code
    Given I am a valid API user
    When I send a valid C code to "v1/cexecutor"
    #Then the response status should be "200"
    Then show me the unparsed response
    #And the JSON response should have "$..result" with a length of 1