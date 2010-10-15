require File.expand_path('../../test_helper', __FILE__)
require 'mocha'
require 'mocha/mock'

class Unstubstest < Test::Unit::TestCase
  
  include Mocha
  
  def test_should_stub_and_unstub_method_on_object
    mock = Object.new
    assert_equal mock.respond_to?('test_stub'), false
    
    mock.stubs(:test_stub)
    assert_equal mock.respond_to?(:test_stub), true
    
    mock.unstubs(:test_stub)
    assert_equal mock.respond_to?(:test_stub), false
  end
  
  def test_should_stub_and_unstub_multiple_methods_on_object
    mock = Object.new
    assert_equal mock.respond_to?('test_stub'), false
    assert_equal mock.respond_to?('another_stub'), false

    
    mock.stubs(:test_stub => '', :another_stub => '')
    assert_equal mock.respond_to?(:test_stub), true
    assert_equal mock.respond_to?(:another_stub), true
    
    mock.unstubs(:test_stub, :another_stub)
    assert_equal mock.respond_to?('test_stub'), false
    assert_equal mock.respond_to?('another_stub'), false
  end
  
  
  # Example class with a method. 
  class TestObject
    def name
      return "test object"
    end
    
    def joke
      return "knock knock"
    end
  end
  
  def test_should_stub_and_unstub_with_existing_method_on_object
    obj = TestObject.new
    assert_equal obj.name, "test object"
    
    obj.stubs('name').returns("stubbed name")
    assert_equal obj.name, "stubbed name"
    
    obj.unstubs('name')
    assert_equal obj.name, "test object"
  end
  
  def test_should_stub_and_unstub_multiple_existing_methods_on_object
    obj = TestObject.new
    assert_equal obj.name, "test object"
    assert_equal obj.joke, "knock knock"
    
    obj.stubs('name').returns("stubbed name")
    obj.stubs('joke').returns("A man walks into a bar")
    assert_equal obj.name, "stubbed name"
    assert_equal obj.joke, "A man walks into a bar"
    
    obj.unstubs('name', 'joke')
    assert_equal obj.name, "test object"
    assert_equal obj.joke, "knock knock"
  end
  
  
end
