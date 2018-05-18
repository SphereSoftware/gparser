RSpec.describe Gparser::Airbnb do
  Camcorder.intercept_constructor(Net::IMAP) do
    methods_with_side_effects :select
  end

  let!(:connection) { Gparser::Feed.new(ENV['EMAIL'], ENV['GKEY']).connection }

  it "fetch emails" do
    expect(described_class.new(connection).emails).to_not be_empty
  end

  describe Gparser::Airbnb::Mail do
    let(:emails) { Gparser::Airbnb.new(connection).emails }
    let(:email) { emails.find {|mail| mail.uid == 120782 } }

    it "parse price properly" do
      expect(email.amount).to eql("$586.80")
    end

    it "parse address properly" do
      expect(email.address).to eql("7315 Chrome Hill Street, Las Vegas, NV 89139, United States")
    end

    it "parse check_in properly" do
      expect(email.check_in).to eql("Friday, Mar 30, 2018")
    end

    it "parse check_out properly" do
      expect(email.check_out).to eql("Thursday, Apr 05, 2018")
    end
  end
end
