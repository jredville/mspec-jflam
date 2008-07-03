require 'mspec/guards/guard'

class SuperUserGuard < SpecGuard
  def match?
    if defined? Process
      Process.euid == 0
    else
      false
    end
  end
end

class Object
  def as_superuser
    g = SuperUserGuard.new
    yield if g.yield?
    g.unregister
  end
end
