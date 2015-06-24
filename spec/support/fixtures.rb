module Fixtures
  def fixture(name, type)
    read_file(name, type)
  end

  def fixture_struct(name)
    klass = name.to_s.camelize
    "PayuZa::Structs::#{klass}".constantize.create(fixture(name, :yml))
  end

  private

  def read_file(name, type)
    path = File.expand_path("../../fixtures/#{name}.#{type}", __FILE__)
    raise ArgumentError, "Unable to load: #{path}" unless File.exist?(path)
    contents = File.read(path)
    parse_content(contents, type)
  end

  def parse_content(contents, type)
    case type
    when :yml
      YAML.load(contents)
    else
      contents
    end
  end
end
