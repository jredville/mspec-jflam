class CoverageFormatter < DottedFormatter
  def finish
    newline
    examples = @tally.counter.examples
    failures = @tally.counter.failures
    print "#{examples-failures} of #{examples} (#{(((examples-failures).to_f/examples.to_f)*100).to_i}%) of specs pass."
    newline
  end

  def newline
    print "/n"
  end
end
