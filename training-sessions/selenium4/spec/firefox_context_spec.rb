# frozen_string_literal: true

require "spec_helper"

describe 'Firefox Context' do
  # Selenium 4 RC 3 is camel casing Firefox Prefs, fixed for next release
  xit "Dynamically Change Prefs", browser: :firefox,
                                 prefs: {"intl.accept_languages" => "de-DE"} do
    @driver.get("https://www.google.com")

    language = @driver.find_element(id: "gws-output-pages-elements-homepage_additional_languages__als")
    expect(language.text).to include("angeboten auf")

    @driver.context = 'chrome'

    @driver.execute_script("Services.prefs.setStringPref('intl.accept_languages', 'es-ES')")

    @driver.context = 'content'
    @driver.navigate.refresh

    language = @driver.find_element(id: "gws-output-pages-elements-homepage_additional_languages__als")
    expect(language.text).to include("Ofrecido por")
  end
end
