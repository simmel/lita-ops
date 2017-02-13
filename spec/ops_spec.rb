require "lita-ops"
require "lita-irc"
require "lita/rspec"

# A compatibility mode is provided for older plugins upgrading from Lita 3. Since this plugin
# was generated with Lita 4, the compatibility mode should be left disabled.
Lita.version_3_compatibility_mode = false

describe Lita::Handlers::Ops, lita_handler: true do

  let(:allowed_nick) { double("Cinch::User", nick: "simmel", mask: Cinch::Mask.new("simmel!~simmel@localhost")) }
  let(:denied_nick) { double("Cinch::User", nick: "evil", mask: Cinch::Mask.new("evil!~evil@localhost")) }
  let(:channel) { "#marvintesting" }

  before do
    registry.configure do |config|
      config.handlers.ops.should_be_oped = {
        "#marvintesting" => %w(
          Lita!~simmel@localhost
          simmel!~simmel@localhost
        )
      }
    end
  end

  describe "#should_be_oped?" do
    it "allowed user" do
      expect(subject.should_be_oped?(channel, allowed_nick)).to be true
    end

    it "denied user" do
      expect(subject.should_be_oped?(channel, denied_nick)).to be false
    end

  end
end
