# frozen_string_literal: true

require "spec_helper"

# Property and Attribute often return effectively the same value. The biggest difference in Ruby is
# that Attribute always returns a String and Property returns the applicable primitive
# Attribute is defined in html spec: https://dom.spec.whatwg.org/#concept-element-attribute
# Property is defined in ecma spec: https://262.ecma-international.org/5.1/#sec-4.3.26
#
# Element#attribute guesses which value you want from an element's attribute or property value and returns that
#
# Since this doesn't make sense in a specification, w3c defines 2 new endpoints, made available in Selenium as:
# Element#dom_attribute and Element#property
# The old behavior with the existing method is still available, but executes a large javascript blob
# New behavior should be preferred for performance and preciseness

describe 'Attributes vs Properties' do
  describe "#property" do
    it 'returns boolean instead of String/nil for boolean properties' do
      @driver.get("http://watir.com/examples/forms_with_input_elements.html")
      element = @driver.find_element(id: 'new_user_interests_books')

      expect(element.attribute('checked')).to eq 'true'
      expect(element.dom_attribute('checked')).to eq 'true'
      expect(element.property('checked')).to eq true
    end

    it 'returns number instead of String for numeric properties' do
      @driver.get("http://watir.com/examples/forms_with_input_elements.html")
      element = @driver.find_element(id: 'new_user_interests_books')

      # Note that the name of the property and the attribute may be different
      # another example is `class` vs `className`
      expect(element.attribute('tabindex')).to eq '1'
      expect(element.attribute('tabIndex')).to eq '1'
      expect(element.dom_attribute('tabindex')).to eq '1'
      expect(element.dom_attribute('tabIndex')).to eq '1'
      expect(element.property('tabindex')).to eq nil
      expect(element.property('tabIndex')).to eq 1
    end

    it 'updates boolean when property changes' do
      @driver.get("http://watir.com/examples/forms_with_input_elements.html")
      element = @driver.find_element(id: 'new_user_interests_books')

      element.click

      expect(element.attribute('checked')).to eq nil
      expect(element.dom_attribute('checked')).to eq true
      expect(element.property('checked')).to eq false
    end

    it 'updates String value when property changes' do
      @driver.get("http://watir.com/examples/forms_with_input_elements.html")
      element = @driver.find_element(id: 'new_user_occupation')

      expect(element.attribute('value')).to eq 'Developer'
      expect(element.dom_attribute('value')).to eq 'Developer'
      expect(element.property('value')).to eq 'Developer'

      element.clear
      element.send_keys("Engineer")

      expect(element.attribute('value')).to eq 'Engineer'
      expect(element.dom_attribute('value')).to eq 'Developer'
      expect(element.property('value')).to eq 'Engineer'
    end

    it 'processes values not in the DOM' do
      @driver.get("http://watir.com/examples/non_control_elements.html")
      element = @driver.find_element(id: 'link_3')

      expect(element.attribute('href')).to eq 'http://watir.com/examples/forms_with_input_elements.html'
      expect(element.dom_attribute('href')).to eq 'forms_with_input_elements.html'
      expect(element.property('href')).to eq 'http://watir.com/examples/forms_with_input_elements.html'
    end

    it 'is case sensitive' do
      @driver.get("http://watir.com/examples/forms_with_input_elements.html")
      element = @driver.find_element(name: 'new_user_email')

      expect(element.attribute('nAme')).to eq 'new_user_email'
      expect(element.dom_attribute('nAme')).to eq 'new_user_email'
      expect(element.property('nAme')).to eq nil
    end
  end
end
