class LogOutput
  attr_writer :logs

  def initialize(logs)
    @logs = logs
  end

  def print_console
    logs.each { |l| puts l }
  end

  private

  def logs
    @logs
  end
end
