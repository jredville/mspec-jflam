require 'mspec/expectations/expectations'
require 'mspec/runner/formatters/dotted'

class FailureFormatter < DottedFormatter
  def initialize(*args)
    $quiet_runner = true
    super
  end

  def after(state)
    if state.exception?
      print "#{state.describe} #{state.it}\n"
      state.exceptions.each do |msg,exc|
        print_backtrace(exc,msg)
        newline; newline
      end
    end
  end

  def finish
    newline
    print "Total failures: #{@tally.counter.failures} out of #{@tally.counter.examples} examples"
    newline
  end

  def newline
    print "\n"
  end
end
