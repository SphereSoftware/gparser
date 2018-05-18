RSpec.describe Gparser::Airbnb do
  Camcorder.intercept_constructor(Net::IMAP) do
    methods_with_side_effects :select
  end

  let!(:gmail) { "shemerey@gmail.com" }
  let!(:key) { "ya29.Glu_BXzR6XVYMDkAiyl_qJhASH7vw90FeSAi55-rhHMPXGTBZKYhP3qzXJe4OHu45Vcn4EFyeQc5PJ-8qmFSlvC0J_V42dC3i7xWDTAK9ky2rovuy1dwFSHedi0x" }
  let!(:connection) { Gparser::Feed.new(gmail, key).connection }

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
