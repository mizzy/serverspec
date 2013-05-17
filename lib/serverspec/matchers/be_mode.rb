RSpec::Matchers.define :be_mode do |mode|
  match do |file|
    if file.respond_to?(:mode?)
      file.mode?(mode)
    else
      backend.check_mode(example, file, mode)
    end
  end
end
