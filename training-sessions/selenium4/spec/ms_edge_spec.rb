# frozen_string_literal: true

require 'selenium-webdriver'

describe 'MS Edge Options' do
  it "supports Chromium Edge", unit: true do
    # Selenium 3 only supported EdgeHTML options directly:
    # :in_private, :extension_paths, and :start_page
    # Now supports same capabilities as Chrome

    edge_opts = Selenium::WebDriver::Edge::Options.new(
      args: %w[foo bar],
      prefs: {foo: 'bar'},
      binary: '/foo/bar',
      foo: 'bar',
      emulation: {device_name: :bar},
      local_state: {foo: 'bar'},
      detach: true)

    expected_opts = {'args' => %w[foo bar],
                     'prefs' => {'foo' => 'bar'},
                     'binary' => '/foo/bar',
                     'foo' => 'bar',
                     'mobileEmulation' => {'deviceName' => 'bar'},
                     'localState' => {'foo' => 'bar'},
                     'detach' => true}

    expect(edge_opts.as_json['ms:edgeOptions']).to eq(expected_opts)
  end
end
