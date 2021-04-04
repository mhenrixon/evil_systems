# frozen_string_literal: true

module EvilSystems
  # Cuprite is a modern Capybara driver which uses Chrome CDP API
  # instead of Selenium & co.
  # See https://github.com/rubycdp/cuprite
  module RegisterCuprite
    # Registers the Cuprite driver. Can be used via:
    # driven_by :cuprite, using: :chrome, screen_size: [1400, 1400]
    # The initial setup prior to the class ApplicationSystemTestCase, runs before the entire test suite.
    # @return [void]
    def self.initial_setup
      return unless defined? Capybara::Cuprite
      remote_options = RemoteChrome.options
      ::Capybara.register_driver(:cuprite) do |app|
        ::Capybara::Cuprite::Driver.new(
          app,
          **{
            window_size: [1200, 800],
            browser_options: {"no-sandbox" => nil},
            inspector: true
          }.merge(remote_options)
        )
      end
    end
  end
end

Capybara.default_driver = Capybara.javascript_driver = :cuprite
