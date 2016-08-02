java_import org.jruby.demo.HelloLibrary

describe "HelloLibrary.addHello" do
  let(:library) { HelloLibrary.new }

  it "prepends 'Hello, ' to the given string" do
    expect(library.addHello('JavaOne')).to eq('Hello, JavaOne')
  end

  it "handles null values" do
    expect(library.addHello(nil)).to eq('Hello, null')
  end
end
