module Fixtures
  def fixture(name)
    read_file(name)
  end

  private

  def read_file(fixture)
    path = File.expand_path("../../fixtures/#{fixture}.xml", __FILE__)
    raise ArgumentError, "Unable to load: #{path}" unless File.exist?(path)
    File.read(path)
  end
end
