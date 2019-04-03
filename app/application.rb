require 'config'
require 'pathname'

class Application
  def run
    load_configs

    sources = Settings.message.sources

    logs = [
      I18n.t(:starting_app, source_names: sources.map(&:name).join(', '), destination: Settings.message.destination.url)
    ]

    log_output = LogOutput.new(logs)
    log_output.print_console

    intercept = InterceptService.new
    intercept.parse_routes(sources)

    log_output.logs = [I18n.t(:log_result)].concat(intercept.logs).concat [ I18n.t(:ending_app) ]

    log_output.print_console
  end

  private

  def load_configs
    Config.load_and_set_settings(Config.setting_files(File.join(Dir.pwd, 'config'), ENV['APP_ENVIRONMENT_NAME']))
    I18n.load_path << Dir[File.join(Dir.pwd, 'config', 'locales') + "/*.yml"]
  end
end
